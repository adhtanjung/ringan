<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Problem taxonomy"
				title="Categories"
				description="Manage top-level categories that organize subcategories and keep the assessment structure easy to scan."
				:total="pagination.total"
				total-label="categories"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Category
					</Button>
					<Button
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
						@click="startTour('problem_types')"
					>
						<HelpCircle class="h-4 w-4" />
						How this works
					</Button>
				</template>
			</DatasetPageHeader>

			<section>
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
					@search-change="(q) => (searchQuery = q)"
					@filter-change="setFilter"
					@create="openCreateModal"
					@edit="openEditModal"
					@view="openDetailView"
					@delete="deleteItem"
					@bulk-delete="bulkDeleteItems"
					@bulk-update="bulkUpdateItems"
					@refresh="refreshData"
					@import="openImportModal"
					@export="openExportModal"
					@page-change="goToPage"
					@page-size-change="changePageSize"
					@next-page="nextPage"
					@prev-page="prevPage"
					@clear-filters="clearFilters"
				>
				</DatasetTable>
			</section>
		</div>

		<ImportModal
			:is-open="showImportModal"
			:data-type="'problem_types'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'problem_types'"
			@close="closeExportModal"
		/>

		<ProblemTypeModal
			:is-open="showEditModal"
			:item="editingItem"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<Toaster />

		<Sheet
			:open="showDetailSheet"
			@update:open="(open) => !open && closeDetailSheet()"
		>
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
					<div v-if="viewingItem" class="space-y-4">
						<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
							<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
								Category name
							</p>
							<h3 class="mt-2 break-words text-2xl font-semibold tracking-tight text-foreground">
								{{ viewingItem.type_name }}
							</h3>
							<p class="mt-3 text-sm leading-6 text-muted-foreground">
								{{ viewingItem.description || "No description provided." }}
							</p>
							<p class="mt-3 text-xs leading-5 text-muted-foreground">
								Subcategories tied to this category are managed on the Subcategories
								page.
							</p>
							<div class="mt-4 flex flex-wrap gap-2">
								<Badge
									v-if="viewingItem.updated_at"
									variant="outline"
									class="h-6 rounded-full px-2 text-[11px] font-medium text-muted-foreground"
								>
									Updated {{ formatDate(viewingItem.updated_at) }}
								</Badge>
							</div>
						</div>

						<div class="grid gap-3 sm:grid-cols-2">
							<div class="rounded-2xl border border-border/70 bg-background p-4">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Category ID
								</p>
								<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
									<p class="min-w-0 break-all text-sm font-medium text-foreground">
										{{ viewingItem.category_id || "-" }}
									</p>
									<Button
										type="button"
										variant="ghost"
										size="icon"
										class="h-11 w-11 shrink-0"
										:title="'Copy category ID'"
										:aria-label="'Copy category ID'"
										:disabled="!viewingItem.category_id"
										@click="copyId(viewingItem.category_id, 'Category ID')"
									>
										<Copy class="h-4 w-4" />
									</Button>
								</div>
							</div>
							<div class="rounded-2xl border border-border/70 bg-background p-4">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Record ID
								</p>
								<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
									<p class="min-w-0 break-all text-sm font-medium text-foreground">
										{{ viewingItem.id || "-" }}
									</p>
									<Button
										type="button"
										variant="ghost"
										size="icon"
										class="h-11 w-11 shrink-0"
										:title="'Copy record ID'"
										:aria-label="'Copy record ID'"
										:disabled="!viewingItem.id"
										@click="copyId(viewingItem.id, 'Record ID')"
									>
										<Copy class="h-4 w-4" />
									</Button>
								</div>
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
							Edit
						</Button>
					</SheetFooter>
				</div>
			</SheetContent>
		</Sheet>
	</div>
</template>

<script setup>
import { computed, onMounted, ref } from "vue";

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
import { Toaster } from "@/components/ui/toast";
import { useToast } from "@/components/ui/toast/use-toast";
import { ChevronDown, HelpCircle, Plus, Copy } from "lucide-vue-next";

import DatasetTable from "@/components/admin/DatasetTable.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ProblemTypeModal from "@/components/admin/ProblemTypeModal.vue";
import { formatDate } from "@/utils/formatDate";
import { useDatasetManagement } from "@/composables/useDatasetManagement";
import { useOnboarding } from "@/composables/useOnboarding";

const { startTour } = useOnboarding();
const { toast } = useToast();
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
	bulkUpdateItems,
} = useDatasetManagement("problem_types", { is_active: "true" });

const showDetailSheet = ref(false);
const viewingItem = ref(null);
const showTechnicalDetails = ref(false);

const activeFilterCount = computed(() => {
	return Object.entries(filters.value).filter(([key, value]) => {
		if (value === null || value === "__all__") return false;
		if (key === "is_active" && value === "true") return false;
		return String(value).trim() !== "";
	}).length;
});

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
	}, 300);
};

const openEditFromDetail = () => {
	if (viewingItem.value) {
		closeDetailSheet();
		openEditModal(viewingItem.value);
	}
};

const copyId = async (value, label) => {
	if (value === null || value === undefined || value === "") {
		toast({
			title: `${label} not available`,
			description: "Nothing to copy for this record.",
			variant: "destructive",
		});
		return;
	}

	if (
		typeof navigator === "undefined" ||
		!navigator.clipboard ||
		typeof navigator.clipboard.writeText !== "function"
	) {
		toast({
			title: "Copy is not supported",
			description: "Clipboard access is unavailable in this browser context.",
			variant: "destructive",
		});
		return;
	}

	try {
		await navigator.clipboard.writeText(String(value));
		toast({
			title: `${label} copied`,
			description: String(value),
		});
	} catch (error) {
		console.error(`Failed to copy ${label}:`, error);
		toast({
			title: "Copy failed",
			description: "Unable to copy to clipboard. Please try again.",
			variant: "destructive",
		});
	}
};

onMounted(() => {
	refreshData();
});
</script>
