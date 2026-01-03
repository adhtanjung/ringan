<template>
	<div class="min-h-screen bg-gray-50 overflow-x-hidden w-full max-w-full">
		<div
			class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-2 sm:py-3 lg:py-4 w-full"
		>
			<div class="mt-6">
				<DatasetTable
					:title="dataTypeLabel"
					:data="data"
					:columns="columns"
					:loading="loading"
					:error="error"
					:pagination="pagination"
					:current-page="currentPage"
					:total-pages="totalPages"
					:search-query="searchQuery"
					:filters="filters"
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
					@generate-sample="handleGenerateSample"
				/>
			</div>
		</div>

		<ImportModal
			:is-open="showImportModal"
			:data-type="'problems'"
			@close="closeImportModal"
			@import-success="handleImportSuccess"
		/>

		<ExportModal
			:is-open="showExportModal"
			:data-type="'problems'"
			@close="closeExportModal"
		/>

		<ProblemModal
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
			<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
				<div class="p-4 pb-0">
					<SheetHeader class="space-y-1">
						<SheetTitle class="text-lg">Problem Details</SheetTitle>
						<SheetDescription class="text-sm">
							View detailed information about this problem
						</SheetDescription>
					</SheetHeader>
				</div>

				<div class="flex-1 overflow-y-auto px-4">
					<div v-if="viewingItem" class="mt-4 space-y-4">
						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Problem Name
							</h4>
							<p class="text-base">{{ viewingItem.problem_name }}</p>
						</div>

						<div class="space-y-1">
							<h4
								class="text-xs font-medium text-muted-foreground uppercase tracking-wide"
							>
								Category
							</h4>
							<button
								@click="openCategoryDetail"
								class="text-sm font-medium text-primary underline decoration-2 underline-offset-2 hover:text-primary/80 transition-colors cursor-pointer text-left"
							>
								{{ viewingItem.category }}
							</button>
							<p class="text-xs text-muted-foreground">
								Click to view category details
							</p>
						</div>

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

						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Subcategory ID
							</h4>
							<p
								class="text-base font-mono text-sm bg-muted px-3 py-2 rounded-md"
							>
								{{ viewingItem.sub_category_id }}
							</p>
						</div>

						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Description
							</h4>
							<p class="text-sm leading-relaxed">
								{{ viewingItem.description }}
							</p>
						</div>

						<div v-if="viewingItem.severity_level" class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Severity Level
							</h4>
							<Badge
								variant="outline"
								:class="getSeverityClass(viewingItem.severity_level)"
							>
								Level {{ viewingItem.severity_level }}
							</Badge>
						</div>

						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">Status</h4>
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
								<p v-if="viewingItem.id" class="font-mono">
									ID: {{ viewingItem.id }}
								</p>
							</div>
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
						>
							Close
						</Button>
						<Button size="sm" @click="openEditFromDetail" class="flex-1">
							Edit
						</Button>
					</SheetFooter>
				</div>
			</SheetContent>
		</Sheet>

		<Sheet
			:open="showCategorySheet"
			@update:open="(open) => !open && closeCategorySheet()"
		>
			<SheetContent class="w-full sm:max-w-lg p-0 flex flex-col">
				<div class="p-4 pb-0">
					<SheetHeader class="space-y-1">
						<SheetTitle class="text-lg">Category Details</SheetTitle>
						<SheetDescription class="text-sm">
							Problem type category information
						</SheetDescription>
					</SheetHeader>
				</div>

				<div class="flex-1 overflow-y-auto px-4">
					<div v-if="viewingCategory" class="mt-4 space-y-4">
						<div class="space-y-1">
							<h4
								class="text-xs font-medium text-muted-foreground uppercase tracking-wide"
							>
								Type Name
							</h4>
							<p class="text-sm font-medium">{{ viewingCategory.type_name }}</p>
						</div>

						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Category ID
							</h4>
							<p
								class="text-base font-mono text-sm bg-muted px-3 py-2 rounded-md"
							>
								{{ viewingCategory.category_id }}
							</p>
						</div>

						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">
								Description
							</h4>
							<p class="text-sm leading-relaxed">
								{{ viewingCategory.description }}
							</p>
						</div>

						<div class="space-y-2">
							<h4 class="text-sm font-medium text-muted-foreground">Status</h4>
							<Badge
								variant="outline"
								:class="
									viewingCategory.is_active
										? 'bg-green-50 text-green-700 border-green-200'
										: 'bg-red-50 text-red-700 border-red-200'
								"
							>
								{{ viewingCategory.is_active ? "Active" : "Inactive" }}
							</Badge>
						</div>
					</div>

					<div
						v-else-if="loadingCategory"
						class="mt-6 flex items-center justify-center py-8"
					>
						<div class="flex items-center gap-2 text-muted-foreground">
							<Loader2 class="h-4 w-4 animate-spin" />
							<span class="text-sm">Loading category details...</span>
						</div>
					</div>
				</div>

				<div class="p-4 pt-0">
					<SheetFooter class="mt-4 pt-4 border-t">
						<Button
							variant="outline"
							size="sm"
							@click="closeCategorySheet"
							class="w-full"
						>
							Close
						</Button>
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
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ProblemModal from "@/components/admin/ProblemModal.vue";

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
import { Loader2 } from "lucide-vue-next";

// Composables
const { supabase } = useSupabase();

// Use the shared composable
const {
	loading,
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
} = useDatasetManagement("problems");

// Detail view state
const showDetailSheet = ref(false);
const viewingItem = ref(null);

// Category detail view state
const showCategorySheet = ref(false);
const viewingCategory = ref(null);
const loadingCategory = ref(false);

// Detail view handlers
const openDetailView = (item) => {
	viewingItem.value = item;
	showDetailSheet.value = true;
};

const closeDetailSheet = () => {
	showDetailSheet.value = false;
	setTimeout(() => {
		viewingItem.value = null;
	}, 300);
};

const openEditFromDetail = () => {
	if (viewingItem.value) {
		closeDetailSheet();
		openEditModal(viewingItem.value);
	}
};

// Category detail handlers
const openCategoryDetail = async () => {
	if (!viewingItem.value?.category) return;

	loadingCategory.value = true;
	showCategorySheet.value = true;

	try {
		const { data: categoryData, error: categoryError } = await supabase
			.from("problem_types")
			.select("*")
			.eq("type_name", viewingItem.value.category)
			.single();

		if (categoryError) throw categoryError;

		viewingCategory.value = categoryData;
	} catch (err) {
		console.error("Error fetching category:", err);
		viewingCategory.value = null;
	} finally {
		loadingCategory.value = false;
	}
};

const closeCategorySheet = () => {
	showCategorySheet.value = false;
	setTimeout(() => {
		viewingCategory.value = null;
		loadingCategory.value = false;
	}, 300);
};

// Helper functions
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

const getSeverityClass = (level) => {
	const classes = {
		1: "bg-blue-50 text-blue-700 border-blue-200",
		2: "bg-green-50 text-green-700 border-green-200",
		3: "bg-yellow-50 text-yellow-700 border-yellow-200",
		4: "bg-orange-50 text-orange-700 border-orange-200",
		5: "bg-red-50 text-red-700 border-red-200",
	};
	return classes[level] || "bg-gray-50 text-gray-700 border-gray-200";
};

const handleGenerateSample = async () => {
	// Requirements: "A button that hits a Supabase function to insert 5 'safe' dummy rows"
	// Since we can't create backend functions, we'll do client-side insert.
	try {
		loading.value = true;
		const dummyData = [
			{
				problem_name: "Example Problem 1: Anxiety",
				category: "Anxiety",
				description: "This is a sample description for an anxiety problem.",
				severity_level: 2,
				is_active: true,
				created_at: new Date().toISOString(),
				updated_at: new Date().toISOString()
			},
			{
				problem_name: "Example Problem 2: Stress",
				category: "Stress",
				description: "High stress levels due to work environment.",
				severity_level: 3,
				is_active: true,
				created_at: new Date().toISOString(),
				updated_at: new Date().toISOString()
			},
			{
				problem_name: "Example Problem 3: Sleep Issues",
				category: "Sleep",
				description: "Difficulty falling asleep at night.",
				severity_level: 1,
				is_active: false,
				created_at: new Date().toISOString(),
				updated_at: new Date().toISOString()
			}
		];

		const { error: insertError } = await supabase.from('problems').insert(dummyData);
		if (insertError) throw insertError;

		await refreshData();
	} catch (err) {
		console.error("Failed to generate sample data:", err);
		// Assuming we have access to toast here, or fallback to alert
		// toast({ title: "Error", description: "Failed to generate sample data", variant: "destructive" });
	} finally {
		loading.value = false;
	}
};

// Lifecycle
onMounted(() => {
	refreshData();
});
</script>
