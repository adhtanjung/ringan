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

			<!-- Detail View Sheet -->
			<Sheet
				:open="showDetailSheet"
				@update:open="(open) => !open && closeDetailSheet()"
			>
				<SheetContent class="flex h-full w-full flex-col p-0 sm:max-w-lg">
					<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
						<SheetHeader class="space-y-1">
							<SheetTitle class="text-lg">Assessment Question</SheetTitle>
							<SheetDescription class="text-sm">
								View detailed information about this question
							</SheetDescription>
						</SheetHeader>
					</div>

					<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
						<div v-if="viewingItem" class="space-y-4">
							<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Question text
								</p>
								<p class="mt-2 text-lg font-semibold leading-tight text-foreground">
									{{ viewingItem.question_text }}
								</p>
								<div class="mt-4 flex flex-wrap gap-2">
									<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
										{{ viewingItem.response_type === "scale" ? "Scale (1-4)" : "Free Text" }}
									</Badge>
									<Badge variant="outline" class="h-6 rounded-full px-2 text-[11px] font-medium text-muted-foreground">
										{{ viewingItem.sub_category_id || "Unassigned subcategory" }}
									</Badge>
								</div>
								<div class="mt-4 grid gap-3 sm:grid-cols-2">
									<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
										<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Question ID
										</p>
										<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
											<p class="min-w-0 break-all text-sm text-foreground">
												{{ viewingItem.question_id || "-" }}
											</p>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy question ID'"
												:aria-label="'Copy question ID'"
												:disabled="!viewingItem.question_id"
												@click="copyId(viewingItem.question_id, 'Question ID')"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</div>
									</div>
									<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
										<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Subcategory ID
										</p>
										<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
											<p class="min-w-0 break-all text-sm text-foreground">
												{{ viewingItem.sub_category_id || "-" }}
											</p>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy subcategory ID'"
												:aria-label="'Copy subcategory ID'"
												:disabled="!viewingItem.sub_category_id"
												@click="copyId(viewingItem.sub_category_id, 'Subcategory ID')"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</div>
									</div>
								</div>
								<div class="mt-4 space-y-1">
									<p class="text-sm font-medium text-muted-foreground">Subcategory</p>
									<Button
										type="button"
										variant="outline"
										class="h-11 w-full justify-between px-4 text-left"
										@click="openSubCategoryDetail"
									>
										<span class="text-sm font-medium">Open linked problem details</span>
										<ChevronDown class="h-4 w-4 -rotate-90" />
									</Button>
								</div>
							</div>

							<Collapsible v-model:open="showTechnicalDetails" class="space-y-2">
								<div class="flex items-center justify-between gap-3">
									<div class="space-y-1">
										<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Advanced details
										</p>
										<p class="text-sm text-muted-foreground">
											Technical metadata for auditing and support.
										</p>
									</div>

									<CollapsibleTrigger as-child>
										<Button variant="ghost" size="sm" class="h-9 gap-2 px-3">
											{{ showTechnicalDetails ? "Hide" : "Show" }}
											<ChevronDown
												class="h-4 w-4 transition-transform duration-200"
												:class="showTechnicalDetails ? 'rotate-180' : ''"
											/>
										</Button>
									</CollapsibleTrigger>
								</div>

								<CollapsibleContent class="space-y-2">
									<div class="rounded-2xl border border-border/70 bg-muted/30 p-4">
										<dl class="grid gap-4 text-sm sm:grid-cols-2">
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Question ID
												</dt>
												<dd class="flex items-center gap-2">
													<span class="min-w-0 break-all text-foreground">
														{{ viewingItem.question_id || "-" }}
													</span>
													<Button
														type="button"
														variant="ghost"
														size="icon"
														class="h-11 w-11 shrink-0"
														:title="'Copy question ID'"
														:aria-label="'Copy question ID'"
														:disabled="!viewingItem.question_id"
														@click="copyId(viewingItem.question_id, 'Question ID')"
													>
														<Copy class="h-4 w-4" />
													</Button>
												</dd>
											</div>
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Batch Group
												</dt>
												<dd class="break-words text-foreground">
													{{ viewingItem.batch_id || "-" }}
												</dd>
											</div>
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Cluster
												</dt>
												<dd class="break-words text-foreground">
													{{ viewingItem.clusters || "-" }}
												</dd>
											</div>
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Order
												</dt>
												<dd class="break-words text-foreground">
													{{ viewingItem.order_number ?? "-" }}
												</dd>
											</div>
											<div class="space-y-1 sm:col-span-2">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Metadata
												</dt>
												<dd class="space-y-0.5 break-words text-foreground">
													<p v-if="viewingItem.created_at">
														Created: {{ formatDate(viewingItem.created_at) }}
													</p>
													<p v-if="viewingItem.updated_at">
														Updated: {{ formatDate(viewingItem.updated_at) }}
													</p>
												</dd>
											</div>
											<div class="space-y-1 sm:col-span-2">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													System ID
												</dt>
												<dd class="flex items-center gap-2">
													<span class="min-w-0 break-all text-foreground">
														{{ viewingItem.id || "-" }}
													</span>
													<Button
														type="button"
														variant="ghost"
														size="icon"
														class="h-11 w-11 shrink-0"
														:title="'Copy record ID'"
														:aria-label="'Copy record ID'"
														:disabled="!viewingItem.id"
														@click="copyId(viewingItem.id, 'Record ID')"
													>
														<Copy class="h-4 w-4" />
													</Button>
												</dd>
											</div>
										</dl>

										<div v-if="viewingItem.response_type === 'scale'" class="mt-4 space-y-3">
											<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
												Scale labels
											</p>
											<div class="space-y-2">
												<div
													v-for="i in 4"
													:key="i"
													class="flex items-center justify-between gap-3 rounded-xl border border-border/70 bg-background px-3 py-2 text-sm"
												>
													<span class="font-mono text-xs font-semibold text-primary">
														{{ i }}
													</span>
													<span class="text-right text-muted-foreground">
														{{ viewingItem[`scale_label_${i}`] || "Not configured" }}
													</span>
												</div>
											</div>
										</div>
									</div>
								</CollapsibleContent>
							</Collapsible>
						</div>
					</div>

					<div class="border-t border-border/70 bg-background px-4 py-4 sm:px-6">
						<SheetFooter class="flex-row gap-2">
							<Button variant="outline" size="sm" @click="closeDetailSheet" class="flex-1">
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
				<SheetContent class="flex h-full w-full flex-col p-0 sm:max-w-lg">
					<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
						<SheetHeader class="space-y-1">
							<SheetTitle class="text-lg">Problem Details</SheetTitle>
							<SheetDescription class="text-sm">
								Linked subcategory information
							</SheetDescription>
						</SheetHeader>
					</div>

					<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
						<div v-if="viewingSubCategory" class="space-y-4">
							<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Problem name
								</p>
								<p class="mt-2 text-lg font-semibold leading-tight text-foreground">
									{{ viewingSubCategory.problem_name }}
								</p>
								<div class="mt-4 flex flex-wrap gap-2">
									<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
										{{ viewingSubCategory.category || "Unknown category" }}
									</Badge>
									<Badge
										v-if="viewingSubCategory.severity_level"
										variant="outline"
										class="h-6 rounded-full px-2 text-[11px] font-medium"
									>
										Level {{ viewingSubCategory.severity_level }}
									</Badge>
								</div>
								<div class="mt-4 space-y-1">
									<p class="text-sm font-medium text-muted-foreground">Description</p>
									<p class="text-sm leading-relaxed text-foreground">
										{{ viewingSubCategory.description || "No description provided." }}
									</p>
								</div>
							</div>

							<div class="grid gap-3 sm:grid-cols-2">
								<div class="rounded-2xl border border-border/70 bg-background p-4">
									<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
										Subcategory ID
									</p>
									<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
										<p class="min-w-0 break-all text-sm font-medium text-foreground">
											{{ viewingSubCategory.sub_category_id || "-" }}
										</p>
										<Button
											type="button"
											variant="ghost"
											size="icon"
											class="h-11 w-11 shrink-0"
											:title="'Copy subcategory ID'"
											:aria-label="'Copy subcategory ID'"
											:disabled="!viewingSubCategory.sub_category_id"
											@click="copyId(viewingSubCategory.sub_category_id, 'Subcategory ID')"
										>
											<Copy class="h-4 w-4" />
										</Button>
									</div>
								</div>
								<div class="rounded-2xl border border-border/70 bg-background p-4">
									<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
										Record ID
									</p>
									<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
										<p class="min-w-0 break-all text-sm font-medium text-foreground">
											{{ viewingSubCategory.id || "-" }}
										</p>
										<Button
											type="button"
											variant="ghost"
											size="icon"
											class="h-11 w-11 shrink-0"
											:title="'Copy record ID'"
											:aria-label="'Copy record ID'"
											:disabled="!viewingSubCategory.id"
											@click="copyId(viewingSubCategory.id, 'Record ID')"
										>
											<Copy class="h-4 w-4" />
										</Button>
									</div>
								</div>
							</div>

							<Collapsible v-model:open="showSubCategoryTechnicalDetails" class="space-y-2">
								<div class="flex items-center justify-between gap-3">
									<div class="space-y-1">
										<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Advanced details
										</p>
										<p class="text-sm text-muted-foreground">
											Technical metadata for auditing and support.
										</p>
									</div>

									<CollapsibleTrigger as-child>
										<Button variant="ghost" size="sm" class="h-9 gap-2 px-3">
											{{ showSubCategoryTechnicalDetails ? "Hide" : "Show" }}
											<ChevronDown
												class="h-4 w-4 transition-transform duration-200"
												:class="showSubCategoryTechnicalDetails ? 'rotate-180' : ''"
											/>
										</Button>
									</CollapsibleTrigger>
								</div>

								<CollapsibleContent class="space-y-2">
									<div class="rounded-2xl border border-border/70 bg-muted/30 p-4">
										<dl class="grid gap-4 text-sm sm:grid-cols-2">
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Category
												</dt>
												<dd class="break-words text-foreground">
													{{ viewingSubCategory.category || "-" }}
												</dd>
											</div>
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Created
												</dt>
												<dd class="break-words text-foreground">
													{{ viewingSubCategory.created_at ? formatDate(viewingSubCategory.created_at) : "-" }}
												</dd>
											</div>
											<div class="space-y-1">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Updated
												</dt>
												<dd class="break-words text-foreground">
													{{ viewingSubCategory.updated_at ? formatDate(viewingSubCategory.updated_at) : "-" }}
												</dd>
											</div>
										</dl>
									</div>
								</CollapsibleContent>
							</Collapsible>
						</div>

						<div v-else-if="loadingSubCategory" class="mt-6 flex items-center justify-center py-8">
							<div class="flex items-center gap-2 text-muted-foreground">
								<Loader2 class="h-4 w-4 animate-spin" />
								<span class="text-sm">Loading problem details...</span>
							</div>
						</div>
						<div
							v-else-if="subCategoryLoadError"
							class="mt-6 rounded-2xl border border-destructive/40 bg-destructive/5 p-4"
						>
							<div class="flex items-start gap-3">
								<AlertCircle class="mt-0.5 h-4 w-4 shrink-0 text-destructive" />
								<div class="space-y-2">
									<p class="text-sm font-medium text-foreground">Couldn’t load linked problem</p>
									<p class="text-sm text-muted-foreground">
										{{ subCategoryLoadError }}
									</p>
									<Button
										type="button"
										variant="outline"
										size="sm"
										class="h-10"
										@click="openSubCategoryDetail"
									>
										Try again
									</Button>
								</div>
							</div>
						</div>
					</div>

					<div class="border-t border-border/70 bg-background px-4 py-4 sm:px-6">
						<SheetFooter>
							<Button variant="outline" size="sm" @click="closeSubCategorySheet" class="w-full">
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
import { formatDate } from "@/utils/formatDate";

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
import {
	ChevronDown,
	Loader2,
	Table as TableIcon,
	HelpCircle,
	Plus,
	Copy,
	AlertCircle,
} from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import {
	Collapsible,
	CollapsibleContent,
	CollapsibleTrigger,
} from "@/components/ui/collapsible";

// Use the shared composable
const {
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

const { startTour } = useOnboarding();
const { supabase: supabaseClient } = useSupabase(); // Explicitly get supabase client

// Detail view state
const showDetailSheet = ref(false);
const viewingItem = ref(null);
const showTechnicalDetails = ref(false);

// Detail view handlers
const openDetailView = (item) => {
	viewingItem.value = item;
	showTechnicalDetails.value = false;
	showDetailSheet.value = true;
};

const closeDetailSheet = () => {
	showDetailSheet.value = false;
	setTimeout(() => {
		viewingItem.value = null;
		showTechnicalDetails.value = false;
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
const showSubCategoryTechnicalDetails = ref(false);
const subCategoryLoadError = ref("");

const openSubCategoryDetail = async () => {
	const linkedSubCategoryId = viewingItem.value?.sub_category_id;

	showSubCategoryTechnicalDetails.value = false;
	subCategoryLoadError.value = "";
	showSubCategorySheet.value = true;
	viewingSubCategory.value = null;

	if (!linkedSubCategoryId) {
		loadingSubCategory.value = false;
		subCategoryLoadError.value =
			"This assessment question is not linked to a subcategory yet.";
		return;
	}

	loadingSubCategory.value = true;

	try {
		const { data: problemData, error: problemError } = await supabaseClient
			.from("problems")
			.select("*")
			.eq("sub_category_id", linkedSubCategoryId)
			.eq("is_active", true)
			.maybeSingle();

		if (problemError) throw problemError;
		if (!problemData) {
			subCategoryLoadError.value =
				"We couldn't find an active subcategory record for this question.";
			return;
		}

		viewingSubCategory.value = problemData;
		subCategoryLoadError.value = "";
	} catch (err) {
		console.error("Error fetching problem:", err);
		viewingSubCategory.value = null;
		subCategoryLoadError.value =
			"We couldn't load linked problem details. Please try again.";
	} finally {
		loadingSubCategory.value = false;
	}
};

const closeSubCategorySheet = () => {
	showSubCategorySheet.value = false;
	setTimeout(() => {
		viewingSubCategory.value = null;
		loadingSubCategory.value = false;
		showSubCategoryTechnicalDetails.value = false;
		subCategoryLoadError.value = "";
	}, 300);
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

const copyId = async (value, label) => {
	if (value === null || value === undefined || value === "") {
		toast({
			title: `${label} not available`,
			description: "Nothing to copy for this record.",
			variant: "destructive",
		});
		return;
	}

	if (
		typeof navigator === "undefined" ||
		!navigator.clipboard ||
		typeof navigator.clipboard.writeText !== "function"
	) {
		toast({
			title: "Copy is not supported",
			description: "Clipboard access is unavailable in this browser context.",
			variant: "destructive",
		});
		return;
	}

	try {
		await navigator.clipboard.writeText(String(value));
		toast({
			title: `${label} copied`,
			description: String(value),
		});
	} catch (error) {
		console.error(`Failed to copy ${label}:`, error);
		toast({
			title: "Copy failed",
			description: "Unable to copy to clipboard. Please try again.",
			variant: "destructive",
		});
	}
};
</script>
