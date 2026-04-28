<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[92vw] sm:max-w-2xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-5 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit Response Type" : "Create Response Type" }}
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the response type definition, tone, and guidance."
								: "Add a new response type to the safety framework."
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

							<!-- Response ID + Response Type row -->
							<div class="grid grid-cols-3 gap-4">
								<div>
									<FormFieldLabel field-key="response_id" label="Response ID" :required="true" />
									<Input
										id="response_id"
										v-model="formData.response_id"
										placeholder="e.g. R001"
										class="mt-1 font-mono"
										:disabled="isEditing"
										@blur="fieldTouched.response_id = true"
									/>
									<p class="mt-1 text-xs text-muted-foreground">
										{{ isEditing ? "ID cannot be changed." : "Auto-generated if left blank." }}
									</p>
									<p
										v-if="responseIdErrorText"
										class="mt-1 text-sm leading-6 text-destructive"
										aria-live="polite"
									>
										{{ responseIdErrorText }}
									</p>
								</div>

								<div class="col-span-2">
									<FormFieldLabel
										field-key="response_type"
										label="Response Type"
										:required="true"
									/>
									<Input
										id="response_type"
										v-model="formData.response_type"
										placeholder="e.g. Emotional Support Response"
										required
										class="mt-1"
										@blur="fieldTouched.response_type = true"
									/>
									<p
										v-if="responseTypeErrorText"
										class="mt-1 text-sm leading-6 text-destructive"
										aria-live="polite"
									>
										{{ responseTypeErrorText }}
									</p>
								</div>
							</div>

							<!-- When Used -->
							<div>
								<FormFieldLabel
									field-key="when_used"
									label="When Used"
									:required="false"
								/>
								<Input
									id="when_used"
									v-model="formData.when_used"
									placeholder="e.g. Tier 1 distress without suicide/violence content"
									class="mt-1"
								/>
							</div>

							<!-- Required Elements -->
							<div>
								<FormFieldLabel
									field-key="required_elements"
									label="Required Elements"
									:required="false"
								/>
								<Textarea
									id="required_elements"
									v-model="formData.required_elements"
									rows="3"
									placeholder="Actions and elements that must be included in this response."
									class="mt-1"
								/>
							</div>

							<!-- Tone -->
							<div>
								<FormFieldLabel
									field-key="tone"
									label="Tone"
									:required="false"
								/>
								<Input
									id="tone"
									v-model="formData.tone"
									placeholder="e.g. Gentle, warm, non-clinical, non-judgmental."
									class="mt-1"
								/>
							</div>

							<!-- Example Opener -->
							<div>
								<FormFieldLabel
									field-key="example_opener"
									label="Example Opener"
									:required="false"
								/>
								<Textarea
									id="example_opener"
									v-model="formData.example_opener"
									rows="3"
									placeholder="An example opening phrase for this response type."
									class="mt-1"
								/>
							</div>

							<!-- Avoid -->
							<div>
								<FormFieldLabel
									field-key="avoid"
									label="Avoid"
									:required="false"
								/>
								<Textarea
									id="avoid"
									v-model="formData.avoid"
									rows="2"
									placeholder="Things to avoid when using this response type."
									class="mt-1"
								/>
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
							:disabled="isSaving"
						>
							<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
							{{ isSaving ? "Saving..." : isEditing ? "Save Changes" : "Create Response Type" }}
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
import { useToast } from "@/components/ui/toast/use-toast";

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

// ─── Types ────────────────────────────────────────────────────────────────────

interface ResponseType {
	id?: string;
	response_id?: string;
	response_type: string;
	when_used: string;
	required_elements: string;
	tone: string;
	example_opener: string;
	avoid: string;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

// ─── Props / Emits ────────────────────────────────────────────────────────────

const props = defineProps<{
	isOpen: boolean;
	item: ResponseType | null;
}>();

const emit = defineEmits<{
	close: [];
	save: [data: Partial<ResponseType>];
}>();

// ─── Composables ──────────────────────────────────────────────────────────────

const { supabase } = useSupabase();
const { toast } = useToast();

// ─── State ────────────────────────────────────────────────────────────────────

const isSaving = ref(false);
const hasSubmitted = ref(false);
const initialFormSnapshot = ref("");

const fieldTouched = reactive({
	response_id: false,
	response_type: false,
});

const formData = reactive<ResponseType>({
	response_id: "",
	response_type: "",
	when_used: "",
	required_elements: "",
	tone: "",
	example_opener: "",
	avoid: "",
	is_active: true,
});

// ─── Computed ─────────────────────────────────────────────────────────────────

const isEditing = computed(() => !!props.item);

const showIdFeedback = computed(() => hasSubmitted.value || fieldTouched.response_id);
const showTypeFeedback = computed(() => hasSubmitted.value || fieldTouched.response_type);

const responseIdErrorText = computed(() => {
	if (!showIdFeedback.value || isEditing.value) return "";
	if (!formData.response_id?.trim()) return ""; // auto-generated
	const valid = /^R\d{3,}$/i.test(formData.response_id.trim());
	if (!valid) return "ID must follow the format R001, R002, etc.";
	return "";
});

const responseTypeErrorText = computed(() => {
	if (!showTypeFeedback.value) return "";
	if (!formData.response_type.trim()) return "Response type name is required.";
	return "";
});

const createFormSnapshot = () =>
	JSON.stringify({
		response_id: formData.response_id,
		response_type: formData.response_type,
		when_used: formData.when_used,
		required_elements: formData.required_elements,
		tone: formData.tone,
		example_opener: formData.example_opener,
		avoid: formData.avoid,
		is_active: formData.is_active,
	});

const hasUnsavedChanges = computed(
	() => createFormSnapshot() !== initialFormSnapshot.value,
);

// ─── Methods ──────────────────────────────────────────────────────────────────

const resetForm = () => {
	formData.response_id = "";
	formData.response_type = "";
	formData.when_used = "";
	formData.required_elements = "";
	formData.tone = "";
	formData.example_opener = "";
	formData.avoid = "";
	formData.is_active = true;
	hasSubmitted.value = false;
	fieldTouched.response_id = false;
	fieldTouched.response_type = false;
	isSaving.value = false;
};

const initializeForm = () => {
	isSaving.value = false;
	hasSubmitted.value = false;
	fieldTouched.response_id = false;
	fieldTouched.response_type = false;

	if (props.item) {
		formData.response_id = props.item.response_id || "";
		formData.response_type = props.item.response_type || "";
		formData.when_used = props.item.when_used || "";
		formData.required_elements = props.item.required_elements || "";
		formData.tone = props.item.tone || "";
		formData.example_opener = props.item.example_opener || "";
		formData.avoid = props.item.avoid || "";
		formData.is_active = props.item.is_active ?? true;
	} else {
		resetForm();
	}

	initialFormSnapshot.value = createFormSnapshot();
};

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

/** Generate next response_id like R011 based on existing max */
const generateResponseId = async (): Promise<string> => {
	const { data, error } = await supabase
		.from("response_types")
		.select("response_id")
		.order("response_id", { ascending: false })
		.limit(1);

	if (error) throw error;
	if (!data || data.length === 0) return "R001";

	const last = data[0].response_id as string;
	const match = last.match(/^R(\d+)$/i);
	if (!match) return "R001";

	const next = parseInt(match[1], 10) + 1;
	return `R${String(next).padStart(3, "0")}`;
};

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.response_type = true;

	if (responseTypeErrorText.value) return;
	if (!isEditing.value && formData.response_id?.trim() && responseIdErrorText.value) return;

	isSaving.value = true;

	try {
		const payload: Partial<ResponseType> = {
			response_type: formData.response_type.trim(),
			when_used: formData.when_used.trim() || null as any,
			required_elements: formData.required_elements.trim() || null as any,
			tone: formData.tone.trim() || null as any,
			example_opener: formData.example_opener.trim() || null as any,
			avoid: formData.avoid.trim() || null as any,
			is_active: formData.is_active,
		};

		if (isEditing.value && props.item?.id) {
			const { error } = await supabase
				.from("response_types")
				.update(payload)
				.eq("id", props.item.id);

			if (error) throw error;

			toast({
				title: "Response type updated",
				description: `${props.item.response_id} — ${payload.response_type} has been saved.`,
			});
		} else {
			const response_id = formData.response_id?.trim() || await generateResponseId();
			const { error } = await supabase
				.from("response_types")
				.insert({ ...payload, response_id });

			if (error) throw error;

			toast({
				title: "Response type created",
				description: `${response_id} — ${payload.response_type} has been added.`,
			});
		}

		emit("save", payload);
		closeModal(true);
	} catch (err: any) {
		console.error("Save error:", err);
		toast({
			title: "Save failed",
			description: err?.message || "An unexpected error occurred. Please try again.",
			variant: "destructive",
		});
	} finally {
		isSaving.value = false;
	}
};

// ─── Watchers ─────────────────────────────────────────────────────────────────

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
		if (props.isOpen) initializeForm();
	},
	{ deep: true },
);
</script>
