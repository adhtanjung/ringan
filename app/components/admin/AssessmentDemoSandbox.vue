<script setup lang="ts">
import { computed, onMounted, ref, watch } from "vue";
import { ChevronDown, ChevronLeft, ChevronRight, FlaskConical, RotateCcw, X } from "lucide-vue-next";
import { Badge } from "@/components/ui/badge";
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

type ResponseType = "scale" | "text";

interface DemoQuestion {
	questionId: string;
	questionLabel: string;
	questionText: string;
	responseType: ResponseType;
	scaleValue: number;
	textValue: string;
	scaleLabels: [string, string, string, string];
}

interface DemoScenario {
	scenarioTitle: string;
	scenarioNote: string;
	category: {
		name: string;
		id: string;
		description: string;
	};
	subcategory: {
		name: string;
		id: string;
		description: string;
		severity: string;
	};
	assessments: DemoQuestion[];
	suggestion: {
		suggestionId: string;
		title: string;
		suggestionText: string;
		evidenceBase: string;
		nextStep: string;
	};
}

const STORAGE_KEY = "ringan-assessment-demo-sandbox-v2";

const createDefaultQuestion = (
	index: number,
	overrides: Partial<DemoQuestion> = {},
): DemoQuestion => ({
	questionId: `Q_DEMO_00${index + 1}`,
	questionLabel: `Question ${index + 1}`,
	questionText:
		index === 0
			? "How intense is your anxiety before an exam?"
			: index === 1
				? "What happens in your body right before the test?"
				: "What would help you feel more prepared?",
	responseType: index === 1 ? "text" : "scale",
	scaleValue: index === 0 ? 3 : 2,
	textValue:
		index === 1 ? "My chest feels tight and I freeze." : "I need a bit more time and structure.",
	scaleLabels: ["Not at all", "A little", "Quite a bit", "Very much"],
	...overrides,
});

const normalizeQuestion = (
	source: Partial<DemoQuestion> | undefined,
	index: number,
): DemoQuestion => {
	const fallback = createDefaultQuestion(index);
	if (!source || typeof source !== "object") return fallback;

	const questionId = String(source.questionId ?? fallback.questionId).trim() || fallback.questionId;
	const questionLabel = String(source.questionLabel ?? fallback.questionLabel).trim() || fallback.questionLabel;
	const questionText = String(source.questionText ?? fallback.questionText).trim() || fallback.questionText;
	const textValue = String(source.textValue ?? fallback.textValue ?? "");
	const scaleValue = Number(source.scaleValue);
	const scaleLabels: DemoQuestion["scaleLabels"] =
		Array.isArray(source.scaleLabels) && source.scaleLabels.length === 4
			? [
					String(source.scaleLabels[0] ?? fallback.scaleLabels[0]),
					String(source.scaleLabels[1] ?? fallback.scaleLabels[1]),
					String(source.scaleLabels[2] ?? fallback.scaleLabels[2]),
					String(source.scaleLabels[3] ?? fallback.scaleLabels[3]),
				]
			: fallback.scaleLabels;

	return {
		...fallback,
		...source,
		questionId,
		questionLabel,
		questionText,
		responseType: source.responseType === "text" ? "text" : "scale",
		scaleValue: Number.isFinite(scaleValue) && scaleValue >= 1 && scaleValue <= 4
			? scaleValue
			: fallback.scaleValue,
		textValue,
		scaleLabels,
	};
};

const createDefaultScenario = (): DemoScenario => ({
	scenarioTitle: "Exam / Test Anxiety Sandbox",
	scenarioNote:
		"Preview the assessment as a real end-user flow. One question appears at a time, and the result closes the loop.",
	category: {
		name: "Anxiety",
		id: "ANX_756",
		description: "General anxiety disorders and anxiety-related conditions.",
	},
	subcategory: {
		name: "Exam/test anxiety",
		id: "EA_001",
		description:
			"Marked fear or having anxiety symptoms before tests and exams.",
		severity: "Moderate",
	},
	assessments: [
		createDefaultQuestion(0, { questionId: "Q_DEMO_001", questionLabel: "Q1" }),
		createDefaultQuestion(1, { questionId: "Q_DEMO_002", questionLabel: "Q2" }),
		createDefaultQuestion(2, { questionId: "Q_DEMO_003", questionLabel: "Q3" }),
	],
	suggestion: {
		suggestionId: "S_DEMO_001",
		title: "Exam-day grounding plan",
		suggestionText:
			"Use a two-minute breathing routine, review one section at a time, and arrive a little early so your body can settle.",
		evidenceBase: "CBT-informed coping skills",
		nextStep:
			"If anxiety keeps disrupting sleep, attendance, or concentration, talk to a trusted adult or mental health professional.",
	},
});

const cloneScenario = (): DemoScenario =>
	JSON.parse(JSON.stringify(createDefaultScenario())) as DemoScenario;

const scenario = ref<DemoScenario>(createDefaultScenario());
const isPreviewOpen = ref(true);
const flowStepIndex = ref(0);
const isReady = ref(false);

const totalFlowSteps = computed(() => scenario.value.assessments.length + 1);
const isSuggestionStep = computed(() => flowStepIndex.value >= scenario.value.assessments.length);
const activeQuestion = computed(() => scenario.value.assessments[flowStepIndex.value] ?? null);
const flowProgress = computed(() => {
	const steps = totalFlowSteps.value;
	if (steps <= 1) return isSuggestionStep.value ? 100 : 0;

	const currentStep = Math.min(flowStepIndex.value, steps - 1);
	return Math.round((currentStep / (steps - 1)) * 100);
});
const nextButtonLabel = computed(() =>
	isSuggestionStep.value ? "Restart flow" : flowStepIndex.value === scenario.value.assessments.length - 1 ? "See suggestion" : "Next question",
);

const hydrateScenario = (input: unknown) => {
	const base = createDefaultScenario();
	if (!input || typeof input !== "object") return base;

	const payload = input as Partial<DemoScenario>;

	base.scenarioTitle = String(payload.scenarioTitle ?? base.scenarioTitle);
	base.scenarioNote = String(payload.scenarioNote ?? base.scenarioNote);
	base.category = {
		...base.category,
		...(payload.category || {}),
	};
	base.subcategory = {
		...base.subcategory,
		...(payload.subcategory || {}),
	};
	base.suggestion = {
		...base.suggestion,
		...(payload.suggestion || {}),
	};

	if (Array.isArray(payload.assessments) && payload.assessments.length > 0) {
		base.assessments = payload.assessments.map((question, index) =>
			normalizeQuestion(
				question && typeof question === "object"
					? (question as Partial<DemoQuestion>)
					: undefined,
				index,
			),
		);
	}

	return base;
};

const saveSandbox = () => {
	if (!import.meta.client) return;
	localStorage.setItem(
		STORAGE_KEY,
		JSON.stringify({
			scenario: scenario.value,
			flowStepIndex: flowStepIndex.value,
		}),
	);
};

const loadSandbox = () => {
	if (!import.meta.client) return;

	try {
		const raw = localStorage.getItem(STORAGE_KEY);
		if (!raw) return;

		const parsed = JSON.parse(raw);
		const source = parsed && typeof parsed === "object" && "scenario" in parsed ? parsed.scenario : parsed;
		scenario.value = hydrateScenario(source);

		const storedStep = Number(
			parsed && typeof parsed === "object" && "flowStepIndex" in parsed
				? (parsed as { flowStepIndex?: unknown }).flowStepIndex
				: (parsed as { previewFocusIndex?: unknown } | null)?.previewFocusIndex,
		);
		if (Number.isFinite(storedStep)) {
			flowStepIndex.value = Math.max(
				0,
				Math.min(Math.trunc(storedStep), scenario.value.assessments.length),
			);
		}
	} catch {
		scenario.value = cloneScenario();
		flowStepIndex.value = 0;
	}
};

const resetSandbox = () => {
	scenario.value = cloneScenario();
	flowStepIndex.value = 0;
	if (import.meta.client) {
		localStorage.removeItem(STORAGE_KEY);
	}
};

const openPreview = () => {
	isPreviewOpen.value = true;
};

const closePreview = () => {
	isPreviewOpen.value = false;
};

const previousStep = () => {
	flowStepIndex.value = Math.max(0, flowStepIndex.value - 1);
};

const nextStep = () => {
	if (isSuggestionStep.value) {
		flowStepIndex.value = 0;
		return;
	}

	flowStepIndex.value = Math.min(flowStepIndex.value + 1, scenario.value.assessments.length);
};

watch(
	scenario,
	() => {
		if (!isReady.value || !import.meta.client) return;
		saveSandbox();
	},
	{ deep: true },
);

watch(flowStepIndex, () => {
	if (!isReady.value || !import.meta.client) return;
	saveSandbox();
});

watch(
	() => scenario.value.assessments.length,
	(length) => {
		if (flowStepIndex.value > length) {
			flowStepIndex.value = length;
		}
	},
);

onMounted(() => {
	loadSandbox();
	isReady.value = true;
});
</script>

<template>
	<section id="assessment-demo" class="space-y-8 rounded-3xl border border-border/70 bg-card p-5 shadow-sm sm:p-6 lg:p-8">
		<div class="grid gap-6 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-end">
			<div class="space-y-3">
				<p class="text-sm font-medium text-muted-foreground">
					Assessment demo
				</p>
				<h2 class="text-2xl font-semibold tracking-tight text-foreground sm:text-3xl">
					Assessment preview
				</h2>
				<p class="max-w-2xl text-sm leading-6 text-muted-foreground sm:text-base">
					Open the popup to step through one question at a time. Category and subcategory stay as context only.
				</p>
				<p class="break-words text-sm font-medium text-foreground">
					{{ scenario.category.name }} / {{ scenario.subcategory.name }}
				</p>
			</div>

			<div class="flex flex-wrap items-center gap-2 lg:justify-end">
				<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openPreview">
					<FlaskConical class="h-4 w-4" />
					Open preview popup
				</Button>
				<Button variant="outline" class="h-11 gap-2 px-4 text-sm font-medium" @click="resetSandbox">
					<RotateCcw class="h-4 w-4" />
					Reset sandbox
				</Button>
			</div>
		</div>

		<div class="rounded-2xl border border-border/70 bg-muted/20 px-5 py-5 sm:px-6">
			<p class="text-sm font-medium text-foreground">
				Preview mode
			</p>
			<p class="mt-1 max-w-3xl text-sm leading-6 text-muted-foreground">
				This demo is designed to feel like a real assessment pop-up: one question, one response, then the suggestion.
			</p>
		</div>

		<Dialog :open="isPreviewOpen" @update:open="isPreviewOpen = $event">
			<DialogContent
				:show-close-button="false"
				class="overflow-hidden border-border/70 bg-background p-0 shadow-2xl sm:max-w-[calc(100vw-2rem)] md:max-w-4xl md:rounded-2xl"
			>
				<div class="flex h-[90svh] max-h-[860px] w-full flex-col">
					<div class="grid gap-4 border-b border-border/70 bg-muted/20 px-5 py-5 sm:px-6 sm:py-6 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-start">
						<div class="space-y-1">
							<p class="text-sm font-medium text-muted-foreground">
								Live preview
							</p>
							<DialogTitle class="break-words text-lg font-semibold tracking-tight text-foreground sm:text-xl">
								{{ scenario.scenarioTitle }}
							</DialogTitle>
							<DialogDescription class="break-words text-sm leading-6 text-muted-foreground">
								{{ scenario.category.name }} / {{ scenario.subcategory.name }}
							</DialogDescription>
						</div>

						<Button
							variant="outline"
							size="icon"
							class="h-11 w-11 rounded-full self-start"
							aria-label="Close preview popup"
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
												:class="Number(value) + 1 === activeQuestion.scaleValue
													? 'border-primary/30 bg-primary/10 text-foreground'
													: 'border-border/70 bg-background text-muted-foreground hover:border-primary/20 hover:bg-muted/40'"
											>
												<input
													v-model="activeQuestion.scaleValue"
													class="sr-only"
													type="radio"
													:name="activeQuestion.questionId"
													:value="Number(value) + 1"
												>
												<div class="text-[11px] font-semibold uppercase tracking-[0.2em] opacity-80">
													{{ Number(value) + 1 }}
												</div>
												<div class="mt-2 break-words text-sm leading-5">
													{{ label }}
												</div>
											</label>
										</div>
									</fieldset>

									<div v-else class="space-y-3">
										<label class="text-sm font-medium text-foreground" :for="`flow-text-${activeQuestion.questionId}`">
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
											{{ scenario.suggestion.title }}
										</h3>
									</div>

									<div class="grid gap-4 lg:grid-cols-[minmax(0,1.35fr)_minmax(240px,0.85fr)]">
										<div class="rounded-2xl border border-primary/20 bg-primary/5 p-5">
											<p class="break-words text-sm leading-7 text-foreground sm:text-base">
												{{ scenario.suggestion.suggestionText }}
											</p>
										</div>

										<div class="grid gap-3">
											<div class="rounded-2xl border border-border/70 bg-background px-4 py-4">
												<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Evidence base
												</p>
												<p class="mt-2 break-words text-sm leading-6 text-foreground">
													{{ scenario.suggestion.evidenceBase }}
												</p>
											</div>
											<div class="rounded-2xl border border-border/70 bg-background px-4 py-4">
												<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Next step
												</p>
												<p class="mt-2 break-words text-sm leading-6 text-foreground">
													{{ scenario.suggestion.nextStep }}
												</p>
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
											@click="resetSandbox"
										>
											<RotateCcw class="h-4 w-4" />
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

		<details class="group rounded-2xl border border-border/70 bg-muted/20 px-4 py-4 sm:px-5">
			<summary class="grid cursor-pointer list-none gap-4 sm:grid-cols-[minmax(0,1fr)_auto] sm:items-start">
				<div class="space-y-1">
					<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
						Optional inspector
					</p>
					<h3 class="text-base font-semibold text-foreground">
						Edit sandbox content
					</h3>
					<p class="text-sm leading-6 text-muted-foreground">
						Open only if you need to change the preview scenario.
					</p>
				</div>
				<ChevronDown class="mt-0.5 h-5 w-5 shrink-0 text-muted-foreground transition-transform duration-200 group-open:rotate-180" />
			</summary>

			<div class="mt-5 space-y-8 border-t border-border/60 pt-5">
				<section class="space-y-4">
					<div class="grid gap-4 lg:grid-cols-2">
						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="demo-title">
								Scenario title
							</label>
							<Input id="demo-title" v-model="scenario.scenarioTitle" class="h-11" />
						</div>

						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="demo-note">
								Scenario note
							</label>
							<Textarea id="demo-note" v-model="scenario.scenarioNote" class="min-h-28" />
						</div>
					</div>

					<div class="grid gap-4 lg:grid-cols-3">
						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="category-name">
								Category name
							</label>
							<Input id="category-name" v-model="scenario.category.name" class="h-11" />
						</div>

						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="category-id">
								Category ID
							</label>
							<Input id="category-id" v-model="scenario.category.id" class="h-11" />
						</div>

						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="category-description">
								Category description
							</label>
							<Textarea id="category-description" v-model="scenario.category.description" class="min-h-28" />
						</div>
					</div>

					<div class="grid gap-4 lg:grid-cols-3">
						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="subcategory-name">
								Subcategory name
							</label>
							<Input id="subcategory-name" v-model="scenario.subcategory.name" class="h-11" />
						</div>

						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="subcategory-id">
								Subcategory ID
							</label>
							<Input id="subcategory-id" v-model="scenario.subcategory.id" class="h-11" />
						</div>

						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="subcategory-severity">
								Severity
							</label>
							<Input id="subcategory-severity" v-model="scenario.subcategory.severity" class="h-11" />
						</div>
					</div>

					<div class="space-y-2">
						<label class="text-sm font-medium text-foreground" for="subcategory-description">
							Subcategory description
						</label>
						<Textarea id="subcategory-description" v-model="scenario.subcategory.description" class="min-h-28" />
					</div>
				</section>

				<section class="space-y-4">
					<div>
						<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Questions
						</p>
						<h4 class="mt-1 text-base font-semibold text-foreground">
							Edit the transcript copy
						</h4>
					</div>

					<div class="space-y-6">
						<article
							v-for="(question, index) in scenario.assessments"
							:key="question.questionId"
							class="space-y-4 border-t border-border/70 pt-6 first:border-t-0 first:pt-0"
						>
								<div class="flex flex-wrap items-center gap-2">
									<div class="flex h-8 w-8 items-center justify-center rounded-full border border-primary/20 bg-primary/10 text-sm font-semibold text-primary">
										{{ index + 1 }}
									</div>
									<h5 class="break-all text-sm font-semibold tracking-tight text-foreground">
										{{ question.questionId }}
									</h5>
								</div>

							<div class="grid gap-4 lg:grid-cols-2">
								<div class="space-y-2">
									<label class="text-sm font-medium text-foreground" :for="`question-label-${question.questionId}`">
										Question label
									</label>
									<Input :id="`question-label-${question.questionId}`" v-model="question.questionLabel" class="h-11" />
								</div>

								<div class="space-y-2">
									<label class="text-sm font-medium text-foreground" :for="`question-type-${question.questionId}`">
										Response type
									</label>
									<select
										:id="`question-type-${question.questionId}`"
										v-model="question.responseType"
										class="h-11 w-full rounded-md border border-input bg-background px-3 text-sm text-foreground shadow-xs outline-none transition-colors focus-visible:border-ring focus-visible:ring-2 focus-visible:ring-ring/40"
									>
										<option value="scale">Scale</option>
										<option value="text">Text</option>
									</select>
								</div>
							</div>

							<div class="space-y-2">
								<label class="text-sm font-medium text-foreground" :for="`question-text-${question.questionId}`">
									Question text
								</label>
								<Textarea :id="`question-text-${question.questionId}`" v-model="question.questionText" class="min-h-28" />
							</div>

							<div v-if="question.responseType === 'scale'" class="space-y-4">
								<div class="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
									<div
										v-for="(label, scaleIndex) in question.scaleLabels"
										:key="`${question.questionId}-scale-${scaleIndex}`"
										class="space-y-2"
									>
										<label class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Scale {{ scaleIndex + 1 }}
										</label>
										<Input v-model="question.scaleLabels[scaleIndex]" class="h-11" />
									</div>
								</div>

								<div class="space-y-2">
									<label class="text-sm font-medium text-foreground" :for="`question-score-${question.questionId}`">
										Simulated answer
									</label>
									<select
										:id="`question-score-${question.questionId}`"
										v-model.number="question.scaleValue"
										class="h-11 w-full rounded-md border border-input bg-background px-3 text-sm text-foreground shadow-xs outline-none transition-colors focus-visible:border-ring focus-visible:ring-2 focus-visible:ring-ring/40"
									>
										<option :value="1">1 - {{ question.scaleLabels[0] }}</option>
										<option :value="2">2 - {{ question.scaleLabels[1] }}</option>
										<option :value="3">3 - {{ question.scaleLabels[2] }}</option>
										<option :value="4">4 - {{ question.scaleLabels[3] }}</option>
									</select>
								</div>
							</div>

							<div v-else class="space-y-2">
								<label class="text-sm font-medium text-foreground" :for="`question-answer-${question.questionId}`">
									Simulated answer
								</label>
								<Textarea :id="`question-answer-${question.questionId}`" v-model="question.textValue" class="min-h-28" />
							</div>
						</article>
					</div>
				</section>

				<section class="space-y-4 border-t border-border/70 pt-6">
					<div>
						<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Suggestion
						</p>
						<h4 class="mt-1 text-base font-semibold text-foreground">
							Edit the final response
						</h4>
					</div>

					<div class="grid gap-4 lg:grid-cols-2">
						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="suggestion-title">
								Suggestion title
							</label>
							<Input id="suggestion-title" v-model="scenario.suggestion.title" class="h-11" />
						</div>

						<div class="space-y-2">
							<label class="text-sm font-medium text-foreground" for="suggestion-evidence">
								Evidence base
							</label>
							<Input id="suggestion-evidence" v-model="scenario.suggestion.evidenceBase" class="h-11" />
						</div>
					</div>

					<div class="space-y-2">
						<label class="text-sm font-medium text-foreground" for="suggestion-text">
							Suggestion text
						</label>
						<Textarea id="suggestion-text" v-model="scenario.suggestion.suggestionText" class="min-h-28" />
					</div>

					<div class="space-y-2">
						<label class="text-sm font-medium text-foreground" for="suggestion-next-step">
							Next step
						</label>
						<Textarea id="suggestion-next-step" v-model="scenario.suggestion.nextStep" class="min-h-28" />
					</div>
				</section>
			</div>
		</details>
	</section>
</template>
