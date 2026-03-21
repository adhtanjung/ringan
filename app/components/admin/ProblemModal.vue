<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[92vw] sm:max-w-xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-5 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit Subcategory" : "Create Subcategory" }}
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the subcategory name, parent category, and description."
								: "Name the subcategory, choose its parent category, and add a short description."
						}}
					</DialogDescription>
				</DialogHeader>
			</div>

			<form
				@submit.prevent="saveItem"
				class="flex-1 flex flex-col min-h-0 overflow-hidden"
			>
				<div class="flex-1 overflow-y-auto min-h-0 px-6">
					<div class="py-6 space-y-6">
						<div>
							<Label for="problem_name" class="text-sm font-medium text-foreground">
								Subcategory Name
								<span class="ml-1 text-destructive">*</span>
							</Label>
							<Input
								id="problem_name"
								v-model="formData.problem_name"
								placeholder="e.g., Work Stress"
								required
								class="mt-1"
								@blur="handleProblemNameBlur"
							/>
							<p
								v-if="problemNameError"
								class="mt-1 text-sm leading-6 text-destructive"
								aria-live="polite"
							>
								{{ problemNameError }}
							</p>
							<p v-else class="mt-1 text-sm leading-6 text-muted-foreground">
								{{ problemNameHelperText }}
							</p>
						</div>

						<div>
							<Label for="category" class="text-sm font-medium text-foreground">
								Parent Category
								<span class="ml-1 text-destructive">*</span>
							</Label>
							<Select
								:model-value="formData.category"
								@update:model-value="handleCategoryChange"
								:disabled="loadingProblemTypes || !!problemTypesLoadError"
							>
								<SelectTrigger id="category" class="mt-1 h-11 w-full">
									<SelectValue placeholder="Select a parent category" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem
										v-if="
											formData.category &&
											!problemTypes.some((type) => type.type_name === formData.category)
										"
										:value="formData.category"
									>
										{{ formData.category }}
									</SelectItem>
									<SelectItem
										v-for="type in problemTypes"
										:key="type.type_name"
										:value="type.type_name"
									>
										{{ type.type_name }}
									</SelectItem>
								</SelectContent>
							</Select>
							<p
								v-if="categoryError"
								class="mt-1 text-sm leading-6 text-destructive"
								aria-live="polite"
							>
								{{ categoryError }}
							</p>
							<p v-else class="mt-1 text-sm leading-6 text-muted-foreground">
								{{ categoryHelperText }}
							</p>
							<Button
								v-if="problemTypesLoadError"
								type="button"
								variant="ghost"
								class="mt-1 h-9 px-2 text-sm text-foreground"
								@click="fetchProblemTypes"
							>
								Try again
							</Button>
						</div>

						<div>
							<Label for="description" class="text-sm font-medium text-foreground">
								Description
								<span class="ml-1 text-destructive">*</span>
							</Label>
							<Textarea
								id="description"
								v-model="formData.description"
								rows="4"
								placeholder="Briefly describe what belongs in this subcategory."
								required
								class="mt-1"
								@blur="markTouched('description')"
							/>
							<p
								v-if="descriptionError"
								class="mt-1 text-sm leading-6 text-destructive"
								aria-live="polite"
							>
								{{ descriptionError }}
							</p>
							<p v-else class="mt-1 text-sm leading-6 text-muted-foreground">
								{{ descriptionHelperText }}
							</p>
						</div>
					</div>
				</div>

				<div class="px-6 py-4 border-t bg-background">
					<DialogFooter class="flex flex-col-reverse sm:flex-row sm:justify-end gap-2">
						<Button
							type="button"
							variant="outline"
							@click="closeModal"
							:disabled="isSaving"
							class="w-full sm:w-auto"
						>
							Cancel
						</Button>
						<Button
							type="submit"
							class="w-full sm:w-auto"
							:disabled="isSaving || loadingProblemTypes || isGeneratingSubCategoryId"
						>
							<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
							{{ isSaving ? "Saving..." : "Save Subcategory" }}
						</Button>
					</DialogFooter>
				</div>
			</form>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { ref, computed, watch, reactive, nextTick } from "vue";
import { Loader2 } from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";
import { generateSubCategoryId } from "@/utils/subCategoryIdGenerator";

// shadcn-vue components
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";

// Types
interface Problem {
	id?: string;
	problem_name: string;
	category: string;
	category_id: string;
	sub_category_id: string;
	description: string;
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

// Reactive data
const formData = reactive<Problem>({
	problem_name: "",
	category: "",
	category_id: "",
	sub_category_id: "",
	description: "",
	is_active: true,
});

const isSaving = ref(false);
const problemTypes = ref<ProblemType[]>([]);
const loadingProblemTypes = ref(false);
const problemTypesLoadError = ref("");
const isGeneratingSubCategoryId = ref(false);
const subCategoryIdError = ref("");
const subCategoryIdRequestId = ref(0);
const hasSubmitted = ref(false);
const initialFormSnapshot = ref("");
const fieldTouched = reactive({
	problem_name: false,
	category: false,
	description: false,
});

// Computed properties
const isEditing = computed(() => !!props.item);
const problemNameTrimmed = computed(() => formData.problem_name.trim());

const showProblemNameFeedback = computed(
	() => hasSubmitted.value || fieldTouched.problem_name,
);
const showCategoryFeedback = computed(
	() => hasSubmitted.value || fieldTouched.category || !!problemTypesLoadError.value,
);
const showDescriptionFeedback = computed(
	() => hasSubmitted.value || fieldTouched.description,
);

const problemNameError = computed(() => {
	if (!showProblemNameFeedback.value) {
		return "";
	}

	if (!problemNameTrimmed.value) {
		return "Subcategory name is required.";
	}

	if (subCategoryIdError.value) {
		return subCategoryIdError.value;
	}

	return "";
});

const problemNameHelperText = computed(() => {
	if (subCategoryIdError.value) {
		return "";
	}

	if (isGeneratingSubCategoryId.value) {
		return "Generating subcategory ID...";
	}

	if (isEditing.value) {
		return "Subcategory ID stays the same while you edit.";
	}

	return formData.sub_category_id
		? "Subcategory ID generated automatically."
		: "Subcategory ID is generated automatically.";
});

const categoryError = computed(() => {
	if (!showCategoryFeedback.value) {
		return "";
	}

	if (problemTypesLoadError.value) {
		return problemTypesLoadError.value;
	}

	if (!formData.category) {
		return "Parent category is required.";
	}

	if (!formData.category_id) {
		return "Please choose a valid parent category.";
	}

	return "";
});

const categoryHelperText = computed(() => {
	if (problemTypesLoadError.value) {
		return "";
	}

	if (loadingProblemTypes.value) {
		return "Loading categories...";
	}

	if (!formData.category) {
		return "Choose the parent category for this subcategory.";
	}

	return `Saved under ${formData.category}.`;
});

const descriptionError = computed(() => {
	if (!showDescriptionFeedback.value) {
		return "";
	}

	if (!formData.description.trim()) {
		return "Description is required.";
	}

	return "";
});

const descriptionHelperText = computed(
	() => "Briefly describe what this subcategory covers.",
);

const createFormSnapshot = () =>
	JSON.stringify({
		problem_name: formData.problem_name || "",
		category: formData.category || "",
		category_id: formData.category_id || "",
		sub_category_id: formData.sub_category_id || "",
		description: formData.description || "",
		is_active: formData.is_active ?? true,
	});

const hasUnsavedChanges = computed(
	() => createFormSnapshot() !== initialFormSnapshot.value,
);

// Methods
const closeModal = (force = false) => {
	if (!isSaving.value || force) {
		if (
			!force &&
			hasUnsavedChanges.value &&
			typeof window !== "undefined" &&
			!window.confirm("Discard unsaved changes?")
		) {
			return;
		}

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
	formData.is_active = true;
	isSaving.value = false;
	loadingProblemTypes.value = false;
	problemTypesLoadError.value = "";
	isGeneratingSubCategoryId.value = false;
	subCategoryIdError.value = "";
	subCategoryIdRequestId.value += 1;
	hasSubmitted.value = false;
	fieldTouched.problem_name = false;
	fieldTouched.category = false;
	fieldTouched.description = false;
};

const initializeForm = async () => {
	isSaving.value = false;
	isGeneratingSubCategoryId.value = false;
	subCategoryIdError.value = "";
	hasSubmitted.value = false;
	fieldTouched.problem_name = false;
	fieldTouched.category = false;
	fieldTouched.description = false;

	if (props.item) {
		formData.problem_name = props.item.problem_name || "";
		formData.category = props.item.category || "";
		formData.category_id = props.item.category_id || "";
		formData.sub_category_id = props.item.sub_category_id || "";
		formData.description = props.item.description || "";
		formData.is_active = props.item.is_active ?? true;
	} else {
		formData.problem_name = "";
		formData.category = "";
		formData.category_id = "";
		formData.sub_category_id = "";
		formData.description = "";
		formData.is_active = true;
	}

	initialFormSnapshot.value = createFormSnapshot();
};

const fetchProblemTypes = async () => {
	loadingProblemTypes.value = true;
	problemTypesLoadError.value = "";

	try {
		const { data, error } = await supabase
			.from("problem_types")
			.select("id, type_name, category_id, description, is_active")
			.eq("is_active", true)
			.order("type_name");

		if (error) throw error;

		problemTypes.value = data || [];
	} catch (error) {
		console.error("Error fetching categories:", error);
		problemTypes.value = [];
		problemTypesLoadError.value = "Unable to load categories. Try again.";
	} finally {
		loadingProblemTypes.value = false;
	}
};

const handleCategoryChange = (value?: string) => {
	fieldTouched.category = true;
	if (typeof value === "string") {
		formData.category = value;
	}

	const selectedType = problemTypes.value.find(
		(type) => type.type_name === formData.category,
	);

	formData.category_id = selectedType?.category_id || "";
};

const autoGenerateSubCategoryId = async () => {
	if (isEditing.value || !problemNameTrimmed.value) {
		return false;
	}

	const currentRequestId = ++subCategoryIdRequestId.value;
	isGeneratingSubCategoryId.value = true;
	subCategoryIdError.value = "";

	try {
		const subCategoryId = await generateSubCategoryId(
			supabase,
			problemNameTrimmed.value,
		);

		if (currentRequestId !== subCategoryIdRequestId.value) {
			return false;
		}

		formData.sub_category_id = subCategoryId;
		return true;
	} catch (error) {
			if (currentRequestId === subCategoryIdRequestId.value) {
				console.error("Error generating subcategory ID:", error);
				subCategoryIdError.value =
					"Unable to generate the subcategory ID. Try a different name.";
				formData.sub_category_id = "";
			}
		return false;
	} finally {
		if (currentRequestId === subCategoryIdRequestId.value) {
			isGeneratingSubCategoryId.value = false;
		}
	}
};

const markTouched = (fieldKey: "problem_name" | "category" | "description") => {
	fieldTouched[fieldKey] = true;
};

const handleProblemNameBlur = async () => {
	markTouched("problem_name");

	if (!problemNameTrimmed.value) {
		return;
	}

	await autoGenerateSubCategoryId();
};

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.problem_name = true;
	fieldTouched.category = true;
	fieldTouched.description = true;

	if (
		!problemNameTrimmed.value ||
		!formData.category ||
		!formData.description.trim()
	) {
		return;
	}

	if (!formData.category_id) {
		handleCategoryChange();
	}

	if (!formData.category_id) {
		return;
	}

	if (!isEditing.value && !formData.sub_category_id) {
		const generated = await autoGenerateSubCategoryId();
		if (!generated) {
			return;
		}
	}

	if (problemNameError.value || categoryError.value || descriptionError.value) {
		return;
	}

	isSaving.value = true;

	try {
		emit("save", { ...formData });
		closeModal(true);
	} catch (error) {
		console.error("Save error:", error);
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
			await initializeForm();
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
	{ deep: true },
);

watch(
	() => formData.problem_name,
	() => {
		subCategoryIdRequestId.value += 1;
		subCategoryIdError.value = "";

		if (!isEditing.value) {
			formData.sub_category_id = "";
		}
	},
);

watch(
	() => formData.category,
	() => {
		if (fieldTouched.category) {
			handleCategoryChange();
		}
	},
);
</script>
