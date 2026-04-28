<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">

			<!-- Page Header -->
			<DatasetPageHeader
				eyebrow="Safety framework"
				title="Risk Classification"
				description="Define and manage the tier-based risk classification framework. Each tier maps a level of emotional or safety risk to response goals, referral guidance, and linked response codes."
				:total="pagination.total"
				total-label="tiers"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Tier
					</Button>
				</template>
			</DatasetPageHeader>

			<!-- Tier Cards (visual overview) -->
			<div v-if="!loading && data.length > 0" class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
				<div
					v-for="item in sortedTiers"
					:key="item.id"
					class="group relative overflow-hidden rounded-2xl border border-border/70 bg-card p-5 shadow-sm transition-all duration-200 hover:shadow-md hover:-translate-y-0.5 cursor-pointer"
					:class="tierCardClass(item.tier)"
					@click="openEditModal(item)"
				>
					<!-- Tier badge -->
					<div class="mb-3 flex items-center justify-between">
						<span
							class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold"
							:class="tierBadgeClass(item.tier)"
						>
							Tier {{ item.tier }}
						</span>
						<span v-if="item.linked_response" class="text-[11px] text-muted-foreground font-mono">
							{{ item.linked_response }}
						</span>
					</div>

					<!-- Label -->
					<h3 class="text-sm font-semibold text-foreground leading-snug mb-2">
						{{ item.framework_label }}
					</h3>

					<!-- Definition excerpt -->
					<p class="text-xs text-muted-foreground leading-relaxed line-clamp-3">
						{{ item.expanded_definition }}
					</p>

					<!-- Edit hint -->
					<div class="mt-3 flex items-center gap-1 text-[11px] text-muted-foreground opacity-0 group-hover:opacity-100 transition-opacity">
						<Pencil class="h-3 w-3" />
						Click to edit
					</div>
				</div>
			</div>

			<!-- Table -->
			<section>
				<DatasetTable
					:title="dataTypeLabel"
					:data-type="dataType"
					:data="data"
					:columns="columns"
					:all-selectable-ids="allMatchingIds"
					:loading="loading || actionLoading"
					:error="error"
					:pagination="pagination"
					:current-page="currentPage"
					:total-pages="totalPages"
					:search-query="searchQuery"
					:filters="filters"
					:filter-options="filterOptions"
					:show-create-button="false"
					class="overflow-hidden rounded-3xl border border-border/70 bg-card shadow-sm"
					@search-change="(q) => (searchQuery = q)"
					@filter-change="setFilter"
					@create="openCreateModal"
					@edit="openEditModal"
					@delete="deleteItem"
					@bulk-delete="bulkDeleteItems"
					@refresh="refreshData"
					@import="openImportModal"
					@export="openExportModal"
					@page-change="goToPage"
					@page-size-change="changePageSize"
					@next-page="nextPage"
					@prev-page="prevPage"
					@clear-filters="clearFilters"
				/>
			</section>
		</div>

		<!-- Modals -->
		<ImportModal
			:is-open="showImportModal"
			:data-type="'risk_classifications'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'risk_classifications'"
			@close="closeExportModal"
		/>

		<RiskClassificationModal
			:is-open="showEditModal"
			:item="editingItem"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<Toaster />
	</div>
</template>

<script setup lang="ts">
import { computed, onMounted } from "vue";
import { Plus, Pencil } from "lucide-vue-next";

import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";

import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import RiskClassificationModal from "@/components/admin/RiskClassificationModal.vue";
import { useDatasetManagement } from "@/composables/useDatasetManagement";

// ─── Dataset management ───────────────────────────────────────────────────────

const {
	loading,
	dataType,
	error,
	data,
	actionLoading,
	filterOptions,
	showImportModal,
	showExportModal,
	showEditModal,
	editingItem,
	pagination,
	columns,
	dataTypeLabel,
	currentPage,
	totalPages,
	searchQuery,
	filters,
	allMatchingIds,
	refreshData,
	openCreateModal,
	openEditModal,
	closeEditModal,
	handleSave,
	deleteItem,
	bulkDeleteItems,
	openImportModal,
	closeImportModal,
	openExportModal,
	closeExportModal,
	handleImportSuccess,
	goToPage,
	changePageSize,
	nextPage,
	prevPage,
	setFilter,
	clearFilters,
} = useDatasetManagement("risk_classifications", { is_active: "true" });

// ─── Tier card helpers ────────────────────────────────────────────────────────

const sortedTiers = computed(() =>
	[...data.value].sort((a, b) => (a.tier ?? 0) - (b.tier ?? 0)),
);

const tierCardClass = (tier: number) => {
	const map: Record<number, string> = {
		1: "border-l-4 border-l-blue-400/60",
		2: "border-l-4 border-l-amber-400/60",
		3: "border-l-4 border-l-orange-400/60",
		4: "border-l-4 border-l-red-500/60",
	};
	return map[tier] ?? "border-l-4 border-l-muted-foreground/30";
};

const tierBadgeClass = (tier: number) => {
	const map: Record<number, string> = {
		1: "bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-300",
		2: "bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300",
		3: "bg-orange-100 text-orange-700 dark:bg-orange-900/40 dark:text-orange-300",
		4: "bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-300",
	};
	return map[tier] ?? "bg-muted text-muted-foreground";
};

// ─── Lifecycle ────────────────────────────────────────────────────────────────

onMounted(() => {
	refreshData();
});
</script>
