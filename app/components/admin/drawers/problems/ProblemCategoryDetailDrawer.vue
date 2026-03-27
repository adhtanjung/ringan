<template>
	<Sheet :open="open" @update:open="(value) => emit('update:open', value)">
		<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
			<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
				<SheetHeader class="space-y-1">
					<SheetTitle class="text-lg">Category Details</SheetTitle>
					<SheetDescription class="text-sm">
						Problem type category information
					</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
				<div v-if="record" class="space-y-4">
					<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
						<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Parent category
						</p>
						<h3 class="mt-2 text-2xl font-semibold tracking-tight text-foreground">
							{{ record.type_name || "Unknown category" }}
						</h3>
						<div class="mt-3 rounded-lg border border-border/60 bg-muted/20 p-3">
							<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
								{{ categorySpec.label }}
							</p>
							<p class="mt-1 text-xs leading-5 text-muted-foreground">
								{{ categorySpec.meaning }}
							</p>
							<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
								<p class="min-w-0 break-all text-sm text-foreground">
									{{ record.category_id || "-" }}
								</p>
								<Button
									type="button"
									variant="ghost"
									size="icon"
									class="h-11 w-11 shrink-0"
									:title="'Copy category ID'"
									:aria-label="'Copy category ID'"
									:disabled="!record.category_id"
									@click="emit('copy-id', { value: record.category_id, label: 'Category ID' })"
								>
									<Copy class="h-4 w-4" />
								</Button>
							</div>
						</div>
						<div class="mt-4 space-y-1">
							<p class="text-sm font-medium text-muted-foreground">Description</p>
							<p class="text-sm leading-relaxed text-foreground">
								{{ record.description || "No description provided." }}
							</p>
						</div>
					</div>
					<RelationContextBlock
						:label="categorySpec.label"
						:state="categoryContext"
						:action-label="categorySpec.actionLabel"
						@open-action="emitListRelation"
						@retry="emit('retry')"
					/>

					<Collapsible
						:model-value="technicalOpen"
						@update:model-value="(value) => emit('update:technicalOpen', value)"
						class="space-y-2"
					>
						<div class="flex items-center justify-between gap-3">
							<div class="space-y-1">
								<p class="text-xs font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Advanced details
								</p>
								<p class="text-sm text-muted-foreground">
									Technical metadata for auditing and support.
								</p>
							</div>

							<CollapsibleTrigger as-child>
								<Button variant="ghost" size="sm" class="h-9 gap-2 px-3">
									{{ technicalOpen ? "Hide" : "Show" }}
									<ChevronDown
										class="h-4 w-4 transition-transform duration-200"
										:class="technicalOpen ? 'rotate-180' : ''"
									/>
								</Button>
							</CollapsibleTrigger>
						</div>

						<CollapsibleContent class="space-y-2">
							<div class="rounded-2xl border border-border/70 bg-muted/30 p-4">
								<dl class="grid gap-4 text-sm sm:grid-cols-2">
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Record ID
										</dt>
										<p class="text-xs leading-5 text-muted-foreground">
											{{ recordSpec.meaning }}
										</p>
										<dd class="flex items-center gap-2">
											<span class="min-w-0 break-all text-foreground">
												{{ record.id || "-" }}
											</span>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy record ID'"
												:aria-label="'Copy record ID'"
												:disabled="!record.id"
												@click="emit('copy-id', { value: record.id, label: 'Record ID' })"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</dd>
									</div>
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Created
										</dt>
										<dd class="break-words text-foreground">
											{{ record.created_at ? formatDate(record.created_at as string) : "-" }}
										</dd>
									</div>
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Updated
										</dt>
										<dd class="break-words text-foreground">
											{{ record.updated_at ? formatDate(record.updated_at as string) : "-" }}
										</dd>
									</div>
								</dl>
							</div>
						</CollapsibleContent>
					</Collapsible>
				</div>

				<div v-else-if="loading" class="mt-6 flex items-center justify-center py-8">
					<div class="flex items-center gap-2 text-muted-foreground">
						<Loader2 class="h-4 w-4 animate-spin" />
						<span class="text-sm">Loading parent category details...</span>
					</div>
				</div>
				<div
					v-else-if="error"
					class="mt-6 rounded-2xl border border-destructive/40 bg-destructive/5 p-4"
				>
					<div class="flex items-start gap-3">
						<AlertCircle class="mt-0.5 h-4 w-4 shrink-0 text-destructive" />
						<div class="space-y-2">
							<p class="text-sm font-medium text-foreground">Couldn’t load parent category</p>
							<p class="text-sm text-muted-foreground">{{ error }}</p>
							<Button type="button" variant="outline" size="sm" class="h-10" @click="emit('retry')">
								Try again
							</Button>
						</div>
					</div>
				</div>
				<div v-else class="mt-6 rounded-2xl border border-border/70 bg-muted/20 p-4">
					<p class="text-sm text-muted-foreground">
						Category details are unavailable for this subcategory.
					</p>
				</div>
			</div>

			<div class="border-t border-border/70 bg-background px-4 py-4 sm:px-6">
				<SheetFooter>
					<Button variant="outline" size="sm" class="w-full" @click="emit('update:open', false)">
						Close
					</Button>
				</SheetFooter>
			</div>
		</SheetContent>
	</Sheet>
</template>

<script setup lang="ts">
import { AlertCircle, ChevronDown, Copy, Loader2 } from "lucide-vue-next";
import { formatDate } from "@/utils/formatDate";
import RelationContextBlock from "@/components/admin/drawers/RelationContextBlock.vue";
import { Button } from "@/components/ui/button";
import {
	Collapsible,
	CollapsibleContent,
	CollapsibleTrigger,
} from "@/components/ui/collapsible";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetFooter,
	SheetHeader,
	SheetTitle,
} from "@/components/ui/sheet";
import type { RelationSpec } from "@/composables/drawerRelations";
import type {
	CopyIdPayload,
	LinkedListRequestPayload,
	RelationSummaryState,
} from "@/composables/drawers/types";

interface Props {
	open: boolean;
	record: Record<string, any> | null;
	loading: boolean;
	error: string;
	technicalOpen: boolean;
	categorySpec: RelationSpec;
	recordSpec: RelationSpec;
	categoryContext: RelationSummaryState;
}

const props = defineProps<Props>();

const emit = defineEmits<{
	(e: "update:open", value: boolean): void;
	(e: "update:technicalOpen", value: boolean): void;
	(e: "copy-id", payload: CopyIdPayload): void;
	(e: "open-list-relation", payload: LinkedListRequestPayload): void;
	(e: "retry"): void;
}>();

const emitListRelation = () => {
	emit("open-list-relation", {
		scopeKey: "problems_category_detail",
		idField: "category_id",
		idValue: props.record?.category_id,
		title: "Subcategories Linked To This Category",
		description: "Subcategory records that reference this category ID.",
	});
};
</script>
