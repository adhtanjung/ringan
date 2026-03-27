import { ref } from "vue";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useToast } from "@/components/ui/toast/use-toast";
import {
	buildSingleRelationSummary,
	fetchSingleRelationRecord,
	getRelationSpec,
	normalizeRelationId,
} from "@/composables/drawerRelations";
import {
	createRelationSummaryState,
	type CopyIdPayload,
	type RelationActionPayload,
} from "@/composables/drawers/types";

interface UseSuggestionsDrawersOptions {
	supabase: SupabaseClient<any, any, any>;
	onEdit: (item: Record<string, unknown>) => void;
}

export const useSuggestionsDrawers = ({
	supabase,
	onEdit,
}: UseSuggestionsDrawersOptions) => {
	const { toast } = useToast();

	const showDetailSheet = ref(false);
	const viewingItem = ref<Record<string, unknown> | null>(null);
	const showTechnicalDetails = ref(false);

	const showSubCategorySheet = ref(false);
	const viewingSubCategory = ref<Record<string, unknown> | null>(null);
	const loadingSubCategory = ref(false);
	const subCategoryLoadError = ref("");

	const suggestionSubCategoryContext = ref(createRelationSummaryState());

	const suggestionIdSpec = getRelationSpec("suggestions_detail", "suggestion_id");
	const suggestionSubCategoryIdSpec = getRelationSpec(
		"suggestions_detail",
		"sub_category_id",
	);
	const suggestionRecordIdSpec = getRelationSpec("suggestions_detail", "id");
	const suggestionLinkedProblemSubCategorySpec = getRelationSpec(
		"assessments_problem_detail",
		"sub_category_id",
	);
	const suggestionLinkedProblemRecordIdSpec = getRelationSpec(
		"assessments_problem_detail",
		"id",
	);

	const loadSuggestionSubCategorySummary = async (
		rawId: unknown = viewingItem.value?.sub_category_id,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = suggestionSubCategoryIdSpec.relationKey;
		const idLabel = suggestionSubCategoryIdSpec.label;

		if (!relationId) {
			suggestionSubCategoryContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			suggestionSubCategoryContext.value = {
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

		suggestionSubCategoryContext.value = {
			status: "loading",
			loading: true,
			error: "",
			data: {
				title: "Resolving linked record",
				subtitle: "",
				badges: [],
				idLabel,
				idValue: relationId,
			},
		};

		try {
			const record = await fetchSingleRelationRecord(
				supabase,
				relationKey,
				relationId,
			);
			if (!record) {
				suggestionSubCategoryContext.value = {
					status: "not_found",
					loading: false,
					error: "",
					data: {
						title: "Linked subcategory not found",
						subtitle: "No active problem matches this subcategory ID.",
						badges: [],
						idLabel,
						idValue: relationId,
					},
				};
				return;
			}

			suggestionSubCategoryContext.value = {
				status: "resolved",
				loading: false,
				error: "",
				data: buildSingleRelationSummary(relationKey, idLabel, relationId, record),
			};
		} catch (error) {
			console.error("Error prefetching suggestion subcategory context:", error);
			suggestionSubCategoryContext.value = {
				status: "error",
				loading: false,
				error: "We couldn't resolve the linked subcategory. Please try again.",
				data: {
					title: "Linked relation unavailable",
					subtitle: "Unable to load linked record right now.",
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
		void loadSuggestionSubCategorySummary(item?.sub_category_id);
	};

	const closeDetailSheet = () => {
		showDetailSheet.value = false;
		setTimeout(() => {
			viewingItem.value = null;
			showTechnicalDetails.value = false;
			suggestionSubCategoryContext.value = createRelationSummaryState();
		}, 300);
	};

	const openEditFromDetail = () => {
		if (!viewingItem.value) return;
		closeDetailSheet();
		onEdit(viewingItem.value);
	};

	const openSubCategoryDetail = async (
		payload: RelationActionPayload = {
			scopeKey: "suggestions_detail",
			idField: "sub_category_id",
			idValue: viewingItem.value?.sub_category_id as string | null | undefined,
		},
	) => {
		const linkedSubCategoryId = normalizeRelationId(payload.idValue);

		subCategoryLoadError.value = "";
		viewingSubCategory.value = null;
		showSubCategorySheet.value = true;

		if (!linkedSubCategoryId) {
			loadingSubCategory.value = false;
			subCategoryLoadError.value =
				"This suggestion is not linked to a subcategory yet.";
			return;
		}

		if (!suggestionSubCategoryIdSpec?.relationKey) {
			loadingSubCategory.value = false;
			subCategoryLoadError.value = "No relation query is configured for this ID.";
			return;
		}

		loadingSubCategory.value = true;
		try {
			const linkedProblem = await fetchSingleRelationRecord(
				supabase,
				suggestionSubCategoryIdSpec.relationKey,
				linkedSubCategoryId,
			);

			if (!linkedProblem) {
				subCategoryLoadError.value =
					"We couldn't find an active problem record for this subcategory.";
				return;
			}

			viewingSubCategory.value = linkedProblem as Record<string, unknown>;
			subCategoryLoadError.value = "";
		} catch (error) {
			console.error("Error fetching linked problem:", error);
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
			subCategoryLoadError.value = "";
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
		showSubCategorySheet,
		viewingSubCategory,
		loadingSubCategory,
		subCategoryLoadError,
		suggestionIdSpec,
		suggestionSubCategoryIdSpec,
		suggestionRecordIdSpec,
		suggestionLinkedProblemSubCategorySpec,
		suggestionLinkedProblemRecordIdSpec,
		suggestionSubCategoryContext,
		openDetailView,
		closeDetailSheet,
		openEditFromDetail,
		openSubCategoryDetail,
		closeSubCategorySheet,
		loadSuggestionSubCategorySummary,
		copyId,
	};
};
