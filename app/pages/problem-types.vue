<template>
	<div class="min-h-screen bg-gray-50 overflow-x-hidden">
		<!-- Main Container -->
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
			<!-- Dataset Table Container -->
			<div class="mt-6">
				<DatasetTable
					:title="dataTypeLabel"
					:data-type="dataType"
					:data="data"
					:columns="columns"
					:loading="loading"
					:error="error"
					:pagination="pagination"
					:current-page="currentPage"
					:total-pages="totalPages"
					:search-query="searchQuery"
					:filters="filters"
					@search-change="(q) => (searchQuery = q)"
					@filter-change="setFilter"
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
					@clear-filters="clearFilters"
					enable-expansion
					name-column-key="type_name"
					id-key="category_id"
				>
					<template #row-expansion="{ item }">
						<NestedDataList
							data-type="problems"
							filter-key="category_id"
							:filter-value="item.category_id"
							:level="0"
							:icon="FileText"
						/>
					</template>
				</DatasetTable>
			</div>
		</div>

		<!-- Import Modal -->
		<ImportModal
			:is-open="showImportModal"
			:data-type="'problem_types'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<!-- Export Modal -->
		<ExportModal
			:is-open="showExportModal"
			:data-type="'problem_types'"
			@close="closeExportModal"
		/>

		<!-- Edit Modal -->
		<ProblemTypeModal
			:is-open="showEditModal"
			:item="editingItem"
			@close="closeEditModal"
			@save="handleSave"
		/>

		<!-- Toast Notifications -->
		<Toaster />

		<!-- Detail View Sheet -->
		<Sheet
			:open="showDetailSheet"
			@update:open="(open) => !open && closeDetailSheet()"
		>
			<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
				<div class="p-4 pb-0">
					<SheetHeader class="space-y-1">
						<SheetTitle class="text-lg">Category Details</SheetTitle>
						<SheetDescription class="text-sm">
							View detailed information about this category
						</SheetDescription>
					</SheetHeader>
				</div>

				<div class="flex-1 overflow-y-auto px-4">
					<div v-if="viewingItem" class="mt-4 space-y-4">
						<!-- Type Name -->
						<div class="space-y-1">
							<h4
								class="text-xs font-medium text-muted-foreground uppercase tracking-wide"
							>
								Type Name
							</h4>
							<p class="text-sm font-medium">{{ viewingItem.type_name }}</p>
						</div>

						<!-- Category ID -->
						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Category ID
							</h4>
							<p
								class="text-base font-mono text-sm bg-muted px-3 py-2 rounded-md"
							>
								{{ viewingItem.category_id }}
							</p>
						</div>

						<!-- Description -->
						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Description
							</h4>
							<p class="text-sm leading-relaxed">
								{{ viewingItem.description }}
							</p>
						</div>

						<!-- Status -->
						<div class="space-y-1">
							<h4
								class="text-xs font-medium text-muted-foreground uppercase tracking-wide"
							>
								Status
							</h4>
							<Badge
								variant="outline"
								:class="
									viewingItem.is_active
										? 'bg-green-50 text-green-700 border-green-200'
										: 'bg-red-50 text-red-700 border-red-200'
								"
							>
								{{ viewingItem.is_active ? "Active" : "Inactive" }}
							</Badge>
						</div>

						<!-- Metadata -->
						<div class="space-y-1.5 pt-3 border-t">
							<h4
								class="text-xs font-medium text-muted-foreground uppercase tracking-wide"
							>
								Metadata
							</h4>
							<div class="space-y-0.5 text-xs text-muted-foreground">
								<p v-if="viewingItem.created_at">
									Created: {{ formatDate(viewingItem.created_at) }}
								</p>
								<p v-if="viewingItem.updated_at">
									Updated: {{ formatDate(viewingItem.updated_at) }}
								</p>
							</div>
							<p v-if="viewingItem.id" class="font-mono">
								ID: {{ viewingItem.id }}
							</p>
						</div>
					</div>
				</div>

				<div class="p-4 pt-0">
					<SheetFooter class="mt-4 pt-4 border-t flex-row gap-2">
						<Button
							variant="outline"
							size="sm"
							@click="closeDetailSheet"
							class="flex-1"
							>Close</Button
						>
						<Button size="sm" @click="openEditFromDetail" class="flex-1"
							>Edit</Button
						>
					</SheetFooter>
				</div>
			</SheetContent>
		</Sheet>
	</div>
</template>

<script setup>
import { onMounted, ref } from "vue";

// Components
import DatasetTable from "@/components/admin/DatasetTable.vue";
import NestedDataList from "@/components/admin/NestedDataList.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ProblemTypeModal from "@/components/admin/ProblemTypeModal.vue";
import { FileText } from "lucide-vue-next";

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
import { Badge } from "@/components/ui/badge";

// Use the shared composable
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
} = useDatasetManagement("problem_types");

// Detail view state
const showDetailSheet = ref(false);
const viewingItem = ref(null);

// Detail view handlers
const openDetailView = (item) => {
	viewingItem.value = item;
	showDetailSheet.value = true;
};

const closeDetailSheet = () => {
	showDetailSheet.value = false;
	setTimeout(() => {
		viewingItem.value = null;
	}, 300); // Wait for sheet animation
};

const openEditFromDetail = () => {
	if (viewingItem.value) {
		closeDetailSheet();
		openEditModal(viewingItem.value);
	}
};

// Helper function to format dates
const formatDate = (dateString) => {
	if (!dateString) return "";
	const date = new Date(dateString);
	return date.toLocaleString("en-US", {
		year: "numeric",
		month: "short",
		day: "numeric",
		hour: "2-digit",
		minute: "2-digit",
	});
};

// Lifecycle
onMounted(() => {
	refreshData();
});
</script>
