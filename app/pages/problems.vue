<template>
	<div class="min-h-screen w-full max-w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Problem taxonomy"
				title="Subcategories"
				description="Manage the subcategories underneath each category and keep the assessment tree easy to scan."
				:total="viewMode === 'list' ? pagination.total : allSubcategories.length"
				total-label="subcategories"
				:page-count="viewMode === 'list' ? data.length : allSubcategories.length"
				:search-query="viewMode === 'list' ? searchQuery : groupedSearch"
				:filters="viewMode === 'list' ? filters : {}"
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

			<!-- Card wrapping both views so the toggle lives inside it -->
			<div class="overflow-hidden rounded-3xl border border-border/70 bg-card shadow-sm">

				<!-- ── Toolbar row with toggle + grouped search ──────────────── -->
				<div class="flex items-center gap-3 border-b border-border px-4 py-3">
					<!-- View toggle -->
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

					<!-- Grouped search (only visible in grouped mode) -->
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
							placeholder="Search subcategories…"
							icon="i-lucide-search"
							size="sm"
							:trailing-icon="groupedSearch ? 'i-lucide-x' : undefined"
							class="w-64"
							@click:trailing="groupedSearch = ''"
						/>
					</Transition>
				</div>

				<!-- ── LIST VIEW ─────────────────────────────────────────────── -->
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

				<!-- ── GROUPED VIEW ───────────────────────────────────────────── -->
				<template v-else>
					<!-- Loading -->
					<div
						v-if="groupedLoading"
						class="flex items-center justify-center gap-2 py-20 text-sm text-muted-foreground"
					>
						<UIcon name="i-lucide-loader-circle" class="h-4 w-4 animate-spin" />
						Loading…
					</div>

					<!-- Error -->
					<UAlert
						v-else-if="groupedError"
						color="error"
						variant="subtle"
						:description="groupedError"
						icon="i-lucide-alert-circle"
						class="m-4"
					/>

					<!-- Grouped table -->
					<UTable
						v-else
						v-model:expanded="groupedExpanded"
						:data="categoryRows"
						:columns="categoryColumns"
						:ui="{
							root: 'min-w-full',
							tr: 'data-[expanded=true]:bg-elevated/50',
							td: 'empty:p-0',
						}"
					>
						<template #expanded="{ row }">
							<div class="px-6 py-4 bg-muted/20">
								<UTable
									:data="getSubcategoriesForCategory(row.original.category_id)"
									:columns="subcategoryColumns"
									:ui="{
										root: 'min-w-full',
										th: 'bg-muted/40 text-xs',
									}"
									class="rounded-xl border border-border/50 overflow-hidden"
								>
									<template #empty>
										<div class="py-6 text-center text-xs text-muted-foreground">
											No subcategories found.
										</div>
									</template>
								</UTable>
							</div>
						</template>

						<template #empty>
							<div class="py-16 text-center text-sm text-muted-foreground">
								No categories found.
							</div>
						</template>
					</UTable>
				</template>

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
import { computed, h, onMounted, ref, resolveComponent } from "vue";

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
import { HelpCircle, Layers, List, Plus } from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";
import { useProblemsDrawers } from "@/composables/drawers/useProblemsDrawers";

// ─── Nuxt UI components (for grouped view) ────────────────────────────────────
const UButton = resolveComponent("UButton");
const UBadge = resolveComponent("UBadge");

// ─── Composables ──────────────────────────────────────────────────────────────
const { supabase } = useSupabase();
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

// ─── List view: filter data for sidebar ───────────────────────────────────────
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
		const seenIds = new Set();
		const formattedSubCategories = [];
		for (const item of subData) {
			if (!seenIds.has(item.sub_category_id)) {
				seenIds.add(item.sub_category_id);
				formattedSubCategories.push({ id: item.sub_category_id, name: item.problem_name });
			}
		}
		subCategories.value = formattedSubCategories;
	} catch (err) {
		console.error("Error fetching subcategories:", err);
	}
};

// ─── View mode ────────────────────────────────────────────────────────────────
const viewMode = ref("list"); // 'list' | 'grouped'

// ─── Grouped view state ───────────────────────────────────────────────────────
const groupedSearch = ref("");
const groupedLoading = ref(false);
const groupedError = ref(null);
const groupedExpanded = ref({});
const allCategories = ref([]);
const allSubcategories = ref([]);

const fetchGroupedData = async () => {
	groupedLoading.value = true;
	groupedError.value = null;
	try {
		const [catRes, subRes] = await Promise.all([
			supabase
				.from("problem_types")
				.select("category_id, type_name, description")
				.eq("is_active", true)
				.order("type_name"),
			supabase
				.from("problems")
				.select("id, sub_category_id, problem_name, description, category_id")
				.eq("is_active", true)
				.order("problem_name"),
		]);
		if (catRes.error) throw catRes.error;
		if (subRes.error) throw subRes.error;
		allCategories.value = catRes.data ?? [];
		allSubcategories.value = subRes.data ?? [];
	} catch (err) {
		groupedError.value = err?.message ?? "Failed to load grouped data";
	} finally {
		groupedLoading.value = false;
	}
};

// ─── Grouped computed ─────────────────────────────────────────────────────────
const filteredSubcategories = computed(() => {
	const q = groupedSearch.value.toLowerCase().trim();
	if (!q) return allSubcategories.value;
	return allSubcategories.value.filter(
		(s) =>
			s.problem_name.toLowerCase().includes(q) ||
			s.sub_category_id.toLowerCase().includes(q) ||
			(s.description ?? "").toLowerCase().includes(q),
	);
});

const categoryRows = computed(() =>
	allCategories.value
		.map((cat) => ({
			category_id: cat.category_id,
			category_name: cat.type_name,
			description: cat.description ?? "",
			count: filteredSubcategories.value.filter(
				(s) => s.category_id === cat.category_id,
			).length,
		}))
		.filter((r) => {
			const q = groupedSearch.value.toLowerCase().trim();
			if (!q) return true;
			return (
				r.category_name.toLowerCase().includes(q) ||
				r.category_id.toLowerCase().includes(q) ||
				r.count > 0
			);
		}),
);

function getSubcategoriesForCategory(categoryId) {
	return filteredSubcategories.value.filter(
		(s) => s.category_id === categoryId,
	);
}

// ─── Category table columns ───────────────────────────────────────────────────
const categoryColumns = [
	{
		id: "expand",
		cell: ({ row }) =>
			h(UButton, {
				color: "neutral",
				variant: "ghost",
				icon: "i-lucide-chevron-right",
				square: true,
				"aria-label": "Expand",
				ui: {
					leadingIcon: [
						"transition-transform duration-200",
						row.getIsExpanded() ? "rotate-90" : "",
					],
				},
				onClick: () => row.toggleExpanded(),
			}),
		meta: { class: { th: "w-10", td: "w-10" } },
	},
	{
		accessorKey: "category_name",
		header: "Category",
		cell: ({ row }) =>
			h("div", { class: "flex items-center gap-2" }, [
				h("span", { class: "font-semibold text-sm" }, row.getValue("category_name")),
				h(UBadge, { variant: "outline", class: "font-mono text-[11px]" }, () => row.original.category_id),
			]),
	},
	{
		accessorKey: "description",
		header: "Description",
		cell: ({ row }) =>
			h("p", { class: "text-xs text-muted-foreground line-clamp-1 max-w-md" }, row.getValue("description") || "—"),
	},
	{
		accessorKey: "count",
		header: "Subcategories",
		meta: { class: { th: "text-center w-32", td: "text-center" } },
		cell: ({ row }) =>
			h(UBadge, { variant: "subtle", color: "primary" }, () => String(row.getValue("count"))),
	},
];

// ─── Subcategory table columns ────────────────────────────────────────────────
const subcategoryColumns = [
	{
		accessorKey: "sub_category_id",
		header: "ID",
		meta: { class: { th: "w-36", td: "font-mono text-xs text-muted-foreground" } },
	},
	{
		accessorKey: "problem_name",
		header: "Subcategory Name",
		cell: ({ row }) =>
			h("span", { class: "font-medium text-sm" }, row.getValue("problem_name")),
	},
	{
		accessorKey: "description",
		header: "Description",
		cell: ({ row }) =>
			h("p", { class: "text-xs text-muted-foreground line-clamp-2 max-w-lg" }, row.getValue("description") || "—"),
	},
];

// ─── Lifecycle ────────────────────────────────────────────────────────────────
onMounted(() => {
	refreshData();
	fetchCategories();
	fetchSubCategories();
	fetchGroupedData();
});
</script>
