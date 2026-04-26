<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Conversation engine"
				title="Opening Questions"
				description="Manage the top-of-funnel questions shown before general questions. Each routes to another opening question or directly to a category."
				:total="pagination.total"
				total-label="questions"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Question
					</Button>
				</template>
			</DatasetPageHeader>

			<div>
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
					:order-by="sortBy"
					:order-direction="sortOrder"
					:show-create-button="false"
					class="overflow-hidden rounded-3xl border border-border/70 bg-card shadow-sm"
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
					@search-change="(value) => (searchQuery = value)"
					@filter-change="setFilter"
					@clear-filters="clearFilters"
					@sort="({ column, direction }) => setSort(column, direction)"
				/>
			</div>
		</div>

		<!-- Import Modal -->
		<ImportModal
			:is-open="showImportModal"
			:data-type="'opening_questions'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<!-- Export Modal -->
		<ExportModal
			:is-open="showExportModal"
			:data-type="'opening_questions'"
			@close="closeExportModal"
		/>

		<!-- Opening Question Modal -->
		<OpeningQuestionModal
			:is-open="showEditModal"
			:item="editingItem"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<Toaster />
	</div>
</template>

<script setup>
import { onMounted } from "vue";
import { Plus } from "lucide-vue-next";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import OpeningQuestionModal from "@/components/admin/OpeningQuestionModal.vue";
import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";

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
	refreshData,
	openCreateModal,
	openEditModal,
	closeEditModal,
	handleSave,
	deleteItem,
	bulkDeleteItems,
	allMatchingIds,
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
	setSort,
	sortBy,
	sortOrder,
} = useDatasetManagement("opening_questions", { is_active: "true" });

onMounted(() => {
	refreshData();
});
</script>
