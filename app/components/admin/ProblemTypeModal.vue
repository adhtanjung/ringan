<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[95vw] sm:max-w-2xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-4 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit" : "Create" }} Category
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the information below"
								: "Fill in the details to create a new category"
						}}
					</DialogDescription>
				</DialogHeader>
			</div>

			<!-- Form -->
			<TooltipProvider>
				<form
					@submit.prevent="saveItem"
					class="flex-1 flex flex-col min-h-0 overflow-hidden"
				>
					<div class="flex-1 overflow-y-auto min-h-0 px-6">
						<div class="py-6">
							<!-- Form Fields -->
							<div class="grid grid-cols-1 gap-4 sm:gap-6">
								<!-- Type Name -->
								<div>
									<FormFieldLabel
										field-key="type_name"
										label="Category Name"
										:required="true"
										description="Category name"
									/>
									<div class="mt-1 flex flex-col sm:flex-row gap-2">
										<Input
											id="type_name"
											v-model="formData.type_name"
											placeholder="e.g., Work Stress, Social Anxiety"
											required
											class="flex-1"
										/>
										<Button
											type="button"
											variant="outline"
											size="sm"
											@click="checkDuplicateTypeName"
											:disabled="
												!formData.type_name ||
												validationStatus.type_name.loading ||
												(isEditing && formData.type_name === originalTypeName)
											"
											class="whitespace-nowrap shrink-0"
										>
											<Loader2
												v-if="validationStatus.type_name.loading"
												class="h-4 w-4 animate-spin mr-1"
											/>
											<CheckCircle
												v-else-if="
													validationStatus.type_name.checked &&
													!validationStatus.type_name.exists
												"
												class="h-4 w-4 text-green-600 mr-1"
											/>
											<XCircle
												v-else-if="
													validationStatus.type_name.checked &&
													validationStatus.type_name.exists
												"
												class="h-4 w-4 text-red-600 mr-1"
											/>
											<span class="hidden sm:inline">Check</span>
											<span class="sm:hidden">✓</span>
										</Button>
									</div>
									<div
										v-if="validationStatus.type_name.checked"
										class="mt-1 text-xs"
									>
										<span
											v-if="!validationStatus.type_name.exists"
											class="text-green-600"
										>
											✓ Available
										</span>
										<span v-else class="text-red-600"> ✗ Already exists </span>
									</div>
								</div>

								<!-- Category ID (Auto-generated) -->
								<div>
									<FormFieldLabel
										field-key="category_id"
										label="Category ID"
										:required="true"
										:description="
											isEditing
												? 'Unique category identifier'
												: 'Auto-generated from type name'
										"
									/>
									<div class="mt-1 flex items-center gap-2">
										<Input
											id="category_id"
											v-model="formData.category_id"
											placeholder="Will be auto-generated"
											readonly
											class="flex-1 bg-muted cursor-not-allowed"
										/>
										<Loader2
											v-if="isGeneratingCategoryId"
											class="h-4 w-4 animate-spin text-muted-foreground"
										/>
										<CheckCircle
											v-else-if="formData.category_id"
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
										description="Detailed description of this category"
									/>
									<Textarea
										id="description"
										v-model="formData.description"
										rows="3"
										placeholder="Detailed description of this category"
										required
										class="mt-1"
									/>
								</div>
							</div>

							<!-- Validation Errors -->
							<Alert
								v-if="hasTouched && validationErrors.length > 0"
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
					</div>

					<!-- Action Buttons -->
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
									isSaving || (hasTouched && validationErrors.length > 0)
								"
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
import { ref, computed, watch, reactive, nextTick } from "vue";
import { AlertCircle, Loader2, CheckCircle, XCircle } from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";
import { useToast } from "@/components/ui/toast/use-toast";
import { generateCategoryId } from "@/utils/categoryIdGenerator";

// shadcn-vue components
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
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
const { toast } = useToast();

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
const hasTouched = ref(false);
const isGeneratingCategoryId = ref(false);
const originalTypeName = ref("");

// Computed properties
const isEditing = computed(() => !!props.item);

const validationErrors = computed(() => {
	const errors: string[] = [];
	console.log("[DEBUG] Re-evaluating validationErrors. formData:", {
		...formData,
	});

	if (!formData.type_name) {
		errors.push("Type Name is required");
	}
	if (!formData.category_id) {
		errors.push("Category ID is required");
	}
	if (!formData.description) {
		errors.push("Description is required");
	}

	// Check validation status (only if type_name has changed from original)
	const typeNameChanged =
		!isEditing.value || formData.type_name !== originalTypeName.value;

	if (typeNameChanged) {
		if (!validationStatus.type_name.checked) {
			errors.push("Please check for duplicate Category Name before saving");
		} else if (validationStatus.type_name.exists) {
			errors.push(
				"Category Name already exists. Please choose a different one.",
			);
		}
	}

	console.log("[DEBUG] Validation errors found:", errors);
	return errors;
});

// Methods
const closeModal = (force = false) => {
	console.log(
		"[DEBUG] closeModal called. isSaving:",
		isSaving.value,
		"force:",
		force,
	);
	if (!isSaving.value || force) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	console.log("[DEBUG] resetForm called");
	formData.type_name = "";
	formData.category_id = "";
	formData.description = "";
	formData.is_active = true;
	hasTouched.value = false;
	isSaving.value = false;
	isGeneratingCategoryId.value = false;
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
};

const checkDuplicateTypeName = async () => {
	validationStatus.type_name.loading = true;

	try {
		const value = formData.type_name;
		if (!value) {
			validationStatus.type_name.loading = false;
			return;
		}

		let query = supabase
			.from("problem_types")
			.select("id", { count: "exact" })
			.eq("type_name", value);

		if (props.item?.id) {
			query = query.neq("id", props.item.id);
		}

		const { count, error } = await query;
		if (error) throw error;

		validationStatus.type_name.checked = true;
		validationStatus.type_name.exists = (count || 0) > 0;

		toast({
			title: validationStatus.type_name.exists
				? "Duplicate Found"
				: "Validation Passed",
			description: `Type name ${
				validationStatus.type_name.exists ? "already exists" : "is available"
			}`,
			variant: validationStatus.type_name.exists ? "destructive" : "default",
		});
	} catch (error) {
		console.error("Validation error:", error);
		toast({
			title: "Validation Error",
			description: "Failed to check for duplicates. Please try again.",
			variant: "destructive",
		});
	} finally {
		validationStatus.type_name.loading = false;
	}
};

const autoGenerateCategoryId = async () => {
	// Only auto-generate for new items, not when editing
	if (isEditing.value || !formData.type_name) {
		return;
	}

	isGeneratingCategoryId.value = true;

	try {
		const categoryId = await generateCategoryId(supabase, formData.type_name);
		formData.category_id = categoryId;
	} catch (error) {
		console.error("Error generating category ID:", error);
		toast({
			title: "Generation Error",
			description: "Failed to generate category ID. Please try again.",
			variant: "destructive",
		});
		formData.category_id = "";
	} finally {
		isGeneratingCategoryId.value = false;
	}
};

const saveItem = async () => {
	console.log(
		"[DEBUG] saveItem initiated. Current errors:",
		validationErrors.value,
	);
	hasTouched.value = true;

	if (validationErrors.value.length > 0) {
		console.log("[DEBUG] saveItem aborted due to validation errors");
		return;
	}

	isSaving.value = true;

	try {
		console.log("[DEBUG] Emitting save event with data:", { ...formData });
		// Emit save event
		emit("save", { ...formData });

		console.log("[DEBUG] Save event emitted successfully. Forcing closeModal.");
		// Close modal after successful save - force it because isSaving is still true
		closeModal(true);
	} catch (error) {
		console.error("[DEBUG] Save error:", error);
	} finally {
		console.log("[DEBUG] saveItem finally block. Setting isSaving to false.");
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
	async () => {
		validationStatus.type_name.checked = false;
		validationStatus.type_name.exists = false;

		// Auto-generate category ID for new items
		if (!isEditing.value && formData.type_name) {
			await autoGenerateCategoryId();
		}
	},
);
</script>
