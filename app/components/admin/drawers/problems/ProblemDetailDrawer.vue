<template>
	<Sheet :open="open" @update:open="handleOpenChange">
		<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
			<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
				<SheetHeader class="space-y-1">
					<SheetTitle class="text-lg">Subcategory Details</SheetTitle>
					<SheetDescription class="text-sm">
						View detailed information about this subcategory
					</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
				<div v-if="item" class="space-y-4">
					<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
						<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Subcategory name
						</p>
						<h3 class="mt-2 text-2xl font-semibold tracking-tight text-foreground">
							{{ item.problem_name }}
						</h3>
						<div class="mt-4 grid gap-3 sm:grid-cols-2">
							<RelationContextBlock
								label="Parent category"
								:state="categoryContext"
								:action-label="categorySpec.actionLabel"
								@open-action="emitSingleRelation"
								@retry="emit('retry')"
							/>
							<RelationContextBlock
								label="Linked records by subcategory"
								:state="subCategoryContext"
								:action-label="subCategorySpec.actionLabel"
								@open-action="emitListRelation"
								@retry="emit('retry')"
							/>
						</div>
						<div class="mt-4 grid gap-3">
							<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									{{ categorySpec.label }}
								</p>
								<p class="mt-1 text-xs leading-5 text-muted-foreground">
									{{ categorySpec.meaning }}
								</p>
								<div class="mt-2 flex flex-wrap items-center gap-2">
									<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
										{{ item.category || "Unknown category" }}
									</Badge>
									<Badge
										v-if="item.severity_level"
										variant="outline"
										class="h-6 rounded-full px-2 text-[11px] font-medium"
									>
										Level {{ item.severity_level }}
									</Badge>
								</div>
								<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
									<p class="min-w-0 break-all text-sm text-foreground">
										ID: {{ item.category_id || "-" }}
									</p>
									<Button
										type="button"
										variant="ghost"
										size="icon"
										class="h-11 w-11 shrink-0"
										:title="'Copy parent category ID'"
										:aria-label="'Copy parent category ID'"
										:disabled="!item.category_id"
										@click="emitCopy(item.category_id, 'Parent Category ID')"
									>
										<Copy class="h-4 w-4" />
									</Button>
								</div>
							</div>

							<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									{{ subCategorySpec.label }}
								</p>
								<p class="mt-1 text-xs leading-5 text-muted-foreground">
									{{ subCategorySpec.meaning }}
								</p>
								<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
									<p class="min-w-0 break-all text-sm text-foreground">
										{{ item.sub_category_id || "-" }}
									</p>
									<Button
										type="button"
										variant="ghost"
										size="icon"
										class="h-11 w-11 shrink-0"
										:title="'Copy subcategory ID'"
										:aria-label="'Copy subcategory ID'"
										:disabled="!item.sub_category_id"
										@click="emitCopy(item.sub_category_id, 'Subcategory ID')"
									>
										<Copy class="h-4 w-4" />
									</Button>
								</div>
							</div>
						</div>
						<div class="mt-4 space-y-1">
							<p class="text-sm font-medium text-muted-foreground">Description</p>
							<p class="text-sm leading-relaxed text-foreground">
								{{ item.description || "No description provided." }}
							</p>
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
									<div class="space-y-1 sm:col-span-2">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Record ID
										</dt>
										<p class="text-xs leading-5 text-muted-foreground">
											{{ recordSpec.meaning }}
										</p>
										<dd class="flex items-center gap-2">
											<span class="min-w-0 break-all text-foreground">
												{{ item.id || "-" }}
											</span>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy record ID'"
												:aria-label="'Copy record ID'"
												:disabled="!item.id"
												@click="emitCopy(item.id, 'Record ID')"
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
					<Button variant="outline" size="sm" class="flex-1" @click="emit('update:open', false)">
						Close
					</Button>
					<Button size="sm" class="flex-1" @click="emit('edit')">Edit</Button>
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
	RelationActionPayload,
	RelationSummaryState,
} from "@/composables/drawers/types";

interface Props {
	open: boolean;
	item: Record<string, any> | null;
	technicalOpen: boolean;
	categorySpec: RelationSpec;
	subCategorySpec: RelationSpec;
	recordSpec: RelationSpec;
	categoryContext: RelationSummaryState;
	subCategoryContext: RelationSummaryState;
}

const props = defineProps<Props>();

const emit = defineEmits<{
	(e: "update:open", value: boolean): void;
	(e: "update:technicalOpen", value: boolean): void;
	(e: "edit"): void;
	(e: "copy-id", payload: CopyIdPayload): void;
	(e: "open-single-relation", payload: RelationActionPayload): void;
	(e: "open-list-relation", payload: LinkedListRequestPayload): void;
	(e: "retry"): void;
}>();

const handleOpenChange = (value: boolean) => {
	emit("update:open", value);
};

const emitCopy = (value: unknown, label: string) => {
	emit("copy-id", { value, label });
};

const emitSingleRelation = () => {
	emit("open-single-relation", {
		scopeKey: "problems_detail",
		idField: "category_id",
		idValue: props.item?.category_id,
	});
};

const emitListRelation = () => {
	emit("open-list-relation", {
		scopeKey: "problems_detail",
		idField: "sub_category_id",
		idValue: props.item?.sub_category_id,
		title: "Records Linked To This Subcategory",
		description:
			"Assessment questions and suggestions that reference this subcategory ID.",
	});
};
</script>
