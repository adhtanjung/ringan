<template>
	<div class="min-h-screen w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Suggestion library"
				title="Suggestions"
				description="Manage the guidance shown to users after assessments and keep the advice consistent across the product."
				:total="pagination.total"
				total-label="suggestions"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Suggestion
					</Button>
					<Button
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
						@click="startTour('suggestions')"
					>
						<HelpCircle class="h-4 w-4" />
						How this works
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
					:show-create-button="false"
					class="overflow-hidden rounded-3xl border border-border/70 bg-card shadow-sm"
					@create="openCreateModal"
					@edit="openEditModal"
					@view="openDetailView"
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
				/>
			</div>
		</div>

		<!-- Import Modal -->
		<ImportModal
			:is-open="showImportModal"
			:data-type="'suggestions'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<!-- Export Modal -->
		<ExportModal
			:is-open="showExportModal"
			:data-type="'suggestions'"
			@close="closeExportModal"
		/>

		<!-- Edit Modal -->
		<DatasetEditModalShadcn
			:is-open="showEditModal"
			:data-type="'suggestions'"
			:item="editingItem"
			:loading="actionLoading"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<SuggestionDetailDrawer
			:open="showDetailSheet"
			:item="viewingItem"
			:technical-open="showTechnicalDetails"
			:suggestion-spec="suggestionIdSpec"
			:sub-category-spec="suggestionSubCategoryIdSpec"
			:record-spec="suggestionRecordIdSpec"
			:sub-category-context="suggestionSubCategoryContext"
			@update:open="(open) => !open && closeDetailSheet()"
			@update:technical-open="(open) => (showTechnicalDetails = open)"
			@edit="openEditFromDetail"
			@copy-id="copyId"
			@open-single-relation="openSubCategoryDetail"
			@retry="loadSuggestionSubCategorySummary"
		/>

		<SuggestionProblemDetailDrawer
			:open="showSubCategorySheet"
			:record="viewingSubCategory"
			:loading="loadingSubCategory"
			:error="subCategoryLoadError"
			:sub-category-spec="suggestionLinkedProblemSubCategorySpec"
			:record-spec="suggestionLinkedProblemRecordIdSpec"
			@update:open="(open) => !open && closeSubCategorySheet()"
			@copy-id="copyId"
			@retry="openSubCategoryDetail()"
		/>

		<Toaster />
	</div>
</template>

<script setup>
import { onMounted } from "vue";

import SuggestionDetailDrawer from "@/components/admin/drawers/suggestions/SuggestionDetailDrawer.vue";
import SuggestionProblemDetailDrawer from "@/components/admin/drawers/suggestions/SuggestionProblemDetailDrawer.vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import DatasetEditModalShadcn from "@/components/admin/DatasetEditModalShadcn.vue";
import { HelpCircle, Plus } from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";
import { useSuggestionsDrawers } from "@/composables/drawers/useSuggestionsDrawers";
import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";

// Use the shared composables
const { startTour } = useOnboarding();
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
} = useDatasetManagement("suggestions", { is_active: "true" });

const { supabase } = useSupabase();
const {
	showDetailSheet,
	viewingItem,
	showTechnicalDetails,
	showSubCategorySheet,
	viewingSubCategory,
	loadingSubCategory,
	subCategoryLoadError,
	suggestionIdSpec,
	suggestionSubCategoryIdSpec,
	suggestionRecordIdSpec,
	suggestionLinkedProblemSubCategorySpec,
	suggestionLinkedProblemRecordIdSpec,
	suggestionSubCategoryContext,
	openDetailView,
	closeDetailSheet,
	openEditFromDetail,
	openSubCategoryDetail,
	closeSubCategorySheet,
	loadSuggestionSubCategorySummary,
	copyId,
} = useSuggestionsDrawers({
	supabase,
	onEdit: (item) => openEditModal(item),
});

// Lifecycle
onMounted(() => {
	refreshData();
});
</script>
