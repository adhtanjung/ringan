import { ref, computed, watch } from "vue";
import { useToast } from "@/components/ui/toast/use-toast";
import { useSupabase } from "./useSupabase";

// Column configurations for each data type
export const columnConfigs = {
	problems: [
		{
			key: "category_display",
			label: "Category",
			type: "text",
			description: "Category ID - Name",
		},
		{
			key: "problem_name",
			label: "Sub Category Name",
			type: "text",
			description:
				"Human-readable name of the mental health problem or condition",
		},
		{
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			description:
				"Internal reference ID for more specific problem subcategories",
		},
		{
			key: "description",
			label: "Description",
			type: "text",
			description:
				"Detailed explanation of the problem, its symptoms, and characteristics",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this subcategory was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp for this subcategory",
		},
	],
	assessments: [
		{
			key: "question_id",
			label: "Question ID",
			type: "text",
			description:
				"Business identifier used to reference this question in the system",
		},
		{
			key: "category_id",
			label: "Category ID",
			type: "text",
			description: "Top-level category this question belongs to",
		},
		{
			key: "category_name",
			label: "Category Name",
			type: "text",
			description: "Name of the top-level category",
		},
		{
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			description:
				"Links this question to a specific mental health subcategory",
		},
		{
			key: "sub_category_name",
			label: "Subcategory Name",
			type: "text",
			description: "Name of the subcategory this question belongs to",
		},
		{
			key: "question_text",
			label: "Question",
			type: "text",
			description:
				"The actual question text presented to users during assessment",
		},
		{
			key: "response_type",
			label: "Response Type",
			type: "badge",
			description: "Type of response expected (scale, text, etc.)",
		},
		{
			key: "scale_label_1",
			label: "Scale Label 1",
			type: "text",
			description: 'Label for scale value 1 (default: "Not at all")',
		},
		{
			key: "scale_label_2",
			label: "Scale Label 2",
			type: "text",
			description: 'Label for scale value 2 (default: "A little")',
		},
		{
			key: "scale_label_3",
			label: "Scale Label 3",
			type: "text",
			description: 'Label for scale value 3 (default: "Quite a bit")',
		},
		{
			key: "scale_label_4",
			label: "Scale Label 4",
			type: "text",
			description: 'Label for scale value 4 (default: "Very much")',
		},
		{
			key: "next_step",
			label: "Next Step",
			type: "text",
			description:
				"Logic for determining the next question based on this response",
		},
		{
			key: "clusters",
			label: "Clusters",
			type: "badge",
			description: "Question groupings used for analysis and scoring purposes",
		},
		{
			key: "batch_id",
			label: "Batch ID",
			type: "text",
			description: "Groups questions that were added or updated together",
		},
		{
			key: "order_number",
			label: "Order",
			type: "number",
			description: "Display order of the question within a batch/cluster",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this assessment question was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp for this question",
		},
	],
	suggestions: [
		{
			key: "suggestion_id",
			label: "Suggestion ID",
			type: "text",
			description:
				"Business identifier used to reference this suggestion in the system",
		},
		{
			key: "category_id",
			label: "Category ID",
			type: "text",
			description: "Top-level category this suggestion belongs to",
		},
		{
			key: "category_name",
			label: "Category Name",
			type: "text",
			description: "Name of the top-level category",
		},
		{
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			description:
				"Links this suggestion to a specific mental health subcategory",
		},
		{
			key: "sub_category_name",
			label: "Subcategory Name",
			type: "text",
			description: "Name of the subcategory this suggestion belongs to",
		},
		{
			key: "cluster",
			label: "Cluster",
			type: "badge",
			description:
				"Groups related suggestions together for better organization",
		},
		{
			key: "suggestion_text",
			label: "Suggestion Text",
			type: "text",
			description:
				"The actual therapeutic advice or intervention text provided to users",
		},
			{
				key: "evidence_base",
				label: "Evidence Base",
				type: "text",
				description:
					"Reference for the therapeutic approach supporting this suggestion",
			},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this suggestion was first added to the system",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp for this suggestion",
		},
	],
	feedback_prompts: [
		{
			key: "prompt_id",
			label: "Prompt ID",
			type: "text",
			description:
				"Business identifier used to reference this prompt in the system",
		},
		{
			key: "stage",
			label: "Stage",
			type: "badge",
			description:
				"When in the therapeutic process this prompt is used (post_suggestion, ongoing, followup)",
		},
		{
			key: "prompt_text",
			label: "Prompt Text",
			type: "text",
			description:
				"The actual text used to prompt users for feedback or reflection",
		},
		{
			key: "next_action_id",
			label: "Next Action ID",
			type: "text",
			description:
				"Links to the next action that should be taken after this prompt",
		},
		{
			key: "context",
			label: "Context",
			type: "text",
			description:
				"Additional context or background information for this prompt",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this feedback prompt was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp for this prompt",
		},
	],
	next_actions: [
		{
			key: "action_id",
			label: "Action ID",
			type: "text",
			description:
				"Business identifier used to reference this action in the system",
		},
		{
			key: "action_text",
			label: "Action Text",
			type: "text",
			description:
				"Human-readable text shown when this action is used",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this next action was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp for this action",
		},
	],
	training_examples: [
		{
			key: "example_id",
			label: "Example ID",
			type: "text",
			description:
				"Business identifier used to reference this training example",
		},
		{
			key: "problem",
			label: "Problem",
			type: "text",
			description: "Description of the mental health problem or situation",
		},
		{
			key: "conversation_id",
			label: "Conversation ID",
			type: "text",
			description: "Links this example to a specific conversation or session",
		},
		{
			key: "user_intent",
			label: "User Intent",
			type: "badge",
			description:
				"What the user was trying to achieve or express in this example",
		},
		{
			key: "prompt",
			label: "Prompt",
			type: "text",
			description: "The input or question that triggered this response",
		},
		{
			key: "completion",
			label: "Completion",
			type: "text",
			description: "The ideal or expected response for this prompt",
		},
		{
			key: "context",
			label: "Context",
			type: "text",
			description:
				"Additional context or background information for this example",
		},
		{
			key: "quality_score",
			label: "Quality Score",
			type: "number",
			description: "Rating (0-10) of how good this training example is",
		},
		{
			key: "tags",
			label: "Tags",
			type: "badge",
			description: "Keywords and labels for categorizing this training example",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this training example was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp for this example",
		},
	],
	problem_types: [
		{
			key: "type_name",
			label: "Category Name",
			type: "text",
			description: "Problem type category name",
		},
		{
			key: "category_id",
			label: "Category ID",
			type: "text",
			description: "Unique category identifier",
		},
		{
			key: "description",
			label: "Description",
			type: "text",
			description: "Detailed description of this problem type",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this type was created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp",
		},
	],
	general_questions: [
		{
			key: "question_id",
			label: "Question ID",
			type: "text",
			description: "Business identifier for this general question (e.g. Q001)",
		},
		{
			key: "question_text",
			label: "Question Text",
			type: "text",
			description: "The question text shown to the user during the conversation",
		},
		{
			key: "response_type",
			label: "Response Type",
			type: "badge",
			description: "How the user answers: yes/no, multiple choice, or auto-route",
		},
		{
			key: "category",
			label: "Category",
			type: "badge",
			description: "Top-level mental health category this question belongs to",
		},
		{
			key: "routing_display",
			label: "Routing",
			type: "text",
			description: "Summary of where this question routes to",
		},
		{
			key: "order_number",
			label: "Order",
			type: "number",
			description: "Display order within the decision tree",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this question was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp",
		},
	],
	opening_questions: [
		{
			key: "question_id",
			label: "Question ID",
			type: "text",
			description: "Business identifier for this opening question (e.g. OQ001)",
		},
		{
			key: "question_text",
			label: "Question Text",
			type: "text",
			description: "The question text shown to the user at the start of the conversation",
		},
		{
			key: "response_type",
			label: "Response Type",
			type: "badge",
			description: "How the user answers: yes/no or multiple choice",
		},
		{
			key: "routing_display",
			label: "Routing",
			type: "text",
			description: "Summary of where this question routes to",
		},
		{
			key: "order_number",
			label: "Order",
			type: "number",
			description: "Display order within the opening flow",
		},
		{
			key: "created_at",
			label: "Created",
			type: "date",
			description: "When this question was first created",
		},
		{
			key: "updated_at",
			label: "Updated",
			type: "date",
			description: "Last modification timestamp",
		},
	],
};

// Dataset type labels
export const datasetLabels = {
	problems: "Subcategories",
	assessments: "Assessment Questions",
	suggestions: "Suggestions",
	feedback_prompts: "Feedback Prompts",
	next_actions: "Next Actions",
	training_examples: "Fine-tuning Examples",
	problem_types: "Categories",
	general_questions: "General Questions",
	opening_questions: "Opening Questions",
};

// List of data types to use Supabase instead of the backend API
const USE_SUPABASE_FOR = [
	"problem_types",
	"problems",
	"assessments",
	"suggestions",
	"feedback_prompts",
	"next_actions",
	"training_examples",
	"general_questions",
	"opening_questions",
];

export function useDatasetManagement(
	dataType: string,
	initialFilters: Record<string, string> = {},
) {
	// Get Supabase client
	const { supabase } = useSupabase();

	// Get runtime config for API URLs
	const config = useRuntimeConfig();
	const adminApiUrl =
		config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";

	const route = useRoute();
	const router = useRouter();

	// Reactive data
	const loading = ref(false);
	const error = ref<string | null>(null);
	const data = ref<any[]>([]);
	const allMatchingIds = ref<any[]>([]);
	const filterOptions = ref<Record<string, any[]>>({});
	const actionLoading = ref(false);
	const showImportModal = ref(false);
	const showExportModal = ref(false);
	const showEditModal = ref(false);
	const editingItem = ref<any>(null);
	const searchQuery = ref("");
	const searchDebounceTimer = ref<NodeJS.Timeout | null>(null);
	const filters = ref<Record<string, string>>({ ...initialFilters });
	const sortBy = ref<string>("");
	const sortOrder = ref<"asc" | "desc">("desc");

	// Pagination state
	const pagination = ref({
		skip: 0,
		limit: 10,
		total: 0,
		has_more: false,
	});

	// Initialize page from URL
	if (route.query.page) {
		const pageFromUrl = parseInt(route.query.page as string) || 1;
		if (pageFromUrl > 1) {
			pagination.value.skip = (pageFromUrl - 1) * pagination.value.limit;
		}
	}

	// Toast notifications
	const { toast } = useToast();

	// Computed properties
	const columns = computed(() => (columnConfigs as any)[dataType] || []);
	const dataTypeLabel = computed(
		() => (datasetLabels as any)[dataType] || "Dataset",
	);

	const applySearchToQuery = (query: any) => {
		if (!searchQuery.value.trim()) return query;

		const search = searchQuery.value.trim();
		if (dataType === "assessments") {
			return query.ilike("question_text", `%${search}%`);
		}
		if (dataType === "problems") {
			return query.or(
				`problem_name.ilike.%${search}%,description.ilike.%${search}%`,
			);
		}
		if (dataType === "suggestions") {
			return query.ilike("suggestion_text", `%${search}%`);
		}
		if (dataType === "feedback_prompts") {
			return query.ilike("prompt_text", `%${search}%`);
		}
		if (dataType === "next_actions") {
			return query.or(
				`action_id.ilike.%${search}%,action_text.ilike.%${search}%`,
			);
		}
		if (dataType === "training_examples") {
			return query.or(
				`problem.ilike.%${search}%,prompt.ilike.%${search}%,completion.ilike.%${search}%`,
			);
		}
		if (dataType === "problem_types") {
			return query.or(`type_name.ilike.%${search}%,description.ilike.%${search}%`);
		}

		if (dataType === "general_questions") {
			return query.or(
				`question_id.ilike.%${search}%,question_text.ilike.%${search}%`,
			);
		}

		if (dataType === "opening_questions") {
			return query.or(
				`question_id.ilike.%${search}%,question_text.ilike.%${search}%`,
			);
		}

		return query;
	};

	const applyFiltersToQuery = (query: any, omitFilterKey = "") => {
		Object.keys(filters.value).forEach((key) => {
			if (omitFilterKey && key === omitFilterKey) return;
			const value = filters.value[key];
			if (!value) return;

			if (key === "is_active") {
				query = query.eq(key, value === "true");
			} else if (key === "created_from") {
				query = query.gte("created_at", value);
			} else if (key === "created_to") {
				query = query.lte("created_at", value + "T23:59:59.999Z");
			} else if (key === "updated_from") {
				query = query.gte("updated_at", value);
			} else if (key === "updated_to") {
				query = query.lte("updated_at", value + "T23:59:59.999Z");
			} else if (key === "clusters") {
				// clusters is an array column — use contains
				query = query.cs(key, [value]);
			} else if (key === "category_id" && (dataType === "assessments" || dataType === "suggestions")) {
				// filter by category_id via sub_category_id join — handled client-side via data transform
				// skip pushing to supabase query; filtering done post-fetch
			} else {
				query = query.eq(key, value);
			}
		});
		return query;
	};

	const buildSupabaseQuery = (
		selectClause: string,
		options: { countExact?: boolean; omitFilterKey?: string } = {},
	) => {
		let query: any;
		if (options.countExact) {
			query = supabase.from(dataType).select(selectClause, {
				count: "exact",
			});
		} else {
			query = supabase.from(dataType).select(selectClause);
		}

		query = applySearchToQuery(query);
		query = applyFiltersToQuery(query, options.omitFilterKey || "");
		return query;
	};

	const fetchFilterOptions = async () => {
		if (!USE_SUPABASE_FOR.includes(dataType)) {
			filterOptions.value = {};
			return;
		}

		const nextOptions: Record<string, any[]> = {};
		const uniqStrings = (values: Array<string | null | undefined>) =>
			[...new Set(values.filter((v): v is string => Boolean(v && String(v).trim())).map((v) => String(v).trim()))].sort(
				(a, b) => a.localeCompare(b),
			);

		try {
			if (dataType === "problems") {
				const [{ data: categoryRows, error: categoryError }, { data: subRows, error: subError }] =
					await Promise.all([
						buildSupabaseQuery("category_id", { omitFilterKey: "category_id" }).order(
							"category_id",
							{ ascending: true },
						),
						buildSupabaseQuery("sub_category_id, problem_name", {
							omitFilterKey: "sub_category_id",
						}).order("sub_category_id", { ascending: true }),
					]);

				if (categoryError) throw categoryError;
				if (subError) throw subError;

				const uniqueCatIds = [...new Set<string>(
					(categoryRows || [])
						.map((row: any) => row.category_id ? String(row.category_id).trim() : "")
						.filter((v: string) => v.length > 0)
				)].sort((a, b) => a.localeCompare(b));

				if (uniqueCatIds.length > 0) {
					const { data: typeRows } = await supabase
						.from("problem_types")
						.select("category_id, type_name")
						.in("category_id", uniqueCatIds);
					const typeMap = new Map(
						(typeRows || []).map((t: any) => [String(t.category_id), String(t.type_name || "").trim()])
					);
					nextOptions.category_id = uniqueCatIds.map((id) => ({
						id,
						name: typeMap.get(id) || id,
					}));
				} else {
					nextOptions.category_id = [];
				}

				const subMap = new Map<string, { id: string; name: string }>();
				for (const row of subRows || []) {
					const id = row?.sub_category_id ? String(row.sub_category_id).trim() : "";
					if (!id || subMap.has(id)) continue;
					subMap.set(id, {
						id,
						name:
							row?.problem_name && String(row.problem_name).trim()
								? String(row.problem_name).trim()
								: id,
					});
				}
				nextOptions.sub_category_id = [...subMap.values()];
			} else if (dataType === "assessments") {
				const [
					{ data: subRows, error: subError },
					{ data: responseTypeRows, error: rtError },
					{ data: clustersRows, error: clustersError },
					{ data: batchRows, error: batchError },
				] = await Promise.all([
					buildSupabaseQuery("sub_category_id", { omitFilterKey: "sub_category_id" }).order("sub_category_id", { ascending: true }),
					buildSupabaseQuery("response_type", { omitFilterKey: "response_type" }).order("response_type", { ascending: true }),
					buildSupabaseQuery("clusters", { omitFilterKey: "clusters" }),
					buildSupabaseQuery("batch_id", { omitFilterKey: "batch_id" }).order("batch_id", { ascending: true }),
				]);

				if (subError) throw subError;
				if (rtError) throw rtError;
				if (clustersError) throw clustersError;
				if (batchError) throw batchError;

				const subIds = uniqStrings((subRows || []).map((row: any) => row.sub_category_id));
				if (subIds.length === 0) {
					nextOptions.sub_category_id = [];
					nextOptions.category_id = [];
				} else {
					const { data: problemRows } = await supabase
						.from("problems")
						.select("sub_category_id, problem_name, category_id")
						.in("sub_category_id", subIds)
						.eq("is_active", true);

					const problemMap = new Map<string, { name: string; category_id: string }>();
					for (const row of problemRows || []) {
						const id = row?.sub_category_id ? String(row.sub_category_id).trim() : "";
						if (!id || problemMap.has(id)) continue;
						problemMap.set(id, {
							name: row?.problem_name ? String(row.problem_name).trim() : id,
							category_id: row?.category_id ? String(row.category_id).trim() : "",
						});
					}

					nextOptions.sub_category_id = subIds.map((id) => ({
						id,
						name: problemMap.get(id)?.name || id,
					}));

					const catIds = [...new Set(
						[...problemMap.values()].map((v) => v.category_id).filter(Boolean)
					)].sort((a, b) => a.localeCompare(b));

					if (catIds.length > 0) {
						const { data: typeRows } = await supabase
							.from("problem_types")
							.select("category_id, type_name")
							.in("category_id", catIds);
						const typeMap = new Map(
							(typeRows || []).map((t: any) => [String(t.category_id), String(t.type_name || "").trim()])
						);
						nextOptions.category_id = catIds.map((id) => ({
							id,
							name: typeMap.get(id) || id,
						}));
					} else {
						nextOptions.category_id = [];
					}
				}

				nextOptions.response_type = uniqStrings(
					(responseTypeRows || []).map((row: any) => row.response_type),
				);

				const clusterSet = new Set<string>();
				for (const row of clustersRows || []) {
					const val = row?.clusters;
					if (Array.isArray(val)) {
						val.forEach((c: any) => { if (c) clusterSet.add(String(c).trim()); });
					} else if (val) {
						clusterSet.add(String(val).trim());
					}
				}
				nextOptions.clusters = [...clusterSet].sort((a, b) => a.localeCompare(b));

				nextOptions.batch_id = uniqStrings(
					(batchRows || []).map((row: any) => row.batch_id),
				);
			} else if (dataType === "suggestions") {
				const [
					{ data: subRows, error: subError },
					{ data: clusterRows, error: clusterError },
				] = await Promise.all([
					buildSupabaseQuery("sub_category_id", { omitFilterKey: "sub_category_id" }).order("sub_category_id", { ascending: true }),
					buildSupabaseQuery("cluster", { omitFilterKey: "cluster" }).order("cluster", { ascending: true }),
				]);

				if (subError) throw subError;
				if (clusterError) throw clusterError;

				const subIds = uniqStrings((subRows || []).map((row: any) => row.sub_category_id));
				if (subIds.length === 0) {
					nextOptions.sub_category_id = [];
					nextOptions.category_id = [];
				} else {
					const { data: problemRows } = await supabase
						.from("problems")
						.select("sub_category_id, problem_name, category_id")
						.in("sub_category_id", subIds)
						.eq("is_active", true);

					const problemMap = new Map<string, { name: string; category_id: string }>();
					for (const row of problemRows || []) {
						const id = row?.sub_category_id ? String(row.sub_category_id).trim() : "";
						if (!id || problemMap.has(id)) continue;
						problemMap.set(id, {
							name: row?.problem_name ? String(row.problem_name).trim() : id,
							category_id: row?.category_id ? String(row.category_id).trim() : "",
						});
					}

					nextOptions.sub_category_id = subIds.map((id) => ({
						id,
						name: problemMap.get(id)?.name || id,
					}));

					const catIds = [...new Set(
						[...problemMap.values()].map((v) => v.category_id).filter(Boolean)
					)].sort((a, b) => a.localeCompare(b));

					if (catIds.length > 0) {
						const { data: typeRows } = await supabase
							.from("problem_types")
							.select("category_id, type_name")
							.in("category_id", catIds);
						const typeMap = new Map(
							(typeRows || []).map((t: any) => [String(t.category_id), String(t.type_name || "").trim()])
						);
						nextOptions.category_id = catIds.map((id) => ({
							id,
							name: typeMap.get(id) || id,
						}));
					} else {
						nextOptions.category_id = [];
					}
				}

				nextOptions.cluster = uniqStrings(
					(clusterRows || []).map((row: any) => row.cluster),
				);
			} else if (dataType === "problem_types") {
				const { data: categoryRows, error: categoryError } = await buildSupabaseQuery(
					"category_id, type_name",
					{ omitFilterKey: "category_id" },
				).order("category_id", { ascending: true });

				if (categoryError) throw categoryError;

				const catMap = new Map<string, string>();
				for (const row of categoryRows || []) {
					const id = row?.category_id ? String(row.category_id).trim() : "";
					if (!id || catMap.has(id)) continue;
					const name = row?.type_name && String(row.type_name).trim()
						? String(row.type_name).trim()
						: id;
					catMap.set(id, name);
				}
				nextOptions.category_id = [...catMap.entries()].map(([id, name]) => ({ id, name }));
			} else if (dataType === "general_questions") {
				const [
					{ data: categoryRows, error: categoryError },
					{ data: responseTypeRows, error: rtError },
				] = await Promise.all([
					buildSupabaseQuery("category", { omitFilterKey: "category" }).order("category", { ascending: true }),
					buildSupabaseQuery("response_type", { omitFilterKey: "response_type" }).order("response_type", { ascending: true }),
				]);

				if (categoryError) throw categoryError;
				if (rtError) throw rtError;

				const uniqStrings = (values: Array<string | null | undefined>) =>
					[...new Set(values.filter((v): v is string => Boolean(v && String(v).trim())).map((v) => String(v).trim()))].sort((a, b) => a.localeCompare(b));

				nextOptions.category = uniqStrings((categoryRows || []).map((row: any) => row.category));
				nextOptions.response_type = uniqStrings((responseTypeRows || []).map((row: any) => row.response_type));
			} else if (dataType === "opening_questions") {
				const { data: responseTypeRows, error: rtError } = await buildSupabaseQuery(
					"response_type",
					{ omitFilterKey: "response_type" },
				).order("response_type", { ascending: true });

				if (rtError) throw rtError;

				const uniqStr = (values: Array<string | null | undefined>) =>
					[...new Set(values.filter((v): v is string => Boolean(v && String(v).trim())).map((v) => String(v).trim()))].sort((a, b) => a.localeCompare(b));

				nextOptions.response_type = uniqStr((responseTypeRows || []).map((row: any) => row.response_type));
			}

			filterOptions.value = nextOptions;
		} catch (err) {
			console.error(`Error fetching filter options for ${dataType}:`, err);
			filterOptions.value = {};
		}
	};

	// Methods
	const refreshData = async () => {
		loading.value = true;
		error.value = null;

		try {
			if (USE_SUPABASE_FOR.includes(dataType)) {
				const from = pagination.value.skip;
				const to = from + pagination.value.limit - 1;
				const finalSortBy =
					sortBy.value ||
					(dataType === "problem_types" ? "type_name" : "created_at");
				const finalAscending = sortBy.value
					? sortOrder.value === "asc"
					: dataType === "problem_types";

				const pageQuery = buildSupabaseQuery("*", { countExact: true })
					.order(finalSortBy, { ascending: finalAscending })
					.range(from, to);
				const idsQuery = buildSupabaseQuery("id");

				const [
					{ data: items, count, error: supabaseError },
					{ data: idRows, error: idsError },
				] = await Promise.all([pageQuery, idsQuery]);

				if (supabaseError) throw supabaseError;
				if (idsError) throw idsError;

				allMatchingIds.value = (idRows || [])
					.map((row: any) => row.id)
					.filter(Boolean);

				// Transform data if needed
				if (dataType === "problems") {
					// Fetch category names from problem_types to ensure accuracy
					const { data: types } = await supabase
						.from("problem_types")
						.select("category_id, type_name");
					const typeMap = new Map(
						types?.map((t) => [t.category_id, t.type_name]) || [],
					);

					data.value = (items || []).map((item: any) => {
						const catName =
							typeMap.get(item.category_id) || item.category || "";
						return {
							...item,
							category_display: item.category_id
								? `${item.category_id} - ${catName}`
								: catName,
						};
					});
				} else if (dataType === "assessments" || dataType === "suggestions") {
					// Enrich with category_id, category_name, sub_category_name via problems + problem_types
					const subIds = [...new Set(
						(items || []).map((item: any) => item.sub_category_id).filter(Boolean)
					)] as string[];

					let problemMap = new Map<string, { name: string; category_id: string }>();
					let typeMap = new Map<string, string>();

					if (subIds.length > 0) {
						const { data: problemRows } = await supabase
							.from("problems")
							.select("sub_category_id, problem_name, category_id")
							.in("sub_category_id", subIds)
							.eq("is_active", true);

						for (const row of problemRows || []) {
							const id = row?.sub_category_id ? String(row.sub_category_id).trim() : "";
							if (!id || problemMap.has(id)) continue;
							problemMap.set(id, {
								name: row?.problem_name ? String(row.problem_name).trim() : id,
								category_id: row?.category_id ? String(row.category_id).trim() : "",
							});
						}

						const catIds = [...new Set([...problemMap.values()].map((v) => v.category_id).filter(Boolean))];
						if (catIds.length > 0) {
							const { data: typeRows } = await supabase
								.from("problem_types")
								.select("category_id, type_name")
								.in("category_id", catIds);
							typeMap = new Map(
								(typeRows || []).map((t: any) => [String(t.category_id), String(t.type_name || "").trim()])
							);
						}
					}

					const categoryIdFilter = filters.value["category_id"];
					let enriched = (items || []).map((item: any) => {
						const prob = problemMap.get(String(item.sub_category_id || "").trim());
						const catId = prob?.category_id || "";
						const catName = catId ? (typeMap.get(catId) || catId) : "";
						return {
							...item,
							category_id: catId,
							category_name: catName,
							sub_category_name: prob?.name || "",
						};
					});

					// Client-side filter by category_id if set
					if (categoryIdFilter) {
						enriched = enriched.filter((item: any) => item.category_id === categoryIdFilter);
					}

					data.value = enriched;
				} else if (dataType === "general_questions") {
					data.value = (items || []).map((item: any) => {
						let routing_display = "";
						const rt = item.response_type;
						if (rt === "auto-route") {
							routing_display = item.leads_to_subcategory
								? `→ ${item.leads_to_subcategory}`
								: "—";
						} else if (rt === "yes/no") {
							const yesVal = item.yes_destination_value || item.next_question_if_yes || "";
							const noVal  = item.no_destination_value  || item.next_question_if_no  || "";
							const yType  = item.yes_destination_type  || "";
							const nType  = item.no_destination_type   || "";
							const yesPart = yesVal ? `Yes → ${yType ? yType + ": " : ""}${yesVal}` : "";
							const noPart  = noVal  ? `No → ${nType  ? nType  + ": " : ""}${noVal}`  : "";
							routing_display = [yesPart, noPart].filter(Boolean).join("  |  ") || "—";
						} else if (rt === "multiple choice") {
							const ch = Array.isArray(item.choices) ? item.choices : [];
							routing_display = ch.length ? `${ch.length} choice${ch.length !== 1 ? "s" : ""}` : "—";
						} else {
							routing_display = "—";
						}
						return { ...item, routing_display };
					});
				} else if (dataType === "opening_questions") {
					data.value = (items || []).map((item: any) => {
						let routing_display = "";
						const rt = item.response_type;
						if (rt === "yes/no") {
							const yesVal = item.yes_destination_value || "";
							const noVal  = item.no_destination_value  || "";
							const yType  = item.yes_destination_type  || "";
							const nType  = item.no_destination_type   || "";
							const yesPart = yesVal ? `Yes → ${yType === "category" ? "Category: " : ""}${yesVal}` : "";
							const noPart  = noVal  ? `No → ${nType  === "category" ? "Category: " : ""}${noVal}`  : "";
							routing_display = [yesPart, noPart].filter(Boolean).join("  |  ") || "—";
						} else if (rt === "multiple choice") {
							const ch = Array.isArray(item.choices) ? item.choices : [];
							routing_display = ch.length ? `${ch.length} choice${ch.length !== 1 ? "s" : ""}` : "—";
						} else {
							routing_display = "—";
						}
						return { ...item, routing_display };
					});
				} else {
					data.value = items || [];
				}
				pagination.value = {
					skip: from,
					limit: pagination.value.limit,
					total: count || 0,
					has_more: from + (items?.length || 0) < (count || 0),
				};

				await fetchFilterOptions();
			} else {
				// Use existing API
				allMatchingIds.value = [];
				filterOptions.value = {};
				const currentPagination = pagination.value;
				const params = new URLSearchParams({
					skip: currentPagination.skip.toString(),
					limit: currentPagination.limit.toString(),
				});

				// Add search query if present
				if (searchQuery.value.trim()) {
					params.append("search", searchQuery.value.trim());
				}

				// Add filters dynamically based on data type
				Object.keys(filters.value).forEach((key) => {
					if (filters.value[key]) {
						params.append(key, filters.value[key]);
					}
				});

				const response = (await $fetch(
					`${adminApiUrl}/dataset/${dataType}?${params.toString()}`,
				)) as any;

				data.value = response.data?.items || [];

				// Update pagination state
				pagination.value = {
					skip: response.data?.skip || 0,
					limit: response.data?.limit || 10,
					total: response.data?.total || 0,
					has_more: response.data?.has_more || false,
				};
			}
		} catch (err) {
			const errCode = (err as any)?.code;
			if (
				USE_SUPABASE_FOR.includes(dataType) &&
				errCode === "PGRST103" &&
				pagination.value.skip > 0
			) {
				// Current page is out of range (e.g. after import/delete shrinks dataset).
				// Reset to page 1 and retry once.
				pagination.value.skip = 0;
				await router.replace({
					query: {
						...route.query,
						page: "1",
					},
				});
				await refreshData();
				return;
			}

			console.error(`Error fetching ${dataType}:`, err);
			error.value = "Failed to load data. Please try again.";
			data.value = [];
			filterOptions.value = {};
		} finally {
			loading.value = false;
		}
	};

	// Debounced search handler
	const handleSearch = () => {
		// Clear existing timer
		if (searchDebounceTimer.value) {
			clearTimeout(searchDebounceTimer.value);
		}

		// Reset to first page when searching
		pagination.value.skip = 0;

		// Set new timer
		searchDebounceTimer.value = setTimeout(() => {
			refreshData();
		}, 300);
	};

	// Watch search query and trigger debounced search
	watch(searchQuery, () => {
		handleSearch();
	});

	const setFilter = (key: string, value: string | null) => {
		if (value) {
			filters.value[key] = value;
		} else {
			delete filters.value[key];
		}
		pagination.value.skip = 0; // Reset to first page
		refreshData();
	};

	const clearFilters = () => {
		filters.value = { ...initialFilters };
		pagination.value.skip = 0;
		refreshData();
	};

	const setSort = (column: string, order: "asc" | "desc") => {
		sortBy.value = column;
		sortOrder.value = order;
		pagination.value.skip = 0;
		refreshData();
	};

	const openCreateModal = () => {
		editingItem.value = null;
		showEditModal.value = true;
	};

	const openEditModal = (item: any) => {
		editingItem.value = item;
		showEditModal.value = true;
	};

	const closeEditModal = () => {
		showEditModal.value = false;
		editingItem.value = null;
	};

	const handleSave = async (itemData: any) => {
		actionLoading.value = true;
		const isUpdate = !!editingItem.value;
		const actionType = isUpdate ? "updated" : "created";

		try {
			if (USE_SUPABASE_FOR.includes(dataType)) {
				// Use Supabase
				if (isUpdate) {
					const { error: supabaseError } = await supabase
						.from(dataType)
						.update({
							...itemData,
							updated_at: new Date().toISOString(),
						})
						.eq("id", editingItem.value.id);

					if (supabaseError) throw supabaseError;
				} else {
					const { error: supabaseError } = await supabase
						.from(dataType)
						.insert({
							...itemData,
							created_at: new Date().toISOString(),
							updated_at: new Date().toISOString(),
						});

					if (supabaseError) throw supabaseError;
				}
			} else {
				// Use existing API
				if (isUpdate) {
					// Update existing item
					await $fetch(
						`${adminApiUrl}/dataset/${dataType}/${editingItem.value?.id}`,
						{
							method: "PUT",
							body: itemData,
						},
					);
				} else {
					// Create new item
					await $fetch(`${adminApiUrl}/dataset/${dataType}`, {
						method: "POST",
						body: itemData,
					});
				}
			}

			// Show success toast
			toast({
				title: "Success",
				description: `${dataTypeLabel.value} ${actionType} successfully`,
				variant: "default",
			});

			// Refresh data
			await refreshData();

			// Close modal
			closeEditModal();
		} catch (err) {
			console.error("Error saving item:", err);

			// Show error toast
			toast({
				title: "Error",
				description:
					(err as any)?.data?.detail ||
					`Failed to ${
						actionType === "updated" ? "update" : "create"
					} ${dataTypeLabel.value.toLowerCase()}. Please try again.`,
				variant: "destructive",
			});

			throw err;
		} finally {
			actionLoading.value = false;
		}
	};

	const deleteItem = async (item: any) => {
		actionLoading.value = true;

		try {
			if (USE_SUPABASE_FOR.includes(dataType)) {
				// Use Supabase - Soft delete by setting is_active to false
				const { error: supabaseError } = await supabase
					.from(dataType)
					.update({ is_active: false, updated_at: new Date().toISOString() })
					.eq("id", item.id);

				if (supabaseError) throw supabaseError;
			} else {
				// Use existing API
				await $fetch(`${adminApiUrl}/dataset/${dataType}/${item.id}`, {
					method: "DELETE",
				});
			}

			// Show success toast
			toast({
				title: "Success",
				description: `${dataTypeLabel.value} deleted successfully`,
				variant: "default",
			});

			// Refresh data
			await refreshData();
		} catch (err) {
			console.error("Error deleting item:", err);

			// Show error toast
			toast({
				title: "Error",
				description:
					(err as any)?.message ||
					(err as any)?.data?.detail ||
					`Failed to delete ${dataTypeLabel.value.toLowerCase()}. Please try again.`,
				variant: "destructive",
			});
		} finally {
			actionLoading.value = false;
		}
	};

	const bulkDeleteItems = async (itemIds: string[]) => {
		actionLoading.value = true;
		const itemCount = itemIds.length;

		try {
			if (USE_SUPABASE_FOR.includes(dataType)) {
				// Use Supabase - Soft delete by setting is_active to false
				const { error: supabaseError } = await supabase
					.from(dataType)
					.update({ is_active: false, updated_at: new Date().toISOString() })
					.in("id", itemIds);

				if (supabaseError) throw supabaseError;
			} else {
				// Use existing API
				await $fetch(`${adminApiUrl}/dataset/${dataType}/bulk-delete`, {
					method: "POST",
					body: { ids: itemIds },
				});
			}

			// Show success toast
			toast({
				title: "Success",
				description: `${itemCount} ${dataTypeLabel.value.toLowerCase()}${
					itemCount > 1 ? "s" : ""
				} deleted successfully`,
				variant: "default",
			});

			// Refresh data
			await refreshData();
		} catch (err) {
			console.error("Error bulk deleting items:", err);

			// Show error toast
			toast({
				title: "Error",
				description:
					(err as any)?.message ||
					(err as any)?.data?.detail ||
					`Failed to delete ${dataTypeLabel.value.toLowerCase()}s. Please try again.`,
				variant: "destructive",
			});
		} finally {
			actionLoading.value = false;
		}
	};

	const openImportModal = () => {
		showImportModal.value = true;
	};

	const closeImportModal = () => {
		showImportModal.value = false;
	};

	const openExportModal = () => {
		showExportModal.value = true;
	};

	const closeExportModal = () => {
		showExportModal.value = false;
	};

	const handleImportSuccess = async (result: any) => {
		// Only show success toast if import was actually successful
		if (result.success && result.imported_count > 0) {
			toast({
				title: "Import Successful",
				description: `Successfully imported ${result.imported_count} items`,
				variant: "default",
			});
		} else if (result.imported_count > 0) {
			// Partial success
			toast({
				title: "Import Completed with Issues",
				description: `Imported ${result.imported_count} items, ${result.failed_count} failed`,
				variant: "default",
			});
		} else {
			// Complete failure - show error toast
			toast({
				title: "Import Failed",
				description:
					result.message || "Import failed. Please check the error messages.",
				variant: "destructive",
			});
		}

		// After import, reset to first page to avoid stale out-of-range offsets.
		pagination.value.skip = 0;
		await router.replace({
			query: {
				...route.query,
				page: "1",
			},
		});

		// Refresh data after import (whether successful or not)
		await refreshData();
	};

	// Pagination methods
	const goToPage = async (page: number) => {
		const newSkip = (page - 1) * pagination.value.limit;
		pagination.value.skip = newSkip;

		// Update URL
		router.push({
			query: {
				...route.query,
				page: page.toString(),
			},
		});

		await refreshData();
	};

	const changePageSize = async (newLimit: number) => {
		pagination.value.limit = newLimit;
		pagination.value.skip = 0; // Reset to first page

		// Update URL (reset to page 1)
		router.push({
			query: {
				...route.query,
				page: "1",
			},
		});

		await refreshData();
	};

	const nextPage = async () => {
		if (pagination.value.has_more) {
			pagination.value.skip += pagination.value.limit;

			const nextPageNum =
				Math.floor(pagination.value.skip / pagination.value.limit) + 1;
			router.push({
				query: {
					...route.query,
					page: nextPageNum.toString(),
				},
			});

			await refreshData();
		}
	};

	const prevPage = async () => {
		if (pagination.value.skip > 0) {
			pagination.value.skip = Math.max(
				0,
				pagination.value.skip - pagination.value.limit,
			);

			const prevPageNum =
				Math.floor(pagination.value.skip / pagination.value.limit) + 1;
			router.push({
				query: {
					...route.query,
					page: prevPageNum.toString(),
				},
			});

			await refreshData();
		}
	};

	// Computed properties for pagination
	const currentPage = computed(
		() => Math.floor(pagination.value.skip / pagination.value.limit) + 1,
	);
	const totalPages = computed(() =>
		Math.ceil(pagination.value.total / pagination.value.limit),
	);

	const bulkUpdateItems = async (
		idsOrData: string[] | { ids: string[]; field: string; value: any },
		field?: string,
		value?: any,
	) => {
		actionLoading.value = true;
		try {
			let ids: string[];
			let targetField: string;
			let targetValue: any;

			if (Array.isArray(idsOrData)) {
				ids = idsOrData;
				targetField = field!;
				targetValue = value;
			} else {
				ids = idsOrData.ids;
				targetField = idsOrData.field;
				targetValue = idsOrData.value;
			}

			if (USE_SUPABASE_FOR.includes(dataType)) {
				const { error: supabaseError } = await supabase
					.from(dataType)
					.update({
						[targetField]: targetValue,
						updated_at: new Date().toISOString(),
					})
					.in("id", ids);

				if (supabaseError) throw supabaseError;
			} else {
				// API implementation if needed
				await $fetch(`${adminApiUrl}/dataset/${dataType}/bulk-update`, {
					method: "POST",
					body: { ids, field: targetField, value: targetValue },
				});
			}

			toast({
				title: "Success",
				description: `Updated ${ids.length} items successfully`,
			});

			await refreshData();
		} catch (err) {
			console.error("Bulk update error:", err);
			toast({
				title: "Error",
				description: "Failed to update items. Please try again.",
				variant: "destructive",
			});
			throw err;
		} finally {
			actionLoading.value = false;
		}
	};

	return {
		// State
		dataType,
		loading,
		error,
		data,
		allMatchingIds,
		filterOptions,
		actionLoading,
		showImportModal,
		showExportModal,
		showEditModal,
		editingItem,
		pagination,
		searchQuery,
		filters,

		// Computed
		columns,
		dataTypeLabel,
		currentPage,
		totalPages,

		// Methods
		refreshData,
		openCreateModal,
		openEditModal,
		closeEditModal,
		handleSave,
		deleteItem,
		bulkDeleteItems,
		bulkUpdateItems,
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
	};
}
