import { ref } from "vue";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useToast } from "@/components/ui/toast/use-toast";
import {
	buildListRelationSummary,
	fetchListRelationRecords,
	getRelationSpec,
	normalizeRelationId,
} from "@/composables/drawerRelations";
import type { LinkedRecordSection } from "@/composables/drawerRelations";
import {
	createRelationSummaryState,
	type CopyIdPayload,
	type LinkedListRequestPayload,
} from "@/composables/drawers/types";

interface UseProblemTypesDrawersOptions {
	supabase: SupabaseClient<any, any, any>;
	onEdit: (item: Record<string, unknown>) => void;
}

export const useProblemTypesDrawers = ({
	supabase,
	onEdit,
}: UseProblemTypesDrawersOptions) => {
	const { toast } = useToast();

	const showDetailSheet = ref(false);
	const viewingItem = ref<Record<string, unknown> | null>(null);
	const showTechnicalDetails = ref(false);

	const showLinkedRecordsSheet = ref(false);
	const linkedRecordsTitle = ref("Linked Records");
	const linkedRecordsDescription = ref("Records related to this identifier.");
	const linkedRecordsSections = ref<LinkedRecordSection[]>([]);
	const linkedRecordsLoading = ref(false);
	const linkedRecordsError = ref("");
	const linkedRecordsRetryKey = ref("");
	const linkedRecordsRetryId = ref("");

	const problemTypesCategoryContext = ref(createRelationSummaryState());
	const listPrefetchCache = ref<Record<string, LinkedRecordSection[]>>({});

	const problemTypesCategoryIdSpec = getRelationSpec(
		"problem_types_detail",
		"category_id",
	);
	const problemTypesRecordIdSpec = getRelationSpec("problem_types_detail", "id");

	const buildCacheKey = (relationKey: string, relationId: string) =>
		`${relationKey}:${relationId}`;

	const getCachedSections = (relationKey: string, relationId: string) => {
		return listPrefetchCache.value[buildCacheKey(relationKey, relationId)];
	};

	const setCachedSections = (
		relationKey: string,
		relationId: string,
		sections: LinkedRecordSection[],
	) => {
		listPrefetchCache.value[buildCacheKey(relationKey, relationId)] = sections;
	};

	const loadCategoryContextSummary = async (
		rawId: unknown = viewingItem.value?.category_id,
	) => {
		const relationId = normalizeRelationId(rawId);
		const relationKey = problemTypesCategoryIdSpec.relationKey;
		const idLabel = problemTypesCategoryIdSpec.label;

		if (!relationId) {
			problemTypesCategoryContext.value = {
				status: "missing",
				loading: false,
				error: "",
				data: null,
			};
			return;
		}

		if (!relationKey) {
			problemTypesCategoryContext.value = {
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
			problemTypesCategoryContext.value = {
				status: cached.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, cached),
			};
			return;
		}

		problemTypesCategoryContext.value = {
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
			problemTypesCategoryContext.value = {
				status: sections.some((section) => section.items.length > 0)
					? "resolved"
					: "not_found",
				loading: false,
				error: "",
				data: buildListRelationSummary(relationKey, idLabel, relationId, sections),
			};
		} catch (error) {
			console.error("Error prefetching category relation context:", error);
			problemTypesCategoryContext.value = {
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
		void loadCategoryContextSummary(item?.category_id);
	};

	const closeDetailSheet = () => {
		showDetailSheet.value = false;
		setTimeout(() => {
			viewingItem.value = null;
			showTechnicalDetails.value = false;
			problemTypesCategoryContext.value = createRelationSummaryState();
		}, 300);
	};

	const openEditFromDetail = () => {
		if (!viewingItem.value) return;
		closeDetailSheet();
		onEdit(viewingItem.value);
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
		showLinkedRecordsSheet,
		linkedRecordsTitle,
		linkedRecordsDescription,
		linkedRecordsSections,
		linkedRecordsLoading,
		linkedRecordsError,
		problemTypesCategoryIdSpec,
		problemTypesRecordIdSpec,
		problemTypesCategoryContext,
		openDetailView,
		closeDetailSheet,
		openEditFromDetail,
		openLinkedRecords,
		closeLinkedRecordsSheet,
		loadLinkedRecords,
		loadCategoryContextSummary,
		copyId,
	};
};
