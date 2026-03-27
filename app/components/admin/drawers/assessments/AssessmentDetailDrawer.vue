<template>
	<Sheet :open="open" @update:open="(value) => emit('update:open', value)">
		<SheetContent class="flex h-full w-full flex-col p-0 sm:max-w-lg">
			<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
				<SheetHeader class="space-y-1">
					<SheetTitle class="text-lg">Assessment Question</SheetTitle>
					<SheetDescription class="text-sm">
						View detailed information about this question
					</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
				<div v-if="item" class="space-y-4">
					<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
						<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Question text
						</p>
						<p class="mt-2 text-lg font-semibold leading-tight text-foreground">
							{{ item.question_text }}
						</p>
						<div class="mt-4 flex flex-wrap gap-2">
							<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
								{{ item.response_type === "scale" ? "Scale (1-4)" : "Free Text" }}
							</Badge>
							<Badge
								variant="outline"
								class="h-6 rounded-full px-2 text-[11px] font-medium text-muted-foreground"
							>
								{{ item.sub_category_id || "Unassigned subcategory" }}
							</Badge>
						</div>
						<div class="mt-4">
							<RelationContextBlock
								label="Connected subcategory"
								:state="subCategoryContext"
								:action-label="subCategorySpec.actionLabel"
								@open-action="emitSingleRelation"
								@retry="emit('retry')"
							/>
						</div>
						<div class="mt-4 grid gap-3 sm:grid-cols-2">
							<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									{{ questionSpec.label }}
								</p>
								<p class="mt-1 text-xs leading-5 text-muted-foreground">
									{{ questionSpec.meaning }}
								</p>
								<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
									<p class="min-w-0 break-all text-sm text-foreground">
										{{ item.question_id || "-" }}
									</p>
									<Button
										type="button"
										variant="ghost"
										size="icon"
										class="h-11 w-11 shrink-0"
										:title="'Copy question ID'"
										:aria-label="'Copy question ID'"
										:disabled="!item.question_id"
										@click="emit('copy-id', { value: item.question_id, label: 'Question ID' })"
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
										@click="emit('copy-id', { value: item.sub_category_id, label: 'Subcategory ID' })"
									>
										<Copy class="h-4 w-4" />
									</Button>
								</div>
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
											Question ID
										</dt>
										<p class="text-xs leading-5 text-muted-foreground">
											{{ questionSpec.meaning }}
										</p>
										<dd class="flex items-center gap-2">
											<span class="min-w-0 break-all text-foreground">
												{{ item.question_id || "-" }}
											</span>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy question ID'"
												:aria-label="'Copy question ID'"
												:disabled="!item.question_id"
												@click="emit('copy-id', { value: item.question_id, label: 'Question ID' })"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</dd>
									</div>
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Batch Group
										</dt>
										<p class="text-xs leading-5 text-muted-foreground">
											{{ batchSpec.meaning }}
										</p>
										<dd class="break-words text-foreground">
											{{ item.batch_id || "-" }}
										</dd>
									</div>
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Cluster
										</dt>
										<dd class="break-words text-foreground">
											{{ item.clusters || "-" }}
										</dd>
									</div>
									<div class="space-y-1">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Order
										</dt>
										<dd class="break-words text-foreground">
											{{ item.order_number ?? "-" }}
										</dd>
									</div>
									<div class="space-y-1 sm:col-span-2">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Metadata
										</dt>
										<dd class="space-y-0.5 break-words text-foreground">
											<p v-if="item.created_at">
												Created: {{ formatDate(item.created_at as string) }}
											</p>
											<p v-if="item.updated_at">
												Updated: {{ formatDate(item.updated_at as string) }}
											</p>
										</dd>
									</div>
									<div class="space-y-1 sm:col-span-2">
										<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											System ID
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
												@click="emit('copy-id', { value: item.id, label: 'Record ID' })"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</dd>
									</div>
								</dl>

								<div v-if="item.response_type === 'scale'" class="mt-4 space-y-3">
									<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
										Scale labels
									</p>
									<div class="space-y-2">
										<div
											v-for="i in 4"
											:key="i"
											class="flex items-center justify-between gap-3 rounded-xl border border-border/70 bg-background px-3 py-2 text-sm"
										>
											<span class="font-mono text-xs font-semibold text-primary">
												{{ i }}
											</span>
											<span class="text-right text-muted-foreground">
												{{ item[`scale_label_${i}`] || "Not configured" }}
											</span>
										</div>
									</div>
								</div>
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
	RelationActionPayload,
	RelationSummaryState,
} from "@/composables/drawers/types";

interface Props {
	open: boolean;
	item: Record<string, any> | null;
	technicalOpen: boolean;
	questionSpec: RelationSpec;
	subCategorySpec: RelationSpec;
	batchSpec: RelationSpec;
	recordSpec: RelationSpec;
	subCategoryContext: RelationSummaryState;
}

const props = defineProps<Props>();

const emit = defineEmits<{
	(e: "update:open", value: boolean): void;
	(e: "update:technicalOpen", value: boolean): void;
	(e: "edit"): void;
	(e: "copy-id", payload: CopyIdPayload): void;
	(e: "open-single-relation", payload: RelationActionPayload): void;
	(e: "retry"): void;
}>();

const emitSingleRelation = () => {
	emit("open-single-relation", {
		scopeKey: "assessments_detail",
		idField: "sub_category_id",
		idValue: props.item?.sub_category_id,
	});
};
</script>
