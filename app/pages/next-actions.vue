<template>
	<div class="min-h-screen w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Action catalog"
				title="Next Actions"
				description="Define the follow-up actions that guide the next step in each workflow, from session flow to escalation."
				:total="pagination.total"
				total-label="next actions"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Action
					</Button>
					<Button
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
						@click="startTour('next_actions')"
					>
						<HelpCircle class="h-4 w-4" />
						How this works
					</Button>
				</template>
			</DatasetPageHeader>

			<div>
				<DatasetTable
					:title="dataTypeLabel"
					:data-type="dataType"
					:data="data"
					:columns="columns"
					:all-selectable-ids="allMatchingIds"
					:loading="loading || actionLoading"
					:error="error"
					:pagination="pagination"
					:current-page="currentPage"
					:total-pages="totalPages"
					:search-query="searchQuery"
					:filters="filters"
					:show-create-button="false"
					class="overflow-hidden rounded-3xl border border-border/70 bg-card shadow-sm"
					@create="openCreateModal"
					@edit="openEditModal"
					@view="openDetailView"
					@delete="deleteItem"
					@bulk-delete="bulkDeleteItems"
					@refresh="refreshData"
					@import="openImportModal"
					@export="openExportModal"
					@page-change="goToPage"
					@page-size-change="changePageSize"
					@next-page="nextPage"
					@prev-page="prevPage"
					@search-change="(value) => (searchQuery = value)"
					@filter-change="setFilter"
					@clear-filters="clearFilters"
				/>
			</div>
		</div>

		<!-- Import Modal -->
		<ImportModal
			:is-open="showImportModal"
			:data-type="'next_actions'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<!-- Export Modal -->
		<ExportModal
			:is-open="showExportModal"
			:data-type="'next_actions'"
			@close="closeExportModal"
		/>

		<!-- Edit Modal -->
		<DatasetEditModalShadcn
			:is-open="showEditModal"
			:data-type="'next_actions'"
			:item="editingItem"
			:loading="actionLoading"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<!-- Detail View Sheet -->
		<Sheet
			:open="showDetailSheet"
			@update:open="(open) => !open && closeDetailSheet()"
		>
			<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
				<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
					<SheetHeader class="space-y-1">
						<SheetTitle class="text-lg">Action Details</SheetTitle>
						<SheetDescription class="text-sm">
							View detailed information about this next action record
						</SheetDescription>
					</SheetHeader>
				</div>

				<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
					<div v-if="viewingItem" class="space-y-4">
						<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
							<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
								Action text
							</p>
							<p class="mt-2 text-lg font-semibold leading-tight text-foreground">
								{{ viewingItem.action_text || "-" }}
							</p>
							<div class="mt-4 flex flex-wrap gap-2">
								<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
									ID: {{ viewingItem.action_id || "-" }}
								</Badge>
							</div>
						</div>

						<Collapsible v-model:open="showTechnicalDetails" class="space-y-2">
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
										{{ showTechnicalDetails ? "Hide" : "Show" }}
										<ChevronDown
											class="h-4 w-4 transition-transform duration-200"
											:class="showTechnicalDetails ? 'rotate-180' : ''"
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
												{{ viewingItem.created_at ? formatDate(viewingItem.created_at) : "-" }}
											</dd>
										</div>
										<div class="space-y-1">
											<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
												Updated
											</dt>
											<dd class="break-words text-foreground">
												{{ viewingItem.updated_at ? formatDate(viewingItem.updated_at) : "-" }}
											</dd>
										</div>
										<div class="space-y-1 sm:col-span-2">
											<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
												System ID
											</dt>
											<dd class="break-all text-foreground">
												{{ viewingItem.id || "-" }}
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
						<Button variant="outline" @click="closeDetailSheet" class="flex-1">
							Close
						</Button>
						<Button @click="openEditFromDetail" class="flex-1">
							Edit Record
						</Button>
					</SheetFooter>
				</div>
			</SheetContent>
		</Sheet>

		<!-- Toast Notifications -->
		<Toaster />
	</div>
</template>

<script setup>
import { onMounted, ref } from "vue";

// Components
import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import DatasetEditModalShadcn from "@/components/admin/DatasetEditModalShadcn.vue";
import { formatDate } from "@/utils/formatDate";
import { ChevronDown, HelpCircle, Plus } from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";

// shadcn-vue components
import { Toaster } from "@/components/ui/toast";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetFooter,
	SheetHeader,
	SheetTitle,
} from "@/components/ui/sheet";
import { Button } from "@/components/ui/button";
import {
	Collapsible,
	CollapsibleContent,
	CollapsibleTrigger,
} from "@/components/ui/collapsible";
import { Badge } from "@/components/ui/badge";

// Use the shared composables
const { startTour } = useOnboarding();
const {
	loading,
	dataType,
	error,
	data,
	actionLoading,
	showImportModal,
	showExportModal,
	showEditModal,
	editingItem,
	pagination,
	columns,
	dataTypeLabel,
	currentPage,
	totalPages,
	searchQuery,
	filters,
	refreshData,
	openCreateModal,
	openEditModal,
	closeEditModal,
	handleSave,
	deleteItem,
	bulkDeleteItems,
	allMatchingIds,
	openImportModal,
	closeImportModal,
	openExportModal,
	closeExportModal,
	handleImportSuccess,
	goToPage,
	changePageSize,
	nextPage,
	prevPage,
	setFilter,
	clearFilters,
} = useDatasetManagement("next_actions", { is_active: "true" });

// Detail view state
const showDetailSheet = ref(false);
const viewingItem = ref(null);
const showTechnicalDetails = ref(false);

// Detail view handlers
const openDetailView = (item) => {
	viewingItem.value = item;
	showTechnicalDetails.value = false;
	showDetailSheet.value = true;
};

const closeDetailSheet = () => {
	showDetailSheet.value = false;
	setTimeout(() => {
		viewingItem.value = null;
		showTechnicalDetails.value = false;
	}, 300); // Wait for sheet animation
};

const openEditFromDetail = () => {
	if (viewingItem.value) {
		const itemToEdit = { ...viewingItem.value };
		closeDetailSheet();
		openEditModal(itemToEdit);
	}
};

// Lifecycle
onMounted(() => {
	refreshData();
});
</script>
