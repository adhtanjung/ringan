<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">

			<!-- Page Header -->
			<DatasetPageHeader
				eyebrow="Safety framework"
				title="Response Types"
				description="Define and manage the response types used when a safety signal is detected. Each response type specifies required elements, tone guidance, an example opener, and things to avoid."
				:total="pagination.total"
				total-label="response types"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Response Type
					</Button>
				</template>
			</DatasetPageHeader>

			<!-- Response type cards (visual overview) -->
			<div v-if="!loading && sortedResponses.length > 0" class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-3">
				<div
					v-for="item in sortedResponses"
					:key="item.id"
					class="group relative overflow-hidden rounded-2xl border border-border/70 bg-card p-5 shadow-sm transition-all duration-200 hover:shadow-md hover:-translate-y-0.5 cursor-pointer"
					@click="openEditModal(item)"
				>
					<!-- Header row -->
					<div class="mb-3 flex items-start justify-between gap-2">
						<span class="inline-flex items-center rounded-full bg-muted px-2.5 py-0.5 text-xs font-semibold font-mono text-foreground">
							{{ item.response_id }}
						</span>
						<span
							v-if="item.tone"
							class="text-right text-[11px] italic text-muted-foreground leading-snug max-w-[55%]"
						>
							{{ item.tone }}
						</span>
					</div>

					<!-- Response type name -->
					<h3 class="text-sm font-semibold text-foreground leading-snug mb-1">
						{{ item.response_type }}
					</h3>

					<!-- When used -->
					<p v-if="item.when_used" class="text-xs text-muted-foreground leading-relaxed mb-3">
						{{ item.when_used }}
					</p>

					<!-- Example opener excerpt -->
					<blockquote
						v-if="item.example_opener"
						class="border-l-2 border-border pl-3 text-xs text-muted-foreground italic leading-relaxed line-clamp-2"
					>
						"{{ item.example_opener }}"
					</blockquote>

					<!-- Avoid pill -->
					<div
						v-if="item.avoid"
						class="mt-3 flex items-start gap-1.5 rounded-lg bg-destructive/5 border border-destructive/10 px-3 py-2"
					>
						<AlertTriangle class="mt-0.5 h-3 w-3 shrink-0 text-destructive/60" />
						<p class="text-[11px] text-destructive/80 leading-snug line-clamp-2">
							{{ item.avoid }}
						</p>
					</div>

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
			:data-type="'response_types'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'response_types'"
			@close="closeExportModal"
		/>

		<ResponseTypeModal
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
import { AlertTriangle, Pencil, Plus } from "lucide-vue-next";

import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";

import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ResponseTypeModal from "@/components/admin/ResponseTypeModal.vue";
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
} = useDatasetManagement("response_types", { is_active: "true" });

// ─── Sorted responses for card view ──────────────────────────────────────────

const sortedResponses = computed(() =>
	[...data.value].sort((a, b) =>
		(a.response_id ?? "").localeCompare(b.response_id ?? ""),
	),
);

// ─── Lifecycle ────────────────────────────────────────────────────────────────

onMounted(() => {
	refreshData();
});
</script>
