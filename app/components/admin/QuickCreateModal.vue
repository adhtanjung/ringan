<template>
	<BaseModal :modelValue="isOpen" @update:modelValue="closeModal">
		<div class="w-full max-w-lg">
			<div class="mb-5 border-b pb-4">
				<div class="flex items-start justify-between gap-4">
					<div>
						<h3 class="text-lg font-semibold text-foreground">
							Create New {{ typeLabel }}
						</h3>
						<p class="mt-1 text-sm leading-6 text-muted-foreground">
							Fill in the details below. Availability is checked automatically.
						</p>
					</div>
					<Button
						variant="ghost"
						size="icon"
						@click="closeModal"
						class="text-muted-foreground hover:text-foreground"
					>
						<X class="h-4 w-4" />
					</Button>
				</div>
			</div>

			<form @submit.prevent="saveItem" class="space-y-5">
				<div v-if="type === 'domain'" class="space-y-5">
					<div>
						<Label for="domain_name" class="text-sm font-medium text-foreground">
							Domain Name
							<span class="ml-1 text-destructive">*</span>
						</Label>
						<Input
							id="domain_name"
							v-model="formData.domain_name"
							placeholder="e.g., Stress Management"
							required
							class="mt-1"
							@blur="markTouched('domain_name')"
						/>
						<p
							v-if="getRequiredError('domain_name', 'Domain name')"
							class="mt-1 text-sm leading-6 text-destructive"
							aria-live="polite"
						>
							{{ getRequiredError("domain_name", "Domain name") }}
						</p>
					</div>

					<div>
						<Label for="domain_code" class="text-sm font-medium text-foreground">
							Domain Code
							<span class="ml-1 text-destructive">*</span>
						</Label>
						<Input
							id="domain_code"
							v-model="formData.domain_code"
							placeholder="e.g., STR, ANX, TRA"
							required
							class="mt-1"
							@blur="handleDuplicateFieldBlur"
						/>
						<p
							class="mt-2 text-sm leading-6"
							:class="duplicateHelperTone"
							aria-live="polite"
						>
							{{ duplicateHelperText }}
						</p>
						<p
							v-if="duplicateFieldError"
							class="mt-1 text-sm leading-6 text-destructive"
							aria-live="polite"
						>
							{{ duplicateFieldError }}
						</p>
					</div>
				</div>

				<div v-else class="space-y-5">
					<div>
						<Label for="type_name" class="text-sm font-medium text-foreground">
							Category Name
							<span class="ml-1 text-destructive">*</span>
						</Label>
						<Input
							id="type_name"
							v-model="formData.type_name"
							placeholder="e.g., Work Stress, Social Anxiety"
							required
							class="mt-1"
							@blur="handleDuplicateFieldBlur"
						/>
						<p
							class="mt-2 text-sm leading-6"
							:class="duplicateHelperTone"
							aria-live="polite"
						>
							{{ duplicateHelperText }}
						</p>
						<p
							v-if="duplicateFieldError"
							class="mt-1 text-sm leading-6 text-destructive"
							aria-live="polite"
						>
							{{ duplicateFieldError }}
						</p>
					</div>
				</div>

				<div>
					<Label for="description" class="text-sm font-medium text-foreground">
						Description
						<span class="ml-1 text-destructive">*</span>
					</Label>
					<Textarea
						id="description"
						v-model="formData.description"
						:placeholder="
							type === 'domain'
								? 'Briefly describe what belongs in this domain.'
								: 'Briefly describe what belongs in this category.'
						"
						rows="4"
						required
						class="mt-1"
						@blur="markTouched('description')"
					/>
					<p
						v-if="getRequiredError('description', 'Description')"
						class="mt-1 text-sm leading-6 text-destructive"
						aria-live="polite"
					>
						{{ getRequiredError("description", "Description") }}
					</p>
				</div>

				<div class="flex items-center justify-end gap-3 border-t pt-4">
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
						:disabled="isSaving || duplicateStatus.loading"
					>
						<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
						{{ isSaving ? "Creating..." : `Create ${typeLabel}` }}
					</Button>
				</div>
			</form>
		</div>
	</BaseModal>
</template>

<script setup>
import { ref, computed, reactive, watch } from "vue";
import { X, Loader2 } from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";
import { useToast } from "@/components/ui/toast/use-toast";

// shadcn-vue components
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import BaseModal from "@/components/BaseModal.vue";

const props = defineProps({
	isOpen: {
		type: Boolean,
		default: false,
	},
	type: {
		type: String,
		required: true,
		validator: (value) => ["domain", "problem_type"].includes(value),
	},
});

const { supabase } = useSupabase();
const { toast } = useToast();

const emit = defineEmits(["close", "created"]);

const formData = reactive({
	domain_name: "",
	domain_code: "",
	type_name: "",
	description: "",
	is_active: true,
});

const validationStatus = reactive({
	domain_code: { checked: false, exists: false, loading: false },
	type_name: { checked: false, exists: false, loading: false },
});

const requestIds = reactive({
	domain_code: 0,
	type_name: 0,
});

const fieldTouched = reactive({
	domain_name: false,
	domain_code: false,
	type_name: false,
	description: false,
});

const isSaving = ref(false);
const hasSubmitted = ref(false);
const duplicateCheckError = ref("");

const typeLabel = computed(() =>
	props.type === "domain" ? "Domain" : "Problem Type",
);

const duplicateFieldKey = computed(() =>
	props.type === "domain" ? "domain_code" : "type_name",
);

const duplicateFieldLabel = computed(() =>
	props.type === "domain" ? "Domain code" : "Category name",
);

const duplicateFieldValue = computed(() => formData[duplicateFieldKey.value]);

const duplicateStatus = computed(
	() => validationStatus[duplicateFieldKey.value],
);

const showDuplicateFeedback = computed(
	() => hasSubmitted.value || fieldTouched[duplicateFieldKey.value],
);

const duplicateFieldError = computed(() => {
	if (!showDuplicateFeedback.value) {
		return "";
	}

	const label = duplicateFieldLabel.value;
	const value = String(duplicateFieldValue.value || "").trim();

	if (!value) {
		return `${label} is required.`;
	}

	if (duplicateCheckError.value) {
		return duplicateCheckError.value;
	}

	if (duplicateStatus.value.checked && duplicateStatus.value.exists) {
		return `${label} already exists.`;
	}

	return "";
});

const duplicateHelperText = computed(() => {
	if (duplicateCheckError.value) {
		return duplicateCheckError.value;
	}

	if (!duplicateFieldValue.value) {
		return "Availability is checked automatically.";
	}

	if (duplicateStatus.value.loading) {
		return "Checking availability...";
	}

	if (duplicateStatus.value.checked && !duplicateStatus.value.exists) {
		return "Available.";
	}

	if (duplicateStatus.value.checked && duplicateStatus.value.exists) {
		return "Already exists.";
	}

	return "Will be checked when you leave the field.";
});

const duplicateHelperTone = computed(() => {
	if (duplicateCheckError.value || duplicateStatus.value.exists) {
		return "text-destructive";
	}

	if (duplicateStatus.value.checked && !duplicateStatus.value.exists) {
		return "text-emerald-600";
	}

	return "text-muted-foreground";
});

const resetDuplicateState = () => {
	const key = duplicateFieldKey.value;
	requestIds[key] += 1;
	validationStatus[key].checked = false;
	validationStatus[key].exists = false;
	validationStatus[key].loading = false;
	duplicateCheckError.value = "";
};

const markTouched = (fieldKey) => {
	fieldTouched[fieldKey] = true;
};

const getRequiredError = (fieldKey, label) => {
	const value = String(formData[fieldKey] || "").trim();

	if (!hasSubmitted.value && !fieldTouched[fieldKey]) {
		return "";
	}

	if (!value) {
		return `${label} is required.`;
	}

	return "";
};

const closeModal = (force = false) => {
	if (!isSaving.value || force) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	formData.domain_name = "";
	formData.domain_code = "";
	formData.type_name = "";
	formData.description = "";
	formData.is_active = true;

	validationStatus.domain_code = {
		checked: false,
		exists: false,
		loading: false,
	};
	validationStatus.type_name = {
		checked: false,
		exists: false,
		loading: false,
	};

	requestIds.domain_code = 0;
	requestIds.type_name = 0;

	fieldTouched.domain_name = false;
	fieldTouched.domain_code = false;
	fieldTouched.type_name = false;
	fieldTouched.description = false;

	duplicateCheckError.value = "";
	hasSubmitted.value = false;
	isSaving.value = false;
};

const checkForDuplicate = async () => {
	const fieldKey = duplicateFieldKey.value;
	const value = String(duplicateFieldValue.value || "").trim();

	resetDuplicateState();

	if (!value) {
		return false;
	}

	const currentRequestId = ++requestIds[fieldKey];
	validationStatus[fieldKey].loading = true;

	try {
		const tableName =
			props.type === "domain" ? "domain_types" : "problem_types";
		const { count, error } = await supabase
			.from(tableName)
			.select("id", { count: "exact" })
			.eq(fieldKey, value);

		if (error) throw error;
		if (currentRequestId !== requestIds[fieldKey]) {
			return false;
		}

		validationStatus[fieldKey].checked = true;
		validationStatus[fieldKey].exists = (count || 0) > 0;

		return !validationStatus[fieldKey].exists;
	} catch (error) {
		if (currentRequestId === requestIds[fieldKey]) {
			duplicateCheckError.value =
				"Unable to check availability right now. Please try again.";
		}

		console.error("Validation error:", error);
		return false;
	} finally {
		if (currentRequestId === requestIds[fieldKey]) {
			validationStatus[fieldKey].loading = false;
		}
	}
};

const handleDuplicateFieldBlur = async () => {
	const fieldKey = duplicateFieldKey.value;
	fieldTouched[fieldKey] = true;

	if (!String(duplicateFieldValue.value || "").trim()) {
		resetDuplicateState();
		return;
	}

	await checkForDuplicate();
};

const validateForm = async () => {
	hasSubmitted.value = true;

	if (props.type === "domain") {
		fieldTouched.domain_name = true;
		fieldTouched.domain_code = true;
	} else {
		fieldTouched.type_name = true;
	}
	fieldTouched.description = true;

	if (props.type === "domain") {
		if (!String(formData.domain_name || "").trim()) return false;
		if (!String(formData.domain_code || "").trim()) return false;
	} else if (!String(formData.type_name || "").trim()) {
		return false;
	}

	if (!String(formData.description || "").trim()) return false;

	if (
		!duplicateStatus.value.checked ||
		duplicateStatus.value.exists ||
		duplicateStatus.value.loading
	) {
		return await checkForDuplicate();
	}

	return true;
};

const saveItem = async () => {
	if (!(await validateForm())) {
		return;
	}

	isSaving.value = true;

	try {
		const tableName =
			props.type === "domain" ? "domain_types" : "problem_types";
		const payload = {
			...formData,
			created_at: new Date().toISOString(),
			updated_at: new Date().toISOString(),
		};

		if (props.type === "domain") {
			delete payload.type_name;
		} else {
			delete payload.domain_name;
			delete payload.domain_code;
		}

		const { data, error } = await supabase
			.from(tableName)
			.insert(payload)
			.select()
			.single();

		if (error) throw error;

		toast({
			title: "Success",
			description: `${typeLabel.value} created successfully`,
			variant: "default",
		});

		emit("created", data);
		closeModal(true);
	} catch (error) {
		console.error("Create error:", error);
		toast({
			title: "Error",
			description: "Failed to create item. Please try again.",
			variant: "destructive",
		});
	} finally {
		isSaving.value = false;
	}
};

watch(
	() => props.isOpen,
	(newValue) => {
		if (newValue) {
			resetForm();
		}
	},
);

watch(
	() => props.type,
	() => {
		resetForm();
	},
);

watch(duplicateFieldValue, () => {
	resetDuplicateState();
});
</script>
