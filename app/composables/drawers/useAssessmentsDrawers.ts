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

interface UseAssessmentsDrawersOptions {
	supabase: SupabaseClient<any, any, any>;
	onEdit: (item: Record<string, unknown>) => void;
}

export const useAssessmentsDrawers = ({
	supabase,
	onEdit,
}: UseAssessmentsDrawersOptions) => {
	const { toast } = useToast();

	const showDetailSheet = ref(false);
	const viewingItem = ref<Record<string, unknown> | null>(null);
	const showTechnicalDetails = ref(false);

	const showSubCategorySheet = ref(false);
	const viewingSubCategory = ref<Record<string, unknown> | null>(null);
	const loadingSubCategory = ref(false);
	const showSubCategoryTechnicalDetails = ref(false);
	const subCategoryLoadError = ref("");

	const showLinkedRecordsSheet = ref(false);
	const linkedRecordsTitle = ref("Linked Records");
	const linkedRecordsDescription = ref("Records related to this identifier.");
	const linkedRecordsSections = ref<LinkedRecordSection[]>([]);
	const linkedRecordsLoading = ref(false);
	const linkedRecordsError = ref("");
	const linkedRecordsRetryKey = ref("");
	const linkedRecordsRetryId = ref("");

	const assessmentSubCategoryContext = ref(createRelationSummaryState());
	const assessmentProblemSubCategoryContext = ref(createRelationSummaryState());
	const listPrefetchCache = ref<Record<string, LinkedRecordSection[]>>({});

	const assessmentQuestionIdSpec = getRelationSpec("assessments_detail", "question_id");
	const assessmentSubCategoryIdSpec = getRelationSpec(
		"assessments_detail",
		"sub_category_id",
	);
	const assessmentBatchIdSpec = getRelationSpec("assessments_detail", "batch_id");
	const assessmentRecordIdSpec = getRelationSpec("assessments_detail", "id");
	const assessmentProblemSubCategoryIdSpec = getRelationSpec(
		"assessments_problem_detail",
		"sub_category_id",
	);
	const assessmentProblemRecordIdSpec = getRelationSpec(
		"assessments_problem_detail",
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

	const loadAssessmentSubCategorySummary = async (
		rawId: unknown = viewingItem.value?.sub_category_id,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = assessmentSubCategoryIdSpec.relationKey;
		const idLabel = assessmentSubCategoryIdSpec.label;

		if (!relationId) {
			assessmentSubCategoryContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			assessmentSubCategoryContext.value = {
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

		assessmentSubCategoryContext.value = {
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
				assessmentSubCategoryContext.value = {
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

			assessmentSubCategoryContext.value = {
				status: "resolved",
				loading: false,
				error: "",
				data: buildSingleRelationSummary(relationKey, idLabel, relationId, record),
			};
		} catch (error) {
			console.error("Error prefetching assessment subcategory context:", error);
			assessmentSubCategoryContext.value = {
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

	const loadAssessmentProblemSubCategorySummary = async (
		rawId: unknown = viewingSubCategory.value?.sub_category_id,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = assessmentProblemSubCategoryIdSpec.relationKey;
		const idLabel = assessmentProblemSubCategoryIdSpec.label;

		if (!relationId) {
			assessmentProblemSubCategoryContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			assessmentProblemSubCategoryContext.value = {
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
			assessmentProblemSubCategoryContext.value = {
				status: cached.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, cached),
			};
			return;
		}

		assessmentProblemSubCategoryContext.value = {
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
			assessmentProblemSubCategoryContext.value = {
				status: sections.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, sections),
			};
		} catch (error) {
			console.error(
				"Error prefetching assessment-problem relation context:",
				error,
			);
			assessmentProblemSubCategoryContext.value = {
				status: "error",
				loading: false,
				error: "We couldn't resolve linked assessments/suggestions. Please try again.",
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
		void loadAssessmentSubCategorySummary(item?.sub_category_id);
	};

	const closeDetailSheet = () => {
		showDetailSheet.value = false;
		setTimeout(() => {
			viewingItem.value = null;
			showTechnicalDetails.value = false;
			assessmentSubCategoryContext.value = createRelationSummaryState();
		}, 300);
	};

	const openEditFromDetail = () => {
		if (!viewingItem.value) return;
		closeDetailSheet();
		onEdit(viewingItem.value);
	};

	const openSubCategoryDetail = async (
		payload: RelationActionPayload = {
			scopeKey: "assessments_detail",
			idField: "sub_category_id",
			idValue: viewingItem.value?.sub_category_id as string | null | undefined,
		},
	) => {
		const linkedSubCategoryId = normalizeRelationId(payload.idValue);

		showSubCategoryTechnicalDetails.value = false;
		subCategoryLoadError.value = "";
		showSubCategorySheet.value = true;
		viewingSubCategory.value = null;
		assessmentProblemSubCategoryContext.value = createRelationSummaryState();

		if (!linkedSubCategoryId) {
			loadingSubCategory.value = false;
			subCategoryLoadError.value =
				"This assessment question is not linked to a subcategory yet.";
			return;
		}

		if (!assessmentSubCategoryIdSpec?.relationKey) {
			loadingSubCategory.value = false;
			subCategoryLoadError.value = "No relation query is configured for this ID.";
			return;
		}

		loadingSubCategory.value = true;
		try {
			const problemData = await fetchSingleRelationRecord(
				supabase,
				assessmentSubCategoryIdSpec.relationKey,
				linkedSubCategoryId,
			);

			if (!problemData) {
				subCategoryLoadError.value =
					"We couldn't find an active subcategory record for this question.";
				return;
			}

			viewingSubCategory.value = problemData as Record<string, unknown>;
			subCategoryLoadError.value = "";
			void loadAssessmentProblemSubCategorySummary(
				(problemData as Record<string, unknown>)?.sub_category_id,
			);
		} catch (error) {
			console.error("Error fetching problem:", error);
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
			assessmentProblemSubCategoryContext.value = createRelationSummaryState();
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
		showSubCategorySheet,
		viewingSubCategory,
		loadingSubCategory,
		showSubCategoryTechnicalDetails,
		subCategoryLoadError,
		showLinkedRecordsSheet,
		linkedRecordsTitle,
		linkedRecordsDescription,
		linkedRecordsSections,
		linkedRecordsLoading,
		linkedRecordsError,
		assessmentQuestionIdSpec,
		assessmentSubCategoryIdSpec,
		assessmentBatchIdSpec,
		assessmentRecordIdSpec,
		assessmentProblemSubCategoryIdSpec,
		assessmentProblemRecordIdSpec,
		assessmentSubCategoryContext,
		assessmentProblemSubCategoryContext,
		openDetailView,
		closeDetailSheet,
		openEditFromDetail,
		openSubCategoryDetail,
		closeSubCategorySheet,
		openLinkedRecords,
		closeLinkedRecordsSheet,
		loadLinkedRecords,
		loadAssessmentSubCategorySummary,
		loadAssessmentProblemSubCategorySummary,
		copyId,
	};
};
