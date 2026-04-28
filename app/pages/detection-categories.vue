<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">

			<!-- Page Header -->
			<DatasetPageHeader
				eyebrow="Safety framework"
				title="Detection Categories"
				description="Define and manage the signal detection categories used to classify user messages. Each category maps a detected pattern to a default risk tier, linked response, and workflow."
				:total="pagination.total"
				total-label="detection categories"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Category
					</Button>
				</template>
			</DatasetPageHeader>

			<!-- Status summary pills -->
			<div v-if="!loading && data.length > 0" class="flex flex-wrap gap-3">
				<div
					v-for="group in statusGroups"
					:key="group.status"
					class="flex items-center gap-2 rounded-full border border-border/60 bg-card px-4 py-1.5 text-sm shadow-sm"
				>
					<span
						class="h-2 w-2 rounded-full"
						:class="group.status === 'Existing' ? 'bg-blue-500' : 'bg-emerald-500'"
					/>
					<span class="font-medium text-foreground">{{ group.status }}</span>
					<span class="text-muted-foreground">{{ group.count }}</span>
				</div>

				<!-- Tier distribution -->
				<div
					v-for="tier in tierGroups"
					:key="tier.label"
					class="flex items-center gap-2 rounded-full border border-border/60 bg-card px-4 py-1.5 text-sm shadow-sm"
				>
					<span class="h-2 w-2 rounded-full" :class="tierDotClass(tier.label)" />
					<span class="font-medium text-foreground">{{ tier.label }}</span>
					<span class="text-muted-foreground">{{ tier.count }}</span>
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
			:data-type="'detection_categories'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'detection_categories'"
			@close="closeExportModal"
		/>

		<DetectionCategoryModal
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
import { Plus } from "lucide-vue-next";

import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";

import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import DetectionCategoryModal from "@/components/admin/DetectionCategoryModal.vue";
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
} = useDatasetManagement("detection_categories", { is_active: "true" });

// ─── Summary helpers ──────────────────────────────────────────────────────────

const statusGroups = computed(() => {
	const counts: Record<string, number> = {};
	for (const item of data.value) {
		const s = item.status || "Unknown";
		counts[s] = (counts[s] || 0) + 1;
	}
	return Object.entries(counts)
		.map(([status, count]) => ({ status, count }))
		.sort((a, b) => a.status.localeCompare(b.status));
});

const tierGroups = computed(() => {
	const counts: Record<string, number> = {};
	for (const item of data.value) {
		const t = item.default_tier || "Unassigned";
		counts[t] = (counts[t] || 0) + 1;
	}
	return Object.entries(counts)
		.map(([label, count]) => ({ label, count }))
		.sort((a, b) => a.label.localeCompare(b.label));
});

const tierDotClass = (tier: string) => {
	if (tier.includes("5")) return "bg-red-500";
	if (tier.includes("4")) return "bg-orange-500";
	if (tier.includes("3")) return "bg-amber-500";
	if (tier.includes("2")) return "bg-yellow-400";
	if (tier.includes("1")) return "bg-blue-400";
	return "bg-muted-foreground";
};

// ─── Lifecycle ────────────────────────────────────────────────────────────────

onMounted(() => {
	refreshData();
});
</script>
