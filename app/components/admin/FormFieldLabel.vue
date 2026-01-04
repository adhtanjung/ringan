<script setup lang="ts">
import { Label } from "@/components/ui/label";
import {
	Tooltip,
	TooltipContent,
	TooltipTrigger,
} from "@/components/ui/tooltip";
import { HelpCircle } from "lucide-vue-next";

defineProps<{
	fieldKey: string;
	label: string;
	required?: boolean;
	description?: string;
	hintTitle?: string;
}>();
</script>

<template>
	<div class="flex items-center gap-1.5 mb-1.5">
		<Label
			:for="fieldKey"
			class="text-xs sm:text-sm font-semibold text-foreground/90 flex items-center gap-1"
		>
			{{ label }}
			<span
				v-if="required"
				class="text-destructive font-bold text-xs"
				title="Required field"
				>*</span
			>
		</Label>

		<Tooltip v-if="description" :delay-duration="300">
			<TooltipTrigger as-child>
				<button
					type="button"
					tabindex="-1"
					class="inline-flex items-center justify-center text-muted-foreground/60 hover:text-primary transition-colors focus:outline-none"
				>
					<HelpCircle class="h-3.5 w-3.5" />
				</button>
			</TooltipTrigger>
			<TooltipContent
				side="right"
				:side-offset="8"
				class="max-w-xs p-3 bg-popover text-popover-foreground border shadow-md"
			>
				<div class="space-y-1">
					<p
						v-if="hintTitle"
						class="text-xs font-bold uppercase tracking-tight text-foreground/70"
					>
						{{ hintTitle }}
					</p>
					<p class="text-xs leading-relaxed">{{ description }}</p>
				</div>
			</TooltipContent>
		</Tooltip>
	</div>
</template>
