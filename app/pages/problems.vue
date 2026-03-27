<template>
	<div class="min-h-screen w-full max-w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Problem taxonomy"
				title="Subcategories"
				description="Manage the subcategories underneath each category and keep the assessment tree easy to scan."
				:total="pagination.total"
				total-label="subcategories"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Subcategory
					</Button>
					<Button
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
						@click="startTour('problems')"
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
					@bulk-update="bulkUpdateItems"
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
					:categories="problemCategories"
					:sub-categories="subCategories"
				/>
			</div>
		</div>

		<ImportModal
			:is-open="showImportModal"
			:data-type="'problems'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'problems'"
			@close="closeExportModal"
		/>

		<ProblemModal
			:is-open="showEditModal"
			:item="editingItem"
			@close="closeEditModal"
			@save="handleSave"
		/>

			<Toaster />
			<ProblemDetailDrawer
				:open="showDetailSheet"
				:item="viewingItem"
				:technical-open="showTechnicalDetails"
				:category-spec="problemsCategoryIdSpec"
				:sub-category-spec="problemsSubCategoryIdSpec"
				:record-spec="problemsRecordIdSpec"
				:category-context="problemsCategoryContext"
				:sub-category-context="problemsSubCategoryContext"
				@update:open="(open) => !open && closeDetailSheet()"
				@update:technical-open="(open) => (showTechnicalDetails = open)"
				@edit="openEditFromDetail"
				@copy-id="copyId"
				@open-single-relation="openCategoryDetail"
				@open-list-relation="openLinkedRecords"
				@retry="() => { loadProblemsCategorySummary(); loadProblemsSubCategorySummary(); }"
			/>

			<ProblemCategoryDetailDrawer
				:open="showCategorySheet"
				:record="viewingCategory"
				:loading="loadingCategory"
				:error="categoryLoadError"
				:technical-open="showCategoryTechnicalDetails"
				:category-spec="categoryDetailCategoryIdSpec"
				:record-spec="categoryDetailRecordIdSpec"
				:category-context="problemsCategoryDetailContext"
				@update:open="(open) => !open && closeCategorySheet()"
				@update:technical-open="(open) => (showCategoryTechnicalDetails = open)"
				@copy-id="copyId"
				@open-list-relation="openLinkedRecords"
				@retry="() => { openCategoryDetail(); loadCategoryDetailSummary(); }"
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
import { onMounted, ref } from "vue";

// Components
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ProblemModal from "@/components/admin/ProblemModal.vue";
import LinkedRecordsSheet from "@/components/admin/LinkedRecordsSheet.vue";
import ProblemDetailDrawer from "@/components/admin/drawers/problems/ProblemDetailDrawer.vue";
import ProblemCategoryDetailDrawer from "@/components/admin/drawers/problems/ProblemCategoryDetailDrawer.vue";

// shadcn-vue components
import { Toaster } from "@/components/ui/toast";
import { Button } from "@/components/ui/button";
import { HelpCircle, Plus } from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";
import { useProblemsDrawers } from "@/composables/drawers/useProblemsDrawers";

// Composables
const { supabase } = useSupabase();
const { startTour } = useOnboarding();

// Use the shared composable
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
} = useDatasetManagement("problems", { is_active: "true" });

const {
	showDetailSheet,
	viewingItem,
	showTechnicalDetails,
	showCategorySheet,
	viewingCategory,
	showCategoryTechnicalDetails,
	loadingCategory,
	categoryLoadError,
	showLinkedRecordsSheet,
	linkedRecordsTitle,
	linkedRecordsDescription,
	linkedRecordsSections,
	linkedRecordsLoading,
	linkedRecordsError,
	problemsCategoryIdSpec,
	problemsSubCategoryIdSpec,
	problemsRecordIdSpec,
	categoryDetailCategoryIdSpec,
	categoryDetailRecordIdSpec,
	problemsCategoryContext,
	problemsSubCategoryContext,
	problemsCategoryDetailContext,
	openDetailView,
	closeDetailSheet,
	openEditFromDetail,
	openCategoryDetail,
	closeCategorySheet,
	openLinkedRecords,
	closeLinkedRecordsSheet,
	loadLinkedRecords,
	loadProblemsCategorySummary,
	loadProblemsSubCategorySummary,
	loadCategoryDetailSummary,
	copyId,
} = useProblemsDrawers({
	supabase,
	onEdit: (item) => openEditModal(item),
});

const problemCategories = ref([]);
const subCategories = ref([]);

const fetchCategories = async () => {
	try {
		const { data: catData, error: catError } = await supabase
			.from("problem_types")
			.select("type_name")
			.eq("is_active", true)
			.order("type_name", { ascending: true });

		if (catError) throw catError;
		problemCategories.value = catData.map((c) => c.type_name);
	} catch (err) {
		console.error("Error fetching categories:", err);
	}
};

const fetchSubCategories = async () => {
	try {
		const { data: subData, error: subError } = await supabase
			.from("problems")
			.select("sub_category_id, problem_name")
			.eq("is_active", true)
			.order("sub_category_id", { ascending: true });

		if (subError) throw subError;

		// Get unique entries based on sub_category_id
		const seenIds = new Set();
		const formattedSubCategories = [];

		for (const item of subData) {
			if (!seenIds.has(item.sub_category_id)) {
				seenIds.add(item.sub_category_id);
				formattedSubCategories.push({
					id: item.sub_category_id,
					name: item.problem_name,
				});
			}
		}

		subCategories.value = formattedSubCategories;
	} catch (err) {
		console.error("Error fetching subcategories:", err);
	}
};

// Lifecycle
onMounted(() => {
	refreshData();
	fetchCategories();
	fetchSubCategories();
});
</script>
