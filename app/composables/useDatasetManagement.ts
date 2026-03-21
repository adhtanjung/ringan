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
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			description:
				"Links this question to a specific mental health subcategory",
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
			key: "scale_min",
			label: "Scale Min",
			type: "number",
			description: "Minimum value for scale-based questions (fixed at 1)",
		},
		{
			key: "scale_max",
			label: "Scale Max",
			type: "number",
			description: "Maximum value for scale-based questions (fixed at 4)",
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
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			description:
				"Links this suggestion to a specific mental health subcategory",
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
			key: "resource_link",
			label: "Resource Link",
			type: "text",
			description:
				"URL or reference to additional resources related to this suggestion",
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
};

// Dataset type labels
export const datasetLabels = {
	problems: "Subcategories",
	assessments: "Assessment Questions",
	suggestions: "Therapeutic Suggestions",
	feedback_prompts: "Feedback Prompts",
	next_actions: "Next Actions",
	training_examples: "Fine-tuning Examples",
	problem_types: "Categories",
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

	// Methods
	const refreshData = async () => {
		loading.value = true;
		error.value = null;

		try {
			if (USE_SUPABASE_FOR.includes(dataType)) {
				// Use Supabase
				const buildQuery = (selectClause: string) => {
					let query = supabase.from(dataType).select(selectClause, {
						count: "exact",
					});

					// Search logic
					if (searchQuery.value.trim()) {
						const search = searchQuery.value.trim();
						if (dataType === "assessments") {
							query = query.ilike("question_text", `%${search}%`);
						} else if (dataType === "problems") {
							query = query.or(
								`problem_name.ilike.%${search}%,description.ilike.%${search}%`,
							);
						} else if (dataType === "suggestions") {
							query = query.ilike("suggestion_text", `%${search}%`);
						} else if (dataType === "feedback_prompts") {
							query = query.ilike("prompt_text", `%${search}%`);
						} else if (dataType === "next_actions") {
							query = query.or(
								`action_id.ilike.%${search}%,action_text.ilike.%${search}%`,
							);
						} else if (dataType === "training_examples") {
							query = query.or(
								`problem.ilike.%${search}%,prompt.ilike.%${search}%,completion.ilike.%${search}%`,
							);
						} else if (dataType === "problem_types") {
							query = query.or(
								`type_name.ilike.%${search}%,description.ilike.%${search}%`,
							);
						}
					}

					// Filters logic
					Object.keys(filters.value).forEach((key) => {
						const value = filters.value[key];
						if (value) {
							if (key === "is_active") {
								query = query.eq(key, value === "true");
							} else {
								query = query.eq(key, value);
							}
						}
					});

					// Sorting
					const finalSortBy =
						sortBy.value ||
						(dataType === "problem_types" ? "type_name" : "created_at");
					const finalAscending = sortBy.value
						? sortOrder.value === "asc"
						: dataType === "problem_types";
					query = query.order(finalSortBy, { ascending: finalAscending });

					return query;
				};

				const from = pagination.value.skip;
				const to = from + pagination.value.limit - 1;
				const pageQuery = buildQuery("*").range(from, to);
				const idsQuery = buildQuery("id");

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

					data.value = (items || []).map((item) => {
						const catName =
							typeMap.get(item.category_id) || item.category || "";
						return {
							...item,
							category_display: item.category_id
								? `${item.category_id} - ${catName}`
								: catName,
						};
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
			} else {
				// Use existing API
				allMatchingIds.value = [];
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
			console.error(`Error fetching ${dataType}:`, err);
			error.value = "Failed to load data. Please try again.";
			data.value = [];
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
