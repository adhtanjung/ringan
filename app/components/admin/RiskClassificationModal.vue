<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[92vw] sm:max-w-2xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-5 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit Risk Classification" : "Create Risk Classification" }}
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the tier definition, indicators, and response guidance."
								: "Add a new tier to the safety framework risk classification."
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

							<!-- Tier + Framework Label row -->
							<div class="grid grid-cols-2 gap-4">
								<div>
									<FormFieldLabel field-key="tier" label="Tier" :required="true" />
									<Input
										id="tier"
										v-model.number="formData.tier"
										type="number"
										min="1"
										max="10"
										placeholder="e.g. 1"
										required
										class="mt-1"
										@blur="fieldTouched.tier = true"
									/>
									<p
										v-if="tierErrorText"
										class="mt-1 text-sm leading-6 text-destructive"
										aria-live="polite"
									>
										{{ tierErrorText }}
									</p>
								</div>

								<div>
									<FormFieldLabel
										field-key="framework_label"
										label="Framework Label"
										:required="true"
									/>
									<Input
										id="framework_label"
										v-model="formData.framework_label"
										placeholder="e.g. Emotional distress"
										required
										class="mt-1"
										@blur="fieldTouched.framework_label = true"
									/>
									<p
										v-if="labelErrorText"
										class="mt-1 text-sm leading-6 text-destructive"
										aria-live="polite"
									>
										{{ labelErrorText }}
									</p>
								</div>
							</div>

							<!-- Expanded Definition -->
							<div>
								<FormFieldLabel
									field-key="expanded_definition"
									label="Expanded Definition"
									:required="true"
								/>
								<Textarea
									id="expanded_definition"
									v-model="formData.expanded_definition"
									rows="4"
									placeholder="Full description of this risk tier, including what it covers and what it excludes."
									required
									class="mt-1"
									@blur="fieldTouched.expanded_definition = true"
								/>
								<p
									v-if="definitionErrorText"
									class="mt-1 text-sm leading-6 text-destructive"
									aria-live="polite"
								>
									{{ definitionErrorText }}
								</p>
							</div>

							<!-- Typical Indicators -->
							<div>
								<FormFieldLabel
									field-key="typical_indicators"
									label="Typical Indicators"
									:required="false"
								/>
								<Textarea
									id="typical_indicators"
									v-model="formData.typical_indicators"
									rows="3"
									placeholder='Example phrases or behaviours, e.g. "I feel empty", sleep problems, social withdrawal.'
									class="mt-1"
								/>
							</div>

							<!-- Decision Boundary -->
							<div>
								<FormFieldLabel
									field-key="decision_boundary"
									label="Decision Boundary"
									:required="false"
								/>
								<Textarea
									id="decision_boundary"
									v-model="formData.decision_boundary"
									rows="3"
									placeholder="When to use this tier vs adjacent tiers."
									class="mt-1"
								/>
							</div>

							<!-- Primary Response Goal -->
							<div>
								<FormFieldLabel
									field-key="primary_response_goal"
									label="Primary Response Goal"
									:required="false"
								/>
								<Textarea
									id="primary_response_goal"
									v-model="formData.primary_response_goal"
									rows="3"
									placeholder="What the system should aim to achieve for users at this tier."
									class="mt-1"
								/>
							</div>

							<!-- Referral Guidance -->
							<div>
								<FormFieldLabel
									field-key="referral_guidance"
									label="Referral / Handoff Guidance"
									:required="false"
								/>
								<Textarea
									id="referral_guidance"
									v-model="formData.referral_guidance"
									rows="3"
									placeholder="Who to refer to and under what conditions."
									class="mt-1"
								/>
							</div>

							<!-- Linked Response -->
							<div>
								<FormFieldLabel
									field-key="linked_response"
									label="Linked Response"
									:required="false"
								/>
								<Input
									id="linked_response"
									v-model="formData.linked_response"
									placeholder="e.g. R001 Emotional Support"
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
							{{ isSaving ? "Saving..." : isEditing ? "Save Changes" : "Create Classification" }}
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

interface RiskClassification {
	id?: string;
	classification_id?: string;
	tier: number | null;
	framework_label: string;
	expanded_definition: string;
	typical_indicators: string;
	decision_boundary: string;
	primary_response_goal: string;
	referral_guidance: string;
	linked_response: string;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

// ─── Props / Emits ────────────────────────────────────────────────────────────

const props = defineProps<{
	isOpen: boolean;
	item: RiskClassification | null;
}>();

const emit = defineEmits<{
	close: [];
	save: [data: Partial<RiskClassification>];
}>();

// ─── Composables ──────────────────────────────────────────────────────────────

const { supabase } = useSupabase();
const { toast } = useToast();

// ─── State ────────────────────────────────────────────────────────────────────

const isSaving = ref(false);
const hasSubmitted = ref(false);
const initialFormSnapshot = ref("");

const fieldTouched = reactive({
	tier: false,
	framework_label: false,
	expanded_definition: false,
});

const formData = reactive<RiskClassification>({
	tier: null,
	framework_label: "",
	expanded_definition: "",
	typical_indicators: "",
	decision_boundary: "",
	primary_response_goal: "",
	referral_guidance: "",
	linked_response: "",
	is_active: true,
});

// ─── Computed ─────────────────────────────────────────────────────────────────

const isEditing = computed(() => !!props.item);

const showTierFeedback = computed(() => hasSubmitted.value || fieldTouched.tier);
const showLabelFeedback = computed(() => hasSubmitted.value || fieldTouched.framework_label);
const showDefinitionFeedback = computed(() => hasSubmitted.value || fieldTouched.expanded_definition);

const tierErrorText = computed(() => {
	if (!showTierFeedback.value) return "";
	if (formData.tier === null || formData.tier === undefined || String(formData.tier) === "") return "Tier number is required.";
	if (formData.tier < 1 || formData.tier > 10) return "Tier must be between 1 and 10.";
	return "";
});

const labelErrorText = computed(() => {
	if (!showLabelFeedback.value) return "";
	if (!formData.framework_label.trim()) return "Framework label is required.";
	return "";
});

const definitionErrorText = computed(() => {
	if (!showDefinitionFeedback.value) return "";
	if (!formData.expanded_definition.trim()) return "Expanded definition is required.";
	return "";
});

const createFormSnapshot = () =>
	JSON.stringify({
		tier: formData.tier,
		framework_label: formData.framework_label,
		expanded_definition: formData.expanded_definition,
		typical_indicators: formData.typical_indicators,
		decision_boundary: formData.decision_boundary,
		primary_response_goal: formData.primary_response_goal,
		referral_guidance: formData.referral_guidance,
		linked_response: formData.linked_response,
		is_active: formData.is_active,
	});

const hasUnsavedChanges = computed(
	() => createFormSnapshot() !== initialFormSnapshot.value,
);

// ─── Methods ──────────────────────────────────────────────────────────────────

const resetForm = () => {
	formData.tier = null;
	formData.framework_label = "";
	formData.expanded_definition = "";
	formData.typical_indicators = "";
	formData.decision_boundary = "";
	formData.primary_response_goal = "";
	formData.referral_guidance = "";
	formData.linked_response = "";
	formData.is_active = true;
	hasSubmitted.value = false;
	fieldTouched.tier = false;
	fieldTouched.framework_label = false;
	fieldTouched.expanded_definition = false;
	isSaving.value = false;
};

const initializeForm = () => {
	isSaving.value = false;
	hasSubmitted.value = false;
	fieldTouched.tier = false;
	fieldTouched.framework_label = false;
	fieldTouched.expanded_definition = false;

	if (props.item) {
		formData.tier = props.item.tier;
		formData.framework_label = props.item.framework_label || "";
		formData.expanded_definition = props.item.expanded_definition || "";
		formData.typical_indicators = props.item.typical_indicators || "";
		formData.decision_boundary = props.item.decision_boundary || "";
		formData.primary_response_goal = props.item.primary_response_goal || "";
		formData.referral_guidance = props.item.referral_guidance || "";
		formData.linked_response = props.item.linked_response || "";
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

/** Generate a classification_id like RC005 based on existing max */
const generateClassificationId = async (): Promise<string> => {
	const { data, error } = await supabase
		.from("risk_classifications")
		.select("classification_id")
		.order("classification_id", { ascending: false })
		.limit(1);

	if (error) throw error;

	if (!data || data.length === 0) return "RC001";

	const last = data[0].classification_id as string;
	const match = last.match(/^RC(\d+)$/i);
	if (!match) return "RC001";

	const next = parseInt(match[1], 10) + 1;
	return `RC${String(next).padStart(3, "0")}`;
};

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.tier = true;
	fieldTouched.framework_label = true;
	fieldTouched.expanded_definition = true;

	if (tierErrorText.value || labelErrorText.value || definitionErrorText.value) {
		return;
	}

	isSaving.value = true;

	try {
		const payload: Partial<RiskClassification> = {
			tier: formData.tier!,
			framework_label: formData.framework_label.trim(),
			expanded_definition: formData.expanded_definition.trim(),
			typical_indicators: formData.typical_indicators.trim() || null as any,
			decision_boundary: formData.decision_boundary.trim() || null as any,
			primary_response_goal: formData.primary_response_goal.trim() || null as any,
			referral_guidance: formData.referral_guidance.trim() || null as any,
			linked_response: formData.linked_response.trim() || null as any,
			is_active: formData.is_active,
		};

		if (isEditing.value && props.item?.id) {
			// Update
			const { error } = await supabase
				.from("risk_classifications")
				.update(payload)
				.eq("id", props.item.id);

			if (error) throw error;

			toast({
				title: "Classification updated",
				description: `Tier ${payload.tier} — ${payload.framework_label} has been saved.`,
			});
		} else {
			// Create — generate classification_id
			const classification_id = await generateClassificationId();
			const { error } = await supabase
				.from("risk_classifications")
				.insert({ ...payload, classification_id });

			if (error) throw error;

			toast({
				title: "Classification created",
				description: `Tier ${payload.tier} — ${payload.framework_label} has been added.`,
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
