<script setup lang="ts">
import { ref, computed, onMounted } from "vue";
import {
	MessageSquare,
	Send,
	Loader2,
	AlertCircle,
	Sparkles,
	HelpCircle,
	CheckCircle2,
	X,
	ChevronDown,
	ChevronUp,
} from "lucide-vue-next";
import { useRoute } from "vue-router";
import { useSupabase } from "@/composables/useSupabase";
import { useToast } from "@/components/ui/toast/use-toast";

// Shadcn Components
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetHeader,
	SheetTitle,
	SheetTrigger,
	SheetFooter,
	SheetClose,
} from "@/components/ui/sheet";
import {
	Collapsible,
	CollapsibleContent,
	CollapsibleTrigger,
} from "@/components/ui/collapsible";

const { supabase } = useSupabase();
const { toast } = useToast();
const route = useRoute();

const browserStats = ref({
	viewport: "Loading...",
	userAgent: "Loading...",
});

onMounted(() => {
	browserStats.value = {
		viewport: `${window.innerWidth}x${window.innerHeight}`,
		userAgent: navigator.userAgent,
	};
});

const isOpen = ref(false);
const isSubmitting = ref(false);
const isSuccess = ref(false);
const showTechDetails = ref(false);

const feedbackType = ref("issue");
const message = ref("");

const feedbackTypes = [
	{
		value: "issue",
		label: "Report Issue",
		description: "Something isn't working right",
		icon: AlertCircle,
		color: "text-red-500",
		bg: "bg-red-500/10",
		border: "border-red-500/20",
		activeBorder: "border-red-500",
	},
	{
		value: "idea",
		label: "Feature Idea",
		description: "I have a suggestion",
		icon: Sparkles,
		color: "text-amber-500",
		bg: "bg-amber-500/10",
		border: "border-amber-500/20",
		activeBorder: "border-amber-500",
	},
	{
		value: "question",
		label: "Just Asking",
		description: "How does this work?",
		icon: HelpCircle,
		color: "text-blue-500",
		bg: "bg-blue-500/10",
		border: "border-blue-500/20",
		activeBorder: "border-blue-500",
	},
];

const submitFeedback = async () => {
	if (!message.value.trim()) return;

	isSubmitting.value = true;

	try {
		const { error } = await supabase.from("feedback").insert({
			feedback_type: feedbackType.value,
			message: message.value,
			page_route: route.path,
			browser_info: {
				userAgent: navigator.userAgent,
				language: navigator.language,
				viewport: `${window.innerWidth}x${window.innerHeight}`,
			},
			created_at: new Date().toISOString(),
		});

		if (error) throw error;

		// Show success state
		isSuccess.value = true;

		// Reset form after delay
		setTimeout(() => {
			if (isOpen.value) {
				handleOpenChange(false);
			}
		}, 2000);
	} catch (err: any) {
		console.error("Feedback error:", err);
		toast({
			title: "Error",
			description: "Failed to send feedback. Please try again.",
			variant: "destructive",
		});
		isSubmitting.value = false;
	}
};

const handleOpenChange = (open: boolean) => {
	isOpen.value = open;
	if (!open) {
		// Reset state slightly after close animation starts
		setTimeout(() => {
			isSubmitting.value = false;
			isSuccess.value = false;
			message.value = "";
			feedbackType.value = "issue";
			showTechDetails.value = false;
		}, 300);
	}
};
</script>

<template>
	<Sheet :open="isOpen" @update:open="handleOpenChange">
		<SheetTrigger as-child>
			<button
				class="feedback-trigger fixed bottom-6 right-6 h-14 w-14 rounded-full bg-primary text-primary-foreground shadow-xl hover:scale-105 active:scale-95 transition-all duration-300 flex items-center justify-center z-50 group overflow-hidden"
				aria-label="Give Feedback"
			>
				<div
					class="absolute inset-0 bg-white/20 translate-y-full group-hover:translate-y-0 transition-transform duration-500 rounded-full"
				></div>
				<MessageSquare
					class="h-6 w-6 relative z-10 group-hover:scale-110 transition-transform duration-300"
				/>
				<span
					class="absolute right-[120%] mr-2 px-3 py-1.5 rounded-md bg-foreground text-background text-xs font-medium opacity-0 translate-x-4 group-hover:opacity-100 group-hover:translate-x-0 transition-all duration-300 whitespace-nowrap pointer-events-none shadow-lg"
				>
					Feedback
				</span>
				<!-- Pulse effect -->
				<span
					class="absolute -inset-1 rounded-full border-2 border-primary opacity-20 animate-ping pointer-events-none"
				></span>
			</button>
		</SheetTrigger>

		<SheetContent class="w-full sm:max-w-md flex flex-col p-0 border-l-0">
			<!-- Success State -->
			<div
				v-if="isSuccess"
				class="absolute inset-0 z-50 bg-background flex flex-col items-center justify-center p-6 text-center animate-in fade-in zoom-in-95 duration-300"
			>
				<div
					class="h-20 w-20 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center mb-6"
				>
					<CheckCircle2 class="h-10 w-10 text-green-600 dark:text-green-400" />
				</div>
				<h3 class="text-2xl font-bold mb-2">Thank You!</h3>
				<p class="text-muted-foreground mb-8 max-w-xs">
					Your feedback helps us make Ringan Data better for everyone.
				</p>
				<Button variant="outline" @click="handleOpenChange(false)">
					Close
				</Button>
			</div>

			<!-- Header -->
			<div class="px-6 pt-6 pb-4 border-b bg-muted/30">
				<SheetHeader class="text-left space-y-1">
					<SheetTitle class="text-xl flex items-center gap-2">
						Make it better
						<Sparkles class="h-4 w-4 text-amber-500" />
					</SheetTitle>
					<SheetDescription class="text-base">
						Share details about bugs, feature requests, or any thoughts you
						have.
					</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto">
				<div class="p-6 space-y-8">
					<!-- Type Selector -->
					<div class="space-y-3">
						<Label
							class="text-xs font-semibold uppercase tracking-wider text-muted-foreground"
						>
							I want to...
						</Label>
						<div class="grid grid-cols-1 gap-3" role="radiogroup">
							<button
								v-for="type in feedbackTypes"
								:key="type.value"
								@click="feedbackType = type.value"
								class="flex items-start p-3 rounded-xl border-2 transition-all duration-200 text-left relative group hover:shadow-md"
								:class="[
									feedbackType === type.value
										? `bg-background ${
												type.activeBorder
										  } ring-1 ring-offset-0 ${type.activeBorder.replace(
												'border-',
												'ring-'
										  )}`
										: 'border-transparent bg-muted/50 hover:bg-muted border-dashed border-muted-foreground/20',
								]"
								role="radio"
								:aria-checked="feedbackType === type.value"
							>
								<div
									class="h-8 w-8 rounded-full flex items-center justify-center mr-3 mt-0.5 transition-colors"
									:class="[
										feedbackType === type.value
											? 'bg-transparent'
											: 'bg-background',
									]"
								>
									<component
										:is="type.icon"
										class="h-5 w-5"
										:class="type.color"
									/>
								</div>
								<div class="flex-1">
									<div
										class="font-semibold text-sm flex items-center justify-between"
									>
										{{ type.label }}
										<span
											v-if="feedbackType === type.value"
											class="h-2 w-2 rounded-full absolute right-3 top-3 animate-pulse"
											:class="type.color.replace('text-', 'bg-')"
										></span>
									</div>
									<div class="text-xs text-muted-foreground mt-0.5">
										{{ type.description }}
									</div>
								</div>
							</button>
						</div>
					</div>

					<!-- Message Input -->
					<div class="space-y-3">
						<Label
							for="feedback-message"
							class="text-xs font-semibold uppercase tracking-wider text-muted-foreground"
						>
							Tell us more
						</Label>
						<div class="relative">
							<Textarea
								id="feedback-message"
								v-model="message"
								placeholder="What's happening? Be as detailed as you like..."
								class="min-h-[160px] resize-none text-base p-4 bg-muted/20 border-muted-foreground/20 focus:bg-background transition-colors"
								:disabled="isSubmitting"
							/>
							<div
								class="absolute bottom-3 right-3 text-xs text-muted-foreground pointer-events-none"
							>
								{{ message.length }} chars
							</div>
						</div>
					</div>

					<!-- Technical Details Collapsible -->
					<Collapsible v-model:open="showTechDetails" class="space-y-2">
						<div class="flex items-center justify-between">
							<Label
								class="text-xs font-semibold uppercase tracking-wider text-muted-foreground"
							>
								Technical Details
							</Label>
							<CollapsibleTrigger as-child>
								<Button variant="ghost" size="sm" class="h-6 w-6 p-0">
									<component
										:is="showTechDetails ? ChevronUp : ChevronDown"
										class="h-4 w-4"
									/>
									<span class="sr-only">Toggle</span>
								</Button>
							</CollapsibleTrigger>
						</div>
						<CollapsibleContent class="space-y-2">
							<div
								class="p-3 rounded-lg bg-muted/40 border border-border/50 space-y-2 text-xs font-mono"
							>
								<div class="flex justify-between">
									<span class="text-muted-foreground">Route:</span>
									<span class="truncate max-w-[200px]">{{ route.path }}</span>
								</div>
								<div class="flex justify-between">
									<span class="text-muted-foreground">Viewport:</span>
									<span>{{ browserStats.viewport }}</span>
								</div>
								<div class="flex justify-between">
									<span class="text-muted-foreground">Browser:</span>
									<span class="truncate max-w-[200px]">{{
										browserStats.userAgent.split(")")[0] + ")"
									}}</span>
								</div>
							</div>
						</CollapsibleContent>
					</Collapsible>
				</div>
			</div>

			<SheetFooter
				class="p-6 pt-2 border-t mt-auto bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
			>
				<div class="flex gap-3 w-full">
					<SheetClose as-child>
						<Button variant="outline" class="flex-1" :disabled="isSubmitting">
							Cancel
						</Button>
					</SheetClose>
					<Button
						@click="submitFeedback"
						class="flex-[2] h-11 shadow-md hover:shadow-lg transition-all"
						:disabled="isSubmitting || !message.trim()"
					>
						<template v-if="isSubmitting">
							<Loader2 class="mr-2 h-4 w-4 animate-spin" />
							Sending...
						</template>
						<template v-else>
							<Send class="mr-2 h-4 w-4" />
							Submit Feedback
						</template>
					</Button>
				</div>
			</SheetFooter>
		</SheetContent>
	</Sheet>
</template>

<style scoped>
.feedback-trigger {
	box-shadow: 0 8px 30px -4px rgba(0, 0, 0, 0.3);
}
</style>
