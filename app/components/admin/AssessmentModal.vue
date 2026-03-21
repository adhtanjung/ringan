<template>
	<Dialog :open="isOpen" @update:open="handleOpenChange">
		<DialogContent
			class="w-[92vw] sm:max-w-2xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="border-b bg-background px-6 py-5">
					<DialogHeader class="space-y-1">
						<DialogTitle class="text-xl font-semibold">
							{{ isEditing ? "Edit" : "Create" }} Assessment Question
						</DialogTitle>
						<DialogDescription class="text-sm leading-6">
							Write a clear question, choose the answer format, then link it to the
							right subcategory.
						</DialogDescription>
					</DialogHeader>
				</div>

			<form @submit.prevent="saveItem" class="flex flex-1 min-h-0 flex-col">
				<div class="flex-1 overflow-y-auto bg-muted/10">
					<div class="space-y-6 px-6 py-6">
						<section class="space-y-2">
							<Label for="question_text" class="text-sm font-semibold">
								Question Text
							</Label>
							<Textarea
								id="question_text"
								v-model="formData.question_text"
								rows="4"
								placeholder="e.g., Over the last 2 weeks, how often have you been bothered by feeling nervous?"
								required
								class="min-h-[120px] resize-y"
								@blur="handleQuestionTextBlur"
							/>
							<p class="text-sm leading-6 text-muted-foreground">
								This is the exact question people will see.
							</p>
							<div
								class="flex flex-wrap items-center gap-2 text-xs leading-5"
								aria-live="polite"
							>
								<Loader2
									v-if="isGeneratingQuestionId"
									class="h-3.5 w-3.5 animate-spin text-muted-foreground"
									aria-hidden="true"
								/>
								<span v-if="questionIdError" class="text-destructive">
									{{ questionIdError }}
								</span>
								<template v-else>
									<span class="text-muted-foreground">
										{{ questionIdHelperText }}
									</span>
									<span
										v-if="formData.question_id"
										class="rounded-full border border-border/70 bg-background px-2.5 py-1 font-mono text-[11px] text-foreground/80"
									>
										{{ formData.question_id }}
									</span>
								</template>
							</div>
							<p
								v-if="questionTextError"
								class="text-sm leading-6 text-destructive"
								aria-live="polite"
							>
								{{ questionTextError }}
							</p>
						</section>

						<section class="grid gap-5 md:grid-cols-2">
							<div class="space-y-2">
								<Label for="response_type" class="text-sm font-semibold">
									Response Type
								</Label>
								<Select
									:model-value="formData.response_type"
									@update:model-value="handleResponseTypeChange"
								>
									<SelectTrigger id="response_type" class="h-11 w-full">
										<SelectValue placeholder="Select how users answer" />
									</SelectTrigger>
									<SelectContent>
										<SelectItem value="scale">Scale (1-4 Rating)</SelectItem>
										<SelectItem value="text">Free Text</SelectItem>
									</SelectContent>
								</Select>
								<p class="text-sm leading-6 text-muted-foreground">
									Scale shows fixed answer choices. Text lets people type their
									own response.
								</p>
								<p
									v-if="responseTypeError"
									class="text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ responseTypeError }}
								</p>
							</div>

							<div class="space-y-2">
								<Label for="sub_category_id" class="text-sm font-semibold">
									Linked Subcategory
								</Label>
								<AsyncSearchSelect
									:model-value="formData.sub_category_id"
									@update:model-value="handleSubCategoryChange"
									input-id="sub_category_id"
									table-name="problems"
									:search-fields="['problem_name', 'sub_category_id']"
									value-field="sub_category_id"
									:display-fields="['sub_category_id', 'problem_name']"
									placeholder="Search by subcategory ID or name"
								/>
								<p class="text-sm leading-6 text-muted-foreground">
									Choose the subcategory this question belongs to.
								</p>
								<p
									v-if="subCategoryError"
									class="text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ subCategoryError }}
								</p>
							</div>
						</section>

						<section
							v-if="formData.response_type === 'scale'"
							class="space-y-4 rounded-2xl border border-border/70 bg-background px-4 py-4"
						>
							<div class="flex items-start justify-between gap-4">
								<div class="space-y-1">
									<h3 class="text-sm font-semibold text-foreground">
										Scale Labels
									</h3>
									<p class="text-sm leading-6 text-muted-foreground">
										Keep the labels short and easy to scan.
									</p>
								</div>

								<div class="rounded-full border border-border/70 bg-muted/40 px-3 py-1 text-xs text-muted-foreground">
									Scale range: 1-4
								</div>
							</div>

							<div class="grid gap-3 sm:grid-cols-2">
								<div v-for="i in 4" :key="i" class="space-y-2">
									<Label
										:for="`scale_label_${i}`"
										class="text-xs font-medium uppercase tracking-wide text-muted-foreground"
									>
										Choice {{ i }}
									</Label>
									<Input
										:id="`scale_label_${i}`"
										:model-value="getScaleLabel(i)"
										@update:model-value="(value) => setScaleLabel(i, value)"
										:placeholder="getPlaceholder(i)"
										class="h-11"
									/>
								</div>
							</div>
						</section>

						<section class="space-y-3">
							<button
								type="button"
								class="flex w-full items-center justify-between rounded-xl border border-border/70 bg-background px-4 py-3 text-left text-sm font-medium text-foreground transition-colors hover:bg-muted/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
								:aria-expanded="showAdvancedDetails"
								aria-controls="assessment-advanced-details"
								@click="showAdvancedDetails = !showAdvancedDetails"
							>
									<span>Optional details</span>
								<ChevronDown
									class="h-4 w-4 transition-transform duration-200"
									:class="showAdvancedDetails ? 'rotate-180' : ''"
									aria-hidden="true"
								/>
							</button>

							<div
								v-if="showAdvancedDetails"
								id="assessment-advanced-details"
								class="space-y-4 rounded-2xl border border-border/70 bg-background px-4 py-4"
							>
								<div class="grid gap-4 sm:grid-cols-2">
									<div class="space-y-2">
										<Label for="batch_id" class="text-sm font-semibold">
											Batch Group
										</Label>
										<Input
											id="batch_id"
											v-model="formData.batch_id"
											placeholder="e.g. BATCH_A"
											class="h-11"
										/>
									</div>

									<div class="space-y-2">
										<Label for="clusters" class="text-sm font-semibold">
											Cluster
										</Label>
										<Input
											id="clusters"
											v-model="formData.clusters"
											placeholder="e.g. c1"
											class="h-11"
										/>
									</div>
								</div>

								<div class="space-y-2">
									<Label for="order_number" class="text-sm font-semibold">
										Order Number
									</Label>
									<Input
										id="order_number"
										type="number"
										:min="1"
										v-model.number="formData.order_number"
										placeholder="e.g. 1"
										class="h-11"
									/>
								</div>
							</div>
						</section>
					</div>
				</div>

				<div class="border-t bg-background px-6 py-4">
					<DialogFooter class="flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
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
							:disabled="isSaving || isGeneratingQuestionId"
							id="tour-edit-save-btn"
						>
							<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
							{{ isSaving ? "Saving..." : isEditing ? "Save Changes" : "Create Question" }}
						</Button>
					</DialogFooter>
				</div>
			</form>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { computed, reactive, ref, watch } from "vue";
import { ChevronDown, Loader2 } from "lucide-vue-next";
import { useDebounceFn } from "@vueuse/core";
import { useSupabase } from "@/composables/useSupabase";
import { generateQuestionId } from "@/utils/questionIdGenerator";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import AsyncSearchSelect from "@/components/admin/AsyncSearchSelect.vue";

interface Assessment {
	id?: string;
	question_text: string;
	question_id: string;
	sub_category_id: string;
	response_type: string;
	scale_min?: number | null;
	scale_max?: number | null;
	scale_label_1?: string | null;
	scale_label_2?: string | null;
	scale_label_3?: string | null;
	scale_label_4?: string | null;
	batch_id?: string | null;
	clusters?: string | null;
	order_number?: number | null;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

const props = defineProps<{
	isOpen: boolean;
	item: Assessment | null;
	isParentLoading?: boolean;
}>();

const emit = defineEmits<{
	close: [];
	save: [data: Assessment];
}>();

const { supabase } = useSupabase();

const getInitialState = (): Assessment => ({
	question_text: "",
	question_id: "",
	sub_category_id: "",
	response_type: "",
	scale_min: 1,
	scale_max: 4,
	scale_label_1: "Not at all",
	scale_label_2: "A little",
	scale_label_3: "Quite a bit",
	scale_label_4: "Very much",
	batch_id: null,
	clusters: null,
	order_number: null,
	is_active: true,
});

const formData = reactive<Assessment>(getInitialState());
const isSaving = ref(false);
const isGeneratingQuestionId = ref(false);
const questionIdError = ref("");
const questionIdRequestId = ref(0);
const hasSubmitted = ref(false);
const showAdvancedDetails = ref(false);
const initialFormSnapshot = ref("");

const fieldTouched = reactive({
	question_text: false,
	response_type: false,
	sub_category_id: false,
});

const isEditing = computed(() => !!props.item);
const questionTextTrimmed = computed(() => formData.question_text.trim());

const showQuestionTextFeedback = computed(
	() => hasSubmitted.value || fieldTouched.question_text,
);
const showResponseTypeFeedback = computed(
	() => hasSubmitted.value || fieldTouched.response_type,
);
const showSubCategoryFeedback = computed(
	() => hasSubmitted.value || fieldTouched.sub_category_id,
);

const questionTextError = computed(() => {
	if (!showQuestionTextFeedback.value) {
		return "";
	}

	if (!questionTextTrimmed.value) {
		return "Question text is required.";
	}

	return "";
});

const responseTypeError = computed(() => {
	if (!showResponseTypeFeedback.value) {
		return "";
	}

	if (!formData.response_type) {
		return "Choose how users will respond.";
	}

	return "";
});

const subCategoryError = computed(() => {
	if (!showSubCategoryFeedback.value) {
		return "";
	}

	if (!formData.sub_category_id) {
		return "Choose a subcategory.";
	}

	return "";
});

const questionIdHelperText = computed(() => {
	if (isGeneratingQuestionId.value) {
		return "Generating question ID...";
	}

	if (formData.question_id) {
		return isEditing.value
			? "Question ID stays the same while you edit."
			: "Question ID is generated automatically.";
	}

	return isEditing.value
		? "Question ID is preserved for this question."
		: "Question ID will be generated automatically.";
});

const createFormSnapshot = () =>
	JSON.stringify({
		question_text: formData.question_text || "",
		question_id: formData.question_id || "",
		sub_category_id: formData.sub_category_id || "",
		response_type: formData.response_type || "",
		scale_min: formData.scale_min ?? null,
		scale_max: formData.scale_max ?? null,
		scale_label_1: formData.scale_label_1 ?? null,
		scale_label_2: formData.scale_label_2 ?? null,
		scale_label_3: formData.scale_label_3 ?? null,
		scale_label_4: formData.scale_label_4 ?? null,
		batch_id: formData.batch_id ?? null,
		clusters: formData.clusters ?? null,
		order_number: formData.order_number ?? null,
		is_active: formData.is_active ?? true,
		showAdvancedDetails: showAdvancedDetails.value,
	});

const hasUnsavedChanges = computed(
	() => createFormSnapshot() !== initialFormSnapshot.value,
);

const resetFieldState = () => {
	hasSubmitted.value = false;
	questionIdError.value = "";
	isGeneratingQuestionId.value = false;
	showAdvancedDetails.value = false;
	questionIdRequestId.value += 1;
	fieldTouched.question_text = false;
	fieldTouched.response_type = false;
	fieldTouched.sub_category_id = false;
};

const resetForm = () => {
	Object.assign(formData, getInitialState());
	resetFieldState();
};

const applyScaleDefaults = () => {
	formData.scale_min = 1;
	formData.scale_max = 4;

	if (!formData.scale_label_1) formData.scale_label_1 = "Not at all";
	if (!formData.scale_label_2) formData.scale_label_2 = "A little";
	if (!formData.scale_label_3) formData.scale_label_3 = "Quite a bit";
	if (!formData.scale_label_4) formData.scale_label_4 = "Very much";
};

const clearScaleLabels = () => {
	formData.scale_label_1 = null;
	formData.scale_label_2 = null;
	formData.scale_label_3 = null;
	formData.scale_label_4 = null;
};

const getScaleLabel = (index: number) => {
	switch (index) {
		case 1:
			return formData.scale_label_1 ?? "";
		case 2:
			return formData.scale_label_2 ?? "";
		case 3:
			return formData.scale_label_3 ?? "";
		case 4:
			return formData.scale_label_4 ?? "";
		default:
			return "";
	}
};

const setScaleLabel = (index: number, value: unknown) => {
	const normalized = typeof value === "string" ? value : String(value ?? "");

	switch (index) {
		case 1:
			formData.scale_label_1 = normalized;
			break;
		case 2:
			formData.scale_label_2 = normalized;
			break;
		case 3:
			formData.scale_label_3 = normalized;
			break;
		case 4:
			formData.scale_label_4 = normalized;
			break;
	}
};

const populateForm = () => {
	resetForm();

	if (props.item) {
		Object.assign(formData, {
			...getInitialState(),
			...props.item,
		});
	}

	if (formData.response_type === "scale") {
		applyScaleDefaults();
	}

	initialFormSnapshot.value = createFormSnapshot();
};

const closeModal = (force = false) => {
	if (isSaving.value && !force) {
		return;
	}

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
};

const handleOpenChange = (open: boolean) => {
	if (!open) {
		closeModal();
	}
};

const handleQuestionTextBlur = async () => {
	fieldTouched.question_text = true;

	if (isEditing.value) {
		return;
	}

	if (questionTextTrimmed.value && !formData.question_id) {
		await ensureQuestionId();
	}
};

const handleResponseTypeChange = (value: string) => {
	formData.response_type = value;
	fieldTouched.response_type = true;

	if (value === "scale") {
		applyScaleDefaults();
	} else {
		clearScaleLabels();
	}
};

const handleSubCategoryChange = (value: string) => {
	formData.sub_category_id = value;
	fieldTouched.sub_category_id = true;
};

const getPlaceholder = (index: number) => {
	const placeholders = ["Not at all", "A little", "Quite a bit", "Very much"];
	return placeholders[index - 1] || "";
};

const ensureQuestionId = async () => {
	if (!questionTextTrimmed.value) {
		return false;
	}

	const requestId = ++questionIdRequestId.value;
	isGeneratingQuestionId.value = true;
	questionIdError.value = "";

	try {
		const id = await generateQuestionId(supabase, questionTextTrimmed.value);

		if (requestId !== questionIdRequestId.value) {
			return false;
		}

		formData.question_id = id;
		return true;
	} catch (error) {
		if (requestId === questionIdRequestId.value) {
			questionIdError.value =
				"Question ID could not be generated. Please try again.";
		}
		return false;
	} finally {
		if (requestId === questionIdRequestId.value) {
			isGeneratingQuestionId.value = false;
		}
	}
};

const debouncedGenerateQuestionId = useDebounceFn(async () => {
	if (isEditing.value || !questionTextTrimmed.value) {
		return;
	}

	if (!formData.question_id) {
		await ensureQuestionId();
	}
}, 400);

watch(
	() => props.isOpen,
	(isOpen) => {
		if (isOpen) {
			populateForm();
		} else {
			resetForm();
		}
	},
);

watch(
	() => props.item,
	() => {
		if (props.isOpen) {
			populateForm();
		}
	},
);

watch(
	() => formData.question_text,
	(newValue, oldValue) => {
		if (isEditing.value) {
			return;
		}

		if (newValue !== oldValue) {
			formData.question_id = "";
			questionIdError.value = "";
		}

		if (questionTextTrimmed.value) {
			debouncedGenerateQuestionId();
		}
	},
);

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.question_text = true;
	fieldTouched.response_type = true;
	fieldTouched.sub_category_id = true;

	if (questionTextError.value || responseTypeError.value || subCategoryError.value) {
		return;
	}

	if (!formData.question_id) {
		const generated = await ensureQuestionId();
		if (!generated || !formData.question_id) {
			return;
		}
	}

	if (formData.response_type === "scale") {
		applyScaleDefaults();
	}

	isSaving.value = true;

	try {
		emit("save", { ...formData });
		closeModal(true);
	} finally {
		isSaving.value = false;
	}
};
</script>
