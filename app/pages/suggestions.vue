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
					<Button variant="outline" class="h-11 gap-2 px-4 text-sm font-medium" @click="startTour('suggestions')">
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
							placeholder="Search categories, subcategories, clusters, suggestions…"
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
					:show-create-button="false"
					class="rounded-none border-0 shadow-none"
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

				<!-- GROUPED VIEW: Category → Subcategory → Cluster → Suggestions -->
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
												:ui="{ root: 'min-w-full', tr: 'data-[expanded=true]:bg-elevated/50', th: 'bg-emerald-50/50 dark:bg-emerald-950/20 text-xs py-2 px-3', td: 'empty:p-0 py-2 px-3' }"
												class="rounded-lg border border-emerald-200/40 dark:border-emerald-800/30 overflow-hidden"
											>
												<template #expanded="{ row: clusterRow }">
													<div class="px-4 py-2 bg-background/70">
														<!-- Level 4: Suggestions -->
														<UTable
															:data="getSuggestionsForCluster(subRow.original.sub_category_id, clusterRow.original.cluster)"
															:columns="suggestionColumns"
															:ui="{ root: 'min-w-full', th: 'bg-muted/30 text-xs py-1.5 px-3', td: 'py-1.5 px-3 text-xs' }"
															class="rounded-md border border-border/40 overflow-hidden"
														>
															<template #empty>
																<div class="py-3 text-center text-xs text-muted-foreground italic">No suggestions.</div>
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
		<ImportModal :is-open="showImportModal" :data-type="'suggestions'" @close="closeImportModal" @import-success="handleImportSuccess" />
		<ExportModal :is-open="showExportModal" :data-type="'suggestions'" @close="closeExportModal" />
		<DatasetEditModalShadcn :is-open="showEditModal" :data-type="'suggestions'" :item="editingItem" :loading="actionLoading" @close="closeEditModal" @save="handleSave" />
		<SuggestionDetailDrawer
			:open="showDetailSheet" :item="viewingItem" :technical-open="showTechnicalDetails"
			:suggestion-spec="suggestionIdSpec" :sub-category-spec="suggestionSubCategoryIdSpec"
			:record-spec="suggestionRecordIdSpec" :sub-category-context="suggestionSubCategoryContext"
			@update:open="(open) => !open && closeDetailSheet()"
			@update:technical-open="(open) => (showTechnicalDetails = open)"
			@edit="openEditFromDetail" @copy-id="copyId"
			@open-single-relation="openSubCategoryDetail" @retry="loadSuggestionSubCategorySummary"
		/>
		<SuggestionProblemDetailDrawer
			:open="showSubCategorySheet" :record="viewingSubCategory" :loading="loadingSubCategory"
			:error="subCategoryLoadError" :sub-category-spec="suggestionLinkedProblemSubCategorySpec"
			:record-spec="suggestionLinkedProblemRecordIdSpec"
			@update:open="(open) => !open && closeSubCategorySheet()"
			@copy-id="copyId" @retry="openSubCategoryDetail()"
		/>
		<Toaster />
	</div>
</template>

<script setup>
import { computed, h, onMounted, ref, resolveComponent } from "vue";
import SuggestionDetailDrawer from "@/components/admin/drawers/suggestions/SuggestionDetailDrawer.vue";
import SuggestionProblemDetailDrawer from "@/components/admin/drawers/suggestions/SuggestionProblemDetailDrawer.vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import DatasetEditModalShadcn from "@/components/admin/DatasetEditModalShadcn.vue";
import { HelpCircle, Layers, List, Plus } from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";
import { useSuggestionsDrawers } from "@/composables/drawers/useSuggestionsDrawers";
import { Button } from "@/components/ui/button";
import { Toaster } from "@/components/ui/toast";

const UButton = resolveComponent("UButton");
const UBadge = resolveComponent("UBadge");

const { startTour } = useOnboarding();
const { supabase } = useSupabase();

const {
	loading, dataType, error, data, actionLoading, filterOptions,
	showImportModal, showExportModal, showEditModal, editingItem,
	pagination, columns, dataTypeLabel, currentPage, totalPages,
	searchQuery, filters, refreshData, openCreateModal, openEditModal,
	closeEditModal, handleSave, deleteItem, bulkDeleteItems, allMatchingIds,
	openImportModal, closeImportModal, openExportModal, closeExportModal,
	handleImportSuccess, goToPage, changePageSize, nextPage, prevPage,
	setFilter, clearFilters, setSort,
} = useDatasetManagement("suggestions", { is_active: "true" });

const {
	showDetailSheet, viewingItem, showTechnicalDetails,
	showSubCategorySheet, viewingSubCategory, loadingSubCategory, subCategoryLoadError,
	suggestionIdSpec, suggestionSubCategoryIdSpec, suggestionRecordIdSpec,
	suggestionLinkedProblemSubCategorySpec, suggestionLinkedProblemRecordIdSpec,
	suggestionSubCategoryContext,
	openDetailView, closeDetailSheet, openEditFromDetail, openSubCategoryDetail,
	closeSubCategorySheet, loadSuggestionSubCategorySummary, copyId,
} = useSuggestionsDrawers({ supabase, onEdit: (item) => openEditModal(item) });

// ─── Grouped view state ───────────────────────────────────────────────────────
const viewMode = ref("list");
const groupedSearch = ref("");
const groupedLoading = ref(false);
const groupedError = ref(null);
const catExpanded = ref({});
const subExpanded = ref({});
const clusterExpanded = ref({});

const allCategories = ref([]);
const allSubcategories = ref([]);
const allSuggestions = ref([]);

const fetchGroupedData = async () => {
	groupedLoading.value = true;
	groupedError.value = null;
	try {
		const [catRes, subRes, sRes] = await Promise.all([
			supabase.from("problem_types").select("category_id, type_name").eq("is_active", true).order("type_name"),
			supabase.from("problems").select("sub_category_id, problem_name, category_id").eq("is_active", true).order("problem_name"),
			supabase.from("suggestions")
				.select("id, suggestion_id, suggestion_text, cluster, evidence_base, sub_category_id")
				.eq("is_active", true)
				.order("sub_category_id", { ascending: true })
				.order("cluster", { ascending: true, nullsFirst: false }),
		]);
		if (catRes.error) throw catRes.error;
		if (subRes.error) throw subRes.error;
		if (sRes.error) throw sRes.error;
		allCategories.value = catRes.data ?? [];
		const seen = new Set();
		allSubcategories.value = (subRes.data ?? []).filter((s) => { if (seen.has(s.sub_category_id)) return false; seen.add(s.sub_category_id); return true; });
		allSuggestions.value = sRes.data ?? [];
	} catch (err) {
		groupedError.value = err?.message ?? "Failed to load grouped data";
	} finally { groupedLoading.value = false; }
};

// ─── Helpers ──────────────────────────────────────────────────────────────────
const subToCatMap = computed(() => { const m = new Map(); for (const s of allSubcategories.value) m.set(s.sub_category_id, s.category_id); return m; });
const q = computed(() => groupedSearch.value.toLowerCase().trim());

const filteredSuggestions = computed(() => {
	if (!q.value) return allSuggestions.value;
	return allSuggestions.value.filter((s) => s.suggestion_text.toLowerCase().includes(q.value) || s.suggestion_id.toLowerCase().includes(q.value) || (s.cluster ?? "").toLowerCase().includes(q.value));
});

const filteredSubcategories = computed(() => {
	if (!q.value) return allSubcategories.value;
	const matchingSubs = new Set(filteredSuggestions.value.map((s) => s.sub_category_id));
	return allSubcategories.value.filter((s) => s.problem_name.toLowerCase().includes(q.value) || s.sub_category_id.toLowerCase().includes(q.value) || matchingSubs.has(s.sub_category_id));
});

const categoryRows = computed(() =>
	allCategories.value.map((cat) => {
		const subs = filteredSubcategories.value.filter((s) => s.category_id === cat.category_id);
		const sCount = filteredSuggestions.value.filter((s) => subToCatMap.value.get(s.sub_category_id) === cat.category_id).length;
		return { category_id: cat.category_id, category_name: cat.type_name, sub_count: subs.length, suggestion_count: sCount };
	}).filter((r) => !q.value || r.category_name.toLowerCase().includes(q.value) || r.category_id.toLowerCase().includes(q.value) || r.sub_count > 0),
);

function getSubsForCategory(categoryId) {
	return filteredSubcategories.value.filter((s) => s.category_id === categoryId).map((s) => {
		const sCount = filteredSuggestions.value.filter((sg) => sg.sub_category_id === s.sub_category_id).length;
		return { sub_category_id: s.sub_category_id, problem_name: s.problem_name, cluster_count: getClustersForSub(s.sub_category_id).length, suggestion_count: sCount };
	});
}

function getClustersForSub(subCategoryId) {
	const ss = filteredSuggestions.value.filter((s) => s.sub_category_id === subCategoryId);
	const clusterSet = new Set(ss.map((s) => s.cluster ?? "(no cluster)"));
	return [...clusterSet].sort().map((cluster) => ({
		cluster,
		suggestion_count: ss.filter((s) => (s.cluster ?? "(no cluster)") === cluster).length,
	}));
}

function getSuggestionsForCluster(subCategoryId, cluster) {
	return filteredSuggestions.value.filter((s) => s.sub_category_id === subCategoryId && (s.cluster ?? "(no cluster)") === cluster);
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
	{ accessorKey: "suggestion_count", header: "Suggestions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "success" }, () => String(row.getValue("suggestion_count"))) },
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
	{ accessorKey: "suggestion_count", header: "Suggestions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "success" }, () => String(row.getValue("suggestion_count"))) },
];

const clusterColumns = [
	{ id: "expand", cell: ({ row }) => expandBtn(row, "xs"), meta: { class: { th: "w-8", td: "w-8" } } },
	{
		accessorKey: "cluster", header: "Cluster",
		cell: ({ row }) => h(UBadge, { variant: "subtle", color: "success", class: "text-xs font-medium" }, () => row.getValue("cluster")),
	},
	{ accessorKey: "suggestion_count", header: "Suggestions", meta: { class: { th: "text-center w-28", td: "text-center" } }, cell: ({ row }) => h(UBadge, { variant: "subtle", color: "success" }, () => String(row.getValue("suggestion_count"))) },
];

const suggestionColumns = [
	{ accessorKey: "suggestion_id", header: "ID", meta: { class: { th: "w-32", td: "font-mono text-xs text-muted-foreground" } } },
	{ accessorKey: "suggestion_text", header: "Suggestion", cell: ({ row }) => h("p", { class: "text-xs leading-relaxed" }, row.getValue("suggestion_text")) },
	{
		accessorKey: "evidence_base", header: "Evidence Base", meta: { class: { th: "w-44" } },
		cell: ({ row }) => h("p", { class: "text-xs text-muted-foreground" }, row.getValue("evidence_base") || "—"),
	},
];

// ─── Lifecycle ────────────────────────────────────────────────────────────────
onMounted(() => {
	setSort("sub_category_id", "asc");
	refreshData();
	fetchGroupedData();
});
</script>
