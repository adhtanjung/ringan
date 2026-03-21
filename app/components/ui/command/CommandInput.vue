<script setup lang="ts">
import type { HTMLAttributes } from "vue";
import { Search } from "lucide-vue-next";
import { ComboboxInput } from "reka-ui";
import { cn } from "@/lib/utils";

defineOptions({
	inheritAttrs: false,
});

const props = withDefaults(
	defineProps<{
		class?: HTMLAttributes["class"];
		autoFocus?: boolean;
		modelValue?: string | number;
		placeholder?: string;
		displayValue?: (val: any) => string;
		disabled?: boolean;
	}>(),
	{
		autoFocus: true,
	},
);
</script>

<template>
	<div class="flex items-center border-b px-3" cmdk-input-wrapper>
		<Search class="mr-2 h-4 w-4 shrink-0 opacity-50" />
		<ComboboxInput
			v-bind="$attrs"
			:auto-focus="autoFocus"
			:class="
				cn(
					'flex h-11 w-full rounded-md bg-transparent py-3 text-sm outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50',
					props.class,
				)
			"
		/>
	</div>
</template>
