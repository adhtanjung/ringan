<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="max-w-2xl max-h-[90vh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-4 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit" : "Create" }} Problem Type
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the information below"
								: "Fill in the details to create a new problem type"
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
								<!-- Type Name -->
								<div>
									<FormFieldLabel
										field-key="type_name"
										label="Type Name"
										:required="true"
										description="Problem type category name"
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
												validationStatus.type_name.loading
											"
											class="whitespace-nowrap flex-shrink-0"
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
										description="Detailed description of this problem type"
									/>
									<Textarea
										id="description"
										v-model="formData.description"
										rows="3"
										placeholder="Detailed description of this problem type"
										required
										class="mt-1"
									/>
								</div>

								<!-- Active Switch -->
								<div>
									<div class="flex items-center space-x-2">
										<Switch id="is_active" v-model="formData.is_active" />
										<FormFieldLabel
											field-key="is_active"
											label="Active"
											description="Whether this problem type is currently active and available for use"
										/>
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
								v-if="!isValidationComplete"
								variant="destructive"
								class="mt-6"
							>
								<AlertCircle class="h-4 w-4" />
								<AlertTitle>Validation Required</AlertTitle>
								<AlertDescription>
									Please check for duplicate type name and category ID before
									saving.
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
const validationErrors = ref<string[]>([]);
const isGeneratingCategoryId = ref(false);

// Computed properties
const isEditing = computed(() => !!props.item);

const isValidationComplete = computed(() => {
	if (!formData.type_name || !formData.category_id) return false;
	if (!validationStatus.type_name.checked) return false;
	if (validationStatus.type_name.exists) return false;
	return true;
});

// Methods
const closeModal = () => {
	if (!isSaving.value) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	formData.type_name = "";
	formData.category_id = "";
	formData.description = "";
	formData.is_active = true;
	validationErrors.value = [];
	isSaving.value = false;
	isGeneratingCategoryId.value = false;
	validationStatus.type_name = {
		checked: false,
		exists: false,
		loading: false,
	};
};

const initializeForm = async () => {
	// Reset validation status and errors
	validationErrors.value = [];
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
	} else {
		// Create mode - set defaults
		formData.type_name = "";
		formData.category_id = "";
		formData.description = "";
		formData.is_active = true;
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

const validateForm = () => {
	const errors: string[] = [];

	if (!formData.type_name) {
		errors.push("Type Name is required");
	}
	if (!formData.category_id) {
		errors.push("Category ID is required");
	}
	if (!formData.description) {
		errors.push("Description is required");
	}

	// Check validation status
	if (!validationStatus.type_name.checked) {
		errors.push("Please check for duplicate Type Name before saving");
	} else if (validationStatus.type_name.exists) {
		errors.push("Type Name already exists. Please choose a different one.");
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
	}
);
</script>
