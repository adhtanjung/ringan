<script setup lang="ts">
import { computed } from "vue";
import { Badge } from "@/components/ui/badge";

const props = withDefaults(
	defineProps<{
		eyebrow?: string;
		title: string;
		description?: string;
		total?: number;
		totalLabel?: string;
		pageCount?: number;
		searchQuery?: string;
		filters?: Record<string, any>;
	}>(),
	{
		eyebrow: "",
		description: "",
		total: null,
		totalLabel: "",
		pageCount: null,
		searchQuery: "",
		filters: () => ({}),
	},
);

const activeFilterCount = computed(() => {
	return Object.entries(props.filters).filter(([key, value]) => {
		if (value === null || value === "__all__") return false;
		if (key === "is_active" && value === "true") return false;
		return String(value).trim() !== "";
	}).length;
});

const hasSearch = computed(() => props.searchQuery.trim().length > 0);
const showTotal = computed(
	() => props.total !== null && props.total !== undefined,
);
const showPageCount = computed(
	() => props.pageCount !== null && props.pageCount !== undefined,
);
</script>

<template>
	<section
		class="relative overflow-hidden rounded-3xl border border-border/70 bg-card px-5 py-6 shadow-sm sm:px-6 sm:py-7 lg:px-8"
	>
		<div
			class="pointer-events-none absolute inset-y-0 right-0 w-1/3 bg-gradient-to-l from-primary/10 via-transparent to-transparent"
		/>
		<div
			class="pointer-events-none absolute -right-12 top-0 h-40 w-40 rounded-full bg-primary/10 blur-3xl"
		/>

		<div
			class="relative flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between"
		>
			<div class="max-w-3xl space-y-4">
				<div class="flex flex-wrap items-center gap-2">
					<Badge
						v-if="eyebrow"
						variant="secondary"
						class="rounded-full px-3 py-1 text-[11px] font-semibold uppercase tracking-[0.2em]"
					>
						{{ eyebrow }}
					</Badge>
					<Badge
						v-if="showTotal"
						variant="outline"
						class="rounded-full px-3 py-1 text-[11px] text-muted-foreground"
					>
						{{ total }} {{ totalLabel || "items" }} total
					</Badge>
				</div>

				<div class="space-y-2">
					<h1 class="text-3xl font-semibold tracking-tight text-foreground sm:text-4xl">
						{{ title }}
					</h1>
					<p
						v-if="description"
						class="max-w-2xl text-sm leading-6 text-muted-foreground sm:text-base"
					>
						{{ description }}
					</p>
				</div>

				<div class="flex flex-wrap gap-2">
					<div
						v-if="showPageCount"
						class="rounded-full border border-border/70 bg-background/80 px-3 py-1.5 text-xs text-muted-foreground"
					>
						{{ pageCount }} on this page
					</div>
					<div
						v-if="hasSearch"
						class="rounded-full border border-border/70 bg-background/80 px-3 py-1.5 text-xs text-muted-foreground"
					>
						Search active
					</div>
					<div
						v-if="activeFilterCount > 0"
						class="rounded-full border border-border/70 bg-background/80 px-3 py-1.5 text-xs text-muted-foreground"
					>
						{{ activeFilterCount }} active filter{{ activeFilterCount > 1 ? "s" : "" }}
					</div>
				</div>
			</div>

			<div class="flex flex-wrap items-center gap-2 lg:justify-end">
				<slot name="actions" />
			</div>
		</div>
	</section>
</template>
