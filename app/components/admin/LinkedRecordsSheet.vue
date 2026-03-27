<template>
	<Sheet :open="open" @update:open="handleOpenChange">
		<SheetContent class="flex h-full w-full flex-col p-0 sm:max-w-lg">
			<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
				<SheetHeader class="space-y-1">
					<SheetTitle class="text-lg">{{ title }}</SheetTitle>
					<SheetDescription class="text-sm">{{ description }}</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
				<div v-if="loading" class="mt-6 flex items-center justify-center py-8">
					<div class="flex items-center gap-2 text-muted-foreground">
						<Loader2 class="h-4 w-4 animate-spin" />
						<span class="text-sm">Loading related records...</span>
					</div>
				</div>

				<div
					v-else-if="error"
					class="mt-6 rounded-2xl border border-destructive/40 bg-destructive/5 p-4"
				>
					<div class="flex items-start gap-3">
						<AlertCircle class="mt-0.5 h-4 w-4 shrink-0 text-destructive" />
						<div class="space-y-2">
							<p class="text-sm font-medium text-foreground">Couldn’t load linked records</p>
							<p class="text-sm text-muted-foreground">{{ error }}</p>
							<Button
								type="button"
								variant="outline"
								size="sm"
								class="h-10"
								@click="$emit('retry')"
							>
								{{ retryLabel }}
							</Button>
						</div>
					</div>
				</div>

				<div v-else-if="!hasAnyItems" class="mt-6 rounded-2xl border border-border/70 bg-muted/20 p-4">
					<p class="text-sm text-muted-foreground">
						{{ emptyMessage }}
					</p>
				</div>

				<div v-else class="space-y-4">
					<section
						v-for="section in sections"
						:key="section.key"
						class="rounded-2xl border border-border/70 bg-card p-4"
					>
						<div class="flex items-center justify-between gap-3">
							<div>
								<p class="text-sm font-semibold text-foreground">{{ section.title }}</p>
								<p v-if="section.description" class="text-xs text-muted-foreground">
									{{ section.description }}
								</p>
							</div>
							<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
								{{ section.items.length }}
							</Badge>
						</div>

						<div
							v-if="section.items.length === 0"
							class="mt-3 rounded-xl border border-border/70 bg-muted/20 px-3 py-2"
						>
							<p class="text-xs text-muted-foreground">
								{{ section.emptyMessage || "No records found for this relation." }}
							</p>
						</div>

						<div v-else class="mt-3 space-y-2">
							<article
								v-for="item in section.items"
								:key="item.key"
								class="rounded-xl border border-border/70 bg-background p-3"
							>
								<div class="flex items-start justify-between gap-3">
									<div class="space-y-0.5">
										<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											{{ item.businessIdLabel }}
										</p>
										<p class="font-mono text-sm text-foreground">{{ item.businessId }}</p>
									</div>
									<div v-if="item.badges?.length" class="flex flex-wrap justify-end gap-1">
										<Badge
											v-for="badge in item.badges"
											:key="`${item.key}-${badge}`"
											variant="outline"
											class="h-6 rounded-full px-2 text-[11px] font-medium"
										>
											{{ badge }}
										</Badge>
									</div>
								</div>
								<p class="mt-2 text-sm font-medium text-foreground">
									{{ item.title }}
								</p>
								<p v-if="item.subtitle" class="mt-1 text-xs text-muted-foreground">
									{{ item.subtitle }}
								</p>
							</article>
						</div>
					</section>
				</div>
			</div>

			<div class="border-t border-border/70 bg-background px-4 py-4 sm:px-6">
				<SheetFooter>
					<Button variant="outline" size="sm" class="w-full" @click="$emit('update:open', false)">
						Close
					</Button>
				</SheetFooter>
			</div>
		</SheetContent>
	</Sheet>
</template>

<script setup>
import { computed } from "vue";
import { AlertCircle, Loader2 } from "lucide-vue-next";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetFooter,
	SheetHeader,
	SheetTitle,
} from "@/components/ui/sheet";

const props = defineProps({
	open: {
		type: Boolean,
		required: true,
	},
	title: {
		type: String,
		default: "Linked Records",
	},
	description: {
		type: String,
		default: "Records related to this identifier.",
	},
	sections: {
		type: Array,
		default: () => [],
	},
	loading: {
		type: Boolean,
		default: false,
	},
	error: {
		type: String,
		default: "",
	},
	emptyMessage: {
		type: String,
		default: "No linked records were found.",
	},
	retryLabel: {
		type: String,
		default: "Try again",
	},
});

const emit = defineEmits(["update:open", "retry"]);

const hasAnyItems = computed(() => {
	return props.sections.some((section) => Array.isArray(section.items) && section.items.length > 0);
});

const handleOpenChange = (value) => {
	emit("update:open", value);
};
</script>
