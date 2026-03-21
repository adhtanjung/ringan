<script setup lang="ts">
import { computed } from "vue";
import {
	Inbox,
	Search,
	Upload,
	Plus,
	Database,
	HelpCircle,
	AlertCircle,
	FileJson,
	BrainCircuit,
	MessageSquare,
	ArrowRight,
} from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

const props = defineProps<{
	datasetType: string;
	hasFilters: boolean;
}>();

const emit = defineEmits(["import", "create", "clear-search"]);

const config = computed(() => {
	if (props.hasFilters) {
		return {
			icon: Search,
			title: "No matching results",
			description:
				"We couldn't find any items matching your current filters or search query.",
			primaryAction: "Clear Filters",
			actionLabel: "Clear Filters",
			action: () => emit("clear-search"),
			tips: [
				"Check for typos in your search query",
				"Try using more general filter terms",
				"Ensure you're looking in the correct category",
			],
		};
	}

	const base = {
		icon: Database,
		title: "Your dataset is empty",
		description:
			"Start building your knowledge base by importing data or creating your first entry.",
		primaryAction: "",
		actionLabel: "New Entry",
		tips: [
			"Download our template to see the required format",
			"Import from CSV or JSON for bulk setup",
		],
		action: () => {},
	};

	switch (props.datasetType) {
		case "problem_types":
			return {
				...base,
				icon: AlertCircle,
				title: "No problem categories yet",
				description:
					"Create your first category to group related subcategories and keep the assessment structure easy to manage.",
				actionLabel: "Create Category",
				tips: [
					"Use broad themes like anxiety, sleep, or mood",
					"Write descriptions that help future editors stay consistent",
					"Keep category IDs stable so subcategories stay linked correctly",
				],
			};
		case "problems":
			return {
				...base,
				icon: Inbox,
				title: "No subcategories yet",
				description:
					"Add subcategories so you can organize assessments and suggestions around specific issues.",
				actionLabel: "Create Subcategory",
				tips: [
					"Give each subcategory a clear, human-readable name",
					"Link it to the correct category before creating assessments",
					"Use the description to capture enough context for future editors",
				],
			};
		case "assessments":
			return {
				...base,
				icon: HelpCircle,
				title: "No assessment questions yet",
				description:
					"Create the questions users will answer during an assessment flow.",
				actionLabel: "Create Question",
				tips: [
					"Choose between Scale (1-4) or Free Text responses",
					"Connect questions to relevant problem categories",
					"Ensure question text is clear and unambiguous",
				],
			};
		case "suggestions":
			return {
				...base,
				icon: BrainCircuit,
				title: "No suggestions yet",
				description:
					"Add the guidance that users will receive after their assessment or check-in.",
				actionLabel: "Create Suggestion",
				tips: [
					"Tailor suggestions to specific categories",
					"Keep advice actionable and supportive",
					"Use structured IDs to link with backend logic",
				],
			};
		case "training_examples":
			return {
				...base,
				icon: FileJson,
				title: "No training examples yet",
				description:
					"Add training examples so your model has better labeled data to learn from.",
				actionLabel: "Create Example",
				tips: [
					"Map actual user inputs to desired classifications",
					"Consistency is key for model performance",
					"Import in JSON format for complex structures",
				],
			};
		case "feedback_prompts":
			return {
				...base,
				icon: MessageSquare,
				title: "No feedback prompts yet",
				description:
					"Create prompts that ask for feedback at the right step in the journey.",
				actionLabel: "Create Prompt",
				tips: [
					"Use prompts to measure satisfaction or feature usage",
					"Keep prompts short and non-intrusive",
					"Categorize prompts by their intent",
				],
			};
		default:
			if (props.datasetType === "next_actions") {
				return {
					...base,
					icon: Inbox,
					title: "No next actions yet",
					description:
						"Add the follow-up actions that move a user to the next step in the flow.",
					actionLabel: "Create Action",
					tips: [
						"Use short action names that read well in dropdowns and tables",
						"Keep action types consistent so the flow is easier to scan",
						"Add context in the description when the action is not obvious",
					],
				};
			}
			return base;
	}
});
</script>

<template>
	<div
		class="flex flex-col items-center justify-center p-8 sm:p-12 md:p-16 text-center animate-in fade-in duration-500"
	>
		<div class="relative mb-6">
			<div
				class="absolute inset-0 bg-primary/5 rounded-full scale-150 blur-xl"
			></div>
			<component
				:is="config.icon"
				class="relative h-16 w-16 text-muted-foreground/40"
			/>
		</div>

		<h3 class="text-xl font-bold tracking-tight mb-2">{{ config.title }}</h3>
		<p class="text-muted-foreground max-w-sm mb-8 leading-relaxed">
			{{ config.description }}
		</p>

		<!-- Initial state actions -->
	<div
		v-if="!hasFilters"
		class="flex flex-col sm:flex-row items-center gap-3"
	>
		<Button
			variant="default"
			@click="emit('create')"
			class="w-full sm:w-auto px-8 group"
		>
			<Plus class="mr-2 h-4 w-4 group-hover:scale-110 transition-transform" />
			{{ config.actionLabel || "New Entry" }}
		</Button>
		<Button
			variant="outline"
				@click="emit('import')"
				class="w-full sm:w-auto px-8"
			>
				<Upload class="mr-2 h-4 w-4" />
				Import Data
			</Button>
		</div>

	<!-- Filter state actions -->
	<div v-else>
		<Button variant="outline" @click="config.action" class="px-8">
			{{ config.primaryAction || config.actionLabel || "Clear Filters" }}
		</Button>
	</div>

		<!-- Onboarding Tips -->
		<Card class="mt-12 w-full max-w-lg border-dashed bg-muted/30">
			<CardHeader class="pb-3">
				<CardTitle
					class="text-xs uppercase tracking-widest text-muted-foreground font-semibold flex items-center justify-center gap-2"
				>
					<BrainCircuit class="h-3.5 w-3.5" />
					Onboarding Tips
				</CardTitle>
			</CardHeader>
			<CardContent>
				<ul class="space-y-4 text-left">
					<li
						v-for="(tip, index) in config.tips"
						:key="index"
						class="flex items-start gap-3 group"
					>
						<div
							class="flex-shrink-0 w-5 h-5 rounded-full bg-primary/10 text-primary flex items-center justify-center text-[10px] font-bold mt-0.5"
						>
							{{ index + 1 }}
						</div>
						<p
							class="text-sm text-foreground/80 leading-snug group-hover:text-foreground transition-colors"
						>
							{{ tip }}
						</p>
					</li>
				</ul>

				<div
					v-if="!hasFilters"
					class="mt-6 pt-4 border-t border-dashed flex items-center justify-center"
				>
					<button
						@click="emit('import')"
						class="text-xs font-medium text-primary hover:underline flex items-center gap-1"
					>
						Need a template? Click here to import
						<ArrowRight class="h-3 w-3" />
					</button>
				</div>
			</CardContent>
		</Card>
	</div>
</template>

<style scoped>
.animate-in {
	animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
	from {
		opacity: 0;
		transform: translateY(10px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}
</style>
