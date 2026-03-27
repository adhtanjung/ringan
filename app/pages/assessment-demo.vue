<script setup lang="ts">
import { computed, onMounted, ref, watch } from "vue";
import { ArrowRight, CheckCircle2 } from "lucide-vue-next";
import type { AcceptableValue } from "reka-ui";
import AssessmentDemoSandbox from "@/components/admin/AssessmentDemoSandbox.vue";
import { Button } from "@/components/ui/button";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { useSupabase } from "@/composables/useSupabase";

type ResponseType = "scale" | "text";

interface CategoryRow {
	type_name: string;
	category_id: string;
	description: string | null;
	is_active?: boolean | null;
}

interface SubcategoryRow {
	problem_name: string;
	sub_category_id: string;
	category_id: string | null;
	description: string | null;
	severity_level: number | null;
	is_active?: boolean | null;
}

interface AssessmentRow {
	question_id: string;
	question_text: string;
	response_type: string;
	scale_labels?: Record<string, unknown> | null;
	scale_label_1?: string | null;
	scale_label_2?: string | null;
	scale_label_3?: string | null;
	scale_label_4?: string | null;
	clusters?: string | null;
	batch_id?: string | null;
	order_number?: number | null;
	is_active?: boolean | null;
	created_at?: string | null;
	updated_at?: string | null;
}

interface SuggestionRow {
	suggestion_id: string | null;
	sub_category_id: string | null;
	cluster: string | null;
	suggestion_text: string | null;
	evidence_base: string | null;
	resource_link: string | null;
	difficulty_level: string | null;
	estimated_duration: string | null;
	is_active?: boolean | null;
	created_at?: string | null;
	updated_at?: string | null;
}

interface DemoQuestion {
	questionId: string;
	questionLabel: string;
	questionText: string;
	responseType: ResponseType;
	scaleValue: number;
	textValue: string;
	scaleLabels: [string, string, string, string];
	clusters?: string | null;
	batchId?: string | null;
}

interface DemoCategory {
	name: string;
	id: string;
	description: string;
}

interface DemoSubcategory {
	name: string;
	id: string;
	description: string;
	severity: string;
}

interface DemoSuggestion {
	suggestionId: string;
	title: string;
	suggestionText: string;
	evidenceBase: string;
	nextStep: string;
	cluster?: string | null;
	resourceLink?: string | null;
}

interface DemoScenario {
	scenarioTitle: string;
	scenarioNote: string;
	category: DemoCategory;
	subcategory: DemoSubcategory;
	assessments: DemoQuestion[];
	suggestion: DemoSuggestion;
}

const DEFAULT_SCALE_LABELS: [string, string, string, string] = [
	"Not at all",
	"A little",
	"Quite a bit",
	"Very much",
];

const { supabase } = useSupabase();

const categories = ref<CategoryRow[]>([]);
const subcategories = ref<SubcategoryRow[]>([]);
const selectedCategoryId = ref("");
const selectedSubcategoryId = ref("");
const liveScenario = ref<DemoScenario | null>(null);
const categoriesLoading = ref(false);
const subcategoriesLoading = ref(false);
const contentLoading = ref(false);
const pageError = ref<string | null>(null);

const categoryRequestId = ref(0);
const subcategoryRequestId = ref(0);
const contentRequestId = ref(0);

const selectedCategory = computed(
	() =>
		categories.value.find(
			(category) => category.category_id === selectedCategoryId.value,
		) || null,
);

const selectedSubcategory = computed(
	() =>
		subcategories.value.find(
			(subcategory) =>
				subcategory.sub_category_id === selectedSubcategoryId.value,
		) || null,
);

const questionCount = computed(
	() => liveScenario.value?.assessments.length ?? 0,
);

const hasCategories = computed(() => categories.value.length > 0);
const isLoadingAny = computed(
	() => categoriesLoading.value || subcategoriesLoading.value || contentLoading.value,
);

const statusTitle = computed(() => {
	if (pageError.value) return "Load error";
	if (categoriesLoading.value) return "Loading categories";
	if (!hasCategories.value) return "No active categories";
	if (!selectedCategoryId.value) return "Select a category";
	if (subcategoriesLoading.value) return "Loading subcategories";
	if (selectedCategoryId.value && !subcategories.value.length) {
		return "No active subcategories";
	}
	if (!selectedSubcategoryId.value) return "Select a subcategory";
	if (contentLoading.value) return "Loading assessment flow";
	if (!liveScenario.value) return "No active assessment questions";
	return "Live assessment ready";
});

const statusDescription = computed(() => {
	if (pageError.value) return pageError.value;
	if (categoriesLoading.value) return "Fetching live categories from Supabase.";
	if (!hasCategories.value) {
		return "No active categories are available yet. Create or activate a category to continue.";
	}
	if (!selectedCategoryId.value) {
		return "Choose a category to load its subcategories.";
	}
	if (subcategoriesLoading.value) {
		return `Loading subcategories for ${selectedCategory.value?.type_name || "the selected category"}.`;
	}
	if (selectedCategoryId.value && !subcategories.value.length) {
		return `No active subcategories are available for ${selectedCategory.value?.type_name || "this category"}.`;
	}
	if (!selectedSubcategoryId.value) {
		return "Choose a subcategory to load the live assessment flow.";
	}
	if (contentLoading.value) {
		return `Fetching live questions for ${selectedSubcategory.value?.problem_name || "the selected subcategory"}.`;
	}
	if (!liveScenario.value) {
		return `No active assessment questions were found for ${selectedSubcategory.value?.problem_name || "this subcategory"}.`;
	}
	if (liveScenario.value.suggestion.suggestionId) {
		return `${questionCount.value} live questions loaded with a matching suggestion.`;
	}
	return `${questionCount.value} live questions loaded. A placeholder suggestion is shown because this subcategory has no active suggestion row.`;
});

const statusToneClass = computed(() => {
	if (pageError.value) {
		return "border-rose-500/20 bg-rose-500/5 dark:border-rose-400/25 dark:bg-rose-400/10";
	}
	if (isLoadingAny.value) {
		return "border-primary/20 bg-primary/5 dark:border-primary/25 dark:bg-primary/10";
	}
	if (liveScenario.value) {
		return "border-emerald-500/20 bg-emerald-500/5 dark:border-emerald-400/25 dark:bg-emerald-400/10";
	}
	return "border-border/70 bg-muted/20";
});

const sandboxEmptyTitle = computed(() => {
	if (pageError.value) return "Live data unavailable";
	if (categoriesLoading.value) return "Loading categories";
	if (!hasCategories.value) return "No active categories";
	if (!selectedCategoryId.value) return "Select a category";
	if (subcategoriesLoading.value) return "Loading subcategories";
	if (selectedCategoryId.value && !subcategories.value.length) {
		return "No active subcategories";
	}
	if (!selectedSubcategoryId.value) return "Select a subcategory";
	if (contentLoading.value) return "Loading assessment flow";
	if (!liveScenario.value) return "No assessment questions found";
	return "Live assessment preview";
});

const sandboxEmptyDescription = computed(() => statusDescription.value);

const formatError = (error: unknown, fallback: string) => {
	if (error instanceof Error) return error.message || fallback;
	if (error && typeof error === "object" && "message" in error) {
		return String((error as { message?: unknown }).message || fallback);
	}
	return fallback;
};

const normalizeScaleLabels = (row: AssessmentRow): [string, string, string, string] => {
	const source =
		row.scale_labels && typeof row.scale_labels === "object"
			? (row.scale_labels as Record<string, unknown>)
			: null;

	const legacy = [
		row.scale_label_1,
		row.scale_label_2,
		row.scale_label_3,
		row.scale_label_4,
	];

	return [0, 1, 2, 3].map((index) => {
		const value = source?.[String(index + 1)] ?? legacy[index] ?? DEFAULT_SCALE_LABELS[index];
		return String(value || DEFAULT_SCALE_LABELS[index]);
	}) as [string, string, string, string];
};

const buildSuggestionNextStep = (suggestion: SuggestionRow | null) => {
	if (!suggestion) {
		return "No active suggestion row is available for this subcategory.";
	}

	const parts = [
		suggestion.difficulty_level ? `Difficulty ${suggestion.difficulty_level}` : "",
		suggestion.estimated_duration ? `Duration ${suggestion.estimated_duration}` : "",
		suggestion.resource_link ? "Reference link available" : "",
	].filter(Boolean);

	return parts.length > 0
		? parts.join(" • ")
		: "No additional follow-up metadata recorded.";
};

const buildScenario = (
	category: CategoryRow,
	subcategory: SubcategoryRow,
	assessmentRows: AssessmentRow[],
	suggestionRow: SuggestionRow | null,
): DemoScenario => {
	const sortedAssessments = [...assessmentRows].sort((a, b) => {
		const orderA = a.order_number ?? Number.MAX_SAFE_INTEGER;
		const orderB = b.order_number ?? Number.MAX_SAFE_INTEGER;
		if (orderA !== orderB) return orderA - orderB;

		const createdA = a.created_at ? new Date(a.created_at).getTime() : 0;
		const createdB = b.created_at ? new Date(b.created_at).getTime() : 0;
		return createdA - createdB;
	});

	const suggestion = suggestionRow
		? {
				suggestionId: suggestionRow.suggestion_id || "suggestion",
				title:
					suggestionRow.cluster || suggestionRow.suggestion_id || "Suggested guidance",
				suggestionText:
					suggestionRow.suggestion_text || "No suggestion text available.",
				evidenceBase: suggestionRow.evidence_base || "No evidence base recorded.",
				nextStep: buildSuggestionNextStep(suggestionRow),
				cluster: suggestionRow.cluster,
				resourceLink: suggestionRow.resource_link,
			}
		: {
				suggestionId: "",
				title: "No active suggestion found",
				suggestionText:
					"This subcategory does not currently have an active suggestion row. Review the Suggestions table or select a different subcategory.",
				evidenceBase: "No active suggestion available",
				nextStep:
					"Add or activate a suggestion for this subcategory in the Suggestions table.",
				cluster: null,
				resourceLink: null,
			};

	return {
		scenarioTitle: `${category.type_name} / ${subcategory.problem_name}`,
		scenarioNote: `${sortedAssessments.length} live question${
			sortedAssessments.length === 1 ? "" : "s"
		} loaded from Supabase for ${subcategory.problem_name}.`,
		category: {
			name: category.type_name,
			id: category.category_id,
			description:
				category.description || "No category description is recorded for this row.",
		},
		subcategory: {
			name: subcategory.problem_name,
			id: subcategory.sub_category_id,
			description:
				subcategory.description ||
				"No subcategory description is recorded for this row.",
			severity: subcategory.severity_level
				? `Severity ${subcategory.severity_level}`
				: "Severity not set",
		},
		assessments: sortedAssessments.map((row, index) => ({
			questionId: row.question_id,
			questionLabel: row.question_id || `Question ${index + 1}`,
			questionText: row.question_text,
			responseType: row.response_type === "text" ? "text" : "scale",
			scaleValue: row.response_type === "text" ? 2 : 2,
			textValue: "",
			scaleLabels: normalizeScaleLabels(row),
			clusters: row.clusters || null,
			batchId: row.batch_id || null,
		})),
		suggestion,
	};
};

const loadCategories = async () => {
	categoriesLoading.value = true;
	pageError.value = null;

	const requestId = ++categoryRequestId.value;

	try {
		const { data, error } = await supabase
			.from("problem_types")
			.select("type_name, category_id, description, is_active")
			.eq("is_active", true)
			.order("type_name", { ascending: true });

		if (error) throw error;
		if (requestId !== categoryRequestId.value) return;

		categories.value = ((data ?? []) as CategoryRow[]).map((row) => ({
			type_name: row.type_name,
			category_id: row.category_id,
			description: row.description,
			is_active: row.is_active,
		}));

		if (!categories.value.length) {
			selectedCategoryId.value = "";
			selectedSubcategoryId.value = "";
			liveScenario.value = null;
			return;
		}

		const stillValid = categories.value.some(
			(category) => category.category_id === selectedCategoryId.value,
		);
		if (!selectedCategoryId.value || !stillValid) {
			selectedCategoryId.value = "";
			selectedSubcategoryId.value = "";
		}
	} catch (error) {
		if (requestId !== categoryRequestId.value) return;

		categories.value = [];
		selectedCategoryId.value = "";
		selectedSubcategoryId.value = "";
		liveScenario.value = null;
		pageError.value = formatError(
			error,
			"Failed to load categories from Supabase.",
		);
	} finally {
		if (requestId === categoryRequestId.value) {
			categoriesLoading.value = false;
		}
	}
};

const loadSubcategories = async (categoryId: string) => {
	subcategoriesLoading.value = true;
	pageError.value = null;
	subcategories.value = [];
	selectedSubcategoryId.value = "";
	liveScenario.value = null;

	const requestId = ++subcategoryRequestId.value;

	try {
		const { data, error } = await supabase
			.from("problems")
			.select(
				"problem_name, sub_category_id, category_id, description, severity_level, is_active",
			)
			.eq("is_active", true)
			.eq("category_id", categoryId)
			.order("problem_name", { ascending: true });

		if (error) throw error;
		if (requestId !== subcategoryRequestId.value) return;

		subcategories.value = ((data ?? []) as SubcategoryRow[]).map((row) => ({
			problem_name: row.problem_name,
			sub_category_id: row.sub_category_id,
			category_id: row.category_id,
			description: row.description,
			severity_level: row.severity_level,
			is_active: row.is_active,
		}));

	} catch (error) {
		if (requestId !== subcategoryRequestId.value) return;

		subcategories.value = [];
		pageError.value = formatError(
			error,
			"Failed to load subcategories from Supabase.",
		);
	} finally {
		if (requestId === subcategoryRequestId.value) {
			subcategoriesLoading.value = false;
		}
	}
};

const loadAssessmentBundle = async (subcategoryId: string) => {
	contentLoading.value = true;
	pageError.value = null;
	liveScenario.value = null;

	const requestId = ++contentRequestId.value;

	try {
		const [assessmentsResponse, suggestionsResponse] = await Promise.all([
			supabase
				.from("assessments")
				.select(
					"question_id, question_text, response_type, scale_labels, scale_label_1, scale_label_2, scale_label_3, scale_label_4, clusters, batch_id, order_number, is_active, created_at, updated_at",
				)
				.eq("is_active", true)
				.eq("sub_category_id", subcategoryId)
				.order("order_number", { ascending: true })
				.order("created_at", { ascending: true }),
			supabase
				.from("suggestions")
				.select(
					"suggestion_id, sub_category_id, cluster, suggestion_text, evidence_base, resource_link, difficulty_level, estimated_duration, is_active, created_at, updated_at",
				)
				.eq("sub_category_id", subcategoryId)
				.order("is_active", { ascending: false })
				.order("updated_at", { ascending: false })
				.order("created_at", { ascending: false }),
		]);

		if (requestId !== contentRequestId.value) return;

		if (assessmentsResponse.error) throw assessmentsResponse.error;
		if (suggestionsResponse.error) throw suggestionsResponse.error;

		const assessments = ((assessmentsResponse.data ?? []) as AssessmentRow[]).sort(
			(a, b) => {
				const orderA = a.order_number ?? Number.MAX_SAFE_INTEGER;
				const orderB = b.order_number ?? Number.MAX_SAFE_INTEGER;
				if (orderA !== orderB) return orderA - orderB;

				const createdA = a.created_at ? new Date(a.created_at).getTime() : 0;
				const createdB = b.created_at ? new Date(b.created_at).getTime() : 0;
				return createdA - createdB;
			},
		);

		if (!assessments.length) {
			liveScenario.value = null;
			return;
		}

		const suggestions = ((suggestionsResponse.data ?? []) as SuggestionRow[]).sort(
			(a, b) => {
				const activeA = a.is_active ? 1 : 0;
				const activeB = b.is_active ? 1 : 0;
				if (activeA !== activeB) return activeB - activeA;

				const updatedA = a.updated_at ? new Date(a.updated_at).getTime() : 0;
				const updatedB = b.updated_at ? new Date(b.updated_at).getTime() : 0;
				if (updatedA !== updatedB) return updatedB - updatedA;

				const createdA = a.created_at ? new Date(a.created_at).getTime() : 0;
				const createdB = b.created_at ? new Date(b.created_at).getTime() : 0;
				return createdB - createdA;
			},
		);

		const category = selectedCategory.value;
		const subcategory = selectedSubcategory.value;
		if (!category || !subcategory) {
			liveScenario.value = null;
			return;
		}

		liveScenario.value = buildScenario(
			category,
			subcategory,
			assessments,
			suggestions[0] ?? null,
		);
	} catch (error) {
		if (requestId !== contentRequestId.value) return;

		liveScenario.value = null;
		pageError.value = formatError(
			error,
			"Failed to load the assessment flow from Supabase.",
		);
	} finally {
		if (requestId === contentRequestId.value) {
			contentLoading.value = false;
		}
	}
};

const coerceSelectValue = (value: AcceptableValue) => {
	return typeof value === "string" ? value : "";
};

const handleCategoryChange = (value: AcceptableValue) => {
	selectedCategoryId.value = coerceSelectValue(value);
};

const handleSubcategoryChange = (value: AcceptableValue) => {
	selectedSubcategoryId.value = coerceSelectValue(value);
};

watch(
	selectedCategoryId,
	async (categoryId) => {
		if (!categoryId) {
			subcategories.value = [];
			selectedSubcategoryId.value = "";
			liveScenario.value = null;
			return;
		}

		await loadSubcategories(categoryId);
	},
);

watch(
	selectedSubcategoryId,
	async (subcategoryId) => {
		if (!subcategoryId) {
			liveScenario.value = null;
			return;
		}

		await loadAssessmentBundle(subcategoryId);
	},
);

onMounted(() => {
	void loadCategories();
});
</script>

<template>
	<div class="min-h-screen w-full bg-muted/20">
		<div class="mx-auto w-full max-w-6xl px-4 py-6 sm:px-6 lg:px-8">
			<header class="space-y-5">
				<div class="flex flex-wrap items-center gap-2">
					<span
						class="inline-flex h-8 items-center rounded-full border border-border/70 bg-card px-3 text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground"
					>
						Assessment demo
					</span>
					<span
						class="inline-flex items-center gap-2 rounded-full border border-primary/20 bg-primary/5 px-3 py-1 text-xs font-medium text-primary"
					>
						<CheckCircle2 class="h-3.5 w-3.5" />
						Live read-only data
					</span>
				</div>

				<div class="space-y-4">
					<h1 class="max-w-3xl text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
						Preview live assessment flow
					</h1>
					<p class="max-w-3xl text-sm leading-6 text-muted-foreground sm:text-base">
						Choose a category and subcategory to load live questions and suggestion data from Supabase.
					</p>

					<div class="flex flex-wrap gap-3">
						<Button as-child class="h-11 gap-2 px-4 text-sm font-medium">
							<NuxtLink to="/dashboard">
								Back to dashboard
								<ArrowRight class="h-4 w-4" />
							</NuxtLink>
						</Button>
						<Button as-child variant="outline" class="h-11 gap-2 px-4 text-sm font-medium">
							<NuxtLink to="/assessments">
								Open assessments
								<ArrowRight class="h-4 w-4" />
							</NuxtLink>
						</Button>
					</div>
				</div>
			</header>

			<main class="mt-8 grid gap-8 xl:grid-cols-[minmax(0,1fr)_18rem] xl:items-start">
				<section class="space-y-6">
					<section class="rounded-2xl border border-border/70 bg-card p-5 sm:p-6">
						<div class="grid gap-5 sm:gap-6 lg:grid-cols-2">
							<div class="space-y-2">
								<label id="assessment-category-label" class="text-sm font-medium text-foreground">
									Category
								</label>
								<Select
									:model-value="selectedCategoryId"
									:disabled="categoriesLoading || categories.length === 0"
									@update:model-value="handleCategoryChange"
								>
									<SelectTrigger
										class="h-11 w-full"
										aria-labelledby="assessment-category-label"
										aria-describedby="assessment-category-help"
									>
										<SelectValue :placeholder="categoriesLoading ? 'Loading categories...' : 'Select a category'" />
									</SelectTrigger>
									<SelectContent>
										<SelectItem
											v-for="category in categories"
											:key="category.category_id"
											:value="category.category_id"
										>
											{{ category.type_name }} · {{ category.category_id }}
										</SelectItem>
									</SelectContent>
								</Select>
								<p id="assessment-category-help" class="text-sm leading-6 text-muted-foreground">
									{{ selectedCategory?.description || "Choose a category to load its subcategories." }}
								</p>
							</div>

							<div class="space-y-2">
								<label id="assessment-subcategory-label" class="text-sm font-medium text-foreground">
									Subcategory
								</label>
								<Select
									:model-value="selectedSubcategoryId"
									:disabled="subcategoriesLoading || !selectedCategoryId || subcategories.length === 0"
									@update:model-value="handleSubcategoryChange"
								>
									<SelectTrigger
										class="h-11 w-full"
										aria-labelledby="assessment-subcategory-label"
										aria-describedby="assessment-subcategory-help"
									>
										<SelectValue :placeholder="subcategoriesLoading ? 'Loading subcategories...' : 'Select a subcategory'" />
									</SelectTrigger>
									<SelectContent>
										<SelectItem
											v-for="subcategory in subcategories"
											:key="subcategory.sub_category_id"
											:value="subcategory.sub_category_id"
										>
											{{ subcategory.problem_name }} · {{ subcategory.sub_category_id }}
										</SelectItem>
									</SelectContent>
								</Select>
								<p id="assessment-subcategory-help" class="text-sm leading-6 text-muted-foreground">
									{{ selectedSubcategory?.description || "Choose a subcategory to load the live assessment flow." }}
								</p>
								<p class="text-xs font-medium text-muted-foreground">
									{{ selectedSubcategory?.severity_level ? `Severity level ${selectedSubcategory.severity_level}` : "Severity level not set" }}
								</p>
							</div>
						</div>

						<p class="mt-4 text-sm leading-6 text-muted-foreground">
							The preview updates automatically when you choose a new category or subcategory.
						</p>
					</section>

					<AssessmentDemoSandbox
						:scenario="liveScenario"
						:loading="categoriesLoading || subcategoriesLoading || contentLoading"
						:error="pageError"
						:empty-title="sandboxEmptyTitle"
						:empty-description="sandboxEmptyDescription"
					/>
				</section>

				<aside class="xl:sticky xl:top-6">
					<div
						:class="['rounded-2xl border p-5 sm:p-6', statusToneClass]"
						role="status"
						aria-live="polite"
						:aria-busy="isLoadingAny"
					>
						<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Live status
						</p>
						<h2 class="mt-2 text-lg font-semibold text-foreground">
							{{ statusTitle }}
						</h2>
						<p class="mt-2 text-sm leading-6 text-muted-foreground">
							{{ statusDescription }}
						</p>

						<div class="mt-6 space-y-3 text-sm">
							<div class="flex items-start justify-between gap-3">
								<span class="text-muted-foreground">Category</span>
								<span class="text-right font-medium text-foreground">
									{{ selectedCategory?.type_name || "—" }}
								</span>
							</div>
							<div class="flex items-start justify-between gap-3">
								<span class="text-muted-foreground">Subcategory</span>
								<span class="text-right font-medium text-foreground">
									{{ selectedSubcategory?.problem_name || "—" }}
								</span>
							</div>
							<div class="flex items-start justify-between gap-3">
								<span class="text-muted-foreground">Category ID</span>
								<span class="break-all text-right font-medium text-foreground">
									{{ selectedCategory?.category_id || "—" }}
								</span>
							</div>
							<div class="flex items-start justify-between gap-3">
								<span class="text-muted-foreground">Subcategory ID</span>
								<span class="break-all text-right font-medium text-foreground">
									{{ selectedSubcategory?.sub_category_id || "—" }}
								</span>
							</div>
							<div class="flex items-start justify-between gap-3">
								<span class="text-muted-foreground">Questions</span>
								<span class="font-medium text-foreground">
									{{ questionCount }}
								</span>
							</div>
							<div class="flex items-start justify-between gap-3">
								<span class="text-muted-foreground">Suggestion row</span>
								<span class="font-medium text-foreground">
									{{ liveScenario?.suggestion.suggestionId ? "Loaded" : "Missing" }}
								</span>
							</div>
						</div>
					</div>
				</aside>
			</main>
		</div>
	</div>
</template>
