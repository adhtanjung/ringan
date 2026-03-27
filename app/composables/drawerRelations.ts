import type { SupabaseClient } from "@supabase/supabase-js";
import type { RelationSummaryPayload } from "@/composables/drawers/types";

export type RelationMode = "none" | "single" | "list";

export type RelationQueryKey =
	| "problemTypeByCategoryId"
	| "problemBySubCategoryId"
	| "assessmentsAndSuggestionsBySubCategoryId"
	| "problemsByCategoryId"
	| "feedbackPromptsByActionId";

export interface RelationSpec {
	idField: string;
	label: string;
	meaning: string;
	mode: RelationMode;
	actionLabel?: string;
	relationKey?: RelationQueryKey;
}

export interface LinkedRecordItem {
	key: string;
	businessId: string;
	businessIdLabel: string;
	title: string;
	badges?: string[];
	subtitle?: string;
}

export interface LinkedRecordSection {
	key: string;
	title: string;
	description?: string;
	emptyMessage?: string;
	items: LinkedRecordItem[];
}

const DEFAULT_SPEC: RelationSpec = {
	idField: "id",
	label: "ID",
	meaning: "Internal identifier for this record.",
	mode: "none",
};

export const drawerRelationSpecs: Record<string, Record<string, RelationSpec>> = {
	problems_detail: {
		category_id: {
			idField: "category_id",
			label: "Parent Category ID",
			meaning:
				"Points to the parent category in problem_types that this subcategory belongs to.",
			mode: "single",
			actionLabel: "Open parent category details",
			relationKey: "problemTypeByCategoryId",
		},
		sub_category_id: {
			idField: "sub_category_id",
			label: "Subcategory ID",
			meaning:
				"Primary subcategory identifier used by assessments and suggestions to link to this record.",
			mode: "list",
			actionLabel: "Show linked assessments and suggestions",
			relationKey: "assessmentsAndSuggestionsBySubCategoryId",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this subcategory.",
			mode: "none",
		},
	},
	problems_category_detail: {
		category_id: {
			idField: "category_id",
			label: "Category ID",
			meaning:
				"Primary category identifier used by subcategories in the problems table.",
			mode: "list",
			actionLabel: "Show linked subcategories",
			relationKey: "problemsByCategoryId",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this category.",
			mode: "none",
		},
	},
	problem_types_detail: {
		category_id: {
			idField: "category_id",
			label: "Category ID",
			meaning:
				"Primary category identifier used by subcategories in the problems table.",
			mode: "list",
			actionLabel: "Show linked subcategories",
			relationKey: "problemsByCategoryId",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this category.",
			mode: "none",
		},
	},
	assessments_detail: {
		question_id: {
			idField: "question_id",
			label: "Question ID",
			meaning:
				"Business identifier used by the assessment engine to reference this question.",
			mode: "none",
		},
		sub_category_id: {
			idField: "sub_category_id",
			label: "Subcategory ID",
			meaning:
				"Links this question to a problem record in the problems table.",
			mode: "single",
			actionLabel: "Open linked problem details",
			relationKey: "problemBySubCategoryId",
		},
		batch_id: {
			idField: "batch_id",
			label: "Batch ID",
			meaning:
				"Groups questions that were imported or updated together for operational tracking.",
			mode: "none",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this assessment record.",
			mode: "none",
		},
	},
	assessments_problem_detail: {
		sub_category_id: {
			idField: "sub_category_id",
			label: "Subcategory ID",
			meaning:
				"Primary subcategory identifier shared by linked assessment and suggestion records.",
			mode: "list",
			actionLabel: "Show linked assessments and suggestions",
			relationKey: "assessmentsAndSuggestionsBySubCategoryId",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this problem record.",
			mode: "none",
		},
	},
	suggestions_detail: {
		suggestion_id: {
			idField: "suggestion_id",
			label: "Suggestion ID",
			meaning:
				"Business identifier used by the guidance engine to reference this suggestion.",
			mode: "none",
		},
		sub_category_id: {
			idField: "sub_category_id",
			label: "Subcategory ID",
			meaning:
				"Links this suggestion to a problem record in the problems table.",
			mode: "single",
			actionLabel: "Open linked problem details",
			relationKey: "problemBySubCategoryId",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this suggestion record.",
			mode: "none",
		},
	},
	next_actions_detail: {
		action_id: {
			idField: "action_id",
			label: "Action ID",
			meaning:
				"Business identifier referenced by feedback prompts through next_action_id.",
			mode: "list",
			actionLabel: "Show linked feedback prompts",
			relationKey: "feedbackPromptsByActionId",
		},
		id: {
			idField: "id",
			label: "Record ID",
			meaning: "Internal database row identifier for this action record.",
			mode: "none",
		},
	},
};

export const getRelationSpec = (
	scopeKey: string,
	idField: string,
): RelationSpec => {
	return drawerRelationSpecs[scopeKey]?.[idField] || {
		...DEFAULT_SPEC,
		idField,
		label: idField,
	};
};

export const normalizeRelationId = (value: unknown): string => {
	if (value === null || value === undefined) return "";
	if (typeof value === "string") return value.trim();
	return String(value).trim();
};

type RelationSingleQuery = (
	supabase: SupabaseClient<any, any, any>,
	relationId: string,
) => Promise<Record<string, any> | null>;

type RelationListQuery = (
	supabase: SupabaseClient<any, any, any>,
	relationId: string,
) => Promise<LinkedRecordSection[]>;

const singleRelationQueryHandlers: Partial<Record<RelationQueryKey, RelationSingleQuery>> = {
	problemTypeByCategoryId: async (supabase, relationId) => {
		const { data, error } = await supabase
			.from("problem_types")
			.select("*")
			.eq("category_id", relationId)
			.eq("is_active", true)
			.maybeSingle();

		if (error) throw error;
		return data || null;
	},
	problemBySubCategoryId: async (supabase, relationId) => {
		const { data, error } = await supabase
			.from("problems")
			.select("*")
			.eq("sub_category_id", relationId)
			.eq("is_active", true)
			.maybeSingle();

		if (error) throw error;
		return data || null;
	},
};

const listRelationQueryHandlers: Partial<Record<RelationQueryKey, RelationListQuery>> = {
	assessmentsAndSuggestionsBySubCategoryId: async (supabase, relationId) => {
		const [
			{ data: assessmentData, error: assessmentError },
			{ data: suggestionData, error: suggestionError },
		] = await Promise.all([
			supabase
				.from("assessments")
				.select("id, question_id, question_text, response_type")
				.eq("sub_category_id", relationId)
				.eq("is_active", true)
				.order("created_at", { ascending: false }),
			supabase
				.from("suggestions")
				.select("id, suggestion_id, suggestion_text, cluster")
				.eq("sub_category_id", relationId)
				.eq("is_active", true)
				.order("created_at", { ascending: false }),
		]);

		if (assessmentError) throw assessmentError;
		if (suggestionError) throw suggestionError;

		const assessments: LinkedRecordSection = {
			key: "assessments",
			title: "Assessment Questions",
			description: "Questions linked to this subcategory ID.",
			emptyMessage: "No active assessment questions are linked to this subcategory.",
			items: (assessmentData || []).map((row) => ({
				key: `assessment-${row.id}`,
				businessId: row.question_id || "-",
				businessIdLabel: "Question ID",
				title: row.question_text || "Untitled question",
				badges: [row.response_type === "scale" ? "Scale (1-4)" : "Free Text"],
			})),
		};

		const suggestions: LinkedRecordSection = {
			key: "suggestions",
			title: "Suggestions",
			description: "Guidance records linked to this subcategory ID.",
			emptyMessage: "No active suggestions are linked to this subcategory.",
			items: (suggestionData || []).map((row) => ({
				key: `suggestion-${row.id}`,
				businessId: row.suggestion_id || "-",
				businessIdLabel: "Suggestion ID",
				title: row.suggestion_text || "Untitled suggestion",
				badges: row.cluster ? [`Cluster: ${row.cluster}`] : [],
			})),
		};

		return [assessments, suggestions];
	},
	problemsByCategoryId: async (supabase, relationId) => {
		const { data, error } = await supabase
			.from("problems")
			.select("id, sub_category_id, problem_name, severity_level")
			.eq("category_id", relationId)
			.eq("is_active", true)
			.order("problem_name", { ascending: true });

		if (error) throw error;

		return [
			{
				key: "problems",
				title: "Subcategories",
				description: "Subcategories linked to this category ID.",
				emptyMessage: "No active subcategories are linked to this category.",
				items: (data || []).map((row) => ({
					key: `problem-${row.id}`,
					businessId: row.sub_category_id || "-",
					businessIdLabel: "Subcategory ID",
					title: row.problem_name || "Untitled subcategory",
					badges: row.severity_level ? [`Level ${row.severity_level}`] : [],
				})),
			},
		];
	},
	feedbackPromptsByActionId: async (supabase, relationId) => {
		const { data, error } = await supabase
			.from("feedback_prompts")
			.select("id, prompt_id, prompt_text, stage")
			.eq("next_action_id", relationId)
			.eq("is_active", true)
			.order("created_at", { ascending: false });

		if (error) throw error;

		return [
			{
				key: "feedback-prompts",
				title: "Feedback Prompts",
				description: "Prompts that reference this action ID as their next step.",
				emptyMessage: "No active feedback prompts are linked to this action ID.",
				items: (data || []).map((row) => ({
					key: `prompt-${row.id}`,
					businessId: row.prompt_id || "-",
					businessIdLabel: "Prompt ID",
					title: row.prompt_text || "Untitled prompt",
					badges: row.stage ? [`Stage: ${row.stage}`] : [],
				})),
			},
		];
	},
};

export const fetchSingleRelationRecord = async (
	supabase: SupabaseClient<any, any, any>,
	relationKey: RelationQueryKey,
	relationId: string,
) => {
	const handler = singleRelationQueryHandlers[relationKey];
	if (!handler) {
		throw new Error(`No single relation query handler registered for "${relationKey}".`);
	}

	return handler(supabase, relationId);
};

export const fetchListRelationRecords = async (
	supabase: SupabaseClient<any, any, any>,
	relationKey: RelationQueryKey,
	relationId: string,
) => {
	const handler = listRelationQueryHandlers[relationKey];
	if (!handler) {
		throw new Error(`No list relation query handler registered for "${relationKey}".`);
	}

	return handler(supabase, relationId);
};

export const buildSingleRelationSummary = (
	relationKey: RelationQueryKey,
	idLabel: string,
	relationId: string,
	record: Record<string, any>,
): RelationSummaryPayload => {
	if (relationKey === "problemBySubCategoryId") {
		const categoryValue =
			record.category ||
			record.category_name ||
			(record.category_id ? `Category ID ${record.category_id}` : "");
		const badges: string[] = [];
		if (record.category_id) {
			badges.push(`Category ID: ${record.category_id}`);
		}
		if (record.severity_level) {
			badges.push(`Level ${record.severity_level}`);
		}

		return {
			title: record.problem_name || "Linked subcategory",
			subtitle: categoryValue
				? `Category: ${categoryValue}`
				: "Category is not available for this linked subcategory.",
			badges,
			idLabel,
			idValue: relationId,
		};
	}

	if (relationKey === "problemTypeByCategoryId") {
		return {
			title: record.type_name || "Linked category",
			subtitle: "Parent category linked by category ID.",
			badges: [],
			idLabel,
			idValue: relationId,
		};
	}

	return {
		title:
			record.name || record.title || record.label || "Linked record",
		subtitle: "Record linked by identifier.",
		badges: [],
		idLabel,
		idValue: relationId,
	};
};

export const buildListRelationSummary = (
	relationKey: RelationQueryKey,
	idLabel: string,
	relationId: string,
	sections: LinkedRecordSection[],
): RelationSummaryPayload => {
	const total = sections.reduce((sum, section) => sum + section.items.length, 0);
	const nonEmptySections = sections
		.filter((section) => section.items.length > 0)
		.map((section) => `${section.title}: ${section.items.length}`);

	if (relationKey === "assessmentsAndSuggestionsBySubCategoryId") {
		return {
			title:
				total > 0
					? `${total} linked assessments and suggestions`
					: "No linked assessments or suggestions",
			subtitle:
				nonEmptySections.length > 0
					? nonEmptySections.join(" • ")
					: "No active records reference this subcategory ID.",
			badges: nonEmptySections,
			idLabel,
			idValue: relationId,
		};
	}

	if (relationKey === "problemsByCategoryId") {
		const firstSubcategory = sections[0]?.items[0]?.title;
		return {
			title:
				total > 0
					? `${total} linked subcategories`
					: "No linked subcategories",
			subtitle:
				firstSubcategory && total > 0
					? `First linked subcategory: ${firstSubcategory}`
					: "No active subcategories reference this category ID.",
			badges:
				total > 0
					? [`Subcategories: ${total}`]
					: [],
			idLabel,
			idValue: relationId,
		};
	}

	if (relationKey === "feedbackPromptsByActionId") {
		return {
			title:
				total > 0
					? `${total} linked feedback prompts`
					: "No linked feedback prompts",
			subtitle:
				total > 0
					? "Feedback prompts referencing this action ID."
					: "No active feedback prompts reference this action ID.",
			badges:
				total > 0
					? [`Prompts: ${total}`]
					: [],
			idLabel,
			idValue: relationId,
		};
	}

	return {
		title: total > 0 ? `${total} linked records` : "No linked records",
		subtitle:
			nonEmptySections.length > 0
				? nonEmptySections.join(" • ")
				: "No active records found for this identifier.",
		badges: nonEmptySections,
		idLabel,
		idValue: relationId,
	};
};
