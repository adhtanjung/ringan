<template>
	<div
		class="relative flex items-center justify-center w-4 h-4 cursor-pointer"
		@click="toggle"
	>
		<div
			class="h-4 w-4 shrink-0 rounded border border-primary ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 transition-all duration-200"
			:class="[
				effectiveChecked === true || effectiveChecked === 'indeterminate'
					? 'bg-primary'
					: 'bg-background',
			]"
		/>
		<Check
			v-if="effectiveChecked === true"
			class="absolute pointer-events-none h-3 w-3 text-primary-foreground stroke-3"
		/>
		<Minus
			v-if="effectiveChecked === 'indeterminate'"
			class="absolute pointer-events-none h-3 w-3 text-primary-foreground stroke-3"
		/>
	</div>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { Check, Minus } from "lucide-vue-next";

const props = defineProps<{
	modelValue?: boolean | "indeterminate";
	checked?: boolean | "indeterminate";
}>();

const emit = defineEmits(["update:modelValue", "update:checked", "change"]);

const effectiveChecked = computed(() => {
	if (props.modelValue !== undefined) return props.modelValue;
	return props.checked;
});

const toggle = () => {
	const newValue = effectiveChecked.value !== true;
	emit("update:modelValue", newValue);
	emit("update:checked", newValue);
	emit("change", newValue);
};
</script>
