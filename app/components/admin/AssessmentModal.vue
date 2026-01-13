<template>
	<Dialog :open="isOpen" @update:open="handleOpenChange">
		<DialogContent
			class="w-[75vw] sm:max-w-none max-h-[90vh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-4 border-b bg-background z-10">
				<DialogHeader>
					<DialogTitle class="text-xl">
						{{ isEditing ? "Edit" : "Create" }} Assessment Question
					</DialogTitle>
					<DialogDescription>
						Configure the question content and its classification settings.
					</DialogDescription>
				</DialogHeader>
			</div>

			<form @submit.prevent="saveItem" class="flex-1 flex flex-col min-h-0">
				<div class="flex-1 overflow-y-auto bg-muted/10">
					<div class="p-6">
						<div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
							<div class="lg:col-span-8 flex flex-col gap-6">
								<div
									class="bg-background border rounded-lg p-4 shadow-sm space-y-4"
								>
									<div>
										<FormFieldLabel
											field-key="question_text"
											label="Question Text"
											:required="true"
											hint-title="User-Facing Content"
											description="This is the exact question text users will see in the app. Keep it clear, concise, and trauma-informed."
										/>
										<Textarea
											id="question_text"
											v-model="formData.question_text"
											rows="3"
											placeholder="e.g., Over the last 2 weeks, how often have you been bothered by feeling nervous?"
											required
											class="mt-2 text-base resize-none"
										/>
									</div>
								</div>

								<div
									class="bg-background border rounded-lg p-4 shadow-sm space-y-4"
								>
									<div class="flex items-center justify-between">
										<h3 class="text-sm font-semibold text-foreground">
											Response Configuration
										</h3>
									</div>

									<div>
										<FormFieldLabel
											field-key="response_type"
											label="Response Type"
											:required="true"
											hint-title="Data Structure"
											description="Scale: Users choose from 1-4. Free Text: Users type their own response. Choose based on how you plan to analyze the data."
										/>
										<select
											id="response_type"
											v-model="formData.response_type"
											required
											class="mt-1 flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus:ring-2 focus:ring-ring focus:ring-offset-2"
										>
											<option value="" disabled>Select Type...</option>
											<option value="scale">Scale (1-4 Rating)</option>
											<option value="text">Free Text</option>
										</select>
									</div>

									<template v-if="formData.response_type === 'scale'">
										<div class="mt-4 pt-4 border-t">
											<div class="grid grid-cols-2 gap-4 mb-4">
												<div class="bg-muted/30 p-3 rounded-md">
													<span
														class="text-xs font-medium text-muted-foreground uppercase tracking-wider"
														>Min Value</span
													>
													<div class="text-lg font-bold">1</div>
												</div>
												<div class="bg-muted/30 p-3 rounded-md">
													<span
														class="text-xs font-medium text-muted-foreground uppercase tracking-wider"
														>Max Value</span
													>
													<div class="text-lg font-bold">4</div>
												</div>
											</div>

											<div class="space-y-3">
												<h4 class="text-xs font-medium text-muted-foreground">
													Define Scale Labels
												</h4>
												<div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
													<div v-for="i in 4" :key="i" class="relative">
														<div
															class="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 rounded-full bg-primary/10 text-primary flex items-center justify-center text-xs font-bold"
														>
															{{ i }}
														</div>
														<Input
															:id="`scale_label_${i}`"
															:model-value="(formData[`scale_label_${i}` as keyof Assessment] as string) ?? undefined"
															@update:model-value="(v) => ((formData as any)[`scale_label_${i}`] = v)"
															:placeholder="getPlaceholder(i)"
															class="pl-10"
														/>
													</div>
												</div>
											</div>
										</div>
									</template>

									<div
										v-if="formData.response_type === 'text'"
										class="mt-4 pt-4 border-t text-sm text-muted-foreground italic flex items-center gap-2"
									>
										<CheckCircle class="h-4 w-4" />
										User will be provided a text box. No further configuration
										needed.
									</div>
								</div>
							</div>

							<div class="lg:col-span-4 flex flex-col gap-4">
								<div
									class="bg-background border rounded-lg p-4 shadow-sm space-y-4 h-full"
								>
									<h3
										class="text-sm font-semibold text-foreground border-b pb-2 mb-2"
									>
										Metadata
									</h3>

									<div>
										<FormFieldLabel
											field-key="question_id"
											label="Question ID"
											:required="true"
										/>
										<div class="mt-1 relative">
											<Input
												id="question_id"
												v-model="formData.question_id"
												placeholder="Auto-generated..."
												readonly
												class="bg-muted text-muted-foreground text-xs font-mono"
											/>
											<div
												v-if="isGeneratingQuestionId"
												class="absolute right-3 top-2"
											>
												<Loader2 class="h-4 w-4 animate-spin text-primary" />
											</div>
										</div>
										<p class="text-[10px] text-muted-foreground mt-1">
											Generated from Question Text
										</p>
									</div>

									<div>
										<FormFieldLabel
											field-key="sub_category_id"
											label="Subcategory"
											:required="true"
											hint-title="Classification"
											description="Link this question to a specific mental health category for scoring and reporting."
										/>
										<AsyncSearchSelect
											id="sub_category_id"
											v-model="formData.sub_category_id"
											table-name="problems"
											:search-fields="['problem_name', 'sub_category_id']"
											value-field="sub_category_id"
											:display-fields="['problem_name']"
											placeholder="Select Category..."
											class="mt-1"
										/>
									</div>

									<div>
										<FormFieldLabel field-key="batch_id" label="Batch Group" />
										<Input
											id="batch_id"
											:model-value="formData.batch_id ?? undefined"
											@update:model-value="(v) => (formData.batch_id = v as string)"
											placeholder="e.g. BATCH_A"
											class="mt-1"
										/>
									</div>

									<div>
										<FormFieldLabel field-key="clusters" label="Cluster" />
										<Input
											id="clusters"
											:model-value="formData.clusters ?? undefined"
											@update:model-value="(v) => (formData.clusters = v as string)"
											placeholder="e.g. c1"
											class="mt-1"
										/>
									</div>

									<div>
										<FormFieldLabel
											field-key="order_number"
											label="Order Number"
										/>
										<Input
											id="order_number"
											type="number"
											:model-value="formData.order_number ?? undefined"
											@update:model-value="
												(v) => (formData.order_number = v ? Number(v) : null)
											"
											placeholder="e.g. 1"
											class="mt-1"
										/>
									</div>
								</div>
							</div>
						</div>

						<Alert
							v-if="validationErrors.length > 0"
							variant="destructive"
							class="mt-6"
						>
							<AlertCircle class="h-4 w-4" />
							<AlertTitle>Please check the following:</AlertTitle>
							<AlertDescription>
								<ul class="list-disc pl-5 text-xs space-y-1 mt-1">
									<li v-for="error in validationErrors" :key="error">
										{{ error }}
									</li>
								</ul>
							</AlertDescription>
						</Alert>
					</div>
				</div>

				<div class="px-6 py-4 border-t bg-background">
					<DialogFooter class="flex-col sm:flex-row gap-2 sm:justify-end">
						<Button
							type="button"
							variant="ghost"
							@click="handleOpenChange(false)"
							:disabled="isSaving"
						>
							Cancel
						</Button>
						<Button
							type="submit"
							class="min-w-[120px]"
							:disabled="isSaving || isGeneratingQuestionId"
						>
							<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
							{{
								isSaving
									? "Saving..."
									: isEditing
									? "Save Changes"
									: "Create Question"
							}}
						</Button>
					</DialogFooter>
				</div>
			</form>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
// ... Exact same script logic as before ...
// Just copy the script block from the previous answer
import { ref, computed, watch, reactive } from "vue";
import { useDebounceFn } from "@vueuse/core";
import { AlertCircle, Loader2, CheckCircle } from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";
import { useToast } from "@/components/ui/toast/use-toast";
import { generateQuestionId } from "@/utils/questionIdGenerator";

// Components imports
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Switch } from "@/components/ui/switch";
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
import AsyncSearchSelect from "@/components/admin/AsyncSearchSelect.vue";

// Types
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
	scale_label_1: null,
	scale_label_2: null,
	scale_label_3: null,
	scale_label_4: null,
	batch_id: null,
	clusters: null,
	order_number: null,
	is_active: true,
});

const formData = reactive<Assessment>(getInitialState());
const isSaving = ref(false);
const validationErrors = ref<string[]>([]);
const isGeneratingQuestionId = ref(false);

const isEditing = computed(() => !!props.item);

const getPlaceholder = (i: number) => {
	const examples = ["Not at all", "A little", "Quite a bit", "Very much"];
	return `e.g., ${examples[i - 1]}`;
};

const handleOpenChange = (open: boolean) => {
	if (!open && !isSaving.value) {
		Object.assign(formData, getInitialState());
		validationErrors.value = [];
		emit("close");
	}
};

watch(
	() => props.isOpen,
	(isOpen) => {
		if (isOpen) {
			validationErrors.value = [];
			if (props.item) {
				Object.assign(formData, { ...props.item });
			} else {
				Object.assign(formData, getInitialState());
			}
		}
	}
);

const debouncedGenerateId = useDebounceFn(async (text: string) => {
	if (isEditing.value || !text) return;

	isGeneratingQuestionId.value = true;
	try {
		const id = await generateQuestionId(supabase, text);
		if (formData.question_text === text) {
			formData.question_id = id;
		}
	} catch (e) {
		console.error(e);
	} finally {
		isGeneratingQuestionId.value = false;
	}
}, 500);

watch(
	() => formData.question_text,
	(newText) => {
		if (!isEditing.value) {
			formData.question_id = "";
			debouncedGenerateId(newText);
		}
	}
);

const saveItem = async () => {
	validationErrors.value = [];
	if (!formData.question_text)
		validationErrors.value.push("Question text is required");
	if (!formData.sub_category_id)
		validationErrors.value.push("Subcategory is required");
	if (!formData.question_id)
		validationErrors.value.push("Question ID is generating or missing");

	if (validationErrors.value.length > 0) return;

	isSaving.value = true;

	try {
		emit("save", { ...formData });
		handleOpenChange(false);
	} catch (error) {
		console.error("Save error:", error);
	} finally {
		isSaving.value = false;
	}
};
</script>
