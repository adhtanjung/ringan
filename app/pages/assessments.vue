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
						<Button variant="outline" class="h-11 gap-2 px-4 text-sm font-medium" @click="enterSpreadsheetMode" id="tour-bulk-edit">
							<TableIcon class="h-4 w-4" />
							Bulk Edit Mode
						</Button>
						<Button variant="outline" class="h-11 gap-2 px-4 text-sm font-medium" @click="startTour('assessments')">
							<HelpCircle class="h-4 w-4" />
							How this works
						</Button>
					</template>
				</DatasetPageHeader>

				<!-- Card wrapping both views -->
				<div class="overflow-hidden rounded-3xl border border-border/70 bg-card shadow-sm">

					<!-- Toolbar row -->
					<div class="flex items-center gap-3 border-b border-border px-4 py-3">
						<div class="flex items-center gap-1 rounded-lg border border-border bg-muted/40 p-0.5">
							<button
								class="flex items-center gap-1.5 rounded-md px-3 py-1.5 text-xs font-medium transition-colors"
								:class="viewMode === 'list' ? 'bg-background shadow-sm text-foreground' : 'text-muted-foreground hover:text-foreground'"
								@click="viewMode = 'list'"
							>
								<List class="h-3.5 w-3.5" />
								List
							</button>
							<button
								class="flex items-center gap-1.5 rounded-md px-3 py-1.5 text-xs font-medium transition-colors"
								:class="viewMode === 'grouped' ? 'bg-background shadow-sm text-foreground' : 'text-muted-foreground hover:text-foreground'"
								@click="viewMode = 'grouped'"
							>
								<Layers class="h-3.5 w-3.5" />
								Grouped
							</button>
						</div>
						<Transition
							enter-active-class="transition-all duration-150"
							enter-from-class="opacity-0 -translate-x-2"
							enter-to-class="opacity-100 translate-x-0"
							leave-active-class="transition-all duration-100"
							leave-from-class="opacity-100 translate-x-0"
							leave-to-class="opacity-0 -translate-x-2"
						>
							<UInput
								v-if="viewMode === 'grouped'"
								v-model="groupedSearch"
								placeholder="Search categories, subcategories, clusters, questions…"
								icon="i-lucide-search"
								size="sm"
								:trailing-icon="groupedSearch ? 'i-lucide-x' : undefined"
								class="w-80"
								@click:trailing="groupedSearch = ''"
							/>
						</Transition>
					</div>

					<!-- LIST VIEW -->
					<DatasetTable
						v-if="viewMode === 'list'"
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
						class="rounded-none border-0 shadow-none"
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

					<!-- GROUPED VIEW: Category → Subcategory → Cluster → Batch → Questions -->
					<template v-else>
						<div v-if="groupedLoading" class="flex items-center justify-center gap-2 py-20 text-sm text-muted-foreground">
							<UIcon name="i-lucide-loader-circle" class="h-4 w-4 animate-spin" />
							Loading…
						</div>
						<UAlert v-else-if="groupedError" color="error" variant="subtle" :description="groupedError" icon="i-lucide-alert-circle" class="m-4" />

						<!-- Level 1: Category -->
						<UTable
							v-else
							v-model:expanded="catExpanded"
							:data="categoryRows"
							:columns="categoryColumns"
							:ui="{ root: 'min-w-full', tr: 'data-[expanded=true]:bg-elevated/50', td: 'empty:p-0 py-2 px-3', th: 'py-2 px-3 text-xs' }"
						>
							<template #expanded="{ row: catRow }">
								<div class="px-4 py-3 bg-muted/20">
									<!-- Level 2: Subcategory -->
									<UTable
										v-model:expanded="subExpanded"
										:data="getSubsForCategory(catRow.original.category_id)"
										:columns="subcategoryColumns"
										:ui="{ root: 'min-w-full', tr: 'data-[expanded=true]:bg-elevated/50', th: 'bg-muted/40 text-xs py-2 px-3', td: 'empty:p-0 py-2 px-3' }"
										class="rounded-xl border border-border/50 overflow-hidden"
									>
										<template #expanded="{ row: subRow }">
											<div class="px-4 py-3 bg-background/50">
												<!-- Level 3: Cluster -->
												<UTable
													v-model:expanded="clusterExpanded"
													:data="getClustersForSub(subRow.original.sub_category_id)"
													:columns="clusterColumns"
													:ui="{ root: 'min-w-full', tr: 'data-[expanded=true]:bg-elevated/50', th: 'bg-indigo-50/50 dark:bg-indigo-950/20 text-xs py-2 px-3', td: 'empty:p-0 py-2 px-3' }"
													class="rounded-lg border border-indigo-200/40 dark:border-indigo-800/30 overflow-hidden"
												>
													<template #expanded="{ row: clusterRow }">
														<div class="px-4 py-3 bg-background/60">
															<!-- Level 4: Batch -->
															<UTable
																v-model:expanded="batchExpanded"
																:data="getBatchesForCluster(subRow.original.sub_category_id, clusterRow.original.cluster)"
																:columns="batchColumns"
																:ui="{ root: 'min-w-full', tr: 'data-[expanded=true]:bg-elevated/50', th: 'bg-amber-50/50 dark:bg-amber-950/20 text-xs py-2 px-3', td: 'empty:p-0 py-2 px-3' }"
																class="rounded-lg border border-amber-200/40 dark:border-amber-800/30 overflow-hidden"
															>
																<template #expanded="{ row: batchRow }">
																	<div class="px-4 py-2 bg-background/70">
																		<!-- Level 5: Questions -->
																		<UTable
																			:data="getQuestionsForBatch(subRow.original.sub_category_id, clusterRow.original.cluster, batchRow.original.batch_id)"
																			:columns="questionColumns"
																			:ui="{ root: 'min-w-full', th: 'bg-muted/30 text-xs py-1.5 px-3', td: 'py-1.5 px-3 text-xs' }"
																			class="rounded-md border border-border/40 overflow-hidden"
																		>
																			<template #empty>
																				<div class="py-3 text-center text-xs text-muted-foreground italic">No questions.</div>
																			</template>
																		</UTable>
																	</div>
																</template>
																<template #empty>
																	<div class="py-4 text-center text-xs text-muted-foreground">No batches found.</div>
																</template>
															</UTable>
														</div>
													</template>
													<template #empty>
														<div class="py-4 text-center text-xs text-muted-foreground">No clusters found.</div>
													</template>
												</UTable>
											</div>
										</template>
										<template #empty>
											<div class="py-6 text-center text-xs text-muted-foreground">No subcategories found.</div>
										</template>
									</UTable>
								</div>
							</template>
							<template #empty>
								<div class="py-16 text-center text-sm text-muted-foreground">No categories found.</div>
							</template>
						</UTable>
					</template>

				</div>
			</div>

			<!-- Modals & Drawers -->
			<ImportModal :is-open="showImportModal" :data-type="'assessments'" @close="closeImportModal" @import-success="handleImportSuccess" />
			<ExportModal :is-open="showExportModal" :data-type="'assessments'" @close="closeExportModal" />
			<AssessmentModal :is-open="showEditModal" :item="editingItem" @close="closeEditModal" @save="handleSave" />
			<Toaster />
			<AssessmentDetailDrawer
				:open="showDetailSheet" :item="viewingItem" :technical-open="showTechnicalDetails"
				:question-spec="assessmentQuestionIdSpec" :sub-category-spec="assessmentSubCategoryIdSpec"
				:batch-spec="assessmentBatchIdSpec" :record-spec="assessmentRecordIdSpec"
				:sub-category-context="assessmentSubCategoryContext"
				@update:open="(open) => !open && closeDetailSheet()"
				@update:technical-open="(open) => (showTechnicalDetails = open)"
				@edit="openEditFromDetail" @copy-id="copyId"
				@open-single-relation="openSubCategoryDetail" @retry="loadAssessmentSubCategorySummary"
			/>
			<AssessmentProblemDetailDrawer
				:open="showSubCategorySheet" :record="viewingSubCategory" :loading="loadingSubCategory"
				:error="subCategoryLoadError" :technical-open="showSubCategoryTechnicalDetails"
				:sub-category-spec="assessmentProblemSubCategoryIdSpec" :record-spec="assessmentProblemRecordIdSpec"
				:sub-category-context="assessmentProblemSubCategoryContext"
				@update:open="(open) => !open && closeSubCategorySheet()"
				@update:technical-open="(open) => (showSubCategoryTechnicalDetails = open)"
				@copy-id="copyId" @open-list-relation="openLinkedRecords" @retry="openSubCategoryDetail()"
			/>
			<LinkedRecordsSheet
				:open="showLinkedRecordsSheet" :title="linkedRecordsTitle" :description="linkedRecordsDescription"
				:sections="linkedRecordsSections" :loading="linkedRecordsLoading" :error="linkedRecordsError"
				empty-message="No linked records were found for this ID."
				@update:open="(open) => !open && closeLinkedRecordsSheet()" @retry="loadLinkedRecords"
			/>
		</template>
	</div>
</template>

<script setup>
import { computed, h, onMounted, ref, resolveComponent } from "vue";
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
import { HelpCircle, Layers, List, Plus, Table as TableIcon } from "lucide-vue-next";
import { useAssessmentsDrawers } from "@/composables/drawers/useAssessmentsDrawers";
import { useOnboarding } from "@/composables/useOnboarding";

const UButton = resolveComponent("UButton");
const UBadge = resolveComponent("UBadge");

const { startTour } = useOnboarding();
const { supabase: supabaseClient } = useSupabase();

const {
	loading, dataType, error, data, actionLoading, filterOptions,
	showImportModal, showExportModal, showEditModal, editingItem,
	pagination, columns, dataTypeLabel, currentPage, totalPages,
	searchQuery, filters, refreshData, openCreateModal, openEditModal,
	closeEditModal, handleSave, deleteItem, bulkDeleteItems, allMatchingIds,
	openImportModal, closeImportModal, openExportModal, closeExportModal,
	handleImportSuccess, goToPage, changePageSize, nextPage, prevPage,
	setFilter, clearFilters, setSort, sortBy, sortOrder,
} = useDatasetManagement("assessments", { is_active: "true" });

const {
	showDetailSheet, viewingItem, showTechnicalDetails,
	showSubCategorySheet, viewingSubCategory, loadingSubCategory,
	showSubCategoryTechnicalDetails, subCategoryLoadError,
	showLinkedRecordsSheet, linkedRecordsTitle, linkedRecordsDescription,
	linkedRecordsSections, linkedRecordsLoading, linkedRecordsError,
	assessmentQuestionIdSpec, assessmentSubCategoryIdSpec, assessmentBatchIdSpec,
	assessmentRecordIdSpec, assessmentProblemSubCategoryIdSpec,
	assessmentProblemRecordIdSpec, assessmentSubCategoryContext,
	assessmentProblemSubCategoryContext,
	openDetailView, closeDetailSheet, openEditFromDetail, openSubCategoryDetail,
	closeSubCategorySheet, openLinkedRecords, closeLinkedRecordsSheet,
	loadLinkedRecords, loadAssessmentSubCategorySummary, copyId,
} = useAssessmentsDrawers({ supabase: supabaseClient, onEdit: (item) => openEditModal(item) });

// ─── Spreadsheet mode ─────────────────────────────────────────────────────────
const { toast } = useToast();
const isSpreadsheetMode = ref(false);
const allAssessmentsData = ref([]);
const loadingAllData = ref(false);

const spreadsheetColumns = computed(() => [
	{ key: "question_id", label: "Question ID", type: "readonly" },
	{ key: "sub_category_id", label: "Subcategory ID", type: "text", required: true },
	{ key: "question_text", label: "Question Text", type: "text", multiline: true, required: true },
	{ key: "response_type", label: "Response Type", type: "select", required: true, options: [{ value: "scale", label: "Scale (1-4)" }, { value: "free_text", label: "Free Text" }] },
	{ key: "scale_label_1", label: "Label 1", type: "text" },
	{ key: "scale_label_2", label: "Label 2", type: "text" },
	{ key: "scale_label_3", label: "Label 3", type: "text" },
	{ key: "scale_label_4", label: "Label 4", type: "text" },
	{ key: "batch_id", label: "Batch ID", type: "text" },
	{ key: "clusters", label: "Cluster", type: "text" },
	{ key: "order_number", label: "Order", type: "number" },
]);

const fetchAllAssessments = async () => {
	loadingAllData.value = true;
	try {
		const { data: items, error } = await supabaseClient.from("assessments").select("*").order("created_at", { ascending: false });
		if (error) throw error;
		allAssessmentsData.value = items || [];
	} catch (err) {
		toast({ title: "Error", description: "Failed to load assessments for bulk editing.", variant: "destructive" });
	} finally { loadingAllData.value = false; }
};

const enterSpreadsheetMode = async () => { await fetchAllAssessments(); isSpreadsheetMode.value = true; };
const exitSpreadsheetMode = () => { isSpreadsheetMode.value = false; refreshData(); };

const handleBatchSave = async (payload) => {
	const { items, deletedIds } = payload;
	if ((!items || items.length === 0) && (!deletedIds || deletedIds.length === 0)) return;
	try {
		if (deletedIds?.length > 0) {
			const { error: e } = await supabaseClient.from("assessments").update({ is_active: false, updated_at: new Date().toISOString() }).in("id", deletedIds);
			if (e) throw e;
		}
		const newItems = items.filter((i) => !i.id);
		const existingItems = items.filter((i) => i.id);
		if (newItems.length > 0) {
			const { error: e } = await supabaseClient.from("assessments").insert(newItems.map((i) => ({ ...i, is_active: true, created_at: new Date().toISOString(), updated_at: new Date().toISOString() })));
			if (e) throw e;
		}
		for (const item of existingItems) {
			const { error: e } = await supabaseClient.from("assessments").update({ ...item, updated_at: new Date().toISOString() }).eq("id", item.id);
			if (e) throw e;
		}
		await fetchAllAssessments();
		toast({ title: "Success", description: `Processed ${items.length + (deletedIds?.length || 0)} change(s) successfully.` });
	} catch (err) {
		toast({ title: "Error", description: "Failed to save changes. Please try again.", variant: "destructive" });
		throw err;
	}
};

// ─── Grouped view state ───────────────────────────────────────────────────────
const viewMode = ref("list");
const groupedSearch = ref("");
const groupedLoading = ref(false);
const groupedError = ref(null);
// One expanded ref per level — keyed by a unique string per row
const catExpanded = ref({});
const subExpanded = ref({});
const clusterExpanded = ref({});
const batchExpanded = ref({});

const allCategories = ref([]);
const allSubcategories = ref([]);
// allQuestions sorted: sub_category_id → clusters[0] → batch_id → order_number
const allQuestions = ref([]);

const fetchGroupedData = async () => {
	groupedLoading.value = true;
	groupedError.value = null;
	try {
		const [catRes, subRes, qRes] = await Promise.all([
			supabaseClient.from("problem_types").select("category_id, type_name").eq("is_active", true).order("type_name"),
			supabaseClient.from("problems").select("sub_category_id, problem_name, category_id").eq("is_active", true).order("problem_name"),
			supabaseClient.from("assessments")
				.select("id, question_id, question_text, response_type, clusters, order_number, batch_id, sub_category_id")
				.eq("is_active", true)
				.order("sub_category_id", { ascending: true })
				.order("batch_id", { ascending: true, nullsFirst: false })
				.order("order_number", { ascending: true, nullsFirst: false }),
		]);
		if (catRes.error) throw catRes.error;
		if (subRes.error) throw subRes.error;
		if (qRes.error) throw qRes.error;
		allCategories.value = catRes.data ?? [];
		const seen = new Set();
		allSubcategories.value = (subRes.data ?? []).filter((s) => { if (seen.has(s.sub_category_id)) return false; seen.add(s.sub_category_id); return true; });
		allQuestions.value = qRes.data ?? [];
	} catch (err) {
		groupedError.value = err?.message ?? "Failed to load grouped data";
	} finally { groupedLoading.value = false; }
};

// ─── Helpers ──────────────────────────────────────────────────────────────────
function parseClusters(clusters) {
	if (!clusters) return [];
	if (Array.isArray(clusters)) return clusters;
	try { const p = JSON.parse(clusters); return Array.isArray(p) ? p : [String(p)]; } catch { return [String(clusters)]; }
}

const subToCatMap = computed(() => { const m = new Map(); for (const s of allSubcategories.value) m.set(s.sub_category_id, s.category_id); return m; });
const q = computed(() => groupedSearch.value.toLowerCase().trim());

const filteredQuestions = computed(() => {
	if (!q.value) return allQuestions.value;
	return allQuestions.value.filter((q2) => q2.question_text.toLowerCase().includes(q.value) || q2.question_id.toLowerCase().includes(q.value) || (q2.batch_id ?? "").toLowerCase().includes(q.value));
});

const filteredSubcategories = computed(() => {
	if (!q.value) return allSubcategories.value;
	const matchingSubs = new Set(filteredQuestions.value.map((q2) => q2.sub_category_id));
	return allSubcategories.value.filter((s) => s.problem_name.toLowerCase().includes(q.value) || s.sub_category_id.toLowerCase().includes(q.value) || matchingSubs.has(s.sub_category_id));
});

const categoryRows = computed(() =>
	allCategories.value.map((cat) => {
		const subs = filteredSubcategories.value.filter((s) => s.category_id === cat.category_id);
		const qCount = filteredQuestions.value.filter((q2) => subToCatMap.value.get(q2.sub_category_id) === cat.category_id).length;
		return { category_id: cat.category_id, category_name: cat.type_name, sub_count: subs.length, question_count: qCount };
	}).filter((r) => !q.value || r.category_name.toLowerCase().includes(q.value) || r.category_id.toLowerCase().includes(q.value) || r.sub_count > 0),
);

function getSubsForCategory(categoryId) {
	return filteredSubcategories.value.filter((s) => s.category_id === categoryId).map((s) => {
		const qCount = filteredQuestions.value.filter((q2) => q2.sub_category_id === s.sub_category_id).length;
		return { sub_category_id: s.sub_category_id, problem_name: s.problem_name, cluster_count: getClustersForSub(s.sub_category_id).length, question_count: qCount };
	});
}

// Returns unique clusters for a subcategory, sorted alphabetically
function getClustersForSub(subCategoryId) {
	const qs = filteredQuestions.value.filter((q2) => q2.sub_category_id === subCategoryId);
	const clusterSet = new Set();
	for (const q2 of qs) { for (const c of parseClusters(q2.clusters)) clusterSet.add(c); }
	return [...clusterSet].sort().map((cluster) => {
		const batchCount = getBatchesForCluster(subCategoryId, cluster).length;
		const qCount = qs.filter((q2) => parseClusters(q2.clusters).includes(cluster)).length;
		return { cluster, batch_count: batchCount, question_count: qCount };
	});
}

// Returns unique batch_ids for a subcategory+cluster combo, sorted
function getBatchesForCluster(subCategoryId, cluster) {
	const qs = filteredQuestions.value.filter((q2) => q2.sub_category_id === subCategoryId && parseClusters(q2.clusters).includes(cluster));
	const batchSet = new Set();
	for (const q2 of qs) batchSet.add(q2.batch_id ?? "(no batch)");
	return [...batchSet].sort().map((batch_id) => {
		const qCount = qs.filter((q2) => (q2.batch_id ?? "(no batch)") === batch_id).length;
		return { batch_id, question_count: qCount };
	});
}

function getQuestionsForBatch(subCategoryId, cluster, batchId) {
	return filteredQuestions.value
		.filter((q2) => q2.sub_category_id === subCategoryId && parseClusters(q2.clusters).includes(cluster) && (q2.batch_id ?? "(no batch)") === batchId)
		.sort((a, b) => (a.order_number ?? 999) - (b.order_number ?? 999));
}

// ─── Column definitions ───────────────────────────────────────────────────────
const expandBtn = (row, size = "sm") => h(UButton, {
	color: "neutral", variant: "ghost", icon: "i-lucide-chevron-right", square: true, size,
	"aria-label": "Expand",
	ui: { leadingIcon: ["transition-transform duration-200", row.getIsExpanded() ? "rotate-90" : ""] },
	onClick: () => row.toggleExpanded(),
});

const categoryColumns = [
	{ id: "expand", cell: ({ row }) => expandBtn(row), meta: { class: { th: "w-10", td: "w-10" } } },
	{
		accessorKey: "category_name", header: "Category",
		cell: ({ row }) => h("div", { class: "flex items-center gap-2" }, [
			h("span", { class: "font-semibold text-sm" }, row.getValue("category_name")),
			h(UBadge, { variant: "outline", class: "font-mono text-[11px]" }, () => row.original.category_id),
		]),
	},
	{ accessorKey: "sub_count", header: "Subcategories", meta: { class: { th: "text-center w-32", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "primary" }, () => String(row.getValue("sub_count"))) },
	{ accessorKey: "question_count", header: "Questions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "warning" }, () => String(row.getValue("question_count"))) },
];

const subcategoryColumns = [
	{ id: "expand", cell: ({ row }) => expandBtn(row, "xs"), meta: { class: { th: "w-8", td: "w-8" } } },
	{
		accessorKey: "problem_name", header: "Subcategory",
		cell: ({ row }) => h("div", { class: "flex items-center gap-2" }, [
			h("span", { class: "font-medium text-sm" }, row.getValue("problem_name")),
			h(UBadge, { variant: "outline", class: "font-mono text-[11px]" }, () => row.original.sub_category_id),
		]),
	},
	{ accessorKey: "cluster_count", header: "Clusters", meta: { class: { th: "text-center w-24", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "info" }, () => String(row.getValue("cluster_count"))) },
	{ accessorKey: "question_count", header: "Questions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "warning" }, () => String(row.getValue("question_count"))) },
];

const clusterColumns = [
	{ id: "expand", cell: ({ row }) => expandBtn(row, "xs"), meta: { class: { th: "w-8", td: "w-8" } } },
	{
		accessorKey: "cluster", header: "Cluster",
		cell: ({ row }) => h(UBadge, { variant: "subtle", color: "info", class: "text-xs font-medium" }, () => row.getValue("cluster")),
	},
	{ accessorKey: "batch_count", header: "Batches", meta: { class: { th: "text-center w-24", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "neutral" }, () => String(row.getValue("batch_count"))) },
	{ accessorKey: "question_count", header: "Questions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "warning" }, () => String(row.getValue("question_count"))) },
];

const batchColumns = [
	{ id: "expand", cell: ({ row }) => expandBtn(row, "xs"), meta: { class: { th: "w-8", td: "w-8" } } },
	{
		accessorKey: "batch_id", header: "Batch",
		cell: ({ row }) => h("span", { class: "font-mono text-xs font-medium" }, row.getValue("batch_id")),
	},
	{ accessorKey: "question_count", header: "Questions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "warning" }, () => String(row.getValue("question_count"))) },
];

const questionColumns = [
	{ accessorKey: "question_id", header: "ID", meta: { class: { th: "w-28", td: "font-mono text-xs text-muted-foreground" } } },
	{ accessorKey: "question_text", header: "Question", cell: ({ row }) => h("p", { class: "text-xs leading-relaxed" }, row.getValue("question_text")) },
	{
		accessorKey: "response_type", header: "Type", meta: { class: { th: "w-24 text-center", td: "text-center" } },
		cell: ({ row }) => h(UBadge, { variant: "outline", class: "text-[10px]" }, () => row.getValue("response_type")),
	},
	{
		accessorKey: "order_number", header: "Order", meta: { class: { th: "w-16 text-center", td: "text-center text-xs text-muted-foreground" } },
		cell: ({ row }) => row.getValue("order_number") ?? "—",
	},
];

// ─── Lifecycle ────────────────────────────────────────────────────────────────
onMounted(() => {
	setSort("sub_category_id", "asc");
	refreshData();
	fetchGroupedData();
});
</script>
