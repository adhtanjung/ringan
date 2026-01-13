<template>
	<div class="min-h-screen bg-gray-50 overflow-x-hidden w-full max-w-screen">
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
			<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 sm:py-3 w-full">
				<!-- Bulk Edit Toggle Header -->
				<div class="flex items-center justify-between mb-4">
					<div></div>
					<Button
						variant="outline"
						size="sm"
						class="gap-2"
						@click="enterSpreadsheetMode"
					>
						<TableIcon class="h-4 w-4" />
						Bulk Edit Mode
					</Button>
				</div>

				<!-- Dataset Table Container -->
				<div>
					<DatasetTable
						:title="dataTypeLabel"
						:data-type="dataType"
						:data="data"
						:columns="columns"
						:loading="loading"
						:error="error"
						:pagination="pagination"
						:current-page="currentPage"
						:total-pages="totalPages"
						:search-query="searchQuery"
						:filters="filters"
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

			<!-- Detail View Sheet -->
			<Sheet
				:open="showDetailSheet"
				@update:open="(open) => !open && closeDetailSheet()"
			>
				<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
					<div class="p-4 pb-0">
						<SheetHeader class="space-y-1">
							<SheetTitle class="text-lg">Assessment Question</SheetTitle>
							<SheetDescription class="text-sm">
								View detailed information about this question
							</SheetDescription>
						</SheetHeader>
					</div>

					<div class="flex-1 overflow-y-auto px-4">
						<div v-if="viewingItem" class="mt-4 space-y-4">
							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Question Text
								</h4>
								<p class="text-base">{{ viewingItem.question_text }}</p>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Question ID
								</h4>
								<p
									class="text-base font-mono text-sm bg-muted px-3 py-2 rounded-md"
								>
									{{ viewingItem.question_id }}
								</p>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Subcategory
								</h4>
								<button
									@click="openSubCategoryDetail"
									class="text-sm font-medium text-primary underline decoration-2 underline-offset-2 hover:text-primary/80 transition-colors cursor-pointer text-left"
								>
									{{ viewingItem.sub_category_id }}
								</button>
								<p class="text-xs text-muted-foreground mt-0.5">
									Click to view problem details
								</p>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Response Type
								</h4>
								<div class="flex flex-col gap-2">
									<Badge variant="outline" class="w-fit">
										{{
											viewingItem.response_type === "scale"
												? "Scale (1-4)"
												: "Free Text"
										}}
									</Badge>

									<!-- Scale Details -->
									<div
										v-if="viewingItem.response_type === 'scale'"
										class="bg-muted/30 rounded-lg p-3 space-y-2 mt-1 border"
									>
										<h5
											class="text-xs font-semibold uppercase text-muted-foreground"
										>
											Scale Configuration
										</h5>
										<div class="grid grid-cols-1 gap-2 text-sm">
											<div
												class="flex justify-between items-center bg-background p-2 rounded border"
												v-for="i in 4"
												:key="i"
											>
												<span
													class="font-mono text-xs font-bold bg-primary/10 text-primary h-5 w-5 flex items-center justify-center rounded-full"
													>{{ i }}</span
												>
												<span class="text-muted-foreground">{{
													viewingItem[`scale_label_${i}`] || "Not configured"
												}}</span>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div v-if="viewingItem.batch_id" class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Batch Group
								</h4>
								<p class="text-sm">{{ viewingItem.batch_id }}</p>
							</div>

							<div class="space-y-1.5 pt-3 border-t">
								<h4
									class="text-xs font-medium text-muted-foreground uppercase tracking-wide"
								>
									Metadata
								</h4>
								<div class="space-y-0.5 text-xs text-muted-foreground">
									<p v-if="viewingItem.created_at">
										Created: {{ formatDate(viewingItem.created_at) }}
									</p>
									<p v-if="viewingItem.updated_at">
										Updated: {{ formatDate(viewingItem.updated_at) }}
									</p>
									<p v-if="viewingItem.id" class="font-mono">
										ID: {{ viewingItem.id }}
									</p>
								</div>
							</div>
						</div>
					</div>

					<div class="p-4 pt-0">
						<SheetFooter class="mt-4 pt-4 border-t flex-row gap-2">
							<Button
								variant="outline"
								size="sm"
								@click="closeDetailSheet"
								class="flex-1"
							>
								Close
							</Button>
							<Button size="sm" @click="openEditFromDetail" class="flex-1">
								Edit
							</Button>
						</SheetFooter>
					</div>
				</SheetContent>
			</Sheet>

			<!-- Subcategory (Problem) Detail Sheet -->
			<Sheet
				:open="showSubCategorySheet"
				@update:open="(open) => !open && closeSubCategorySheet()"
			>
				<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
					<div class="p-4 pb-0">
						<SheetHeader class="space-y-1">
							<SheetTitle class="text-lg">Problem Details</SheetTitle>
							<SheetDescription class="text-sm">
								Linked subcategory information
							</SheetDescription>
						</SheetHeader>
					</div>

					<div class="flex-1 overflow-y-auto px-4">
						<div v-if="viewingSubCategory" class="mt-4 space-y-4">
							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Problem Name
								</h4>
								<p class="text-base">{{ viewingSubCategory.problem_name }}</p>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Category
								</h4>
								<Badge variant="secondary" class="font-normal">
									{{ viewingSubCategory.category }}
								</Badge>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Subcategory ID
								</h4>
								<p
									class="text-base font-mono text-sm bg-muted px-3 py-2 rounded-md"
								>
									{{ viewingSubCategory.sub_category_id }}
								</p>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Description
								</h4>
								<p class="text-sm leading-relaxed">
									{{ viewingSubCategory.description }}
								</p>
							</div>

							<div v-if="viewingSubCategory.severity_level" class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Severity Level
								</h4>
								<Badge variant="outline">
									Level {{ viewingSubCategory.severity_level }}
								</Badge>
							</div>

							<div class="space-y-2">
								<h4 class="text-sm font-medium text-muted-foreground">
									Status
								</h4>
								<Badge
									variant="outline"
									:class="
										viewingSubCategory.is_active
											? 'bg-green-50 text-green-700 border-green-200'
											: 'bg-red-50 text-red-700 border-red-200'
									"
								>
									{{ viewingSubCategory.is_active ? "Active" : "Inactive" }}
								</Badge>
							</div>
						</div>

						<div
							v-else-if="loadingSubCategory"
							class="mt-6 flex items-center justify-center py-8"
						>
							<div class="flex items-center gap-2 text-muted-foreground">
								<Loader2 class="h-4 w-4 animate-spin" />
								<span class="text-sm">Loading problem details...</span>
							</div>
						</div>
					</div>

					<div class="p-4 pt-0">
						<SheetFooter class="mt-4 pt-4 border-t">
							<Button
								variant="outline"
								size="sm"
								@click="closeSubCategorySheet"
								class="w-full"
							>
								Close
							</Button>
						</SheetFooter>
					</div>
				</SheetContent>
			</Sheet>
		</template>
	</div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { useToast } from "@/components/ui/toast/use-toast";

// Components
import DatasetTable from "@/components/admin/DatasetTable.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import AssessmentModal from "@/components/admin/AssessmentModal.vue";
import SpreadsheetEditor from "@/components/admin/SpreadsheetEditor.vue";

// shadcn-vue components
import { Toaster } from "@/components/ui/toast";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetFooter,
	SheetHeader,
	SheetTitle,
} from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Loader2, Table as TableIcon } from "lucide-vue-next";

// Use the shared composable
const {
	supabase, // Make sure supabase is returned from useSupabase or composable, otherwise import it
	loading,
	dataType,
	error,
	data,
	actionLoading,
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
} = useDatasetManagement("assessments");

const { supabase: supabaseClient } = useSupabase(); // Explicitly get supabase client

// Detail view state
const showDetailSheet = ref(false);
const viewingItem = ref(null);

// Detail view handlers
const openDetailView = (item) => {
	viewingItem.value = item;
	showDetailSheet.value = true;
};

const closeDetailSheet = () => {
	showDetailSheet.value = false;
	setTimeout(() => {
		viewingItem.value = null;
	}, 300);
};

const openEditFromDetail = () => {
	if (viewingItem.value) {
		closeDetailSheet();
		openEditModal(viewingItem.value);
	}
};

// Subcategory (Problem) detail view state
const showSubCategorySheet = ref(false);
const viewingSubCategory = ref(null);
const loadingSubCategory = ref(false);

const openSubCategoryDetail = async () => {
	if (!viewingItem.value?.sub_category_id) return;

	loadingSubCategory.value = true;
	showSubCategorySheet.value = true;

	try {
		const { data: problemData, error: problemError } = await supabaseClient
			.from("problems")
			.select("*")
			.eq("sub_category_id", viewingItem.value.sub_category_id)
			.single();

		if (problemError) throw problemError;

		viewingSubCategory.value = problemData;
	} catch (err) {
		console.error("Error fetching problem:", err);
		viewingSubCategory.value = null;
	} finally {
		loadingSubCategory.value = false;
	}
};

const closeSubCategorySheet = () => {
	showSubCategorySheet.value = false;
	setTimeout(() => {
		viewingSubCategory.value = null;
		loadingSubCategory.value = false;
	}, 300);
};

// Helper functions (mirrored from problems.vue for consistency)
const formatDate = (dateString) => {
	if (!dateString) return "";
	const date = new Date(dateString);
	return date.toLocaleString("en-US", {
		year: "numeric",
		month: "short",
		day: "numeric",
		hour: "2-digit",
		minute: "2-digit",
	});
};

// Lifecycle
onMounted(() => {
	refreshData();
});

// ============================================
// Spreadsheet Mode
// ============================================
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
