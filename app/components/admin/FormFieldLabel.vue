<template>
	<div class="flex items-center gap-1">
		<Tooltip>
			<TooltipTrigger as-child>
				<Label :for="fieldKey" class="text-sm font-medium cursor-help">
					{{ label }}
					<span v-if="required" class="text-red-500 ml-1">*</span>
				</Label>
			</TooltipTrigger>
			<TooltipContent
				v-if="description"
				class="max-w-xs bg-blue-700 text-white"
			>
				<p class="text-sm">{{ description }}</p>
			</TooltipContent>
		</Tooltip>
		<Tooltip v-if="description">
			<TooltipTrigger as-child>
				<button
					type="button"
					class="inline-flex items-center justify-center w-4 h-4 text-gray-400 hover:text-gray-600 focus:outline-none focus:text-gray-600 rounded-full hover:bg-gray-100 transition-colors"
				>
					<svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
						<path
							fill-rule="evenodd"
							d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
							clip-rule="evenodd"
						/>
					</svg>
				</button>
			</TooltipTrigger>
			<TooltipContent class="max-w-xs">
				<p class="text-sm">{{ description }}</p>
			</TooltipContent>
		</Tooltip>
	</div>
</template>

<script setup lang="ts">
import { Label } from "@/components/ui/label";
import {
	Tooltip,
	TooltipContent,
	TooltipTrigger,
} from "@/components/ui/tooltip";

defineProps<{
	fieldKey: string;
	label: string;
	required?: boolean;
	description?: string;
}>();
</script>
