import { ref } from "vue";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useToast } from "@/components/ui/toast/use-toast";
import {
	buildListRelationSummary,
	buildSingleRelationSummary,
	fetchListRelationRecords,
	fetchSingleRelationRecord,
	getRelationSpec,
	normalizeRelationId,
} from "@/composables/drawerRelations";
import type { LinkedRecordSection } from "@/composables/drawerRelations";
import {
	createRelationSummaryState,
	type CopyIdPayload,
	type LinkedListRequestPayload,
	type RelationActionPayload,
} from "@/composables/drawers/types";

interface UseProblemsDrawersOptions {
	supabase: SupabaseClient<any, any, any>;
	onEdit: (item: Record<string, unknown>) => void;
}

export const useProblemsDrawers = ({
	supabase,
	onEdit,
}: UseProblemsDrawersOptions) => {
	const { toast } = useToast();

	const showDetailSheet = ref(false);
	const viewingItem = ref<Record<string, unknown> | null>(null);
	const showTechnicalDetails = ref(false);

	const showCategorySheet = ref(false);
	const viewingCategory = ref<Record<string, unknown> | null>(null);
	const showCategoryTechnicalDetails = ref(false);
	const loadingCategory = ref(false);
	const categoryLoadError = ref("");

	const showLinkedRecordsSheet = ref(false);
	const linkedRecordsTitle = ref("Linked Records");
	const linkedRecordsDescription = ref("Records related to this identifier.");
	const linkedRecordsSections = ref<LinkedRecordSection[]>([]);
	const linkedRecordsLoading = ref(false);
	const linkedRecordsError = ref("");
	const linkedRecordsRetryKey = ref("");
	const linkedRecordsRetryId = ref("");

	const problemsCategoryContext = ref(createRelationSummaryState());
	const problemsSubCategoryContext = ref(createRelationSummaryState());
	const problemsCategoryDetailContext = ref(createRelationSummaryState());
	const listPrefetchCache = ref<Record<string, LinkedRecordSection[]>>({});

	const problemsCategoryIdSpec = getRelationSpec("problems_detail", "category_id");
	const problemsSubCategoryIdSpec = getRelationSpec(
		"problems_detail",
		"sub_category_id",
	);
	const problemsRecordIdSpec = getRelationSpec("problems_detail", "id");
	const categoryDetailCategoryIdSpec = getRelationSpec(
		"problems_category_detail",
		"category_id",
	);
	const categoryDetailRecordIdSpec = getRelationSpec(
		"problems_category_detail",
		"id",
	);

	const buildCacheKey = (relationKey: string, relationId: string) =>
		`${relationKey}:${relationId}`;

	const getCachedSections = (relationKey: string, relationId: string) =>
		listPrefetchCache.value[buildCacheKey(relationKey, relationId)];

	const setCachedSections = (
		relationKey: string,
		relationId: string,
		sections: LinkedRecordSection[],
	) => {
		listPrefetchCache.value[buildCacheKey(relationKey, relationId)] = sections;
	};

	const loadProblemsCategorySummary = async (
		rawId: unknown = viewingItem.value?.category_id,
		fallbackCategoryName: unknown = viewingItem.value?.category,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = problemsCategoryIdSpec.relationKey;
		const idLabel = problemsCategoryIdSpec.label;
		const fallbackName = normalizeRelationId(fallbackCategoryName);

		if (!relationId && !fallbackName) {
			problemsCategoryContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			problemsCategoryContext.value = {
				status: "error",
				loading: false,
				error: "No relation query is configured for this ID.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "No relation handler exists for this field.",
					badges: [],
					idLabel,
					idValue: relationId || fallbackName,
				},
			};
			return;
		}

		problemsCategoryContext.value = {
			status: "loading",
			loading: true,
			error: "",
			data: {
				title: "Resolving linked record",
				subtitle: "",
				badges: [],
				idLabel,
				idValue: relationId || fallbackName,
			},
		};

		try {
			let categoryData: Record<string, unknown> | null = null;

			if (relationId) {
				categoryData = (await fetchSingleRelationRecord(
					supabase,
					relationKey,
					relationId,
				)) as Record<string, unknown> | null;
			}

			if (!categoryData && fallbackName) {
				const { data, error } = await supabase
					.from("problem_types")
					.select("*")
					.eq("type_name", fallbackName)
					.eq("is_active", true)
					.maybeSingle();
				if (error) throw error;
				categoryData = (data as Record<string, unknown> | null) || null;
			}

			if (!categoryData) {
				problemsCategoryContext.value = {
					status: "not_found",
					loading: false,
					error: "",
					data: {
						title: "Linked category not found",
						subtitle: "No active parent category matches this record.",
						badges: [],
						idLabel,
						idValue: relationId || fallbackName,
					},
				};
				return;
			}

			const summaryId = normalizeRelationId(categoryData.category_id) || relationId;
			problemsCategoryContext.value = {
				status: "resolved",
				loading: false,
				error: "",
				data: buildSingleRelationSummary(
					relationKey,
					idLabel,
					summaryId,
					categoryData as Record<string, any>,
				),
			};
		} catch (error) {
			console.error("Error prefetching parent category context:", error);
			problemsCategoryContext.value = {
				status: "error",
				loading: false,
				error: "We couldn't resolve the parent category. Please try again.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "Unable to load linked record right now.",
					badges: [],
					idLabel,
					idValue: relationId || fallbackName,
				},
			};
		}
	};

	const loadProblemsSubCategorySummary = async (
		rawId: unknown = viewingItem.value?.sub_category_id,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = problemsSubCategoryIdSpec.relationKey;
		const idLabel = problemsSubCategoryIdSpec.label;

		if (!relationId) {
			problemsSubCategoryContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			problemsSubCategoryContext.value = {
				status: "error",
				loading: false,
				error: "No relation query is configured for this ID.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "No relation handler exists for this field.",
					badges: [],
					idLabel,
					idValue: relationId,
				},
			};
			return;
		}

		const cached = getCachedSections(relationKey, relationId);
		if (cached) {
			problemsSubCategoryContext.value = {
				status: cached.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, cached),
			};
			return;
		}

		problemsSubCategoryContext.value = {
			status: "loading",
			loading: true,
			error: "",
			data: {
				title: "Resolving linked records",
				subtitle: "",
				badges: [],
				idLabel,
				idValue: relationId,
			},
		};

		try {
			const sections = await fetchListRelationRecords(
				supabase,
				relationKey,
				relationId,
			);
			setCachedSections(relationKey, relationId, sections);
			problemsSubCategoryContext.value = {
				status: sections.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, sections),
			};
		} catch (error) {
			console.error("Error prefetching subcategory relation context:", error);
			problemsSubCategoryContext.value = {
				status: "error",
				loading: false,
				error:
					"We couldn't resolve linked assessments/suggestions. Please try again.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "Unable to load linked records right now.",
					badges: [],
					idLabel,
					idValue: relationId,
				},
			};
		}
	};

	const loadCategoryDetailSummary = async (
		rawId: unknown = viewingCategory.value?.category_id,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = categoryDetailCategoryIdSpec.relationKey;
		const idLabel = categoryDetailCategoryIdSpec.label;

		if (!relationId) {
			problemsCategoryDetailContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			problemsCategoryDetailContext.value = {
				status: "error",
				loading: false,
				error: "No relation query is configured for this ID.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "No relation handler exists for this field.",
					badges: [],
					idLabel,
					idValue: relationId,
				},
			};
			return;
		}

		const cached = getCachedSections(relationKey, relationId);
		if (cached) {
			problemsCategoryDetailContext.value = {
				status: cached.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, cached),
			};
			return;
		}

		problemsCategoryDetailContext.value = {
			status: "loading",
			loading: true,
			error: "",
			data: {
				title: "Resolving linked records",
				subtitle: "",
				badges: [],
				idLabel,
				idValue: relationId,
			},
		};

		try {
			const sections = await fetchListRelationRecords(
				supabase,
				relationKey,
				relationId,
			);
			setCachedSections(relationKey, relationId, sections);
			problemsCategoryDetailContext.value = {
				status: sections.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, sections),
			};
		} catch (error) {
			console.error("Error prefetching category-detail relation context:", error);
			problemsCategoryDetailContext.value = {
				status: "error",
				loading: false,
				error: "We couldn't resolve linked subcategories. Please try again.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "Unable to load linked records right now.",
					badges: [],
					idLabel,
					idValue: relationId,
				},
			};
		}
	};

	const openDetailView = (item: Record<string, unknown>) => {
		viewingItem.value = item;
		showTechnicalDetails.value = false;
		showDetailSheet.value = true;
		void loadProblemsCategorySummary(item?.category_id, item?.category);
		void loadProblemsSubCategorySummary(item?.sub_category_id);
	};

	const closeDetailSheet = () => {
		showDetailSheet.value = false;
		setTimeout(() => {
			viewingItem.value = null;
			showTechnicalDetails.value = false;
			problemsCategoryContext.value = createRelationSummaryState();
			problemsSubCategoryContext.value = createRelationSummaryState();
		}, 300);
	};

	const openEditFromDetail = () => {
		if (!viewingItem.value) return;
		closeDetailSheet();
		onEdit(viewingItem.value);
	};

	const openCategoryDetail = async (
		payload: RelationActionPayload = {
			scopeKey: "problems_detail",
			idField: "category_id",
			idValue: viewingItem.value?.category_id as string | null | undefined,
		},
	) => {
		const relationId = normalizeRelationId(payload.idValue);
		const fallbackCategoryName = normalizeRelationId(viewingItem.value?.category);

		showCategoryTechnicalDetails.value = false;
		categoryLoadError.value = "";
		showCategorySheet.value = true;
		viewingCategory.value = null;
		problemsCategoryDetailContext.value = createRelationSummaryState();

		if (!relationId && !fallbackCategoryName) {
			loadingCategory.value = false;
			categoryLoadError.value =
				"This subcategory does not have a parent category assigned yet.";
			return;
		}

		loadingCategory.value = true;
		try {
			let categoryData: Record<string, unknown> | null = null;

			if (relationId && problemsCategoryIdSpec.relationKey) {
				categoryData = (await fetchSingleRelationRecord(
					supabase,
					problemsCategoryIdSpec.relationKey,
					relationId,
				)) as Record<string, unknown> | null;
			}

			if (!categoryData && fallbackCategoryName) {
				const { data, error } = await supabase
					.from("problem_types")
					.select("*")
					.eq("type_name", fallbackCategoryName)
					.eq("is_active", true)
					.maybeSingle();

				if (error) throw error;
				categoryData = (data as Record<string, unknown> | null) || null;
			}

			if (!categoryData) {
				categoryLoadError.value =
					"We couldn't find an active parent category for this subcategory.";
				return;
			}

			viewingCategory.value = categoryData;
			void loadCategoryDetailSummary((categoryData as Record<string, unknown>)?.category_id);
		} catch (error) {
			console.error("Error fetching category:", error);
			categoryLoadError.value =
				"We couldn't load parent category details. Please try again.";
		} finally {
			loadingCategory.value = false;
		}
	};

	const closeCategorySheet = () => {
		showCategorySheet.value = false;
		setTimeout(() => {
			viewingCategory.value = null;
			showCategoryTechnicalDetails.value = false;
			loadingCategory.value = false;
			categoryLoadError.value = "";
			problemsCategoryDetailContext.value = createRelationSummaryState();
		}, 300);
	};

	const loadLinkedRecords = async () => {
		if (!linkedRecordsRetryKey.value || !linkedRecordsRetryId.value) return;

		const cached = getCachedSections(
			linkedRecordsRetryKey.value,
			linkedRecordsRetryId.value,
		);
		if (cached) {
			linkedRecordsSections.value = cached;
			linkedRecordsLoading.value = false;
			linkedRecordsError.value = "";
			return;
		}

		linkedRecordsLoading.value = true;
		linkedRecordsError.value = "";

		try {
			const sections = await fetchListRelationRecords(
				supabase,
				linkedRecordsRetryKey.value as any,
				linkedRecordsRetryId.value,
			);
			linkedRecordsSections.value = sections;
			setCachedSections(
				linkedRecordsRetryKey.value,
				linkedRecordsRetryId.value,
				sections,
			);
		} catch (error) {
			console.error("Error fetching linked records:", error);
			linkedRecordsSections.value = [];
			linkedRecordsError.value =
				"We couldn't load linked records. Please try again.";
		} finally {
			linkedRecordsLoading.value = false;
		}
	};

	const openLinkedRecords = async (payload: LinkedListRequestPayload) => {
		const relationSpec = getRelationSpec(payload.scopeKey, payload.idField);
		const relationId = normalizeRelationId(payload.idValue);

		linkedRecordsTitle.value = payload.title;
		linkedRecordsDescription.value = payload.description;
		linkedRecordsSections.value = [];
		linkedRecordsError.value = "";
		showLinkedRecordsSheet.value = true;

		if (!relationSpec?.relationKey) {
			linkedRecordsRetryKey.value = "";
			linkedRecordsRetryId.value = "";
			linkedRecordsError.value = "No relation query is configured for this ID.";
			return;
		}

		if (!relationId) {
			linkedRecordsRetryKey.value = "";
			linkedRecordsRetryId.value = "";
			linkedRecordsError.value =
				"This record does not have a linked identifier yet.";
			return;
		}

		linkedRecordsRetryKey.value = relationSpec.relationKey;
		linkedRecordsRetryId.value = relationId;
		await loadLinkedRecords();
	};

	const closeLinkedRecordsSheet = () => {
		showLinkedRecordsSheet.value = false;
		setTimeout(() => {
			linkedRecordsTitle.value = "Linked Records";
			linkedRecordsDescription.value = "Records related to this identifier.";
			linkedRecordsSections.value = [];
			linkedRecordsLoading.value = false;
			linkedRecordsError.value = "";
			linkedRecordsRetryKey.value = "";
			linkedRecordsRetryId.value = "";
		}, 300);
	};

	const copyId = async ({ value, label }: CopyIdPayload) => {
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

	return {
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
	};
};
