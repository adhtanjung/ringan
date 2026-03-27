<template>
	<Sheet :open="open" @update:open="(value) => emit('update:open', value)">
		<SheetContent class="flex w-full flex-col p-0 sm:max-w-xl">
			<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
				<SheetHeader class="space-y-1">
					<SheetTitle class="text-lg">Category details</SheetTitle>
					<SheetDescription class="text-sm">
						Review the category name, description, and supporting metadata.
					</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
				<div v-if="item" class="space-y-4">
					<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
						<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Category name
						</p>
						<h3 class="mt-2 break-words text-2xl font-semibold tracking-tight text-foreground">
							{{ item.type_name }}
						</h3>
						<p class="mt-3 text-sm leading-6 text-muted-foreground">
							{{ item.description || "No description provided." }}
						</p>
						<p class="mt-3 text-xs leading-5 text-muted-foreground">
							Subcategories tied to this category are managed on the Subcategories page.
						</p>
						<div class="mt-4 flex flex-wrap gap-2">
							<Badge
								v-if="item.updated_at"
								variant="outline"
								class="h-6 rounded-full px-2 text-[11px] font-medium text-muted-foreground"
							>
								Updated {{ formatDate(item.updated_at as string) }}
							</Badge>
						</div>
					</div>
					<RelationContextBlock
						:label="categorySpec.label"
						:state="categoryContext"
						:action-label="categorySpec.actionLabel"
						@open-action="emitListRelation"
						@retry="emit('retry')"
					/>

					<div class="grid gap-3 sm:grid-cols-2">
						<div class="rounded-2xl border border-border/70 bg-background p-4">
							<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
								{{ categorySpec.label }}
							</p>
							<p class="mt-1 text-xs leading-5 text-muted-foreground">
								{{ categorySpec.meaning }}
							</p>
							<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
								<p class="min-w-0 break-all text-sm font-medium text-foreground">
									{{ item.category_id || "-" }}
								</p>
								<Button
									type="button"
									variant="ghost"
									size="icon"
									class="h-11 w-11 shrink-0"
									:title="'Copy category ID'"
									:aria-label="'Copy category ID'"
									:disabled="!item.category_id"
									@click="emit('copy-id', { value: item.category_id, label: 'Category ID' })"
								>
									<Copy class="h-4 w-4" />
								</Button>
							</div>
						</div>
						<div class="rounded-2xl border border-border/70 bg-background p-4">
							<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
								Record ID
							</p>
							<p class="mt-1 text-xs leading-5 text-muted-foreground">
								{{ recordSpec.meaning }}
							</p>
							<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
								<p class="min-w-0 break-all text-sm font-medium text-foreground">
									{{ item.id || "-" }}
								</p>
								<Button
									type="button"
									variant="ghost"
									size="icon"
									class="h-11 w-11 shrink-0"
									:title="'Copy record ID'"
									:aria-label="'Copy record ID'"
									:disabled="!item.id"
									@click="emit('copy-id', { value: item.id, label: 'Record ID' })"
								>
									<Copy class="h-4 w-4" />
								</Button>
							</div>
						</div>
					</div>

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
											Created
										</dt>
										<dd class="break-words text-foreground">
											{{ item.created_at ? formatDate(item.created_at as string) : "-" }}
										</dd>
									</div>
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Updated
										</dt>
										<dd class="break-words text-foreground">
											{{ item.updated_at ? formatDate(item.updated_at as string) : "-" }}
										</dd>
									</div>
								</dl>
							</div>
						</CollapsibleContent>
					</Collapsible>
				</div>
			</div>

			<div class="border-t border-border/70 bg-background px-4 py-4 sm:px-6">
				<SheetFooter class="flex-row gap-2">
					<Button variant="outline" class="flex-1" @click="emit('update:open', false)">
						Close
					</Button>
					<Button class="flex-1" @click="emit('edit')">Edit</Button>
				</SheetFooter>
			</div>
		</SheetContent>
	</Sheet>
</template>

<script setup lang="ts">
import { ChevronDown, Copy } from "lucide-vue-next";
import { formatDate } from "@/utils/formatDate";
import RelationContextBlock from "@/components/admin/drawers/RelationContextBlock.vue";
import { Badge } from "@/components/ui/badge";
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
	item: Record<string, any> | null;
	technicalOpen: boolean;
	categorySpec: RelationSpec;
	recordSpec: RelationSpec;
	categoryContext: RelationSummaryState;
}

const props = defineProps<Props>();

const emit = defineEmits<{
	(e: "update:open", value: boolean): void;
	(e: "update:technicalOpen", value: boolean): void;
	(e: "edit"): void;
	(e: "copy-id", payload: CopyIdPayload): void;
	(e: "open-list-relation", payload: LinkedListRequestPayload): void;
	(e: "retry"): void;
}>();

const emitListRelation = () => {
	emit("open-list-relation", {
		scopeKey: "problem_types_detail",
		idField: "category_id",
		idValue: props.item?.category_id,
		title: "Subcategories Linked To This Category",
		description: "Subcategory records that reference this category ID.",
	});
};
</script>
