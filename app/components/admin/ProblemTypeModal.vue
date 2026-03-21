<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[92vw] sm:max-w-xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-5 border-b">
				<DialogHeader>
					<DialogTitle id="tour-pt-modal-title">
						{{ isEditing ? "Edit Category" : "Create Category" }}
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the category name and description."
								: "Add a category name and short description."
						}}
					</DialogDescription>
				</DialogHeader>
			</div>

			<form
				@submit.prevent="saveItem"
				class="flex-1 flex flex-col min-h-0 overflow-hidden"
			>
				<div class="flex-1 overflow-y-auto min-h-0 px-6">
					<div class="py-6">
						<div class="grid grid-cols-1 gap-6">
							<div>
								<FormFieldLabel
									field-key="type_name"
									label="Category Name"
									:required="true"
								/>
								<Input
									id="type_name"
									v-model="formData.type_name"
									placeholder="e.g., Work Stress, Social Anxiety"
									required
									class="mt-1"
									@blur="handleTypeNameBlur"
								/>
								<p
									class="mt-2 text-sm leading-6"
									:class="nameHelperTone"
									aria-live="polite"
								>
									{{ nameHelperText }}
								</p>
								<p
									v-if="nameErrorText"
									class="mt-1 text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ nameErrorText }}
								</p>
							</div>

							<div>
								<FormFieldLabel
									field-key="description"
									label="Description"
									:required="true"
								/>
								<Textarea
									id="description"
									v-model="formData.description"
									rows="4"
									placeholder="Briefly describe what belongs in this category."
									required
									class="mt-1"
									@blur="fieldTouched.description = true"
								/>
								<p
									v-if="descriptionErrorText"
									class="mt-1 text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ descriptionErrorText }}
								</p>
							</div>
						</div>
					</div>
				</div>

				<div class="px-6 py-4 border-t bg-background">
					<DialogFooter
						class="flex flex-col-reverse sm:flex-row sm:justify-end gap-2"
					>
						<Button
							type="button"
							variant="outline"
							class="w-full sm:w-auto"
							@click="closeModal"
							:disabled="isSaving"
						>
							Cancel
						</Button>
						<Button
							type="submit"
							class="w-full sm:w-auto"
							:disabled="
								isSaving || validationStatus.type_name.loading || isGeneratingCategoryId
							"
							id="tour-pt-save-btn"
						>
							<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
							{{ isSaving ? "Saving..." : "Save Category" }}
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
import { generateCategoryId } from "@/utils/categoryIdGenerator";

// shadcn-vue components
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import FormFieldLabel from "@/components/admin/FormFieldLabel.vue";

// Types
interface ProblemType {
	id?: string;
	type_name: string;
	category_id: string;
	description: string;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

interface ValidationStatus {
	checked: boolean;
	exists: boolean;
	loading: boolean;
}

// Props
const props = defineProps<{
	isOpen: boolean;
	item: ProblemType | null;
}>();

// Emits
const emit = defineEmits<{
	close: [];
	save: [data: ProblemType];
}>();

// Composables
const { supabase } = useSupabase();

// Reactive data
const formData = reactive<ProblemType>({
	type_name: "",
	category_id: "",
	description: "",
	is_active: true,
});

const validationStatus = reactive<{
	type_name: ValidationStatus;
}>({
	type_name: { checked: false, exists: false, loading: false },
});

const isSaving = ref(false);
const hasSubmitted = ref(false);
const initialFormSnapshot = ref("");
const fieldTouched = reactive({
	type_name: false,
	description: false,
});
const isGeneratingCategoryId = ref(false);
const duplicateCheckError = ref("");
const categoryIdError = ref("");
const duplicateCheckRequestId = ref(0);
const categoryIdRequestId = ref(0);
const originalTypeName = ref("");

// Computed properties
const isEditing = computed(() => !!props.item);

const typeNameTrimmed = computed(() => formData.type_name.trim());
const originalTypeNameTrimmed = computed(() => originalTypeName.value.trim());
const typeNameChanged = computed(
	() => !isEditing.value || typeNameTrimmed.value !== originalTypeNameTrimmed.value,
);
const showNameFeedback = computed(
	() => hasSubmitted.value || fieldTouched.type_name,
);
const showDescriptionFeedback = computed(
	() => hasSubmitted.value || fieldTouched.description,
);
const nameErrorText = computed(() => {
	if (!showNameFeedback.value) {
		return "";
	}

	if (!typeNameTrimmed.value) {
		return "Category name is required.";
	}

	if (duplicateCheckError.value) {
		return duplicateCheckError.value;
	}

	if (
		typeNameChanged.value &&
		validationStatus.type_name.checked &&
		validationStatus.type_name.exists
	) {
		return "This category name already exists.";
	}

	return "";
});
const descriptionErrorText = computed(() => {
	if (!showDescriptionFeedback.value) {
		return "";
	}

	if (!formData.description.trim()) {
		return "Description is required.";
	}

	return "";
});
const nameHelperText = computed(() => {
	if (categoryIdError.value) {
		return categoryIdError.value;
	}

	if (validationStatus.type_name.loading) {
		return "Checking availability...";
	}

	if (!formData.type_name) {
		return isEditing.value
			? "Category ID stays the same while you edit."
			: "Category ID is generated automatically.";
	}

	if (typeNameChanged.value && validationStatus.type_name.checked) {
		return validationStatus.type_name.exists
			? "This category name is already in use."
			: "Available.";
	}

	if (isGeneratingCategoryId.value) {
		return "Generating category ID...";
	}

	if (isEditing.value && !typeNameChanged.value) {
		return "Name unchanged.";
	}

	if (!isEditing.value && formData.category_id) {
		return "Category ID is generated automatically.";
	}

	return "Category ID is generated automatically.";
});
const nameHelperTone = computed(() => {
	if (categoryIdError.value || nameErrorText.value) {
		return "text-destructive";
	}

	if (
		typeNameChanged.value &&
		validationStatus.type_name.checked &&
		!validationStatus.type_name.exists
	) {
		return "text-emerald-600";
	}

	return "text-muted-foreground";
});

const createFormSnapshot = () =>
	JSON.stringify({
		type_name: formData.type_name || "",
		category_id: formData.category_id || "",
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
	duplicateCheckRequestId.value += 1;
	categoryIdRequestId.value += 1;
	formData.type_name = "";
	formData.category_id = "";
	formData.description = "";
	formData.is_active = true;
	hasSubmitted.value = false;
	fieldTouched.type_name = false;
	fieldTouched.description = false;
	isSaving.value = false;
	isGeneratingCategoryId.value = false;
	duplicateCheckError.value = "";
	categoryIdError.value = "";
	validationStatus.type_name = {
		checked: false,
		exists: false,
		loading: false,
	};
};

const initializeForm = async () => {
	// Reset validation status
	isSaving.value = false;
	isGeneratingCategoryId.value = false;
	hasSubmitted.value = false;
	fieldTouched.type_name = false;
	fieldTouched.description = false;
	duplicateCheckError.value = "";
	categoryIdError.value = "";
	validationStatus.type_name = {
		checked: false,
		exists: false,
		loading: false,
	};

	if (props.item) {
		// Edit mode - populate with existing data
		formData.type_name = props.item.type_name || "";
		formData.category_id = props.item.category_id || "";
		formData.description = props.item.description || "";
		formData.is_active = props.item.is_active ?? true;
		originalTypeName.value = props.item.type_name || "";
	} else {
		// Create mode - set defaults
		formData.type_name = "";
		formData.category_id = "";
		formData.description = "";
		formData.is_active = true;
		originalTypeName.value = "";
	}

	initialFormSnapshot.value = createFormSnapshot();
};

const checkDuplicateTypeName = async () => {
	const value = typeNameTrimmed.value;
	const currentRequestId = ++duplicateCheckRequestId.value;
	duplicateCheckError.value = "";

	if (!value) {
		validationStatus.type_name.checked = false;
		validationStatus.type_name.exists = false;
		return false;
	}

	if (isEditing.value && value === originalTypeNameTrimmed.value) {
		validationStatus.type_name.checked = true;
		validationStatus.type_name.exists = false;
		return true;
	}

	validationStatus.type_name.loading = true;

	try {
		let query = supabase
			.from("problem_types")
			.select("id", { count: "exact" })
			.eq("type_name", value);

		if (props.item?.id) {
			query = query.neq("id", props.item.id);
		}

		const { count, error } = await query;
		if (error) throw error;

		if (currentRequestId !== duplicateCheckRequestId.value) {
			return false;
		}

		validationStatus.type_name.checked = true;
		validationStatus.type_name.exists = (count || 0) > 0;

		return !validationStatus.type_name.exists;
	} catch (error) {
		if (currentRequestId === duplicateCheckRequestId.value) {
			validationStatus.type_name.checked = false;
			validationStatus.type_name.exists = false;
			duplicateCheckError.value =
				"Unable to check category name right now. Please try again.";
		}

		return false;
	} finally {
		if (currentRequestId === duplicateCheckRequestId.value) {
			validationStatus.type_name.loading = false;
		}
	}
};

const autoGenerateCategoryId = async () => {
	// Only auto-generate for new items, not when editing
	if (isEditing.value || !typeNameTrimmed.value) {
		return;
	}

	isGeneratingCategoryId.value = true;
	categoryIdError.value = "";
	const currentRequestId = ++categoryIdRequestId.value;

	try {
		const categoryId = await generateCategoryId(supabase, typeNameTrimmed.value);
		if (currentRequestId !== categoryIdRequestId.value) {
			return false;
		}
		formData.category_id = categoryId;
		return true;
	} catch (error) {
		if (currentRequestId === categoryIdRequestId.value) {
			categoryIdError.value =
				"Unable to generate the category ID. Please try a different name.";
		}
		formData.category_id = "";
		return false;
	} finally {
		if (currentRequestId === categoryIdRequestId.value) {
			isGeneratingCategoryId.value = false;
		}
	}
};

const handleTypeNameBlur = async () => {
	fieldTouched.type_name = true;

	if (!typeNameTrimmed.value) {
		return;
	}

	const isUnique = await checkDuplicateTypeName();

	if (!isEditing.value && isUnique) {
		await autoGenerateCategoryId();
	}
};

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.type_name = true;
	fieldTouched.description = true;

	if (!typeNameTrimmed.value || !formData.description.trim()) {
		return;
	}

	if (typeNameChanged.value) {
		const isUnique = await checkDuplicateTypeName();
		if (!isUnique) {
			return;
		}
	}

	if (!isEditing.value && !formData.category_id) {
		const generated = await autoGenerateCategoryId();
		if (!generated) {
			return;
		}
	}

	isSaving.value = true;

	try {
		emit("save", { ...formData });

		// Close modal after successful save - force it because isSaving is still true
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
	{ deep: true },
);

// Reset validation when type name changes and auto-generate category ID
watch(
	() => formData.type_name,
	() => {
		duplicateCheckRequestId.value += 1;
		categoryIdRequestId.value += 1;
		validationStatus.type_name.checked = false;
		validationStatus.type_name.exists = false;
		validationStatus.type_name.loading = false;
		duplicateCheckError.value = "";
		categoryIdError.value = "";

		if (!isEditing.value) {
			formData.category_id = "";
			if (!formData.type_name) {
				isGeneratingCategoryId.value = false;
			}
		}
	},
);
</script>
