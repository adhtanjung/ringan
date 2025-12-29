<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="max-w-7xl max-h-[90vh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-4 border-b">
				<DialogHeader>
					<DialogTitle
						>{{ isEditing ? "Edit" : "Create" }}
						{{ dataTypeLabel }}</DialogTitle
					>
					<DialogDescription>
						{{
							isEditing
								? "Update the information below"
								: "Fill in the details to create a new item"
						}}
					</DialogDescription>
				</DialogHeader>
			</div>

			<!-- Form -->
			<TooltipProvider>
				<form @submit.prevent="saveItem" class="flex-1 flex flex-col min-h-0">
					<ScrollArea class="flex-1 px-6">
						<div class="py-6">
							<!-- Dynamic Form Fields -->
							<div class="grid grid-cols-1 lg:grid-cols-2 gap-4 sm:gap-6">
								<div
									v-for="field in formFields"
									:key="field.key"
									:class="field.fullWidth ? 'lg:col-span-2' : ''"
								>
									<!-- Text Input -->
									<div v-if="field.type === 'text'">
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<div class="mt-1 flex flex-col sm:flex-row gap-2">
											<Input
												:id="field.key"
												v-model="formData[field.key]"
												:placeholder="field.placeholder"
												:required="field.required"
												:disabled="
													isEditing &&
													props.dataType === 'problems' &&
													field.key === 'sub_category_id'
												"
												class="flex-1"
											/>
											<!-- Validation button -->
											<Button
												v-if="needsValidation(field.key)"
												type="button"
												variant="outline"
												size="sm"
												@click="checkForDuplicate(field.key)"
												:disabled="
													!formData[field.key] ||
													validationStatus[field.key]?.loading ||
													(isEditing &&
														dataType === 'problems' &&
														field.key === 'sub_category_id')
												"
												class="whitespace-nowrap flex-shrink-0"
											>
												<Loader2
													v-if="validationStatus[field.key]?.loading"
													class="h-4 w-4 animate-spin mr-1"
												/>
												<CheckCircle
													v-else-if="
														validationStatus[field.key]?.checked &&
														!validationStatus[field.key]?.exists
													"
													class="h-4 w-4 text-green-600 mr-1"
												/>
												<XCircle
													v-else-if="
														validationStatus[field.key]?.checked &&
														validationStatus[field.key]?.exists
													"
													class="h-4 w-4 text-red-600 mr-1"
												/>
												<span class="hidden sm:inline">Check</span>
												<span class="sm:hidden">✓</span>
											</Button>
										</div>
										<!-- Validation status message -->
										<div v-if="needsValidation(field.key)" class="mt-1 text-xs">
											<span
												v-if="
													validationStatus[field.key]?.checked &&
													!validationStatus[field.key]?.exists
												"
												class="text-green-600"
												>✓ Available</span
											>
											<span
												v-else-if="
													validationStatus[field.key]?.checked &&
													validationStatus[field.key]?.exists
												"
												class="text-red-600"
												>✗ Already exists</span
											>
										</div>
									</div>

									<!-- Textarea -->
									<div v-else-if="field.type === 'textarea'">
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<Textarea
											:id="field.key"
											v-model="formData[field.key]"
											:rows="field.rows || 3"
											:placeholder="field.placeholder"
											:required="field.required"
											class="mt-1"
										/>
									</div>

									<!-- Select Dropdown -->
									<div
										v-else-if="
											field.type === 'select' &&
											!(
												props.dataType === 'assessments' &&
												field.key === 'sub_category_id'
											)
										"
									>
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<Select
											v-model="formData[field.key]"
											:required="field.required"
										>
											<SelectTrigger class="mt-1">
												<SelectValue
													:placeholder="field.placeholder || 'Select an option'"
												/>
											</SelectTrigger>
											<SelectContent>
												<template v-if="field.options && field.options.length">
													<SelectItem
														v-for="option in field.options"
														:key="option.value"
														:value="option.value"
													>
														{{ option.label }}
													</SelectItem>
												</template>
												<template
													v-else-if="
														field.key === 'sub_category_id' &&
														dropdownOptions.sub_category_id &&
														dropdownOptions.sub_category_id.length
													"
												>
													<SelectItem
														v-for="option in dropdownOptions.sub_category_id"
														:key="option.value"
														:value="option.value"
													>
														{{ option.label }}
													</SelectItem>
												</template>
											</SelectContent>
										</Select>
									</div>

									<!-- Async search select for assessments sub_category_id -->
									<div
										v-else-if="
											props.dataType === 'assessments' &&
											field.key === 'sub_category_id'
										"
									>
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<AsyncSearchSelect
											v-model="formData.sub_category_id"
											placeholder="Type to search subcategories by ID, category, or description"
											fetch-url="/dataset/problems/subcategories"
										/>
									</div>

									<!-- Multi-select Tags -->
									<div v-else-if="field.type === 'tags'">
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<div class="mt-1">
											<div class="flex flex-wrap gap-2 mb-2">
												<Badge
													v-for="(tag, index) in formData[field.key] || []"
													:key="index"
													variant="secondary"
													class="flex items-center gap-1"
												>
													{{ tag }}
													<button
														type="button"
														@click="removeTag(field.key, index as number)"
														class="ml-1 hover:bg-gray-200 rounded-full p-0.5"
													>
														<X class="h-3 w-3" />
													</button>
												</Badge>
											</div>
											<div class="flex gap-2">
												<Input
													v-model="newTag[field.key]"
													:placeholder="field.placeholder"
													class="flex-1"
													@keydown.enter.prevent="addTag(field.key)"
													@keydown.comma.prevent="addTag(field.key)"
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
									<div
										v-else-if="
											field.type === 'number' &&
											!(
												props.dataType === 'assessments' &&
												(field.key === 'scale_min' ||
													field.key === 'scale_max') &&
												!showScaleFields
											)
										"
									>
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<Input
											:id="field.key"
											v-model.number="formData[field.key]"
											type="number"
											:min="field.min"
											:max="field.max"
											:step="field.step"
											:placeholder="field.placeholder"
											:required="field.required"
											class="mt-1"
										/>
									</div>

									<!-- Scale fields for assessments -->
									<div
										v-else-if="
											props.dataType === 'assessments' &&
											(field.key === 'scale_min' ||
												field.key === 'scale_max') &&
											showScaleFields
										"
									>
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<Input
											:id="field.key"
											v-model.number="formData[field.key]"
											type="number"
											:min="field.min"
											:max="field.max"
											:step="field.step || 1"
											:placeholder="field.placeholder"
											:required="field.required"
											:readonly="true"
											class="mt-1 bg-gray-100"
										/>
										<p class="mt-1 text-xs text-gray-500">
											Fixed at {{ field.key === "scale_min" ? "1" : "4" }} for
											standardized 1-4 scale
										</p>
									</div>

									<!-- Scale label fields for assessments -->
									<div
										v-else-if="
											props.dataType === 'assessments' &&
											field.key.startsWith('scale_label_') &&
											showScaleFields
										"
									>
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<Input
											:id="field.key"
											v-model="formData[field.key]"
											type="text"
											:placeholder="getDefaultScaleLabel(field.key)"
											:required="field.required"
											class="mt-1"
										/>
										<p class="mt-1 text-xs text-gray-500">
											Label for scale value {{ field.key.split("_")[2] }}
										</p>
									</div>

									<!-- Options field removed - multiple choice not supported -->

									<!-- Switch -->
									<div v-else-if="field.type === 'switch'">
										<div class="flex items-center space-x-2">
											<Switch :id="field.key" v-model="formData[field.key]" />
											<FormFieldLabel
												:field-key="field.key"
												:label="field.label"
												:description="fieldDescriptions[field.key]"
											/>
										</div>
									</div>

									<!-- JSON Editor -->
									<div v-else-if="field.type === 'json'">
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<Textarea
											:id="field.key"
											v-model="jsonFields[field.key]"
											:rows="field.rows || 4"
											:placeholder="field.placeholder"
											class="mt-1 font-mono text-xs"
											@blur="validateJson(field.key)"
										/>
										<p
											v-if="jsonErrors[field.key]"
											class="mt-1 text-sm text-red-600"
										>
											{{ jsonErrors[field.key] }}
										</p>
									</div>

									<!-- Select with Create -->
									<div v-else-if="field.type === 'select-with-create'">
										<FormFieldLabel
											:field-key="field.key"
											:label="field.label"
											:required="field.required"
											:description="fieldDescriptions[field.key]"
										/>
										<div class="mt-1 flex gap-2">
											<Select v-model="formData[field.key]" class="flex-1">
												<SelectTrigger>
													<SelectValue :placeholder="'Select ' + field.label" />
												</SelectTrigger>
												<SelectContent>
													<SelectItem
														v-for="option in dropdownOptions[field.key]"
														:key="String(option[field.valueKey || 'value'])"
														:value="String(option[field.valueKey || 'value'])"
													>
														{{ option[field.labelKey || "label"] }}
													</SelectItem>
												</SelectContent>
											</Select>
											<Button
												type="button"
												variant="outline"
												size="sm"
												@click="
													openQuickCreate(field.createType || '', field.key)
												"
												class="flex-shrink-0"
											>
												<Plus class="h-4 w-4" />
											</Button>
										</div>
									</div>
								</div>
							</div>

							<!-- Validation Errors -->
							<Alert
								v-if="validationErrors.length > 0"
								variant="destructive"
								class="mt-6"
							>
								<AlertCircle class="h-4 w-4" />
								<AlertTitle>Validation Errors</AlertTitle>
								<AlertDescription>
									<ul class="list-disc pl-5 space-y-1">
										<li v-for="error in validationErrors" :key="error">
											{{ error }}
										</li>
									</ul>
								</AlertDescription>
							</Alert>

							<!-- Validation Requirement Message -->
							<Alert
								v-if="!isValidationComplete && dataType === 'problem_types'"
								variant="destructive"
								class="mt-6"
							>
								<AlertCircle class="h-4 w-4" />
								<AlertTitle>Validation Required</AlertTitle>
								<AlertDescription>
									Please check for duplicate type name before saving.
								</AlertDescription>
							</Alert>
						</div>
					</ScrollArea>

					<!-- Action Buttons -->
					<div class="px-6 py-4 border-t bg-background">
						<DialogFooter class="sm:justify-end gap-2">
							<Button
								type="button"
								variant="outline"
								@click="closeModal"
								:disabled="isSaving"
							>
								Cancel
							</Button>
							<Button
								type="submit"
								:disabled="
									isSaving ||
									validationErrors.length > 0 ||
									!isValidationComplete
								"
							>
								<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
								{{ isSaving ? "Saving..." : isEditing ? "Update" : "Create" }}
							</Button>
						</DialogFooter>
					</div>
				</form>
			</TooltipProvider>

			<!-- Quick Create Modal -->
			<QuickCreateModal
				:is-open="showQuickCreate"
				:type="quickCreateType || 'problem_type'"
				@close="closeQuickCreate"
				@created="handleQuickCreateSuccess"
			/>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { ref, computed, watch, reactive, nextTick } from "vue";
import {
	X,
	AlertCircle,
	Loader2,
	CheckCircle,
	XCircle,
	Plus,
} from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";
import { useToast } from "@/components/ui/toast/use-toast";

// shadcn-vue components
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Badge } from "@/components/ui/badge";
import { TooltipProvider } from "@/components/ui/tooltip";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Separator } from "@/components/ui/separator";
import QuickCreateModal from "@/components/admin/QuickCreateModal.vue";
import AsyncSearchSelect from "@/components/admin/AsyncSearchSelect.vue";
import FormFieldLabel from "@/components/admin/FormFieldLabel.vue";
import { columnConfigs } from "@/composables/useDatasetManagement";
import { getFormSchema } from "@/config/formSchemas";

// Migrated types
const USE_SUPABASE_FOR = [
	"problem_types",
	"problems",
	"assessments",
	"suggestions",
	"feedback_prompts",
	"next_actions",
	"training_examples",
];

// Supabase client
const { supabase } = useSupabase();

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
});

// Emits
const emit = defineEmits(["close", "save"]);

// Reactive data
const formData = reactive<Record<string, any>>({});
const jsonFields = reactive<Record<string, any>>({});
const jsonErrors = reactive<Record<string, any>>({});
const newTag = reactive<Record<string, any>>({});
const isSaving = ref(false);

// Validation state
const validationStatus = reactive<Record<string, any>>({
	type_name: { checked: false, exists: false, loading: false },
	category_id: { checked: false, exists: false, loading: false },
	sub_category_id: { checked: false, exists: false, loading: false },
	question_id: { checked: false, exists: false, loading: false },
});

// Dropdown options and quick create state
const dropdownOptions = reactive<Record<string, any>>({
	category: [] as any[],
	sub_category_id: [] as any[],
});
const showQuickCreate = ref(false);
const quickCreateType = ref<string | null>(null);
const quickCreateFieldKey = ref<string | null>(null);

// Computed properties
const isEditing = computed(() => !!props.item);
const validationErrors = ref<string[]>([]);

const fieldDescriptions = computed(() => {
	const config = (columnConfigs as any)[props.dataType] || [];
	const descMap: Record<string, any> = {};
	config.forEach((col: any) => {
		descMap[col.key] = col.description;
	});
	return descMap;
});

const isValidationComplete = computed(() => {
	// For problem_types, check if type_name validation is complete and passed
	if (props.dataType === "problem_types") {
		if (!formData.type_name) return false; // No type name entered
		if (!validationStatus.type_name.checked) return false; // Not validated yet
		if (validationStatus.type_name.exists) return false; // Duplicate exists
		return true; // Validation complete and passed
	}

	// For other data types, no validation required
	return true;
});

// Response type helpers (assessments)
const selectedResponseType = computed(() => formData.response_type);
const showScaleFields = computed(
	() =>
		props.dataType === "assessments" && selectedResponseType.value === "scale"
);

const dataTypeLabel = computed(() => {
	const labels: Record<string, string> = {
		problems: "Problem Category",
		assessments: "Assessment Question",
		suggestions: "Therapeutic Suggestion",
		feedback_prompts: "Feedback Prompt",
		next_actions: "Next Action",
		training_examples: "Fine-tuning Example",
		problem_types: "Problem Type",
	};
	return labels[props.dataType] || "Item";
});

const formFields = computed(() => {
	return getFormSchema(props.dataType);
});

// Helper to check if field needs validation
const needsValidation = (fieldKey: string): boolean => {
	return (
		(props.dataType === "problem_types" &&
			(fieldKey === "type_name" || fieldKey === "category_id")) ||
		(props.dataType === "problems" && fieldKey === "sub_category_id") ||
		(props.dataType === "assessments" && fieldKey === "question_id")
	);
};

// Methods
const closeModal = () => {
	if (!isSaving.value) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	[formData, jsonFields, jsonErrors, newTag].forEach((obj) =>
		Object.keys(obj).forEach((k) => delete obj[k])
	);
	validationErrors.value = [];
	isSaving.value = false;
	// Reset validation status
	["type_name", "category_id", "sub_category_id", "question_id"].forEach(
		(k) => {
			validationStatus[k] = { checked: false, exists: false, loading: false };
		}
	);
};

const initializeForm = async () => {
	console.log("[DEBUG] initializeForm called");
	console.log("[DEBUG] props.item:", props.item);
	console.log("[DEBUG] props.isOpen:", props.isOpen);

	resetForm();

	// Fetch dropdown options for select-with-create fields
	formFields.value.forEach((field) => {
		if (field.type === "select-with-create" && field.fetchEndpoint) {
			fetchDropdownOptions(field.fetchEndpoint as string, field.key);
		}
		if (
			props.dataType === "assessments" &&
			field.key === "sub_category_id" &&
			field.type === "select"
		) {
			fetchDropdownOptions(
				"/dataset/problems/subcategories",
				"sub_category_id"
			);
		}
	});

	if (props.item) {
		console.log("[DEBUG] Edit mode - populating form with:", props.item);
		// Edit mode - populate with existing data
		Object.assign(formData, structuredClone(props.item));
		console.log("[DEBUG] formData after assign:", JSON.stringify(formData));

		// Handle JSON fields
		formFields.value.forEach((field) => {
			if (field.type === "json" && props.item[field.key]) {
				jsonFields[field.key] = JSON.stringify(props.item[field.key], null, 2);
			}
		});

		// Handle scale_labels for assessments
		if (props.dataType === "assessments" && props.item.scale_labels) {
			formData.scale_label_1 = props.item.scale_labels["1"] || "Not at all";
			formData.scale_label_2 = props.item.scale_labels["2"] || "A little";
			formData.scale_label_3 = props.item.scale_labels["3"] || "Quite a bit";
			formData.scale_label_4 = props.item.scale_labels["4"] || "Very much";
		}
	} else {
		console.log("[DEBUG] Create mode - setting defaults");
		// Create mode - set defaults
		formFields.value.forEach((field) => {
			if (field.type === "switch") {
				formData[field.key] = true;
			} else if (field.type === "tags") {
				formData[field.key] = [];
			} else if (field.type === "json") {
				jsonFields[field.key] = "";
			}
		});

		// Set is_active to true by default for new items
		formData.is_active = true;

		// Set default scale labels for assessments
		if (props.dataType === "assessments") {
			formData.scale_label_1 = "Not at all";
			formData.scale_label_2 = "A little";
			formData.scale_label_3 = "Quite a bit";
			formData.scale_label_4 = "Very much";
		}
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
	if (formData[fieldKey] && Array.isArray(formData[fieldKey])) {
		(formData[fieldKey] as any[]).splice(index, 1);
	}
};

const checkForDuplicate = async (fieldKey: string) => {
	validationStatus[fieldKey].loading = true;
	const { toast } = useToast();

	const showResult = (exists: boolean, fieldLabel: string) => {
		toast({
			title: exists ? "Duplicate Found" : "Validation Passed",
			description: `${fieldLabel} ${
				exists ? "already exists" : "is available"
			}`,
			variant: exists ? "destructive" : "default",
		});
	};

	try {
		const value = formData[fieldKey];
		if (!value) {
			validationStatus[fieldKey].loading = false;
			return;
		}

		if (USE_SUPABASE_FOR.includes(props.dataType)) {
			let query = supabase
				.from(props.dataType)
				.select("id", { count: "exact" })
				.eq(fieldKey, value);
			if (props.item?.id) query = query.neq("id", props.item.id);
			const { count, error } = await query;
			if (error) throw error;
			validationStatus[fieldKey].checked = true;
			validationStatus[fieldKey].exists = (count || 0) > 0;
			showResult(
				validationStatus[fieldKey].exists,
				fieldKey === "type_name" ? "Type name" : fieldKey
			);
			return;
		}

		// Legacy API check - build URL based on field
		const config = useRuntimeConfig();
		const base =
			config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";
		const urlMap: Record<string, string> = {
			type_name: `/dataset/validate/problem_types/${encodeURIComponent(value)}`,
			question_id: `/dataset/validate/assessments/question_id/${encodeURIComponent(
				value
			)}`,
			category_id: `/dataset/validate/problem_types/category_id/${encodeURIComponent(
				value
			)}`,
			sub_category_id: `/dataset/validate/problems/sub_category_id/${encodeURIComponent(
				value
			)}`,
		};
		let url = base + (urlMap[fieldKey] || "");
		if (props.item?.id) url += `?exclude_id=${props.item.id}`;

		const response = (await $fetch(url)) as any;
		validationStatus[fieldKey].checked = true;
		validationStatus[fieldKey].exists = response.data.exists;
		showResult(
			response.data.exists,
			fieldKey === "type_name" ? "Type name" : fieldKey
		);
	} catch (error) {
		console.error("Validation error:", error);
		toast({
			title: "Validation Error",
			description: "Failed to check for duplicates. Please try again.",
			variant: "destructive",
		});
	} finally {
		validationStatus[fieldKey].loading = false;
	}
};

const fetchDropdownOptions = async (endpoint: string, key: string) => {
	try {
		// If endpoint resembles a migrated type, use Supabase
		const migratedTable = USE_SUPABASE_FOR.find((t) => endpoint.includes(t));
		if (migratedTable) {
			const { data, error } = await supabase
				.from(migratedTable)
				.select("*")
				.order(migratedTable === "problem_types" ? "type_name" : "created_at", {
					ascending: true,
				});

			if (error) throw error;
			dropdownOptions[key] = data || [];
			return;
		}

		const config = useRuntimeConfig();
		const adminApiUrl =
			config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";
		const url = `${adminApiUrl}${endpoint}`;

		const response = (await $fetch(url)) as any;
		dropdownOptions[key] = response.data?.items || [];
	} catch (error) {
		console.error(`Error fetching ${key} options:`, error);
		dropdownOptions[key] = [];
	}
};

const openQuickCreate = (type: string, fieldKey: string) => {
	quickCreateType.value = type;
	quickCreateFieldKey.value = fieldKey;
	showQuickCreate.value = true;
};

const closeQuickCreate = () => {
	showQuickCreate.value = false;
	quickCreateType.value = null;
	quickCreateFieldKey.value = null;
};

const handleQuickCreateSuccess = async (newItem: any) => {
	// Refresh the dropdown options
	const field = formFields.value.find(
		(f) => f.key === quickCreateFieldKey.value
	);
	if (field && field.fetchEndpoint) {
		await fetchDropdownOptions(field.fetchEndpoint as string, field.key);

		// Auto-select the newly created item
		if (field.createType === "problem_type") {
			formData[field.key] = newItem.type_name;
		}
	}

	closeQuickCreate();
};

const validateForm = () => {
	const errors: string[] = [];

	// ID format validations
	const idFormats: Record<string, { pattern: RegExp; format: string }> = {
		suggestion_id: {
			pattern: /^S_[A-Z]{2,4}_\d{3,4}$/,
			format: "S_DOMAIN_### (e.g., S_STR_001)",
		},
		prompt_id: {
			pattern: /^P_[A-Z]{2,4}_\d{3,4}$/,
			format: "P_DOMAIN_### (e.g., P_STR_001)",
		},
		action_id: {
			pattern: /^A_\d{3,4}$/,
			format: "A_### or A_#### (e.g., A_001)",
		},
		example_id: {
			pattern: /^E_\d{3,4}$/,
			format: "E_### or E_#### (e.g., E_001)",
		},
	};

	formFields.value.forEach((field) => {
		if (field.required && !formData[field.key]) {
			errors.push(`${field.label} is required`);
		}
		if (field.type === "json" && jsonErrors[field.key]) {
			errors.push(`${field.label}: ${jsonErrors[field.key]}`);
		}

		// ID format validation
		const idFormat = idFormats[field.key];
		if (
			idFormat &&
			formData[field.key] &&
			!idFormat.pattern.test(formData[field.key])
		) {
			errors.push(`${field.label} must be in format: ${idFormat.format}`);
		}

		// Scale validation for assessments
		if (
			props.dataType === "assessments" &&
			field.key === "response_type" &&
			formData.response_type === "scale"
		) {
			if (formData.scale_min !== 1 || formData.scale_max !== 4)
				errors.push("Scale questions must use 1-4 range");
			[
				"scale_label_1",
				"scale_label_2",
				"scale_label_3",
				"scale_label_4",
			].forEach((labelKey) => {
				if (!formData[labelKey] || formData[labelKey].trim() === "") {
					errors.push(
						`${labelKey.replace("_", " ")} is required for scale questions`
					);
				}
			});
		}

		// Duplicate validation using needsValidation helper
		if (needsValidation(field.key)) {
			const status = validationStatus[field.key];
			const skipCheck = field.key === "sub_category_id" && isEditing.value;
			if (!skipCheck) {
				if (!status?.checked) {
					errors.push(
						`Please check for duplicate ${field.label} before saving`
					);
				} else if (status?.exists) {
					errors.push(
						`${field.label} already exists. Please choose a different one.`
					);
				}
			}
		}
	});

	validationErrors.value = errors;
	return errors.length === 0;
};

const saveItem = async () => {
	if (!validateForm()) {
		return;
	}

	isSaving.value = true;

	try {
		// Process JSON fields
		formFields.value.forEach((field) => {
			if (field.type === "json" && jsonFields[field.key]) {
				validateJson(field.key);
			}
		});

		// For assessments: boolean defaults
		if (
			props.dataType === "assessments" &&
			formData.response_type === "boolean"
		) {
			if (!Array.isArray(formData.options) || formData.options.length === 0) {
				formData.options = ["Yes", "No"];
			}
		}

		// For assessments: scale processing
		if (
			props.dataType === "assessments" &&
			formData.response_type === "scale"
		) {
			// Set fixed scale values
			formData.scale_min = 1;
			formData.scale_max = 4;

			// Construct scale_labels object from individual fields
			formData.scale_labels = {
				"1": formData.scale_label_1 || "Not at all",
				"2": formData.scale_label_2 || "A little",
				"3": formData.scale_label_3 || "Quite a bit",
				"4": formData.scale_label_4 || "Very much",
			};

			// Remove individual label fields from submission
			delete formData.scale_label_1;
			delete formData.scale_label_2;
			delete formData.scale_label_3;
			delete formData.scale_label_4;
		} else if (props.dataType === "assessments") {
			// For non-scale questions, remove scale fields
			delete formData.scale_min;
			delete formData.scale_max;
			delete formData.scale_labels;
			delete formData.scale_label_1;
			delete formData.scale_label_2;
			delete formData.scale_label_3;
			delete formData.scale_label_4;
		}

		// Emit save event
		emit("save", { ...formData });

		// Close modal after successful save
		closeModal();
	} catch (error) {
		console.error("Save error:", error);
		validationErrors.value = [
			"An error occurred while saving. Please try again.",
		];
	} finally {
		isSaving.value = false;
	}
};

// Watchers
watch(
	() => props.isOpen,
	async (newValue) => {
		if (newValue) {
			// Use nextTick to ensure props.item is fully available
			await nextTick();
			initializeForm();
		}
	}
);

watch(
	() => props.item,
	() => {
		if (props.isOpen) {
			initializeForm();
		}
	},
	{ deep: true }
);

// Clear unrelated fields when response_type changes
watch(
	() => formData.response_type,
	() => {
		if (props.dataType !== "assessments") return;
		if (formData.response_type !== "scale") {
			delete formData.scale_min;
			delete formData.scale_max;
		}
	}
);

// Watch for changes in type_name to reset validation
watch(
	() => formData.type_name,
	() => {
		if (props.dataType === "problem_types") {
			validationStatus.type_name.checked = false;
			validationStatus.type_name.exists = false;
		}
	}
);

watch(
	() => formData.question_id,
	() => {
		if (props.dataType === "assessments") {
			validationStatus.question_id.checked = false;
			validationStatus.question_id.exists = false;
		}
	}
);

watch(
	() => formData.category_id,
	() => {
		if (props.dataType === "problem_types") {
			validationStatus.category_id.checked = false;
			validationStatus.category_id.exists = false;
		}
	}
);

watch(
	() => formData.sub_category_id,
	() => {
		if (props.dataType === "problems") {
			validationStatus.sub_category_id.checked = false;
			validationStatus.sub_category_id.exists = false;
		}
	}
);

// Helper function to get default scale labels
const getDefaultScaleLabel = (fieldKey: string) => {
	const defaults: Record<string, string> = {
		scale_label_1: "Not at all",
		scale_label_2: "A little",
		scale_label_3: "Quite a bit",
		scale_label_4: "Very much",
	};
	return defaults[fieldKey] || "";
};
</script>
