<script setup lang="ts">
import { computed, ref, watch } from "vue";
import {
	ChevronLeft,
	ChevronRight,
	FlaskConical,
	RefreshCcw,
	X,
} from "lucide-vue-next";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogTitle } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";

type ResponseType = "scale" | "text";

interface DemoQuestion {
	questionId: string;
	questionLabel: string;
	questionText: string;
	responseType: ResponseType;
	scaleValue: number;
	textValue: string;
	scaleLabels: [string, string, string, string];
	clusters?: string | null;
	batchId?: string | null;
}

interface DemoCategory {
	name: string;
	id: string;
	description: string;
}

interface DemoSubcategory {
	name: string;
	id: string;
	description: string;
	severity: string;
}

interface DemoSuggestion {
	suggestionId: string;
	title: string;
	suggestionText: string;
	evidenceBase: string;
	nextStep: string;
	cluster?: string | null;
	resourceLink?: string | null;
}

interface DemoScenario {
	scenarioTitle: string;
	scenarioNote: string;
	category: DemoCategory;
	subcategory: DemoSubcategory;
	assessments: DemoQuestion[];
	suggestion: DemoSuggestion;
}

const props = withDefaults(
	defineProps<{
		scenario: DemoScenario | null;
		loading?: boolean;
		error?: string | null;
		emptyTitle?: string;
		emptyDescription?: string;
	}>(),
	{
		loading: false,
		error: null,
		emptyTitle: "Select a category and subcategory",
		emptyDescription:
			"Pick a live category/subcategory pair to load the matching assessment flow.",
	},
);

const isPreviewOpen = ref(false);
const flowStepIndex = ref(0);
const workingScenario = ref<DemoScenario | null>(null);

const cloneScenario = (scenario: DemoScenario | null): DemoScenario | null => {
	if (!scenario) return null;
	return JSON.parse(JSON.stringify(scenario)) as DemoScenario;
};

const canPreview = computed(
	() => !!workingScenario.value && !props.loading && !props.error,
);
const totalFlowSteps = computed(
	() => (workingScenario.value?.assessments.length ?? 0) + 1,
);
const isSuggestionStep = computed(() => {
	const scenario = workingScenario.value;
	if (!scenario) return false;
	return flowStepIndex.value >= scenario.assessments.length;
});
const activeQuestion = computed(() => {
	const scenario = workingScenario.value;
	if (!scenario) return null;
	return scenario.assessments[flowStepIndex.value] ?? null;
});
const flowProgress = computed(() => {
	const scenario = workingScenario.value;
	if (!scenario) return 0;

	const steps = scenario.assessments.length + 1;
	if (steps <= 1) return isSuggestionStep.value ? 100 : 0;

	const currentStep = Math.min(flowStepIndex.value, steps - 1);
	return Math.round((currentStep / (steps - 1)) * 100);
});
const nextButtonLabel = computed(() => {
	const scenario = workingScenario.value;
	if (!scenario) return "Next";

	const questionCount = scenario.assessments.length;
	if (flowStepIndex.value >= questionCount) return "Restart flow";
	if (flowStepIndex.value === questionCount - 1) return "See suggestion";
	return "Next question";
});
const statusTitle = computed(() => {
	if (props.loading) return "Loading live records";
	if (props.error) return "Unable to load live data";
	if (!workingScenario.value) return props.emptyTitle;
	return "Live assessment ready";
});
const statusDescription = computed(() => {
	if (props.loading) return "Fetching categories, subcategories, questions, and suggestions from Supabase.";
	if (props.error) return props.error;
	if (!workingScenario.value) return props.emptyDescription;
	return workingScenario.value.scenarioNote;
});
const selectionSummary = computed(() => {
	const scenario = workingScenario.value;
	if (!scenario) return "No live selection yet.";

	return `${scenario.category.name} / ${scenario.subcategory.name}`;
});

const resetFlow = () => {
	flowStepIndex.value = 0;
	if (workingScenario.value && !props.loading && !props.error) {
		isPreviewOpen.value = true;
	}
};

const openPreview = () => {
	if (canPreview.value) {
		isPreviewOpen.value = true;
	}
};

const closePreview = () => {
	isPreviewOpen.value = false;
};

const previousStep = () => {
	flowStepIndex.value = Math.max(0, flowStepIndex.value - 1);
};

const nextStep = () => {
	const scenario = workingScenario.value;
	if (!scenario) return;

	if (flowStepIndex.value >= scenario.assessments.length) {
		flowStepIndex.value = 0;
		return;
	}

	flowStepIndex.value = Math.min(
		flowStepIndex.value + 1,
		scenario.assessments.length,
	);
};

watch(
	() => props.scenario,
	(nextScenario) => {
		workingScenario.value = cloneScenario(nextScenario);
		flowStepIndex.value = 0;

		if (nextScenario && !props.loading && !props.error) {
			isPreviewOpen.value = true;
		} else {
			isPreviewOpen.value = false;
		}
	},
	{ immediate: true },
);

watch(
	() => props.loading,
	(loading) => {
		if (loading) {
			isPreviewOpen.value = false;
		} else if (workingScenario.value && !props.error) {
			isPreviewOpen.value = true;
		}
	},
);

watch(
	() => props.error,
	(error) => {
		if (error) {
			isPreviewOpen.value = false;
		}
	},
);
</script>

<template>
	<section
		id="assessment-demo"
		class="space-y-6 rounded-2xl border border-border/70 bg-card p-5 sm:p-6 lg:p-8"
		:aria-busy="props.loading"
	>
		<div class="grid gap-6 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-end">
			<div class="space-y-3">
				<p class="text-xs font-medium uppercase tracking-[0.18em] text-primary/80">
					Live assessment preview
				</p>
				<h2 class="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">
					{{ workingScenario?.scenarioTitle || props.emptyTitle }}
				</h2>
				<p class="max-w-2xl text-sm leading-6 text-muted-foreground sm:text-base">
					{{ statusDescription }}
				</p>

				<div class="flex flex-wrap gap-2">
					<Badge v-if="workingScenario" variant="secondary" class="rounded-full px-3 py-1 text-xs font-medium">
						Category: {{ workingScenario.category.name }}
					</Badge>
					<Badge v-if="workingScenario" variant="outline" class="rounded-full px-3 py-1 text-xs font-medium text-muted-foreground">
						Subcategory: {{ workingScenario.subcategory.name }}
					</Badge>
					<Badge v-if="workingScenario" variant="outline" class="rounded-full px-3 py-1 text-xs font-medium text-muted-foreground">
						{{ workingScenario.assessments.length }} question{{ workingScenario.assessments.length === 1 ? "" : "s" }}
					</Badge>
					<Badge
						:variant="workingScenario?.suggestion.suggestionId ? 'secondary' : 'outline'"
						class="rounded-full px-3 py-1 text-xs font-medium"
					>
						{{ workingScenario?.suggestion.suggestionId ? "Suggestion loaded" : "Suggestion missing" }}
					</Badge>
				</div>
			</div>

			<div class="flex flex-wrap items-center gap-2 lg:justify-end">
				<Button class="h-11 gap-2 px-4 text-sm font-medium" :disabled="!canPreview" @click="openPreview">
					<FlaskConical class="h-4 w-4" />
					Open preview
				</Button>
				<Button
					variant="outline"
					class="h-11 gap-2 px-4 text-sm font-medium"
					:disabled="!workingScenario"
					@click="resetFlow"
				>
					<RefreshCcw class="h-4 w-4" />
					Reset flow
				</Button>
			</div>
		</div>

		<div class="grid gap-4 lg:grid-cols-[minmax(0,1fr)_18rem]">
			<div class="rounded-2xl border border-border/70 bg-muted/20 px-5 py-5 sm:px-6">
				<div v-if="props.loading" class="space-y-4">
					<div class="h-4 w-32 animate-pulse rounded-full bg-muted" />
					<div class="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
						<div v-for="index in 4" :key="index" class="space-y-3 rounded-2xl border border-border/60 bg-background p-4">
							<div class="h-3 w-20 animate-pulse rounded-full bg-muted" />
							<div class="h-16 animate-pulse rounded-2xl bg-muted/60" />
						</div>
					</div>
				</div>

				<div v-else-if="props.error" class="space-y-3">
					<p class="text-sm font-medium uppercase tracking-[0.2em] text-destructive">
						Live data unavailable
					</p>
					<p class="max-w-2xl text-sm leading-6 text-muted-foreground">
						{{ props.error }}
					</p>
				</div>

				<div v-else-if="!workingScenario" class="space-y-3">
					<p class="text-sm font-medium uppercase tracking-[0.2em] text-muted-foreground">
						Waiting for selection
					</p>
					<p class="max-w-2xl text-sm leading-6 text-muted-foreground">
						{{ props.emptyDescription }}
					</p>
				</div>

				<div v-else class="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
					<div class="rounded-2xl border border-border/70 bg-background p-4">
						<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
							Category
						</p>
						<p class="mt-2 break-words text-sm font-semibold text-foreground">
							{{ workingScenario.category.name }}
						</p>
						<p class="mt-2 text-sm leading-6 text-muted-foreground">
							{{ workingScenario.category.description }}
						</p>
					</div>

					<div class="rounded-2xl border border-border/70 bg-background p-4">
						<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
							Subcategory
						</p>
						<p class="mt-2 break-words text-sm font-semibold text-foreground">
							{{ workingScenario.subcategory.name }}
						</p>
						<p class="mt-2 text-sm leading-6 text-muted-foreground">
							{{ workingScenario.subcategory.description }}
						</p>
						<p class="mt-2 text-xs font-medium text-muted-foreground">
							{{ workingScenario.subcategory.severity }}
						</p>
					</div>

					<div class="rounded-2xl border border-border/70 bg-background p-4">
						<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
							Questions
						</p>
						<p class="mt-2 text-3xl font-semibold tracking-tight text-foreground">
							{{ workingScenario.assessments.length }}
						</p>
						<p class="mt-2 text-sm leading-6 text-muted-foreground">
							Ordered by `order_number` and surfaced from live assessment records.
						</p>
					</div>

					<div class="rounded-2xl border border-border/70 bg-background p-4">
						<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
							Suggestion
						</p>
						<p class="mt-2 break-words text-sm font-semibold text-foreground">
							{{ workingScenario.suggestion.title }}
						</p>
						<p class="mt-2 text-sm leading-6 text-muted-foreground">
							{{ workingScenario.suggestion.evidenceBase }}
						</p>
					</div>
				</div>
			</div>

			<div
				class="rounded-2xl border border-border/70 bg-card p-5"
				role="status"
				aria-live="polite"
				:aria-busy="props.loading"
			>
				<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
					Preview state
				</p>
				<h3 class="mt-2 text-base font-semibold text-foreground">
					{{ statusTitle }}
				</h3>
				<p class="mt-2 text-sm leading-6 text-muted-foreground">
					{{ selectionSummary }}
				</p>

				<div class="mt-4 space-y-3 text-sm">
					<div class="flex items-center justify-between gap-3">
						<span class="text-muted-foreground">Step</span>
						<span class="font-medium text-foreground">
							{{ Math.min(flowStepIndex + 1, totalFlowSteps) }} / {{ totalFlowSteps }}
						</span>
					</div>
					<div class="flex items-center justify-between gap-3">
						<span class="text-muted-foreground">Questions</span>
						<span class="font-medium text-foreground">
							{{ workingScenario?.assessments.length ?? 0 }}
						</span>
					</div>
					<div class="flex items-center justify-between gap-3">
						<span class="text-muted-foreground">Suggestion</span>
						<span class="font-medium text-foreground">
							{{ workingScenario?.suggestion.suggestionId ? "Loaded" : "Missing" }}
						</span>
					</div>
				</div>

				<div class="mt-4 rounded-2xl border border-border/70 bg-muted/20 p-4 text-sm leading-6 text-muted-foreground">
					{{ workingScenario ? workingScenario.scenarioNote : props.emptyDescription }}
				</div>
			</div>
		</div>

		<Dialog :open="isPreviewOpen" @update:open="isPreviewOpen = $event">
			<DialogContent
				:show-close-button="false"
				class="overflow-hidden border-border/70 bg-background p-0 shadow-2xl sm:max-w-[calc(100vw-2rem)] md:max-w-4xl md:rounded-2xl"
			>
				<div class="flex h-[90svh] max-h-[860px] w-full flex-col">
					<div class="grid gap-4 border-b border-border/70 bg-muted/20 px-5 py-5 sm:px-6 sm:py-6 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-start">
						<div class="space-y-2">
							<p class="text-sm font-medium text-muted-foreground">
								Live preview
							</p>
							<DialogTitle class="break-words text-lg font-semibold tracking-tight text-foreground sm:text-xl">
								{{ workingScenario?.scenarioTitle || props.emptyTitle }}
							</DialogTitle>
							<DialogDescription class="break-words text-sm leading-6 text-muted-foreground">
								{{ workingScenario ? `${workingScenario.category.name} / ${workingScenario.subcategory.name}` : props.emptyDescription }}
							</DialogDescription>
						</div>

						<Button
							variant="outline"
							size="icon"
							class="h-11 w-11 rounded-full self-start"
							aria-label="Close preview"
							@click="closePreview"
						>
							<X class="h-4 w-4" />
						</Button>
					</div>

					<div class="flex-1 overflow-y-auto px-5 py-6 sm:px-6 sm:py-8">
						<div class="mx-auto flex h-full w-full max-w-2xl flex-col justify-between gap-8">
							<div class="space-y-8">
								<div class="space-y-3">
									<div class="flex flex-wrap items-center justify-between gap-3">
										<p class="text-sm font-medium text-muted-foreground">
											Step {{ Math.min(flowStepIndex + 1, totalFlowSteps) }} of {{ totalFlowSteps }}
										</p>
										<p class="text-sm text-muted-foreground">
											{{ isSuggestionStep ? "Final suggestion" : "Assessment question" }}
										</p>
									</div>
									<div
										class="h-2 overflow-hidden rounded-full bg-muted"
										role="progressbar"
										aria-label="Assessment progress"
										:aria-valuemin="0"
										:aria-valuemax="100"
										:aria-valuenow="flowProgress"
									>
										<div
											class="h-full origin-left rounded-full bg-primary transition-transform duration-300 ease-out"
											:style="{ transform: `scaleX(${flowProgress / 100})` }"
										/>
									</div>
								</div>

								<div v-if="!isSuggestionStep && activeQuestion" class="space-y-6">
									<div class="space-y-3">
										<div class="flex flex-wrap items-center gap-2">
											<p class="text-sm font-medium text-muted-foreground">
												{{ activeQuestion.questionLabel }}
											</p>
											<Badge variant="secondary" class="rounded-full px-3 py-1 text-xs font-medium text-foreground">
												{{ activeQuestion.responseType === "scale" ? "Scale response" : "Text response" }}
											</Badge>
											<Badge
												v-if="activeQuestion.batchId"
												variant="outline"
												class="rounded-full px-3 py-1 text-xs font-medium text-muted-foreground"
											>
												Batch {{ activeQuestion.batchId }}
											</Badge>
											<Badge
												v-if="activeQuestion.clusters"
												variant="outline"
												class="rounded-full px-3 py-1 text-xs font-medium text-muted-foreground"
											>
												Cluster {{ activeQuestion.clusters }}
											</Badge>
										</div>
										<h3
											:id="`flow-question-${activeQuestion.questionId}`"
											class="break-words text-2xl font-semibold tracking-tight text-foreground sm:text-3xl"
										>
											{{ activeQuestion.questionText }}
										</h3>
									</div>

									<fieldset
										v-if="activeQuestion.responseType === 'scale'"
										class="space-y-4"
										:aria-labelledby="`flow-question-${activeQuestion.questionId}`"
									>
										<legend class="sr-only">
											{{ activeQuestion.questionText }}
										</legend>
										<div class="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
											<label
												v-for="(label, value) in activeQuestion.scaleLabels"
												:key="`${activeQuestion.questionId}-scale-${value}`"
												class="flex min-h-28 cursor-pointer flex-col justify-between rounded-2xl border px-4 py-4 text-left transition-colors focus-within:ring-2 focus-within:ring-ring/40 focus-within:ring-offset-2"
												:class="
													Number(value) + 1 === activeQuestion.scaleValue
														? 'border-primary/30 bg-primary/10 text-foreground'
														: 'border-border/70 bg-background text-muted-foreground hover:border-primary/20 hover:bg-muted/40'
												"
											>
												<input
													v-model="activeQuestion.scaleValue"
													class="sr-only"
													type="radio"
													:name="activeQuestion.questionId"
													:value="Number(value) + 1"
												>
												<div class="text-xs font-semibold uppercase tracking-[0.18em] opacity-80">
													{{ Number(value) + 1 }}
												</div>
												<div class="mt-2 break-words text-sm leading-5">
													{{ label }}
												</div>
											</label>
										</div>
									</fieldset>

									<div v-else class="space-y-3">
										<label
											class="text-sm font-medium text-foreground"
											:for="`flow-text-${activeQuestion.questionId}`"
										>
											Your response
										</label>
										<Textarea
											:id="`flow-text-${activeQuestion.questionId}`"
											v-model="activeQuestion.textValue"
											class="min-h-40"
											placeholder="Type what the end user might say here"
										/>
									</div>
								</div>

								<div v-else class="space-y-6">
									<div class="space-y-3">
										<p class="text-sm font-medium text-muted-foreground">
											Flow complete
										</p>
										<h3 class="break-words text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">
											{{ workingScenario?.suggestion.title || "Suggested guidance" }}
										</h3>
									</div>

									<div class="grid gap-4 lg:grid-cols-[minmax(0,1.35fr)_minmax(240px,0.85fr)]">
										<div class="rounded-2xl border border-primary/20 bg-primary/5 p-5">
											<p class="break-words text-sm leading-7 text-foreground sm:text-base">
												{{ workingScenario?.suggestion.suggestionText }}
											</p>
										</div>

										<div class="grid gap-3">
											<div class="rounded-2xl border border-border/70 bg-background px-4 py-4">
												<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
													Suggestion ID
												</p>
												<p class="mt-2 break-words text-sm leading-6 text-foreground">
													{{ workingScenario?.suggestion.suggestionId || "Missing" }}
												</p>
											</div>
											<div class="rounded-2xl border border-border/70 bg-background px-4 py-4">
												<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
													Evidence base
												</p>
												<p class="mt-2 break-words text-sm leading-6 text-foreground">
													{{ workingScenario?.suggestion.evidenceBase || "No evidence base recorded." }}
												</p>
											</div>
											<div class="rounded-2xl border border-border/70 bg-background px-4 py-4">
												<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
													Next step
												</p>
												<p class="mt-2 break-words text-sm leading-6 text-foreground">
													{{ workingScenario?.suggestion.nextStep || "No next-step metadata available." }}
												</p>
											</div>
											<div
												v-if="workingScenario?.suggestion.resourceLink"
												class="rounded-2xl border border-border/70 bg-background px-4 py-4"
											>
												<p class="text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground">
													Resource
												</p>
												<Button as-child variant="outline" class="mt-3 h-11 w-full justify-between px-4 text-left">
													<a
														:href="workingScenario.suggestion.resourceLink"
														target="_blank"
														rel="noreferrer"
													>
														<span class="text-sm font-medium">Open linked resource</span>
														<ChevronRight class="h-4 w-4" />
													</a>
												</Button>
											</div>
										</div>
									</div>
								</div>
							</div>

							<DialogFooter class="border-t border-border/70 pt-5">
								<div class="grid w-full gap-4 sm:grid-cols-[minmax(0,1fr)_auto] sm:items-center">
									<p class="break-words text-sm leading-6 text-muted-foreground">
										{{ isSuggestionStep ? "The demo ends with a suggestion, not a settings screen." : "Each response moves the user to the next question." }}
									</p>
									<div class="flex flex-wrap gap-2 sm:justify-end">
										<Button
											variant="outline"
											class="h-11 gap-2 px-4 text-sm font-medium"
											:disabled="flowStepIndex === 0"
											@click="previousStep"
										>
											<ChevronLeft class="h-4 w-4" />
											Back
										</Button>
										<Button
											class="h-11 gap-2 px-4 text-sm font-medium"
											@click="nextStep"
										>
											{{ nextButtonLabel }}
											<ChevronRight class="h-4 w-4" />
										</Button>
										<Button
											variant="outline"
											class="h-11 gap-2 px-4 text-sm font-medium"
											@click="resetFlow"
										>
											<RefreshCcw class="h-4 w-4" />
											Restart
										</Button>
									</div>
								</div>
							</DialogFooter>
						</div>
					</div>
				</div>
			</DialogContent>
		</Dialog>
	</section>
</template>
