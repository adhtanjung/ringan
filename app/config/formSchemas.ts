/**
 * Form Schema Configuration
 * Extracted from DatasetEditModalShadcn.vue for better maintainability
 */

export interface FormFieldOption {
	value: string;
	label: string;
}

export interface FormFieldConfig {
	key: string;
	label: string;
	type:
		| "text"
		| "textarea"
		| "select"
		| "select-with-create"
		| "number"
		| "switch"
		| "tags"
		| "json";
	required?: boolean;
	placeholder?: string;
	fullWidth?: boolean;
	rows?: number;
	min?: number;
	max?: number;
	step?: number;
	readonly?: boolean;
	options?: FormFieldOption[];
	fetchEndpoint?: string;
	createType?: string;
	valueKey?: string;
	labelKey?: string;
}

export const FORM_SCHEMAS: Record<string, FormFieldConfig[]> = {
	problems: [
		{
			key: "problem_name",
			label: "Problem Name",
			type: "text",
			required: true,
			placeholder: "e.g., Work Stress",
		},
		{
			key: "category",
			label: "Category",
			type: "select-with-create",
			required: true,
			fetchEndpoint: "/dataset/problem_types",
			createType: "problem_type",
			valueKey: "type_name",
			labelKey: "type_name",
		},
		{
			key: "description",
			label: "Description",
			type: "textarea",
			required: true,
			rows: 3,
			fullWidth: true,
		},
		{
			key: "severity_level",
			label: "Severity Level",
			type: "number",
			min: 1,
			max: 5,
			placeholder: "1-5",
		},
		{
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			required: true,
			placeholder: "e.g., STR_01_01, ANX_001_01",
		},
		{
			key: "category_id",
			label: "Category ID",
			type: "text",
			required: true,
			placeholder: "e.g., STR_01",
		},
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
	assessments: [
		{
			key: "question_id",
			label: "Question ID",
			type: "text",
			required: true,
			placeholder: "e.g., Q001, Q0001",
		},
		{
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "select",
			required: true,
			placeholder: "Select subcategory",
		},
		{
			key: "question_text",
			label: "Question Text",
			type: "textarea",
			required: true,
			rows: 2,
			fullWidth: true,
		},
		{
			key: "response_type",
			label: "Response Type",
			type: "select",
			required: true,
			options: [
				{ value: "scale", label: "Scale" },
				{ value: "text", label: "Text" },
			],
		},
		{
			key: "scale_min",
			label: "Scale Min",
			type: "number",
			min: 1,
			max: 4,
			readonly: true,
		},
		{
			key: "scale_max",
			label: "Scale Max",
			type: "number",
			min: 1,
			max: 4,
			readonly: true,
		},
		{
			key: "scale_label_1",
			label: "Scale Label 1",
			type: "text",
			placeholder: "Not at all",
		},
		{
			key: "scale_label_2",
			label: "Scale Label 2",
			type: "text",
			placeholder: "A little",
		},
		{
			key: "scale_label_3",
			label: "Scale Label 3",
			type: "text",
			placeholder: "Quite a bit",
		},
		{
			key: "scale_label_4",
			label: "Scale Label 4",
			type: "text",
			placeholder: "Very much",
		},
		{
			key: "options",
			label: "Options",
			type: "tags",
			placeholder: "Add option",
		},
		{
			key: "next_step",
			label: "Next Step",
			type: "text",
			placeholder: "Next step logic",
		},
		{
			key: "clusters",
			label: "Clusters",
			type: "text",
			placeholder: "Question clusters",
		},
		{
			key: "batch_id",
			label: "Batch ID",
			type: "text",
			placeholder: "e.g., BATCH_001",
		},
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
	suggestions: [
		{
			key: "suggestion_id",
			label: "Suggestion ID",
			type: "text",
			required: true,
			placeholder: "e.g., S_STR_001, S_ANX_001",
		},
		{
			key: "sub_category_id",
			label: "Subcategory ID",
			type: "text",
			required: true,
			placeholder: "e.g., STR_01_01, ANX_001_01",
		},
		{
			key: "cluster",
			label: "Cluster",
			type: "text",
			placeholder: "e.g., coping_strategies",
		},
		{
			key: "suggestion_text",
			label: "Suggestion Text",
			type: "textarea",
			required: true,
			rows: 4,
			fullWidth: true,
		},
		{
			key: "resource_link",
			label: "Resource Link",
			type: "text",
			placeholder: "https://example.com",
		},
		{
			key: "evidence_base",
			label: "Evidence Base",
			type: "text",
			placeholder: "e.g., CBT, ACT",
		},
		{
			key: "difficulty_level",
			label: "Difficulty Level",
			type: "number",
			min: 1,
			max: 3,
		},
		{
			key: "estimated_duration",
			label: "Estimated Duration",
			type: "text",
			placeholder: "e.g., 15 minutes",
		},
		{ key: "tags", label: "Tags", type: "tags", placeholder: "Add tag" },
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
	feedback_prompts: [
		{
			key: "prompt_id",
			label: "Prompt ID",
			type: "text",
			required: true,
			placeholder: "e.g., P_STR_001, P_ANX_001",
		},
		{
			key: "stage",
			label: "Stage",
			type: "select",
			required: true,
			options: [
				{ value: "post_suggestion", label: "Post Suggestion" },
				{ value: "ongoing", label: "Ongoing" },
				{ value: "followup", label: "Follow-up" },
			],
		},
		{
			key: "prompt_text",
			label: "Prompt Text",
			type: "textarea",
			required: true,
			rows: 3,
			fullWidth: true,
		},
		{
			key: "next_action_id",
			label: "Next Action ID",
			type: "text",
			required: true,
			placeholder: "e.g., ACTION_001",
		},
		{
			key: "context",
			label: "Context",
			type: "textarea",
			rows: 2,
			placeholder: "Additional context",
		},
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
	next_actions: [
		{
			key: "action_id",
			label: "Action ID",
			type: "text",
			required: true,
			placeholder: "e.g., A_001, A_0001",
		},
		{
			key: "action_type",
			label: "Action Type",
			type: "select",
			required: true,
			options: [
				{ value: "continue_same", label: "Continue Same" },
				{ value: "show_problem_menu", label: "Show Problem Menu" },
				{ value: "end_session", label: "End Session" },
				{ value: "escalate", label: "Escalate" },
				{ value: "schedule_followup", label: "Schedule Follow-up" },
			],
		},
		{
			key: "action_name",
			label: "Action Name",
			type: "text",
			required: true,
			placeholder: "e.g., Schedule Meeting",
		},
		{
			key: "description",
			label: "Description",
			type: "textarea",
			required: true,
			rows: 3,
			fullWidth: true,
		},
		{
			key: "parameters",
			label: "Parameters",
			type: "json",
			placeholder: '{"key": "value"}',
			rows: 3,
		},
		{
			key: "conditions",
			label: "Conditions",
			type: "json",
			placeholder: '{"condition": "value"}',
			rows: 3,
		},
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
	training_examples: [
		{
			key: "example_id",
			label: "Example ID",
			type: "text",
			required: true,
			placeholder: "e.g., E_001, E_0001",
		},
		{
			key: "problem",
			label: "Problem",
			type: "text",
			placeholder: "Problem description",
		},
		{
			key: "conversation_id",
			label: "Conversation ID",
			type: "text",
			placeholder: "e.g., CONV_001",
		},
		{
			key: "user_intent",
			label: "User Intent",
			type: "select",
			required: true,
			options: [
				{ value: "problem_identification", label: "Problem Identification" },
				{ value: "assessment_response", label: "Assessment Response" },
				{ value: "seeking_help", label: "Seeking Help" },
				{ value: "emotional_expression", label: "Emotional Expression" },
				{ value: "progress_update", label: "Progress Update" },
				{ value: "clarification", label: "Clarification" },
				{ value: "resistance", label: "Resistance" },
				{ value: "gratitude", label: "Gratitude" },
			],
		},
		{
			key: "prompt",
			label: "Prompt",
			type: "textarea",
			required: true,
			rows: 3,
			fullWidth: true,
		},
		{
			key: "completion",
			label: "Completion",
			type: "textarea",
			required: true,
			rows: 4,
			fullWidth: true,
		},
		{
			key: "context",
			label: "Context",
			type: "textarea",
			rows: 2,
			placeholder: "Additional context",
		},
		{
			key: "quality_score",
			label: "Quality Score",
			type: "number",
			min: 0,
			max: 1,
			step: 0.1,
		},
		{ key: "tags", label: "Tags", type: "tags", placeholder: "Add tag" },
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
	problem_types: [
		{
			key: "type_name",
			label: "Category Name",
			type: "text",
			required: true,
			placeholder: "e.g., Work Stress, Social Anxiety",
		},
		{
			key: "category_id",
			label: "Category ID",
			type: "text",
			required: true,
			placeholder: "e.g., STR_01, ANX_001",
		},
		{
			key: "description",
			label: "Description",
			type: "textarea",
			required: true,
			rows: 3,
			fullWidth: true,
			placeholder: "Detailed description of this problem type",
		},
		{
			key: "is_active",
			label: "Active",
			type: "switch",
		},
	],
};

/**
 * Get form schema for a specific data type
 */
export function getFormSchema(dataType: string): FormFieldConfig[] {
	return FORM_SCHEMAS[dataType] || [];
}
