<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="max-w-2xl max-h-[90vh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-4 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit" : "Create" }} Problem
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the information below"
								: "Fill in the details to create a new problem"
						}}
					</DialogDescription>
				</DialogHeader>
			</div>

			<!-- Form -->
			<TooltipProvider>
				<form @submit.prevent="saveItem" class="flex-1 flex flex-col min-h-0">
					<ScrollArea class="flex-1 px-6">
						<div class="py-6">
							<!-- Form Fields -->
							<div class="grid grid-cols-1 gap-4 sm:gap-6">
								<!-- Problem Name -->
								<div>
									<FormFieldLabel
										field-key="problem_name"
										label="Problem Name"
										:required="true"
										hint-title="Core Entity"
										description="The common name for this issue (e.g. 'Difficulty Falling Asleep'). Avoid clinical jargon if possible."
									/>
									<Input
										id="problem_name"
										v-model="formData.problem_name"
										placeholder="e.g., Work Stress"
										required
										class="mt-1"
									/>
								</div>

								<!-- Category (from Problem Types) -->
								<div>
									<FormFieldLabel
										field-key="category"
										label="Category"
										:required="true"
										hint-title="Higher Level Grouping"
										description="Select the main group this problem belongs to. This helps in high-level reporting."
									/>
									<select
										id="category"
										v-model="formData.category"
										@change="handleCategoryChange"
										required
										class="mt-1 block w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2"
									>
										<option value="">Select a category</option>
										<option
											v-for="type in problemTypes"
											:key="type.type_name"
											:value="type.type_name"
										>
											{{ type.type_name }}
										</option>
									</select>
									<p
										v-if="loadingProblemTypes"
										class="mt-1 text-xs text-muted-foreground"
									>
										Loading categories...
									</p>
								</div>

								<!-- Category ID (Auto-filled) -->
								<div>
									<FormFieldLabel
										field-key="category_id"
										label="Category ID"
										:required="true"
										description="Auto-filled from selected category"
									/>
									<Input
										id="category_id"
										v-model="formData.category_id"
										placeholder="Will be auto-filled"
										readonly
										class="mt-1 bg-muted cursor-not-allowed"
									/>
								</div>

								<!-- Subcategory ID (Auto-generated) -->
								<div>
									<FormFieldLabel
										field-key="sub_category_id"
										label="Subcategory ID"
										:required="true"
										:description="
											isEditing
												? 'Unique subcategory identifier'
												: 'Auto-generated from problem name'
										"
									/>
									<div class="mt-1 flex items-center gap-2">
										<Input
											id="sub_category_id"
											v-model="formData.sub_category_id"
											placeholder="Will be auto-generated"
											readonly
											class="flex-1 bg-muted cursor-not-allowed"
										/>
										<Loader2
											v-if="isGeneratingSubCategoryId"
											class="h-4 w-4 animate-spin text-muted-foreground"
										/>
										<CheckCircle
											v-else-if="formData.sub_category_id"
											class="h-4 w-4 text-green-600"
										/>
									</div>
								</div>

								<!-- Description -->
								<div>
									<FormFieldLabel
										field-key="description"
										label="Description"
										:required="true"
										hint-title="Internal Context"
										description="Describe the symptoms or context and how it affects the user. This is mainly for internal data science use."
									/>
									<Textarea
										id="description"
										v-model="formData.description"
										rows="3"
										placeholder="Detailed description of this problem"
										required
										class="mt-1"
									/>
								</div>

								<!-- Severity Level -->
								<div>
									<FormFieldLabel
										field-key="severity_level"
										label="Severity Level"
										hint-title="Clinical Weighting"
										description="1: Mild/Sub-clinical, 5: Severe/Critical. This affects prioritization logic."
									/>
									<Input
										id="severity_level"
										:model-value="formData.severity_level ?? undefined"
										@update:model-value="
											(val) =>
												(formData.severity_level =
													val === '' ? null : Number(val))
										"
										type="number"
										min="1"
										max="5"
										placeholder="1-5"
										class="mt-1"
									/>
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
								:disabled="isSaving || validationErrors.length > 0"
							>
								<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
								{{ isSaving ? "Saving..." : isEditing ? "Update" : "Create" }}
							</Button>
						</DialogFooter>
					</div>
				</form>
			</TooltipProvider>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { ref, computed, watch, reactive, nextTick, onMounted } from "vue";
import { AlertCircle, Loader2, CheckCircle } from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";
import { useToast } from "@/components/ui/toast/use-toast";
import { generateSubCategoryId } from "@/utils/subCategoryIdGenerator";

// shadcn-vue components
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Switch } from "@/components/ui/switch";
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
import FormFieldLabel from "@/components/admin/FormFieldLabel.vue";

// Types
interface Problem {
	id?: string;
	problem_name: string;
	category: string;
	category_id: string;
	sub_category_id: string;
	description: string;
	severity_level?: number | null;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

interface ProblemType {
	id: string;
	type_name: string;
	category_id: string;
	description: string;
	is_active: boolean;
}

// Props
const props = defineProps<{
	isOpen: boolean;
	item: Problem | null;
}>();

// Emits
const emit = defineEmits<{
	close: [];
	save: [data: Problem];
}>();

// Composables
const { supabase } = useSupabase();
const { toast } = useToast();

// Reactive data
const formData = reactive<Problem>({
	problem_name: "",
	category: "",
	category_id: "",
	sub_category_id: "",
	description: "",
	severity_level: null,
	is_active: true,
});

const isSaving = ref(false);
const validationErrors = ref<string[]>([]);
const problemTypes = ref<ProblemType[]>([]);
const loadingProblemTypes = ref(false);
const isGeneratingSubCategoryId = ref(false);

// Computed properties
const isEditing = computed(() => !!props.item);

// Methods
const closeModal = () => {
	if (!isSaving.value) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	formData.problem_name = "";
	formData.category = "";
	formData.category_id = "";
	formData.sub_category_id = "";
	formData.description = "";
	formData.severity_level = null;
	formData.is_active = true;
	validationErrors.value = [];
	isSaving.value = false;
	isGeneratingSubCategoryId.value = false;
};

const initializeForm = async () => {
	// Reset validation status and errors
	validationErrors.value = [];
	isSaving.value = false;
	isGeneratingSubCategoryId.value = false;

	if (props.item) {
		// Edit mode - populate with existing data
		formData.problem_name = props.item.problem_name || "";
		formData.category = props.item.category || "";
		formData.category_id = props.item.category_id || "";
		formData.sub_category_id = props.item.sub_category_id || "";
		formData.description = props.item.description || "";
		formData.severity_level = props.item.severity_level ?? null;
		formData.is_active = props.item.is_active ?? true;
	} else {
		// Create mode - set defaults
		formData.problem_name = "";
		formData.category = "";
		formData.category_id = "";
		formData.sub_category_id = "";
		formData.description = "";
		formData.severity_level = null;
		formData.is_active = true;
	}
};

const fetchProblemTypes = async () => {
	loadingProblemTypes.value = true;
	try {
		const { data, error } = await supabase
			.from("problem_types")
			.select("id, type_name, category_id, description, is_active")
			.eq("is_active", true)
			.order("type_name");

		if (error) throw error;

		problemTypes.value = data || [];
	} catch (error) {
		console.error("Error fetching problem types:", error);
		toast({
			title: "Fetch Error",
			description: "Failed to load problem types. Please try again.",
			variant: "destructive",
		});
	} finally {
		loadingProblemTypes.value = false;
	}
};

const handleCategoryChange = () => {
	// Auto-fill category_id when category is selected
	const selectedType = problemTypes.value.find(
		(type) => type.type_name === formData.category
	);

	if (selectedType) {
		formData.category_id = selectedType.category_id;
	} else {
		formData.category_id = "";
	}
};

const autoGenerateSubCategoryId = async () => {
	// Only auto-generate for new items, not when editing
	if (isEditing.value || !formData.problem_name) {
		return;
	}

	isGeneratingSubCategoryId.value = true;

	try {
		const subCategoryId = await generateSubCategoryId(
			supabase,
			formData.problem_name
		);
		formData.sub_category_id = subCategoryId;
	} catch (error) {
		console.error("Error generating subcategory ID:", error);
		toast({
			title: "Generation Error",
			description: "Failed to generate subcategory ID. Please try again.",
			variant: "destructive",
		});
		formData.sub_category_id = "";
	} finally {
		isGeneratingSubCategoryId.value = false;
	}
};

const validateForm = () => {
	const errors: string[] = [];

	if (!formData.problem_name) {
		errors.push("Problem Name is required");
	}
	if (!formData.category) {
		errors.push("Category is required");
	}
	if (!formData.category_id) {
		errors.push("Category ID is required");
	}
	if (!formData.sub_category_id) {
		errors.push("Subcategory ID is required");
	}
	if (!formData.description) {
		errors.push("Description is required");
	}

	if (
		formData.severity_level !== null &&
		formData.severity_level !== undefined
	) {
		if (formData.severity_level < 1 || formData.severity_level > 5) {
			errors.push("Severity Level must be between 1 and 5");
		}
	}

	validationErrors.value = errors;
	return errors.length === 0;
};

const saveItem = async () => {
	if (!validateForm()) {
		return;
	}

	isSaving.value = true;

	try {
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
			await nextTick();
			await fetchProblemTypes();
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

// Watch problem_name changes to auto-generate subcategory ID
watch(
	() => formData.problem_name,
	async () => {
		// Auto-generate subcategory ID for new items
		if (!isEditing.value && formData.problem_name) {
			await autoGenerateSubCategoryId();
		}
	}
);

// Lifecycle
onMounted(() => {
	fetchProblemTypes();
});
</script>
