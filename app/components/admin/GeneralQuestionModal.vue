<template>
	<Dialog :open="isOpen" @update:open="handleOpenChange">
		<DialogContent
			class="w-[92vw] sm:max-w-2xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="border-b bg-background px-6 py-5">
				<DialogHeader class="space-y-1">
					<DialogTitle class="text-xl font-semibold">
						{{ isEditing ? "Edit" : "Create" }} General Question
					</DialogTitle>
					<DialogDescription class="text-sm leading-6">
						Define a decision-tree question that guides the AI conversation before routing to a specific problem category.
					</DialogDescription>
				</DialogHeader>
			</div>

			<form @submit.prevent="saveItem" class="flex flex-1 min-h-0 flex-col">
				<div class="flex-1 overflow-y-auto bg-muted/10">
					<div class="space-y-6 px-6 py-6">

						<!-- Question ID + Response Type -->
						<section class="grid gap-5 md:grid-cols-2">
							<div class="space-y-2">
								<Label for="question_id" class="text-sm font-semibold">
									Question ID <span class="text-destructive">*</span>
								</Label>
								<div class="relative">
									<Input
										id="question_id"
										v-model="formData.question_id"
										placeholder="e.g. Q001"
										class="h-11 font-mono"
										:disabled="isEditing"
									/>
									<span
										v-if="!isEditing"
										class="absolute right-3 top-1/2 -translate-y-1/2 text-[10px] font-semibold uppercase tracking-wide text-muted-foreground/60"
									>auto</span>
								</div>
								<p class="text-xs text-muted-foreground">
									Unique identifier used in routing logic.
								</p>
								<p v-if="errors.question_id" class="text-sm text-destructive" aria-live="polite">
									{{ errors.question_id }}
								</p>
							</div>

							<div class="space-y-2">
								<Label for="response_type" class="text-sm font-semibold">
									Response Type <span class="text-destructive">*</span>
								</Label>
								<Select
									:model-value="formData.response_type"
									@update:model-value="handleResponseTypeChange"
								>
									<SelectTrigger id="response_type" class="h-11 w-full">
										<SelectValue placeholder="Select response type" />
									</SelectTrigger>
									<SelectContent>
										<SelectItem value="yes/no">Yes / No</SelectItem>
										<SelectItem value="multiple choice">Multiple Choice</SelectItem>
										<SelectItem value="auto-route">Auto-route</SelectItem>
									</SelectContent>
								</Select>
								<p v-if="errors.response_type" class="text-sm text-destructive" aria-live="polite">
									{{ errors.response_type }}
								</p>
							</div>
						</section>

						<!-- Question Text -->
						<section class="space-y-2">
							<Label for="question_text" class="text-sm font-semibold">
								Question Text <span class="text-destructive">*</span>
							</Label>
							<Textarea
								id="question_text"
								v-model="formData.question_text"
								rows="3"
								placeholder="e.g. Do you often feel emotionally or mentally overwhelmed?"
								class="min-h-[90px] resize-y"
							/>
							<p v-if="errors.question_text" class="text-sm text-destructive" aria-live="polite">
								{{ errors.question_text }}
							</p>
						</section>

						<!-- Category -->
						<section class="space-y-2">
							<Label for="category" class="text-sm font-semibold">Category</Label>
							<Select
								:model-value="formData.category ?? ''"
								@update:model-value="(v) => (formData.category = v || null)"
							>
								<SelectTrigger id="category" class="h-11 w-full">
									<SelectValue placeholder="Select category (optional)" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="Stress">Stress</SelectItem>
									<SelectItem value="Anxiety">Anxiety</SelectItem>
									<SelectItem value="Trauma">Trauma</SelectItem>
									<SelectItem value="Depression">Depression</SelectItem>
									<SelectItem value="Grief and Loss">Grief and Loss</SelectItem>
									<SelectItem value="Addictions">Addictions</SelectItem>
								</SelectContent>
							</Select>
						</section>

						<!-- ── ROUTING SECTION ── -->

						<!-- Yes / No -->
						<section
							v-if="formData.response_type === 'yes/no'"
							class="space-y-4 rounded-2xl border border-border/70 bg-background px-4 py-4"
						>
							<div class="space-y-1">
								<h3 class="text-sm font-semibold">Routing Logic</h3>
								<p class="text-xs text-muted-foreground">Where does the conversation go based on the answer?</p>
							</div>

							<!-- Yes branch -->
							<div class="space-y-2">
								<div class="flex items-center gap-2">
									<span class="inline-flex h-5 items-center rounded-full bg-emerald-500/10 px-2 text-[11px] font-semibold text-emerald-600 ring-1 ring-inset ring-emerald-500/20">Yes</span>
									<span class="text-xs text-muted-foreground">routes to</span>
								</div>
								<div class="grid gap-3 sm:grid-cols-[160px_1fr]">
									<Select
										:model-value="formData.yes_destination_type ?? ''"
										@update:model-value="(v) => onYesDestTypeChange(v)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select type…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem value="subcategory">Subcategory</SelectItem>
											<SelectItem value="suggestion">Suggestion</SelectItem>
											<SelectItem value="question">General Question</SelectItem>
										</SelectContent>
									</Select>
									<!-- Subcategory dropdown -->
									<Select
										v-if="formData.yes_destination_type === 'subcategory'"
										:model-value="formData.yes_destination_value ?? ''"
										@update:model-value="(v) => (formData.yes_destination_value = v || null)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select subcategory…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem v-for="s in subcategories" :key="s.id" :value="s.id">
												{{ s.label }}
											</SelectItem>
										</SelectContent>
									</Select>
									<!-- Suggestion dropdown -->
									<Select
										v-else-if="formData.yes_destination_type === 'suggestion'"
										:model-value="formData.yes_destination_value ?? ''"
										@update:model-value="(v) => (formData.yes_destination_value = v || null)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select suggestion…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem v-for="s in suggestions" :key="s.id" :value="s.id">
												{{ s.label }}
											</SelectItem>
										</SelectContent>
									</Select>
									<!-- General question dropdown (filtered by category) -->
									<Select
										v-else-if="formData.yes_destination_type === 'question'"
										:model-value="formData.yes_destination_value ?? ''"
										@update:model-value="(v) => (formData.yes_destination_value = v || null)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select question…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem v-for="q in filteredQuestions" :key="q.id" :value="q.id">
												{{ q.label }}
											</SelectItem>
										</SelectContent>
									</Select>
									<!-- Fallback when no type selected -->
									<Input
										v-else
										disabled
										placeholder="Select a type first"
										class="h-10 text-sm"
									/>
								</div>
							</div>

							<!-- No branch -->
							<div class="space-y-2">
								<div class="flex items-center gap-2">
									<span class="inline-flex h-5 items-center rounded-full bg-rose-500/10 px-2 text-[11px] font-semibold text-rose-600 ring-1 ring-inset ring-rose-500/20">No</span>
									<span class="text-xs text-muted-foreground">routes to</span>
								</div>
								<div class="grid gap-3 sm:grid-cols-[160px_1fr]">
									<Select
										:model-value="formData.no_destination_type ?? ''"
										@update:model-value="(v) => onNoDestTypeChange(v)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select type…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem value="subcategory">Subcategory</SelectItem>
											<SelectItem value="suggestion">Suggestion</SelectItem>
											<SelectItem value="question">General Question</SelectItem>
										</SelectContent>
									</Select>
									<!-- Subcategory dropdown -->
									<Select
										v-if="formData.no_destination_type === 'subcategory'"
										:model-value="formData.no_destination_value ?? ''"
										@update:model-value="(v) => (formData.no_destination_value = v || null)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select subcategory…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem v-for="s in subcategories" :key="s.id" :value="s.id">
												{{ s.label }}
											</SelectItem>
										</SelectContent>
									</Select>
									<!-- Suggestion dropdown -->
									<Select
										v-else-if="formData.no_destination_type === 'suggestion'"
										:model-value="formData.no_destination_value ?? ''"
										@update:model-value="(v) => (formData.no_destination_value = v || null)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select suggestion…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem v-for="s in suggestions" :key="s.id" :value="s.id">
												{{ s.label }}
											</SelectItem>
										</SelectContent>
									</Select>
									<!-- General question dropdown (filtered by category) -->
									<Select
										v-else-if="formData.no_destination_type === 'question'"
										:model-value="formData.no_destination_value ?? ''"
										@update:model-value="(v) => (formData.no_destination_value = v || null)"
									>
										<SelectTrigger class="h-10 text-sm">
											<SelectValue placeholder="Select question…" />
										</SelectTrigger>
										<SelectContent>
											<SelectItem v-for="q in filteredQuestions" :key="q.id" :value="q.id">
												{{ q.label }}
											</SelectItem>
										</SelectContent>
									</Select>
									<!-- Fallback when no type selected -->
									<Input
										v-else
										disabled
										placeholder="Select a type first"
										class="h-10 text-sm"
									/>
								</div>
							</div>
						</section>

						<!-- Auto-route -->
						<section
							v-else-if="formData.response_type === 'auto-route'"
							class="space-y-4 rounded-2xl border border-border/70 bg-background px-4 py-4"
						>
							<div class="space-y-1">
								<h3 class="text-sm font-semibold">Routing Logic</h3>
								<p class="text-xs text-muted-foreground">This option directly routes to a subcategory.</p>
							</div>
							<div class="space-y-2">
								<Label for="leads_to_subcategory" class="text-sm font-semibold">Leads To Subcategory</Label>
								<Select
									:model-value="formData.leads_to_subcategory ?? ''"
									@update:model-value="(v) => (formData.leads_to_subcategory = v || null)"
								>
									<SelectTrigger id="leads_to_subcategory" class="h-11 w-full">
										<SelectValue placeholder="Select subcategory…" />
									</SelectTrigger>
									<SelectContent>
										<SelectItem v-for="s in subcategories" :key="s.id" :value="s.id">
											{{ s.label }}
										</SelectItem>
									</SelectContent>
								</Select>
								<p class="text-xs text-muted-foreground">
									The subcategory this question routes to.
								</p>
							</div>
						</section>

						<!-- Multiple Choice -->
						<section
							v-else-if="formData.response_type === 'multiple choice'"
							class="space-y-4 rounded-2xl border border-border/70 bg-background px-4 py-4"
						>
							<div class="flex items-start justify-between gap-3">
								<div class="space-y-1">
									<h3 class="text-sm font-semibold">Answer Choices</h3>
									<p class="text-xs text-muted-foreground">
										Each choice is shown to the user and routes to a specific subcategory.
									</p>
								</div>
								<Button
									type="button"
									variant="outline"
									size="sm"
									class="h-8 shrink-0 gap-1.5 text-xs"
									@click="addChoice"
								>
									<Plus class="h-3.5 w-3.5" />
									Add Choice
								</Button>
							</div>

							<!-- Empty state -->
							<div
								v-if="choices.length === 0"
								class="flex flex-col items-center gap-2 rounded-xl border border-dashed border-border/70 py-8 text-center"
							>
								<p class="text-sm text-muted-foreground">No choices yet.</p>
								<Button type="button" variant="ghost" size="sm" class="gap-1.5 text-xs" @click="addChoice">
									<Plus class="h-3.5 w-3.5" />
									Add first choice
								</Button>
							</div>

							<!-- Choice rows -->
							<div v-else class="space-y-3">
								<div
									v-for="(choice, index) in choices"
									:key="index"
									class="group relative rounded-xl border border-border/60 bg-muted/20 px-4 py-4"
								>
									<!-- Row number badge -->
									<div class="absolute -left-2 -top-2 flex h-5 w-5 items-center justify-center rounded-full bg-muted border border-border/70 text-[10px] font-semibold text-muted-foreground">
										{{ index + 1 }}
									</div>

									<!-- Remove button -->
									<Button
										type="button"
										variant="ghost"
										size="icon"
										class="absolute -right-2 -top-2 h-6 w-6 rounded-full border border-border/70 bg-background text-muted-foreground hover:text-destructive hover:border-destructive/40"
										:aria-label="`Remove choice ${index + 1}`"
										@click="removeChoice(index)"
									>
										<X class="h-3 w-3" />
									</Button>

									<div class="space-y-3">
										<!-- Option text -->
										<div class="space-y-1.5">
											<Label :for="`choice_text_${index}`" class="text-xs font-medium text-muted-foreground uppercase tracking-wide">
												Option Text
											</Label>
											<Input
												:id="`choice_text_${index}`"
												v-model="choice.option_text"
												placeholder="e.g. Relationship issues"
												class="h-10 text-sm"
											/>
										</div>

										<!-- Destination type + value -->
										<div class="grid gap-3 sm:grid-cols-[160px_1fr]">
											<div class="space-y-1.5">
												<Label :for="`choice_dest_type_${index}`" class="text-xs font-medium text-muted-foreground uppercase tracking-wide">
													Routes To
												</Label>
												<Select
													:model-value="choice.destination_type"
													@update:model-value="(v) => onDestTypeChange(choice, v)"
												>
													<SelectTrigger :id="`choice_dest_type_${index}`" class="h-10 text-sm">
														<SelectValue placeholder="Select…" />
													</SelectTrigger>
													<SelectContent>
														<SelectItem value="subcategory">Subcategory</SelectItem>
														<SelectItem value="suggestion">Suggestion</SelectItem>
														<SelectItem value="question">General Question</SelectItem>
													</SelectContent>
												</Select>
											</div>

											<div class="space-y-1.5">
												<Label :for="`choice_dest_val_${index}`" class="text-xs font-medium text-muted-foreground uppercase tracking-wide">
													{{ destinationLabel(choice.destination_type) }}
												</Label>
												<!-- Subcategory dropdown -->
												<Select
													v-if="choice.destination_type === 'subcategory'"
													:model-value="choice.destination_value"
													@update:model-value="(v) => (choice.destination_value = v)"
												>
													<SelectTrigger :id="`choice_dest_val_${index}`" class="h-10 text-sm">
														<SelectValue placeholder="Select subcategory…" />
													</SelectTrigger>
													<SelectContent>
														<SelectItem v-for="s in subcategories" :key="s.id" :value="s.id">
															{{ s.label }}
														</SelectItem>
													</SelectContent>
												</Select>
												<!-- Suggestion dropdown -->
												<Select
													v-else-if="choice.destination_type === 'suggestion'"
													:model-value="choice.destination_value"
													@update:model-value="(v) => (choice.destination_value = v)"
												>
													<SelectTrigger :id="`choice_dest_val_${index}`" class="h-10 text-sm">
														<SelectValue placeholder="Select suggestion…" />
													</SelectTrigger>
													<SelectContent>
														<SelectItem v-for="s in suggestions" :key="s.id" :value="s.id">
															{{ s.label }}
														</SelectItem>
													</SelectContent>
												</Select>
												<!-- General question dropdown (filtered by category) -->
												<Select
													v-else-if="choice.destination_type === 'question'"
													:model-value="choice.destination_value"
													@update:model-value="(v) => (choice.destination_value = v)"
												>
													<SelectTrigger :id="`choice_dest_val_${index}`" class="h-10 text-sm">
														<SelectValue placeholder="Select question…" />
													</SelectTrigger>
													<SelectContent>
														<SelectItem v-for="q in filteredQuestions" :key="q.id" :value="q.id">
															{{ q.label }}
														</SelectItem>
													</SelectContent>
												</Select>
												<!-- Fallback -->
												<Input
													v-else
													:id="`choice_dest_val_${index}`"
													disabled
													placeholder="Select a type first"
													class="h-10 text-sm"
												/>
											</div>
										</div>
									</div>
								</div>
							</div>

							<p v-if="errors.choices" class="text-sm text-destructive" aria-live="polite">
								{{ errors.choices }}
							</p>
						</section>

						<!-- Optional details -->
						<section class="space-y-3">
							<button
								type="button"
								class="flex w-full items-center justify-between rounded-xl border border-border/70 bg-background px-4 py-3 text-left text-sm font-medium text-foreground transition-colors hover:bg-muted/40 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
								:aria-expanded="showAdvanced"
								@click="showAdvanced = !showAdvanced"
							>
								<span>Optional details</span>
								<ChevronDown
									class="h-4 w-4 transition-transform duration-200"
									:class="showAdvanced ? 'rotate-180' : ''"
									aria-hidden="true"
								/>
							</button>

							<div
								v-if="showAdvanced"
								class="space-y-4 rounded-2xl border border-border/70 bg-background px-4 py-4"
							>
								<div class="space-y-2">
									<Label for="order_number" class="text-sm font-semibold">Order Number</Label>
									<Input
										id="order_number"
										type="number"
										:min="1"
										v-model.number="formData.order_number"
										placeholder="e.g. 1"
										class="h-11"
									/>
									<p class="text-xs text-muted-foreground">
										Position of this question in the decision tree sequence.
									</p>
								</div>
							</div>
						</section>
					</div>
				</div>

				<div class="border-t bg-background px-6 py-4">
					<DialogFooter class="flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
						<Button type="button" variant="outline" class="w-full sm:w-auto" @click="closeModal" :disabled="isSaving">
							Cancel
						</Button>
						<Button type="submit" class="w-full sm:w-auto" :disabled="isSaving">
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
import { ChevronDown, Loader2, Plus, X } from "lucide-vue-next";
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
import { useSupabase } from "@/composables/useSupabase";

interface Choice {
	option_text: string;
	destination_type: "subcategory" | "suggestion" | "question" | "";
	destination_value: string;
}

interface GeneralQuestion {
	id?: string;
	question_id: string;
	question_text: string;
	response_type: string;
	category?: string | null;
	leads_to_subcategory?: string | null;
	// yes/no routing
	yes_destination_type?: string | null;
	yes_destination_value?: string | null;
	no_destination_type?: string | null;
	no_destination_value?: string | null;
	// legacy fields kept for backward compat
	next_question_if_yes?: string | null;
	next_question_if_no?: string | null;
	choices?: Choice[] | null;
	order_number?: number | null;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

const props = defineProps<{
	isOpen: boolean;
	item: GeneralQuestion | null;
}>();

const emit = defineEmits<{
	close: [];
	save: [data: GeneralQuestion];
}>();

const getInitialState = (): GeneralQuestion => ({
	question_id: "",
	question_text: "",
	response_type: "",
	category: null,
	leads_to_subcategory: null,
	yes_destination_type: null,
	yes_destination_value: null,
	no_destination_type: null,
	no_destination_value: null,
	next_question_if_yes: null,
	next_question_if_no: null,
	choices: null,
	order_number: null,
	is_active: true,
});

const formData = reactive<GeneralQuestion>(getInitialState());
const choices = ref<Choice[]>([]);
const isSaving = ref(false);
const showAdvanced = ref(false);
const hasSubmitted = ref(false);

const isEditing = computed(() => !!props.item);

// ── Lookup data ────────────────────────────────────────────────────────────────
const { supabase } = useSupabase();

interface SubcategoryOption { id: string; label: string }
interface SuggestionOption  { id: string; label: string }
interface QuestionOption    { id: string; label: string; category: string | null }

const subcategories  = ref<SubcategoryOption[]>([]);
const suggestions    = ref<SuggestionOption[]>([]);
const allQuestions   = ref<QuestionOption[]>([]);
const lookupLoading  = ref(false);

const fetchLookups = async () => {
	if (lookupLoading.value) return;
	lookupLoading.value = true;
	try {
		const [subRes, sugRes, qRes] = await Promise.all([
			supabase
				.from("problems")
				.select("sub_category_id, problem_name")
				.eq("is_active", true)
				.order("sub_category_id", { ascending: true }),
			supabase
				.from("suggestions")
				.select("suggestion_id, suggestion_text")
				.eq("is_active", true)
				.order("suggestion_id", { ascending: true }),
			supabase
				.from("general_questions")
				.select("question_id, question_text, category")
				.eq("is_active", true)
				.order("question_id", { ascending: true }),
		]);

		subcategories.value = (subRes.data || []).map((r: any) => ({
			id: r.sub_category_id,
			label: r.problem_name ? `${r.sub_category_id} – ${r.problem_name}` : r.sub_category_id,
		}));

		suggestions.value = (sugRes.data || []).map((r: any) => ({
			id: r.suggestion_id,
			label: r.suggestion_text ? `${r.suggestion_id} – ${r.suggestion_text}` : r.suggestion_id,
		}));

		allQuestions.value = (qRes.data || []).map((r: any) => ({
			id: r.question_id,
			label: r.question_text ? `${r.question_id} – ${r.question_text}` : r.question_id,
			category: r.category ?? null,
		}));
	} catch (e) {
		console.error("GeneralQuestionModal: failed to fetch lookups", e);
	} finally {
		lookupLoading.value = false;
	}
};

// General questions filtered by the form's selected category (for "question" destination type)
const filteredQuestions = computed(() => {
	const cat = formData.category;
	if (!cat) return allQuestions.value;
	return allQuestions.value.filter((q) => !q.category || q.category === cat);
});

// Auto-generate next Question ID
const generateQuestionId = async () => {
	try {
		const { data } = await supabase
			.from("general_questions")
			.select("question_id")
			.ilike("question_id", "Q%")
			.order("question_id", { ascending: false })
			.limit(1);

		if (data && data.length > 0) {
			const last = data[0].question_id as string;
			const num = parseInt(last.replace(/\D/g, ""), 10);
			if (!isNaN(num)) {
				return `Q${String(num + 1).padStart(3, "0")}`;
			}
		}
		return "Q001";
	} catch {
		return "Q001";
	}
};

const errors = computed(() => {
	if (!hasSubmitted.value) return {} as Record<string, string>;
	const e: Record<string, string> = {};
	if (!formData.question_id.trim()) e.question_id = "Question ID is required.";
	if (!formData.question_text.trim()) e.question_text = "Question text is required.";
	if (!formData.response_type) e.response_type = "Response type is required.";
	if (formData.response_type === "multiple choice" && choices.value.length === 0) {
		e.choices = "Add at least one choice.";
	}
	return e;
});

const addChoice = () => {
	choices.value.push({ option_text: "", destination_type: "", destination_value: "" });
};

const removeChoice = (index: number) => {
	choices.value.splice(index, 1);
};

const onDestTypeChange = (choice: Choice, v: string) => {
	choice.destination_type = v as Choice["destination_type"];
	choice.destination_value = "";
};

const onYesDestTypeChange = (v: string) => {
	formData.yes_destination_type = v || null;
	formData.yes_destination_value = null;
};

const onNoDestTypeChange = (v: string) => {
	formData.no_destination_type = v || null;
	formData.no_destination_value = null;
};

const destinationLabel = (type: string) => {
	if (type === "subcategory") return "Subcategory";
	if (type === "suggestion") return "Suggestion";
	if (type === "question") return "General Question";
	return "Destination";
};

const handleResponseTypeChange = (v: string) => {
	formData.response_type = v;
	if (v !== "yes/no") {
		formData.yes_destination_type = null;
		formData.yes_destination_value = null;
		formData.no_destination_type = null;
		formData.no_destination_value = null;
		formData.next_question_if_yes = null;
		formData.next_question_if_no = null;
	}
	if (v !== "auto-route") {
		formData.leads_to_subcategory = null;
	}
	if (v !== "multiple choice") {
		choices.value = [];
	}
};

const resetForm = () => {
	Object.assign(formData, getInitialState());
	choices.value = [];
	hasSubmitted.value = false;
	showAdvanced.value = false;
};

const populateForm = async () => {
	resetForm();
	await fetchLookups();
	if (props.item) {
		Object.assign(formData, { ...getInitialState(), ...props.item });

		// Migrate legacy yes/no fields to typed destinations if new fields are absent
		if (!formData.yes_destination_type && formData.next_question_if_yes) {
			formData.yes_destination_type = "question";
			formData.yes_destination_value = formData.next_question_if_yes;
		}
		if (!formData.no_destination_type && formData.next_question_if_no) {
			formData.no_destination_type = "question";
			formData.no_destination_value = formData.next_question_if_no;
		}

		// Hydrate choices from stored JSON
		if (Array.isArray(props.item.choices)) {
			choices.value = props.item.choices.map((c) => ({
				option_text: c.option_text ?? "",
				destination_type: c.destination_type ?? "",
				destination_value: c.destination_value ?? "",
			}));
		}
	} else {
		// Auto-generate ID for new questions
		formData.question_id = await generateQuestionId();
	}
};

const closeModal = () => {
	if (isSaving.value) return;
	resetForm();
	emit("close");
};

const handleOpenChange = (open: boolean) => {
	if (!open) closeModal();
};

const saveItem = async () => {
	hasSubmitted.value = true;
	if (Object.keys(errors.value).length > 0) return;

	isSaving.value = true;
	try {
		const payload: GeneralQuestion = {
			...formData,
			choices: formData.response_type === "multiple choice"
				? choices.value.map((c) => ({ ...c }))
				: null,
		};
		emit("save", payload);
		closeModal();
	} finally {
		isSaving.value = false;
	}
};

watch(
	() => props.isOpen,
	(open) => {
		if (open) populateForm();
		else resetForm();
	},
);

watch(
	() => props.item,
	() => {
		if (props.isOpen) populateForm();
	},
);</script>
