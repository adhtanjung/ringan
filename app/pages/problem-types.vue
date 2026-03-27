<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Problem taxonomy"
				title="Categories"
				description="Manage top-level categories that organize subcategories and keep the assessment structure easy to scan."
				:total="pagination.total"
				total-label="categories"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Category
					</Button>
					<Button
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
						@click="startTour('problem_types')"
					>
						<HelpCircle class="h-4 w-4" />
						How this works
					</Button>
				</template>
			</DatasetPageHeader>

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
					@view="openDetailView"
					@delete="deleteItem"
					@bulk-delete="bulkDeleteItems"
					@bulk-update="bulkUpdateItems"
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

		<ImportModal
			:is-open="showImportModal"
			:data-type="'problem_types'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'problem_types'"
			@close="closeExportModal"
		/>

		<ProblemTypeModal
			:is-open="showEditModal"
			:item="editingItem"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<Toaster />
		<ProblemTypeDetailDrawer
			:open="showDetailSheet"
			:item="viewingItem"
			:technical-open="showTechnicalDetails"
			:category-spec="problemTypesCategoryIdSpec"
			:record-spec="problemTypesRecordIdSpec"
			:category-context="problemTypesCategoryContext"
			@update:open="(open) => !open && closeDetailSheet()"
			@update:technical-open="(open) => (showTechnicalDetails = open)"
			@edit="openEditFromDetail"
			@copy-id="copyId"
			@open-list-relation="openLinkedRecords"
			@retry="loadCategoryContextSummary"
		/>

		<LinkedRecordsSheet
			:open="showLinkedRecordsSheet"
			:title="linkedRecordsTitle"
			:description="linkedRecordsDescription"
			:sections="linkedRecordsSections"
			:loading="linkedRecordsLoading"
			:error="linkedRecordsError"
			empty-message="No linked records were found for this ID."
			@update:open="(open) => !open && closeLinkedRecordsSheet()"
			@retry="loadLinkedRecords"
		/>
	</div>
</template>

<script setup>
import { onMounted } from "vue";

import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";
import { HelpCircle, Plus } from "lucide-vue-next";

import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import LinkedRecordsSheet from "@/components/admin/LinkedRecordsSheet.vue";
import ProblemTypeDetailDrawer from "@/components/admin/drawers/problem-types/ProblemTypeDetailDrawer.vue";
import ProblemTypeModal from "@/components/admin/ProblemTypeModal.vue";
import { useProblemTypesDrawers } from "@/composables/drawers/useProblemTypesDrawers";
import { useOnboarding } from "@/composables/useOnboarding";

const { startTour } = useOnboarding();
const { supabase } = useSupabase();

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
	bulkUpdateItems,
} = useDatasetManagement("problem_types", { is_active: "true" });

const {
	showDetailSheet,
	viewingItem,
	showTechnicalDetails,
	showLinkedRecordsSheet,
	linkedRecordsTitle,
	linkedRecordsDescription,
	linkedRecordsSections,
	linkedRecordsLoading,
	linkedRecordsError,
	problemTypesCategoryIdSpec,
	problemTypesRecordIdSpec,
	problemTypesCategoryContext,
	openDetailView,
	closeDetailSheet,
	openEditFromDetail,
	openLinkedRecords,
	closeLinkedRecordsSheet,
	loadLinkedRecords,
	loadCategoryContextSummary,
	copyId,
} = useProblemTypesDrawers({
	supabase,
	onEdit: (item) => openEditModal(item),
});

onMounted(() => {
	refreshData();
});
</script>
