<template>
	<Dialog :open="isOpen" @update:open="$emit('close')">
		<DialogContent
			class="w-[95vw] sm:max-w-2xl max-h-[92dvh] flex flex-col p-0 overflow-hidden"
		>
			<DialogHeader class="px-6 py-4 border-b">
				<DialogTitle class="text-xl font-semibold">
					{{ isEditing ? "Edit" : "Create" }} {{ dataTypeLabel }}
				</DialogTitle>
			</DialogHeader>

			<div class="flex-1 overflow-y-auto min-h-0 p-6 pt-2">
				<form
					id="dataset-edit-form"
					@submit.prevent="saveItem"
					class="space-y-6"
				>
					<!-- Dynamic Form Fields -->
					<div v-for="field in formFields" :key="field.key" class="space-y-1.5">
						<!-- Text Input -->
						<div v-if="field.type === 'text'" class="grid gap-2">
							<Label :for="field.key" class="text-sm font-medium">
								{{ field.label }}
								<span v-if="field.required" class="text-destructive">*</span>
							</Label>
							<Input
								:id="field.key"
								v-model="formData[field.key]"
								type="text"
								:placeholder="field.placeholder"
								:required="field.required"
								class="w-full"
							/>
						</div>

						<!-- Textarea -->
						<div v-else-if="field.type === 'textarea'" class="grid gap-2">
							<Label :for="field.key" class="text-sm font-medium">
								{{ field.label }}
								<span v-if="field.required" class="text-destructive">*</span>
							</Label>
							<Textarea
								:id="field.key"
								v-model="formData[field.key]"
								:rows="field.rows || 3"
								:placeholder="field.placeholder"
								:required="field.required"
								class="w-full min-h-[100px] resize-y"
							/>
						</div>

						<!-- Select Dropdown -->
						<div v-else-if="field.type === 'select'" class="grid gap-2">
							<Label :for="field.key" class="text-sm font-medium">
								{{ field.label }}
								<span v-if="field.required" class="text-destructive">*</span>
							</Label>
							<Select
								:model-value="formData[field.key]"
								@update:model-value="(val: any) => (formData[field.key] = val)"
								:required="field.required"
							>
								<SelectTrigger class="w-full">
									<SelectValue
										:placeholder="field.placeholder || 'Select option'"
									/>
								</SelectTrigger>
								<SelectContent>
									<SelectItem
										v-for="option in field.options"
										:key="option.value"
										:value="option.value"
									>
										{{ option.label }}
									</SelectItem>
								</SelectContent>
							</Select>
						</div>

						<!-- Multi-select Tags -->
						<div v-else-if="field.type === 'tags'" class="grid gap-2">
							<Label :for="field.key" class="text-sm font-medium">
								{{ field.label }}
								<span v-if="field.required" class="text-destructive">*</span>
							</Label>
							<div class="space-y-2">
								<div
									class="flex flex-wrap gap-1.5 min-h-[32px] p-1 border rounded-md bg-muted/30"
								>
									<Badge
										v-for="(tag, index) in formData[field.key] || []"
										:key="index"
										variant="secondary"
										class="gap-1 pl-2 pr-1 h-6"
									>
										{{ tag }}
										<Button
											type="button"
											variant="ghost"
											size="icon"
											class="h-4 w-4 rounded-full hover:bg-muted-foreground/20"
											@click="removeTag(field.key, Number(index))"
										>
											<X class="h-3 w-3" />
										</Button>
									</Badge>
									<span
										v-if="!formData[field.key]?.length"
										class="text-xs text-muted-foreground px-2 py-1"
									>
										No tags added
									</span>
								</div>
								<div class="flex gap-2">
									<Input
										v-model="newTag[field.key]"
										type="text"
										:placeholder="field.placeholder"
										class="flex-1"
										@keydown.enter.prevent="addTag(field.key)"
									/>
									<Button
										type="button"
										variant="outline"
										@click="addTag(field.key)"
									>
										Add
									</Button>
								</div>
							</div>
						</div>

						<!-- Number Input -->
						<div v-else-if="field.type === 'number'" class="grid gap-2">
							<Label :for="field.key" class="text-sm font-medium">
								{{ field.label }}
								<span v-if="field.required" class="text-destructive">*</span>
							</Label>
							<Input
								:id="field.key"
								v-model.number="formData[field.key]"
								type="number"
								:min="field.min"
								:max="field.max"
								:step="field.step"
								:placeholder="field.placeholder"
								:required="field.required"
								class="w-full"
							/>
						</div>

						<!-- Checkbox -->
						<div
							v-else-if="field.type === 'checkbox'"
							class="flex items-center space-x-2 py-2"
						>
							<Checkbox
								:id="field.key"
								:checked="formData[field.key]"
								@update:checked="(val: boolean) => (formData[field.key] = val)"
							/>
							<Label
								:for="field.key"
								class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
							>
								{{ field.label }}
							</Label>
						</div>

						<!-- JSON Editor -->
						<div v-else-if="field.type === 'json'" class="grid gap-2">
							<Label :for="field.key" class="text-sm font-medium">
								{{ field.label }}
								<span v-if="field.required" class="text-destructive">*</span>
							</Label>
							<div class="relative">
								<Textarea
									:id="field.key"
									v-model="jsonFields[field.key]"
									:rows="field.rows || 4"
									:placeholder="field.placeholder"
									class="w-full font-mono text-xs bg-muted/20 pr-10"
									@blur="validateJson(field.key)"
								/>
								<div
									v-if="jsonErrors[field.key]"
									class="absolute top-2 right-2"
								>
									<AlertCircle class="h-4 w-4 text-destructive" />
								</div>
							</div>
							<p
								v-if="jsonErrors[field.key]"
								class="text-xs text-destructive font-medium"
							>
								{{ jsonErrors[field.key] }}
							</p>
						</div>
					</div>

					<!-- Validation Errors -->
					<div
						v-if="hasTouched && validationErrors.length > 0"
						class="bg-destructive/10 border border-destructive/20 rounded-lg p-4"
					>
						<div class="flex gap-3">
							<AlertCircle class="h-5 w-5 text-destructive" />
							<div class="grid gap-1">
								<h3 class="text-sm font-semibold text-destructive">
									Validation Errors
								</h3>
								<ul
									class="text-xs text-destructive/90 list-disc pl-4 space-y-0.5"
								>
									<li v-for="error in validationErrors" :key="error">
										{{ error }}
									</li>
								</ul>
							</div>
						</div>
					</div>
				</form>
			</div>

			<DialogFooter class="px-6 py-4 border-t bg-muted/10">
				<div
					class="flex flex-col-reverse sm:flex-row items-center justify-end gap-3 w-full"
				>
					<Button
						variant="outline"
						type="button"
						class="w-full sm:w-auto"
						@click="closeModal"
						:disabled="isSaving"
					>
						Cancel
					</Button>
					<Button
						type="submit"
						form="dataset-edit-form"
						class="w-full sm:w-auto sm:min-w-[100px]"
						:disabled="isSaving || (hasTouched && validationErrors.length > 0)"
					>
						<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
						{{ isSaving ? "Saving..." : isEditing ? "Update" : "Create" }}
					</Button>
				</div>
			</DialogFooter>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { ref, computed, watch, reactive } from "vue";
import { cn } from "@/lib/utils";
import { X, Loader2, AlertCircle } from "lucide-vue-next";
import {
	Dialog,
	DialogContent,
	DialogHeader,
	DialogTitle,
	DialogFooter,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Checkbox } from "@/components/ui/checkbox";
import { Badge } from "@/components/ui/badge";

// Props
const props = defineProps({
	isOpen: {
		type: Boolean,
		default: false,
	},
	dataType: {
		type: String,
		required: true,
	},
	item: {
		type: Object,
		default: null,
	},
	class: {
		type: String,
		default: "",
	},
});

// Emits
const emit = defineEmits(["close", "save"]);

// Reactive data
const formData = reactive<Record<string, any>>({});
const jsonFields = reactive<Record<string, string>>({});
const jsonErrors = reactive<Record<string, string>>({});
const newTag = reactive<Record<string, string>>({});
const isSaving = ref(false);
const hasTouched = ref(false);

// Computed properties
const isEditing = computed(() => !!props.item);

const validationErrors = computed(() => {
	const errors: string[] = [];

	formFields.value.forEach((field) => {
		const value = formData[field.key];
		const isValueMissing =
			value === undefined ||
			value === null ||
			value === "" ||
			(Array.isArray(value) && value.length === 0);

		if (field.required && isValueMissing) {
			errors.push(`${field.label} is required`);
		}

		if (field.type === "json" && jsonErrors[field.key]) {
			errors.push(`${field.label}: ${jsonErrors[field.key]}`);
		}
	});

	return errors;
});

const dataTypeLabel = computed(() => {
	const labels: Record<string, string> = {
		problems: "Categories",
		assessments: "Assessment Question",
		suggestions: "Therapeutic Suggestion",
		feedback: "Feedback Prompt",
		next_actions: "Next Action",
		training: "Fine-tuning Example",
	};
	return labels[props.dataType] || "Item";
});

const formFields = computed(() => {
	const fieldConfigs: Record<string, any[]> = {
		problems: [
			{
				key: "id",
				label: "ID",
				type: "text",
				required: true,
				placeholder: "e.g., PROB_001",
			},
			{
				key: "category",
				label: "Category",
				type: "text",
				required: true,
				placeholder: "e.g., Anxiety",
			},
			{
				key: "subcategory",
				label: "Subcategory",
				type: "text",
				placeholder: "e.g., Social Anxiety",
			},
			{
				key: "description",
				label: "Description",
				type: "textarea",
				required: true,
				rows: 3,
			},
			{
				key: "severity_levels",
				label: "Severity Levels",
				type: "tags",
				placeholder: "Add severity level",
			},
			{
				key: "related_domains",
				label: "Related Domains",
				type: "tags",
				placeholder: "Add domain",
			},
			{
				key: "keywords",
				label: "Keywords",
				type: "tags",
				placeholder: "Add keyword",
			},
		],
		assessments: [
			{
				key: "id",
				label: "ID",
				type: "text",
				required: true,
				placeholder: "e.g., ASSESS_001",
			},
			{
				key: "question_text",
				label: "Question Text",
				type: "textarea",
				required: true,
				rows: 2,
			},
			{
				key: "response_type",
				label: "Response Type",
				type: "select",
				required: true,
				options: [
					{ value: "scale", label: "Scale (1-10)" },
					{ value: "text", label: "Text Input" },
				],
			},
			{ key: "category", label: "Category", type: "text", required: true },
			{ key: "domain", label: "Domain", type: "text", required: true },
			{
				key: "weight",
				label: "Weight",
				type: "number",
				min: 0,
				max: 10,
				step: 0.1,
			},
			{ key: "is_required", label: "Required", type: "checkbox" },
		],
		suggestions: [
			{
				key: "id",
				label: "ID",
				type: "text",
				required: true,
				placeholder: "e.g., SUGG_001",
			},
			{ key: "title", label: "Title", type: "text", required: true },
			{
				key: "content",
				label: "Content",
				type: "textarea",
				required: true,
				rows: 4,
			},
			{ key: "category", label: "Category", type: "text", required: true },
			{
				key: "target_problems",
				label: "Target Subcategories",
				type: "tags",
				placeholder: "Add subcategory ID",
			},
			{
				key: "severity_range",
				label: "Severity Range",
				type: "json",
				placeholder: '{"min": 1, "max": 10}',
			},
			{
				key: "techniques",
				label: "Techniques",
				type: "tags",
				placeholder: "Add technique",
			},
			{
				key: "duration_minutes",
				label: "Duration (minutes)",
				type: "number",
				min: 1,
			},
			{
				key: "difficulty_level",
				label: "Difficulty Level",
				type: "select",
				options: [
					{ value: "beginner", label: "Beginner" },
					{ value: "intermediate", label: "Intermediate" },
					{ value: "advanced", label: "Advanced" },
				],
			},
		],
		feedback: [
			{
				key: "id",
				label: "ID",
				type: "text",
				required: true,
				placeholder: "e.g., FEED_001",
			},
			{
				key: "prompt_text",
				label: "Prompt Text",
				type: "textarea",
				required: true,
				rows: 3,
			},
			{
				key: "stage",
				label: "Stage",
				type: "select",
				required: true,
				options: [
					{ value: "initial", label: "Initial Assessment" },
					{ value: "progress", label: "Progress Check" },
					{ value: "completion", label: "Completion" },
					{ value: "follow_up", label: "Follow-up" },
				],
			},
			{
				key: "trigger_conditions",
				label: "Trigger Conditions",
				type: "json",
				placeholder: "JSON object with conditions",
			},
			{
				key: "expected_responses",
				label: "Expected Responses",
				type: "tags",
				placeholder: "Add expected response",
			},
			{
				key: "follow_up_actions",
				label: "Follow-up Actions",
				type: "tags",
				placeholder: "Add action",
			},
		],
		next_actions: [
			{
				key: "id",
				label: "ID",
				type: "text",
				required: true,
				placeholder: "e.g., ACTION_001",
			},
			{
				key: "action_type",
				label: "Action Type",
				type: "select",
				required: true,
				options: [
					{ value: "suggestion", label: "Provide Suggestion" },
					{ value: "assessment", label: "Additional Assessment" },
					{ value: "referral", label: "Professional Referral" },
					{ value: "resource", label: "Resource Recommendation" },
					{ value: "follow_up", label: "Schedule Follow-up" },
				],
			},
			{ key: "title", label: "Title", type: "text", required: true },
			{
				key: "description",
				label: "Description",
				type: "textarea",
				required: true,
				rows: 3,
			},
			{
				key: "trigger_conditions",
				label: "Trigger Conditions",
				type: "json",
				placeholder: "JSON object with conditions",
			},
			{ key: "priority", label: "Priority", type: "number", min: 1, max: 10 },
			{
				key: "estimated_duration",
				label: "Estimated Duration",
				type: "text",
				placeholder: "e.g., 15 minutes",
			},
			{
				key: "required_resources",
				label: "Required Resources",
				type: "tags",
				placeholder: "Add resource",
			},
		],
		training: [
			{
				key: "id",
				label: "ID",
				type: "text",
				required: true,
				placeholder: "e.g., TRAIN_001",
			},
			{
				key: "user_intent",
				label: "User Intent",
				type: "select",
				required: true,
				options: [
					{ value: "seeking_help", label: "Seeking Help" },
					{ value: "crisis_support", label: "Crisis Support" },
					{ value: "information_request", label: "Information Request" },
					{ value: "progress_update", label: "Progress Update" },
					{ value: "feedback", label: "Providing Feedback" },
				],
			},
			{
				key: "user_input",
				label: "User Input",
				type: "textarea",
				required: true,
				rows: 3,
			},
			{
				key: "expected_response",
				label: "Expected Response",
				type: "textarea",
				required: true,
				rows: 4,
			},
			{
				key: "context",
				label: "Context",
				type: "json",
				placeholder: "JSON object with context information",
			},
			{
				key: "difficulty_level",
				label: "Difficulty Level",
				type: "select",
				options: [
					{ value: "basic", label: "Basic" },
					{ value: "intermediate", label: "Intermediate" },
					{ value: "complex", label: "Complex" },
				],
			},
			{ key: "tags", label: "Tags", type: "tags", placeholder: "Add tag" },
		],
	};

	return fieldConfigs[props.dataType] || [];
});

// Methods
const closeModal = () => {
	if (!isSaving.value) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	Object.keys(formData).forEach((key) => {
		delete formData[key];
	});
	Object.keys(jsonFields).forEach((key) => {
		delete jsonFields[key];
	});
	Object.keys(jsonErrors).forEach((key) => {
		delete jsonErrors[key];
	});
	Object.keys(newTag).forEach((key) => {
		delete newTag[key];
	});
	hasTouched.value = false;
	isSaving.value = false;
};

const initializeForm = () => {
	resetForm();

	if (props.item) {
		// Edit mode - populate with existing data
		Object.assign(formData, { ...props.item });

		// Handle JSON fields
		formFields.value.forEach((field) => {
			if (field.type === "json" && props.item[field.key]) {
				jsonFields[field.key] = JSON.stringify(props.item[field.key], null, 2);
			}
		});
	} else {
		// Create mode - set defaults
		formFields.value.forEach((field) => {
			if (field.type === "checkbox") {
				formData[field.key] = true;
			} else if (field.type === "tags") {
				formData[field.key] = [];
			} else if (field.type === "json") {
				jsonFields[field.key] = "";
			}
		});
		// Set is_active to true by default for new items
		formData.is_active = true;
	}
};

const validateJson = (fieldKey: string) => {
	const value = jsonFields[fieldKey];
	if (!value) {
		delete jsonErrors[fieldKey];
		return;
	}

	try {
		const parsed = JSON.parse(value);
		formData[fieldKey] = parsed;
		delete jsonErrors[fieldKey];
	} catch (error) {
		jsonErrors[fieldKey] = "Invalid JSON format";
	}
};

const addTag = (fieldKey: string) => {
	const value = newTag[fieldKey]?.trim();
	if (value && !formData[fieldKey]?.includes(value)) {
		if (!formData[fieldKey]) {
			formData[fieldKey] = [];
		}
		formData[fieldKey].push(value);
		newTag[fieldKey] = "";
	}
};

const removeTag = (fieldKey: string, index: number) => {
	if (formData[fieldKey]) {
		formData[fieldKey].splice(index, 1);
	}
};

const saveItem = async () => {
	hasTouched.value = true;

	// Final sync/validation for JSON fields before save
	formFields.value.forEach((field) => {
		if (field.type === "json" && jsonFields[field.key]) {
			validateJson(field.key);
		}
	});

	if (validationErrors.value.length > 0) {
		return;
	}

	isSaving.value = true;

	try {
		// Emit save event
		emit("save", { ...formData });

		// Close modal after successful save
		setTimeout(() => {
			closeModal();
		}, 500);
	} catch (error) {
		console.error("Save error:", error);
	} finally {
		isSaving.value = false;
	}
};

// Watchers
watch(
	() => props.isOpen,
	(newValue) => {
		if (newValue) {
			initializeForm();
		}
	},
);

watch(
	() => props.item,
	() => {
		if (props.isOpen) {
			initializeForm();
		}
	},
);
</script>
