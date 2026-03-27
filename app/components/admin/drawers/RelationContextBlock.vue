<template>
	<div class="rounded-2xl border border-border/70 bg-muted/20 p-4">
		<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
			{{ label }}
		</p>

		<div v-if="state.loading" class="mt-3 flex items-center gap-2 text-sm text-muted-foreground">
			<Loader2 class="h-4 w-4 animate-spin" />
			<span>{{ loadingText }}</span>
		</div>

		<div v-else-if="state.status === 'missing'" class="mt-3 text-sm text-muted-foreground">
			{{ missingText }}
		</div>

		<div v-else-if="state.status === 'error'" class="mt-3 space-y-2">
			<div class="flex items-start gap-2 text-sm text-destructive">
				<AlertCircle class="mt-0.5 h-4 w-4 shrink-0" />
				<p>{{ state.error || errorText }}</p>
			</div>
			<Button type="button" variant="outline" size="sm" class="h-9" @click="emit('retry')">
				Retry
			</Button>
		</div>

		<div v-else-if="state.status === 'not_found'" class="mt-3 space-y-2">
			<div class="flex items-start gap-2 text-sm text-muted-foreground">
				<AlertCircle class="mt-0.5 h-4 w-4 shrink-0 text-amber-500" />
				<p>{{ notFoundText }}</p>
			</div>
			<div v-if="hasIdentifier" class="text-xs text-muted-foreground">
				{{ state.data?.idLabel }}:
				<span class="font-mono text-foreground">{{ state.data?.idValue }}</span>
			</div>
		</div>

		<div v-else-if="state.data" class="mt-3 space-y-2">
			<p class="text-sm font-semibold text-foreground">{{ state.data.title }}</p>
			<p v-if="state.data.subtitle" class="text-sm text-muted-foreground">
				{{ state.data.subtitle }}
			</p>
			<div v-if="state.data.badges?.length" class="flex flex-wrap gap-1">
				<Badge
					v-for="badge in state.data.badges"
					:key="`relation-badge-${badge}`"
					variant="outline"
					class="h-6 rounded-full px-2 text-[11px] font-medium"
				>
					{{ badge }}
				</Badge>
			</div>
			<div class="text-xs text-muted-foreground">
				{{ state.data.idLabel }}:
				<span class="font-mono text-foreground">{{ state.data.idValue }}</span>
			</div>
		</div>

		<Button
			v-if="showAction && actionLabel"
			type="button"
			variant="outline"
			size="sm"
			class="mt-3 h-10 w-full justify-between px-3 text-left"
			:disabled="actionDisabledComputed"
			@click="emit('open-action')"
		>
			<span class="text-sm font-medium">{{ actionLabel }}</span>
			<ChevronDown class="h-4 w-4 -rotate-90" />
		</Button>
	</div>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { AlertCircle, ChevronDown, Loader2 } from "lucide-vue-next";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import type { RelationSummaryState } from "@/composables/drawers/types";

interface Props {
	label: string;
	state: RelationSummaryState;
	actionLabel?: string;
	showAction?: boolean;
	actionDisabled?: boolean;
	loadingText?: string;
	missingText?: string;
	notFoundText?: string;
	errorText?: string;
}

const props = withDefaults(defineProps<Props>(), {
	actionLabel: "",
	showAction: true,
	actionDisabled: false,
	loadingText: "Resolving linked record...",
	missingText: "No linked record configured for this field.",
	notFoundText: "Linked ID was found, but no active related record exists.",
	errorText: "We couldn't resolve the linked record. Please try again.",
});

const emit = defineEmits<{
	(e: "open-action"): void;
	(e: "retry"): void;
}>();

const hasIdentifier = computed(() => {
	return Boolean(props.state.data?.idValue);
});

const actionDisabledComputed = computed(() => {
	return props.actionDisabled || props.state.loading || !hasIdentifier.value;
});
</script>
