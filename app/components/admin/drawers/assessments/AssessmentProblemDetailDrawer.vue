<template>
	<Sheet :open="open" @update:open="(value) => emit('update:open', value)">
		<SheetContent class="flex h-full w-full flex-col p-0 sm:max-w-lg">
			<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
				<SheetHeader class="space-y-1">
					<SheetTitle class="text-lg">Problem Details</SheetTitle>
					<SheetDescription class="text-sm">Linked subcategory information</SheetDescription>
				</SheetHeader>
			</div>

			<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
				<div v-if="record" class="space-y-4">
					<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
						<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
							Problem name
						</p>
						<p class="mt-2 text-lg font-semibold leading-tight text-foreground">
							{{ record.problem_name }}
						</p>
						<div class="mt-4 flex flex-wrap gap-2">
							<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
								{{ record.category || "Unknown category" }}
							</Badge>
							<Badge
								v-if="record.severity_level"
								variant="outline"
								class="h-6 rounded-full px-2 text-[11px] font-medium"
							>
								Level {{ record.severity_level }}
							</Badge>
						</div>
						<div class="mt-4 space-y-1">
							<p class="text-sm font-medium text-muted-foreground">Description</p>
							<p class="text-sm leading-relaxed text-foreground">
								{{ record.description || "No description provided." }}
							</p>
						</div>
					</div>
					<RelationContextBlock
						:label="subCategorySpec.label"
						:state="subCategoryContext"
						:action-label="subCategorySpec.actionLabel"
						@open-action="emitListRelation"
						@retry="emit('retry')"
					/>

					<div class="grid gap-3 sm:grid-cols-2">
						<div class="rounded-2xl border border-border/70 bg-background p-4">
							<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
								{{ subCategorySpec.label }}
							</p>
							<p class="mt-1 text-xs leading-5 text-muted-foreground">
								{{ subCategorySpec.meaning }}
							</p>
							<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
								<p class="min-w-0 break-all text-sm font-medium text-foreground">
									{{ record.sub_category_id || "-" }}
								</p>
								<Button
									type="button"
									variant="ghost"
									size="icon"
									class="h-11 w-11 shrink-0"
									:title="'Copy subcategory ID'"
									:aria-label="'Copy subcategory ID'"
									:disabled="!record.sub_category_id"
									@click="emit('copy-id', { value: record.sub_category_id, label: 'Subcategory ID' })"
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
									{{ record.id || "-" }}
								</p>
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
											Category
										</dt>
										<dd class="break-words text-foreground">
											{{ record.category || "-" }}
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
						<span class="text-sm">Loading problem details...</span>
					</div>
				</div>
				<div
					v-else-if="error"
					class="mt-6 rounded-2xl border border-destructive/40 bg-destructive/5 p-4"
				>
					<div class="flex items-start gap-3">
						<AlertCircle class="mt-0.5 h-4 w-4 shrink-0 text-destructive" />
						<div class="space-y-2">
							<p class="text-sm font-medium text-foreground">Couldn’t load linked problem</p>
							<p class="text-sm text-muted-foreground">{{ error }}</p>
							<Button type="button" variant="outline" size="sm" class="h-10" @click="emit('retry')">
								Try again
							</Button>
						</div>
					</div>
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
	record: Record<string, any> | null;
	loading: boolean;
	error: string;
	technicalOpen: boolean;
	subCategorySpec: RelationSpec;
	recordSpec: RelationSpec;
	subCategoryContext: RelationSummaryState;
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
		scopeKey: "assessments_problem_detail",
		idField: "sub_category_id",
		idValue: props.record?.sub_category_id,
		title: "Records Linked To This Subcategory",
		description:
			"Assessment questions and suggestions that reference this subcategory ID.",
	});
};
</script>
