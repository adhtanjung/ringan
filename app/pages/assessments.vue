<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<!-- Spreadsheet Mode -->
		<SpreadsheetEditor
			v-if="isSpreadsheetMode"
			:data="allAssessmentsData"
			:columns="spreadsheetColumns"
			data-type="assessments"
			@exit="exitSpreadsheetMode"
			@save="handleBatchSave"
		/>

		<!-- Normal Mode -->
		<template v-else>
			<!-- Main Container -->
			<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
				<DatasetPageHeader
					eyebrow="Assessment engine"
					title="Assessments"
					description="Create and manage assessment questions, or switch to spreadsheet mode when you need to edit many rows at once."
					:total="pagination.total"
					total-label="assessment questions"
					:page-count="data.length"
					:search-query="searchQuery"
					:filters="filters"
				>
					<template #actions>
						<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
							<Plus class="h-4 w-4" />
							New Question
						</Button>
						<Button
							variant="outline"
							class="h-11 gap-2 px-4 text-sm font-medium"
							@click="enterSpreadsheetMode"
							id="tour-bulk-edit"
						>
							<TableIcon class="h-4 w-4" />
							Bulk Edit Mode
						</Button>
						<Button
							variant="outline"
							class="h-11 gap-2 px-4 text-sm font-medium"
							@click="startTour('assessments')"
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
						@view="openDetailView"
					/>
				</div>
			</div>

			<!-- Import Modal -->
			<ImportModal
				:is-open="showImportModal"
				:data-type="'assessments'"
				@close="closeImportModal"
				@import-success="handleImportSuccess"
			/>

			<!-- Export Modal -->
			<ExportModal
				:is-open="showExportModal"
				:data-type="'assessments'"
				@close="closeExportModal"
			/>

			<!-- Assessment Modal -->
			<AssessmentModal
				:is-open="showEditModal"
				:item="editingItem"
				@close="closeEditModal"
				@save="handleSave"
			/>

			<!-- Toast Notifications -->
			<Toaster />

			<AssessmentDetailDrawer
				:open="showDetailSheet"
				:item="viewingItem"
				:technical-open="showTechnicalDetails"
				:question-spec="assessmentQuestionIdSpec"
				:sub-category-spec="assessmentSubCategoryIdSpec"
				:batch-spec="assessmentBatchIdSpec"
				:record-spec="assessmentRecordIdSpec"
				:sub-category-context="assessmentSubCategoryContext"
				@update:open="(open) => !open && closeDetailSheet()"
				@update:technical-open="(open) => (showTechnicalDetails = open)"
				@edit="openEditFromDetail"
				@copy-id="copyId"
				@open-single-relation="openSubCategoryDetail"
				@retry="loadAssessmentSubCategorySummary"
			/>

			<AssessmentProblemDetailDrawer
				:open="showSubCategorySheet"
				:record="viewingSubCategory"
				:loading="loadingSubCategory"
				:error="subCategoryLoadError"
				:technical-open="showSubCategoryTechnicalDetails"
				:sub-category-spec="assessmentProblemSubCategoryIdSpec"
				:record-spec="assessmentProblemRecordIdSpec"
				:sub-category-context="assessmentProblemSubCategoryContext"
				@update:open="(open) => !open && closeSubCategorySheet()"
				@update:technical-open="(open) => (showSubCategoryTechnicalDetails = open)"
				@copy-id="copyId"
				@open-list-relation="openLinkedRecords"
				@retry="openSubCategoryDetail()"
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
			</template>
		</div>
	</template>

<script setup>
import { computed, onMounted, ref } from "vue";
import { useToast } from "@/components/ui/toast/use-toast";

import AssessmentDetailDrawer from "@/components/admin/drawers/assessments/AssessmentDetailDrawer.vue";
import AssessmentModal from "@/components/admin/AssessmentModal.vue";
import AssessmentProblemDetailDrawer from "@/components/admin/drawers/assessments/AssessmentProblemDetailDrawer.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import LinkedRecordsSheet from "@/components/admin/LinkedRecordsSheet.vue";
import SpreadsheetEditor from "@/components/admin/SpreadsheetEditor.vue";
import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";
import { HelpCircle, Plus, Table as TableIcon } from "lucide-vue-next";
import { useAssessmentsDrawers } from "@/composables/drawers/useAssessmentsDrawers";
import { useOnboarding } from "@/composables/useOnboarding";

const { startTour } = useOnboarding();
const { supabase: supabaseClient } = useSupabase();

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
} = useDatasetManagement("assessments", { is_active: "true" });

const {
	showDetailSheet,
	viewingItem,
	showTechnicalDetails,
	showSubCategorySheet,
	viewingSubCategory,
	loadingSubCategory,
	showSubCategoryTechnicalDetails,
	subCategoryLoadError,
	showLinkedRecordsSheet,
	linkedRecordsTitle,
	linkedRecordsDescription,
	linkedRecordsSections,
	linkedRecordsLoading,
	linkedRecordsError,
	assessmentQuestionIdSpec,
	assessmentSubCategoryIdSpec,
	assessmentBatchIdSpec,
	assessmentRecordIdSpec,
	assessmentProblemSubCategoryIdSpec,
	assessmentProblemRecordIdSpec,
	assessmentSubCategoryContext,
	assessmentProblemSubCategoryContext,
	openDetailView,
	closeDetailSheet,
	openEditFromDetail,
	openSubCategoryDetail,
	closeSubCategorySheet,
	openLinkedRecords,
	closeLinkedRecordsSheet,
	loadLinkedRecords,
	loadAssessmentSubCategorySummary,
	copyId,
} = useAssessmentsDrawers({
	supabase: supabaseClient,
	onEdit: (item) => openEditModal(item),
});

onMounted(() => {
	refreshData();
});

const { toast } = useToast();
const isSpreadsheetMode = ref(false);
const allAssessmentsData = ref([]);
const loadingAllData = ref(false);

// Define columns for spreadsheet editing
const spreadsheetColumns = computed(() => [
	{ key: "question_id", label: "Question ID", type: "readonly" },
	{
		key: "sub_category_id",
		label: "Subcategory ID",
		type: "text",
		required: true,
	},
	{
		key: "question_text",
		label: "Question Text",
		type: "text",
		multiline: true,
		required: true,
	},
	{
		key: "response_type",
		label: "Response Type",
		type: "select",
		required: true,
		options: [
			{ value: "scale", label: "Scale (1-4)" },
			{ value: "free_text", label: "Free Text" },
		],
	},
	{ key: "scale_label_1", label: "Label 1", type: "text" },
	{ key: "scale_label_2", label: "Label 2", type: "text" },
	{ key: "scale_label_3", label: "Label 3", type: "text" },
	{ key: "scale_label_4", label: "Label 4", type: "text" },
	{ key: "batch_id", label: "Batch ID", type: "text" },
	{ key: "clusters", label: "Cluster", type: "text" },
	{ key: "order_number", label: "Order", type: "number" },
]);

// Fetch all assessments for spreadsheet mode (no pagination)
const fetchAllAssessments = async () => {
	loadingAllData.value = true;
	try {
		const { data: items, error } = await supabaseClient
			.from("assessments")
			.select("*")
			.order("created_at", { ascending: false });

		if (error) throw error;
		allAssessmentsData.value = items || [];
	} catch (err) {
		console.error("Error fetching all assessments:", err);
		toast({
			title: "Error",
			description: "Failed to load assessments for bulk editing.",
			variant: "destructive",
		});
	} finally {
		loadingAllData.value = false;
	}
};

const enterSpreadsheetMode = async () => {
	await fetchAllAssessments();
	isSpreadsheetMode.value = true;
};

const exitSpreadsheetMode = () => {
	isSpreadsheetMode.value = false;
	// Refresh the normal table data
	refreshData();
};

const handleBatchSave = async (payload) => {
	const { items, deletedIds } = payload;

	if (
		(!items || items.length === 0) &&
		(!deletedIds || deletedIds.length === 0)
	) {
		return;
	}

	try {
		// Soft delete removed rows (set is_active to false)
		if (deletedIds && deletedIds.length > 0) {
			const { error: deleteError } = await supabaseClient
				.from("assessments")
				.update({ is_active: false, updated_at: new Date().toISOString() })
				.in("id", deletedIds);

			if (deleteError) throw deleteError;
		}

		// Separate new items (no id) from existing items
		const newItems = items.filter((item) => !item.id);
		const existingItems = items.filter((item) => item.id);

		// Insert new items
		if (newItems.length > 0) {
			const itemsToInsert = newItems.map((item) => ({
				...item,
				is_active: true,
				created_at: new Date().toISOString(),
				updated_at: new Date().toISOString(),
			}));

			const { error: insertError } = await supabaseClient
				.from("assessments")
				.insert(itemsToInsert);

			if (insertError) throw insertError;
		}

		// Update existing items
		for (const item of existingItems) {
			const { error: updateError } = await supabaseClient
				.from("assessments")
				.update({
					...item,
					updated_at: new Date().toISOString(),
				})
				.eq("id", item.id);

			if (updateError) throw updateError;
		}

		// Refresh the data
		await fetchAllAssessments();

		const totalChanges = items.length + (deletedIds?.length || 0);
		toast({
			title: "Success",
			description: `Processed ${totalChanges} change(s) successfully.`,
		});
	} catch (err) {
		console.error("Batch save error:", err);
		toast({
			title: "Error",
			description: "Failed to save changes. Please try again.",
			variant: "destructive",
		});
		throw err;
	}
};
</script>
