<script setup lang="ts">
import { h, resolveComponent, computed, onMounted, ref } from "vue";
import type { TableColumn } from "@nuxt/ui";
import { useSupabase } from "@/composables/useSupabase";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";

// ─── Types ────────────────────────────────────────────────────────────────────

interface Category {
	category_id: string;
	type_name: string;
}

interface Subcategory {
	id: string;
	sub_category_id: string;
	problem_name: string;
	description: string;
	category_id: string;
}

interface AssessmentQuestion {
	id: string;
	question_id: string;
	question_text: string;
	response_type: string;
	clusters: string[] | string | null;
	order_number: number | null;
	sub_category_id: string;
}

interface Suggestion {
	id: string;
	suggestion_id: string;
	suggestion_text: string;
	cluster: string | null;
	evidence_base: string | null;
	sub_category_id: string;
}

// Row type for the category-level table
interface CategoryRow {
	category_id: string;
	category_name: string;
	subcategory_count: number;
	question_count: number;
	suggestion_count: number;
}

// ─── Resolve Nuxt UI components ───────────────────────────────────────────────
const UButton = resolveComponent("UButton");
const UBadge = resolveComponent("UBadge");

// ─── State ────────────────────────────────────────────────────────────────────
const { supabase } = useSupabase();

const loading = ref(false);
const error = ref<string | null>(null);
const searchQuery = ref("");

const categories = ref<Category[]>([]);
const subcategories = ref<Subcategory[]>([]);
const questions = ref<AssessmentQuestion[]>([]);
const suggestions = ref<Suggestion[]>([]);

// Expanded state for the category table
const expanded = ref<Record<string, boolean>>({});

// ─── Data fetching ────────────────────────────────────────────────────────────
const fetchAll = async () => {
	loading.value = true;
	error.value = null;
	try {
		const [catRes, subRes, qRes, sRes] = await Promise.all([
			supabase
				.from("problem_types")
				.select("category_id, type_name")
				.eq("is_active", true)
				.order("type_name"),
			supabase
				.from("problems")
				.select("id, sub_category_id, problem_name, description, category_id")
				.eq("is_active", true)
				.order("problem_name"),
			supabase
				.from("assessments")
				.select("id, question_id, question_text, response_type, clusters, order_number, sub_category_id")
				.eq("is_active", true)
				.order("order_number", { ascending: true }),
			supabase
				.from("suggestions")
				.select("id, suggestion_id, suggestion_text, cluster, evidence_base, sub_category_id")
				.eq("is_active", true)
				.order("suggestion_id"),
		]);

		if (catRes.error) throw catRes.error;
		if (subRes.error) throw subRes.error;
		if (qRes.error) throw qRes.error;
		if (sRes.error) throw sRes.error;

		categories.value = catRes.data ?? [];
		subcategories.value = subRes.data ?? [];
		questions.value = qRes.data ?? [];
		suggestions.value = sRes.data ?? [];
	} catch (err: any) {
		error.value = err?.message ?? "Failed to load data";
	} finally {
		loading.value = false;
	}
};

onMounted(fetchAll);

// ─── Sub-category → category lookup map ──────────────────────────────────────
// Built after subcategories are loaded; maps sub_category_id → category_id
const subCatToCategoryMap = computed<Map<string, string>>(() => {
	const map = new Map<string, string>();
	for (const s of subcategories.value) {
		map.set(s.sub_category_id, s.category_id);
	}
	return map;
});

// ─── Search filter ────────────────────────────────────────────────────────────
const q = computed(() => searchQuery.value.toLowerCase().trim());

const filteredSubcategories = computed(() =>
	q.value
		? subcategories.value.filter(
				(s) =>
					s.problem_name.toLowerCase().includes(q.value) ||
					s.sub_category_id.toLowerCase().includes(q.value),
			)
		: subcategories.value,
);

const filteredQuestions = computed(() =>
	q.value
		? questions.value.filter(
				(q2) =>
					q2.question_text.toLowerCase().includes(q.value) ||
					q2.question_id.toLowerCase().includes(q.value),
			)
		: questions.value,
);

const filteredSuggestions = computed(() =>
	q.value
		? suggestions.value.filter(
				(s) =>
					s.suggestion_text.toLowerCase().includes(q.value) ||
					s.suggestion_id.toLowerCase().includes(q.value),
			)
		: suggestions.value,
);

// ─── Category table rows ──────────────────────────────────────────────────────
const categoryRows = computed<CategoryRow[]>(() =>
	categories.value
		.map((cat) => ({
			category_id: cat.category_id,
			category_name: cat.type_name,
			subcategory_count: filteredSubcategories.value.filter(
				(s) => s.category_id === cat.category_id,
			).length,
			question_count: filteredQuestions.value.filter(
				(q2) => subCatToCategoryMap.value.get(q2.sub_category_id) === cat.category_id,
			).length,
			suggestion_count: filteredSuggestions.value.filter(
				(s) => subCatToCategoryMap.value.get(s.sub_category_id) === cat.category_id,
			).length,
		}))
		.filter(
			(r) =>
				!q.value ||
				r.category_name.toLowerCase().includes(q.value) ||
				r.subcategory_count > 0 ||
				r.question_count > 0 ||
				r.suggestion_count > 0,
		),
);

// ─── Per-category data helpers ────────────────────────────────────────────────
function getSubcategoriesForCategory(categoryId: string) {
	return filteredSubcategories.value.filter(
		(s) => s.category_id === categoryId,
	);
}

function getQuestionsForSubcategory(subCategoryId: string) {
	return filteredQuestions.value.filter(
		(q2) => q2.sub_category_id === subCategoryId,
	);
}

function getSuggestionsForSubcategory(subCategoryId: string) {
	return filteredSuggestions.value.filter(
		(s) => s.sub_category_id === subCategoryId,
	);
}

function parseClusters(clusters: string[] | string | null): string[] {
	if (!clusters) return [];
	if (Array.isArray(clusters)) return clusters;
	try {
		const parsed = JSON.parse(clusters);
		return Array.isArray(parsed) ? parsed : [String(parsed)];
	} catch {
		return [String(clusters)];
	}
}

// ─── Category table columns ───────────────────────────────────────────────────
const categoryColumns: TableColumn<CategoryRow>[] = [
	{
		id: "expand",
		cell: ({ row }) =>
			h(UButton, {
				color: "neutral",
				variant: "ghost",
				icon: "i-lucide-chevron-right",
				square: true,
				"aria-label": "Expand row",
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
				h(
					UBadge,
					{ variant: "outline", class: "font-mono text-[11px]" },
					() => row.original.category_id,
				),
			]),
	},
	{
		accessorKey: "subcategory_count",
		header: "Subcategories",
		meta: { class: { th: "text-center w-32", td: "text-center" } },
		cell: ({ row }) =>
			h(
				UBadge,
				{ variant: "subtle", color: "primary" },
				() => String(row.getValue("subcategory_count")),
			),
	},
	{
		accessorKey: "question_count",
		header: "Questions",
		meta: { class: { th: "text-center w-28", td: "text-center" } },
		cell: ({ row }) =>
			h(
				UBadge,
				{ variant: "subtle", color: "warning" },
				() => String(row.getValue("question_count")),
			),
	},
	{
		accessorKey: "suggestion_count",
		header: "Suggestions",
		meta: { class: { th: "text-center w-28", td: "text-center" } },
		cell: ({ row }) =>
			h(
				UBadge,
				{ variant: "subtle", color: "success" },
				() => String(row.getValue("suggestion_count")),
			),
	},
];

// ─── Subcategory table columns ────────────────────────────────────────────────
const subcategoryColumns: TableColumn<Subcategory>[] = [
	{
		id: "expand",
		cell: ({ row }) =>
			h(UButton, {
				color: "neutral",
				variant: "ghost",
				icon: "i-lucide-chevron-right",
				square: true,
				size: "xs",
				"aria-label": "Expand subcategory",
				ui: {
					leadingIcon: [
						"transition-transform duration-200",
						row.getIsExpanded() ? "rotate-90" : "",
					],
				},
				onClick: () => row.toggleExpanded(),
			}),
		meta: { class: { th: "w-8", td: "w-8" } },
	},
	{
		accessorKey: "problem_name",
		header: "Subcategory",
		cell: ({ row }) =>
			h("div", { class: "flex items-center gap-2" }, [
				h("span", { class: "font-medium text-sm" }, row.getValue("problem_name")),
				h(
					UBadge,
					{ variant: "outline", class: "font-mono text-[10px]" },
					() => row.original.sub_category_id,
				),
			]),
	},
	{
		accessorKey: "description",
		header: "Description",
		cell: ({ row }) =>
			h(
				"p",
				{ class: "text-xs text-muted-foreground line-clamp-2 max-w-md" },
				row.getValue("description") || "—",
			),
	},
];

// ─── Question table columns ───────────────────────────────────────────────────
const questionColumns: TableColumn<AssessmentQuestion>[] = [
	{
		accessorKey: "question_id",
		header: "ID",
		meta: { class: { th: "w-28", td: "font-mono text-xs text-muted-foreground" } },
	},
	{
		accessorKey: "question_text",
		header: "Question",
		cell: ({ row }) =>
			h("p", { class: "text-xs leading-relaxed" }, row.getValue("question_text")),
	},
	{
		accessorKey: "response_type",
		header: "Type",
		meta: { class: { th: "w-24 text-center", td: "text-center" } },
		cell: ({ row }) =>
			h(
				UBadge,
				{ variant: "outline", class: "text-[10px]" },
				() => row.getValue("response_type"),
			),
	},
	{
		accessorKey: "clusters",
		header: "Clusters",
		meta: { class: { th: "w-40" } },
		cell: ({ row }) => {
			const clusters = parseClusters(row.getValue("clusters"));
			if (!clusters.length) return h("span", { class: "text-muted-foreground text-xs" }, "—");
			return h(
				"div",
				{ class: "flex flex-wrap gap-1" },
				clusters.map((c) =>
					h(UBadge, { key: c, variant: "subtle", class: "text-[10px]" }, () => c),
				),
			);
		},
	},
	{
		accessorKey: "order_number",
		header: "Order",
		meta: { class: { th: "w-16 text-center", td: "text-center text-xs text-muted-foreground" } },
		cell: ({ row }) => row.getValue("order_number") ?? "—",
	},
];

// ─── Suggestion table columns ─────────────────────────────────────────────────
const suggestionColumns: TableColumn<Suggestion>[] = [
	{
		accessorKey: "suggestion_id",
		header: "ID",
		meta: { class: { th: "w-32", td: "font-mono text-xs text-muted-foreground" } },
	},
	{
		accessorKey: "suggestion_text",
		header: "Suggestion",
		cell: ({ row }) =>
			h("p", { class: "text-xs leading-relaxed" }, row.getValue("suggestion_text")),
	},
	{
		accessorKey: "cluster",
		header: "Cluster",
		meta: { class: { th: "w-28 text-center", td: "text-center" } },
		cell: ({ row }) => {
			const cluster = row.getValue("cluster") as string | null;
			return cluster
				? h(UBadge, { variant: "subtle", class: "text-[10px]" }, () => cluster)
				: h("span", { class: "text-muted-foreground text-xs" }, "—");
		},
	},
	{
		accessorKey: "evidence_base",
		header: "Evidence Base",
		meta: { class: { th: "w-40" } },
		cell: ({ row }) =>
			h(
				"p",
				{ class: "text-xs text-muted-foreground" },
				row.getValue("evidence_base") || "—",
			),
	},
];

// ─── Totals ───────────────────────────────────────────────────────────────────
const totalItems = computed(
	() =>
		filteredSubcategories.value.length +
		filteredQuestions.value.length +
		filteredSuggestions.value.length,
);
</script>

<template>
	<div class="min-h-screen w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">

			<!-- Page Header -->
			<DatasetPageHeader
				eyebrow="Content overview"
				title="Overview"
				description="Browse subcategories, assessment questions, and suggestions grouped by category."
				:total="totalItems"
				total-label="records"
				:page-count="totalItems"
				:search-query="searchQuery"
				:filters="{}"
			/>

			<!-- Search bar -->
			<div class="flex items-center gap-3">
				<div class="relative min-w-[220px] max-w-sm flex-1">
					<UInput
						v-model="searchQuery"
						placeholder="Search subcategories, questions, suggestions…"
						icon="i-lucide-search"
						:trailing-icon="searchQuery ? 'i-lucide-x' : undefined"
						class="w-full"
						@click:trailing="searchQuery = ''"
					/>
				</div>
			</div>

			<!-- Loading -->
			<div
				v-if="loading"
				class="flex items-center justify-center gap-2 py-20 text-sm text-muted-foreground"
			>
				<UIcon name="i-lucide-loader-circle" class="h-4 w-4 animate-spin" />
				Loading data…
			</div>

			<!-- Error -->
			<UAlert
				v-else-if="error"
				color="error"
				variant="subtle"
				:description="error"
				icon="i-lucide-alert-circle"
			/>

			<!-- Category table -->
			<div
				v-else
				class="overflow-hidden rounded-2xl border border-border/70 bg-card shadow-sm"
			>
				<UTable
					v-model:expanded="expanded"
					:data="categoryRows"
					:columns="categoryColumns"
					:loading="loading"
					:ui="{
						root: 'min-w-full',
						tr: 'data-[expanded=true]:bg-elevated/50',
						td: 'empty:p-0',
					}"
				>
					<!-- Expanded row: subcategory table with nested questions + suggestions -->
					<template #expanded="{ row: categoryRow }">
						<div class="px-4 py-4 bg-muted/20">
							<!-- Subcategory table -->
							<UTable
								:data="getSubcategoriesForCategory(categoryRow.original.category_id)"
								:columns="subcategoryColumns"
								:ui="{
									root: 'min-w-full',
									tr: 'data-[expanded=true]:bg-elevated/50',
									td: 'empty:p-0',
									th: 'bg-muted/40 text-xs',
								}"
								class="rounded-xl border border-border/50 overflow-hidden"
							>
								<!-- Empty state for subcategories -->
								<template #empty>
									<div class="py-6 text-center text-xs text-muted-foreground">
										No subcategories found.
									</div>
								</template>

								<!-- Expanded subcategory: questions + suggestions -->
								<template #expanded="{ row: subRow }">
									<div class="px-4 py-4 space-y-4 bg-background/60">

										<!-- Assessment Questions -->
										<div>
											<div class="mb-2 flex items-center gap-2">
												<UIcon name="i-lucide-file-question" class="h-3.5 w-3.5 text-amber-500" />
												<span class="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
													Assessment Questions
												</span>
												<UBadge variant="subtle" color="warning" class="text-[10px]">
													{{ getQuestionsForSubcategory(subRow.original.sub_category_id).length }}
												</UBadge>
											</div>
											<UTable
												:data="getQuestionsForSubcategory(subRow.original.sub_category_id)"
												:columns="questionColumns"
												:ui="{
													root: 'min-w-full',
													th: 'bg-amber-50/50 dark:bg-amber-950/20 text-xs',
												}"
												class="rounded-lg border border-amber-200/50 dark:border-amber-800/30 overflow-hidden"
											>
												<template #empty>
													<div class="py-4 text-center text-xs text-muted-foreground italic">
														No assessment questions for this subcategory.
													</div>
												</template>
											</UTable>
										</div>

										<!-- Suggestions -->
										<div>
											<div class="mb-2 flex items-center gap-2">
												<UIcon name="i-lucide-lightbulb" class="h-3.5 w-3.5 text-emerald-500" />
												<span class="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
													Suggestions
												</span>
												<UBadge variant="subtle" color="success" class="text-[10px]">
													{{ getSuggestionsForSubcategory(subRow.original.sub_category_id).length }}
												</UBadge>
											</div>
											<UTable
												:data="getSuggestionsForSubcategory(subRow.original.sub_category_id)"
												:columns="suggestionColumns"
												:ui="{
													root: 'min-w-full',
													th: 'bg-emerald-50/50 dark:bg-emerald-950/20 text-xs',
												}"
												class="rounded-lg border border-emerald-200/50 dark:border-emerald-800/30 overflow-hidden"
											>
												<template #empty>
													<div class="py-4 text-center text-xs text-muted-foreground italic">
														No suggestions for this subcategory.
													</div>
												</template>
											</UTable>
										</div>

									</div>
								</template>
							</UTable>
						</div>
					</template>

					<!-- Empty state for categories -->
					<template #empty>
						<div class="py-16 text-center text-sm text-muted-foreground">
							No categories found.
						</div>
					</template>
				</UTable>
			</div>

		</div>
	</div>
</template>
