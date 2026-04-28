<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[92vw] sm:max-w-2xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-5 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit Detection Category" : "Create Detection Category" }}
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the detection type, definition, and linked tier/response/workflow."
								: "Add a new detection category to the safety framework."
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

							<!-- Code + Status row -->
							<div class="grid grid-cols-2 gap-4">
								<div>
									<FormFieldLabel field-key="code" label="Code" :required="true" />
									<Input
										id="code"
										v-model="formData.code"
										placeholder="e.g. D001"
										required
										class="mt-1 font-mono"
										:disabled="isEditing"
										@blur="fieldTouched.code = true"
									/>
									<p class="mt-1 text-xs text-muted-foreground">
										{{ isEditing ? "Code cannot be changed after creation." : "Auto-generated if left blank." }}
									</p>
									<p
										v-if="codeErrorText"
										class="mt-1 text-sm leading-6 text-destructive"
										aria-live="polite"
									>
										{{ codeErrorText }}
									</p>
								</div>

								<div>
									<FormFieldLabel field-key="status" label="Status" :required="true" />
									<select
										id="status"
										v-model="formData.status"
										required
										class="mt-1 flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
										@blur="fieldTouched.status = true"
									>
										<option value="" disabled>Select status…</option>
										<option value="Existing">Existing</option>
										<option value="Added">Added</option>
									</select>
									<p
										v-if="statusErrorText"
										class="mt-1 text-sm leading-6 text-destructive"
										aria-live="polite"
									>
										{{ statusErrorText }}
									</p>
								</div>
							</div>

							<!-- Detection Type -->
							<div>
								<FormFieldLabel
									field-key="detection_type"
									label="Detection Type"
									:required="true"
								/>
								<Input
									id="detection_type"
									v-model="formData.detection_type"
									placeholder="e.g. Emotional distress"
									required
									class="mt-1"
									@blur="fieldTouched.detection_type = true"
								/>
								<p
									v-if="detectionTypeErrorText"
									class="mt-1 text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ detectionTypeErrorText }}
								</p>
							</div>

							<!-- Definition -->
							<div>
								<FormFieldLabel
									field-key="definition"
									label="Definition"
									:required="true"
								/>
								<Textarea
									id="definition"
									v-model="formData.definition"
									rows="3"
									placeholder="Full description of what this detection category covers."
									required
									class="mt-1"
									@blur="fieldTouched.definition = true"
								/>
								<p
									v-if="definitionErrorText"
									class="mt-1 text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ definitionErrorText }}
								</p>
							</div>

							<!-- Typical Trigger Examples -->
							<div>
								<FormFieldLabel
									field-key="typical_trigger_examples"
									label="Typical Trigger Examples"
									:required="false"
								/>
								<Textarea
									id="typical_trigger_examples"
									v-model="formData.typical_trigger_examples"
									rows="3"
									placeholder="Example phrases or behaviours, e.g. 'I want to die', 'I&#39;m thinking about suicide'."
									class="mt-1"
								/>
							</div>

							<!-- Default Tier + Linked Response + Linked Workflow row -->
							<div class="grid grid-cols-3 gap-4">
								<div>
									<FormFieldLabel
										field-key="default_tier"
										label="Default Tier"
										:required="false"
									/>
									<Input
										id="default_tier"
										v-model="formData.default_tier"
										placeholder="e.g. Tier 1"
										class="mt-1"
									/>
								</div>

								<div>
									<FormFieldLabel
										field-key="linked_response"
										label="Linked Response"
										:required="false"
									/>
									<Input
										id="linked_response"
										v-model="formData.linked_response"
										placeholder="e.g. R001"
										class="mt-1 font-mono"
									/>
								</div>

								<div>
									<FormFieldLabel
										field-key="linked_workflow"
										label="Linked Workflow"
										:required="false"
									/>
									<Input
										id="linked_workflow"
										v-model="formData.linked_workflow"
										placeholder="e.g. W001"
										class="mt-1 font-mono"
									/>
								</div>
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
							{{ isSaving ? "Saving..." : isEditing ? "Save Changes" : "Create Category" }}
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

interface DetectionCategory {
	id?: string;
	code?: string;
	status: string;
	detection_type: string;
	definition: string;
	typical_trigger_examples: string;
	default_tier: string;
	linked_response: string;
	linked_workflow: string;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

// ─── Props / Emits ────────────────────────────────────────────────────────────

const props = defineProps<{
	isOpen: boolean;
	item: DetectionCategory | null;
}>();

const emit = defineEmits<{
	close: [];
	save: [data: Partial<DetectionCategory>];
}>();

// ─── Composables ──────────────────────────────────────────────────────────────

const { supabase } = useSupabase();
const { toast } = useToast();

// ─── State ────────────────────────────────────────────────────────────────────

const isSaving = ref(false);
const hasSubmitted = ref(false);
const initialFormSnapshot = ref("");

const fieldTouched = reactive({
	code: false,
	status: false,
	detection_type: false,
	definition: false,
});

const formData = reactive<DetectionCategory>({
	code: "",
	status: "",
	detection_type: "",
	definition: "",
	typical_trigger_examples: "",
	default_tier: "",
	linked_response: "",
	linked_workflow: "",
	is_active: true,
});

// ─── Computed ─────────────────────────────────────────────────────────────────

const isEditing = computed(() => !!props.item);

const showCodeFeedback = computed(() => hasSubmitted.value || fieldTouched.code);
const showStatusFeedback = computed(() => hasSubmitted.value || fieldTouched.status);
const showTypeFeedback = computed(() => hasSubmitted.value || fieldTouched.detection_type);
const showDefinitionFeedback = computed(() => hasSubmitted.value || fieldTouched.definition);

const codeErrorText = computed(() => {
	if (!showCodeFeedback.value || isEditing.value) return "";
	if (!formData.code?.trim()) return ""; // auto-generated, not required from user
	const valid = /^D\d{3,}$/i.test(formData.code.trim());
	if (!valid) return "Code must follow the format D001, D002, etc.";
	return "";
});

const statusErrorText = computed(() => {
	if (!showStatusFeedback.value) return "";
	if (!formData.status) return "Status is required.";
	return "";
});

const detectionTypeErrorText = computed(() => {
	if (!showTypeFeedback.value) return "";
	if (!formData.detection_type.trim()) return "Detection type is required.";
	return "";
});

const definitionErrorText = computed(() => {
	if (!showDefinitionFeedback.value) return "";
	if (!formData.definition.trim()) return "Definition is required.";
	return "";
});

const createFormSnapshot = () =>
	JSON.stringify({
		code: formData.code,
		status: formData.status,
		detection_type: formData.detection_type,
		definition: formData.definition,
		typical_trigger_examples: formData.typical_trigger_examples,
		default_tier: formData.default_tier,
		linked_response: formData.linked_response,
		linked_workflow: formData.linked_workflow,
		is_active: formData.is_active,
	});

const hasUnsavedChanges = computed(
	() => createFormSnapshot() !== initialFormSnapshot.value,
);

// ─── Methods ──────────────────────────────────────────────────────────────────

const resetForm = () => {
	formData.code = "";
	formData.status = "";
	formData.detection_type = "";
	formData.definition = "";
	formData.typical_trigger_examples = "";
	formData.default_tier = "";
	formData.linked_response = "";
	formData.linked_workflow = "";
	formData.is_active = true;
	hasSubmitted.value = false;
	fieldTouched.code = false;
	fieldTouched.status = false;
	fieldTouched.detection_type = false;
	fieldTouched.definition = false;
	isSaving.value = false;
};

const initializeForm = () => {
	isSaving.value = false;
	hasSubmitted.value = false;
	fieldTouched.code = false;
	fieldTouched.status = false;
	fieldTouched.detection_type = false;
	fieldTouched.definition = false;

	if (props.item) {
		formData.code = props.item.code || "";
		formData.status = props.item.status || "";
		formData.detection_type = props.item.detection_type || "";
		formData.definition = props.item.definition || "";
		formData.typical_trigger_examples = props.item.typical_trigger_examples || "";
		formData.default_tier = props.item.default_tier || "";
		formData.linked_response = props.item.linked_response || "";
		formData.linked_workflow = props.item.linked_workflow || "";
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

/** Generate next code like D016 based on existing max */
const generateCode = async (): Promise<string> => {
	const { data, error } = await supabase
		.from("detection_categories")
		.select("code")
		.order("code", { ascending: false })
		.limit(1);

	if (error) throw error;

	if (!data || data.length === 0) return "D001";

	const last = data[0].code as string;
	const match = last.match(/^D(\d+)$/i);
	if (!match) return "D001";

	const next = parseInt(match[1], 10) + 1;
	return `D${String(next).padStart(3, "0")}`;
};

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.status = true;
	fieldTouched.detection_type = true;
	fieldTouched.definition = true;

	if (statusErrorText.value || detectionTypeErrorText.value || definitionErrorText.value) {
		return;
	}

	// Validate manually-entered code format if provided
	if (!isEditing.value && formData.code?.trim() && codeErrorText.value) {
		return;
	}

	isSaving.value = true;

	try {
		const payload: Partial<DetectionCategory> = {
			status: formData.status,
			detection_type: formData.detection_type.trim(),
			definition: formData.definition.trim(),
			typical_trigger_examples: formData.typical_trigger_examples.trim() || null as any,
			default_tier: formData.default_tier.trim() || null as any,
			linked_response: formData.linked_response.trim() || null as any,
			linked_workflow: formData.linked_workflow.trim() || null as any,
			is_active: formData.is_active,
		};

		if (isEditing.value && props.item?.id) {
			const { error } = await supabase
				.from("detection_categories")
				.update(payload)
				.eq("id", props.item.id);

			if (error) throw error;

			toast({
				title: "Detection category updated",
				description: `${props.item.code} — ${payload.detection_type} has been saved.`,
			});
		} else {
			const code = formData.code?.trim() || await generateCode();
			const { error } = await supabase
				.from("detection_categories")
				.insert({ ...payload, code });

			if (error) throw error;

			toast({
				title: "Detection category created",
				description: `${code} — ${payload.detection_type} has been added.`,
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
		if (props.isOpen) {
			initializeForm();
		}
	},
	{ deep: true },
);
</script>
