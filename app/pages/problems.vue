<template>
	<div class="min-h-screen w-full max-w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Problem taxonomy"
				title="Subcategories"
				description="Manage the subcategories underneath each category and keep the assessment tree easy to scan."
				:total="pagination.total"
				total-label="subcategories"
				:page-count="data.length"
				:search-query="searchQuery"
				:filters="filters"
			>
				<template #actions>
					<Button class="h-11 gap-2 px-4 text-sm font-medium" @click="openCreateModal">
						<Plus class="h-4 w-4" />
						New Subcategory
					</Button>
					<Button
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
						@click="startTour('problems')"
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
					@bulk-update="bulkUpdateItems"
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
					:categories="problemCategories"
					:sub-categories="subCategories"
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
				<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
					<SheetHeader class="space-y-1">
						<SheetTitle class="text-lg">Subcategory Details</SheetTitle>
						<SheetDescription class="text-sm">
							View detailed information about this subcategory
						</SheetDescription>
					</SheetHeader>
				</div>

				<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
						<div v-if="viewingItem" class="space-y-4">
							<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Subcategory name
								</p>
								<h3 class="mt-2 text-2xl font-semibold tracking-tight text-foreground">
									{{ viewingItem.problem_name }}
								</h3>
								<div class="mt-4 grid gap-3">
									<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
										<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Parent category
										</p>
										<div class="mt-2 flex flex-wrap items-center gap-2">
											<Badge variant="secondary" class="h-6 rounded-full px-2 text-[11px] font-medium">
												{{ viewingItem.category || "Unknown category" }}
											</Badge>
											<Badge
												v-if="viewingItem.severity_level"
												variant="outline"
												:class="getSeverityClass(viewingItem.severity_level)"
												class="h-6 rounded-full px-2 text-[11px] font-medium"
											>
												Level {{ viewingItem.severity_level }}
											</Badge>
										</div>
										<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
											<p class="min-w-0 break-all text-sm text-foreground">
												ID: {{ viewingItem.category_id || "-" }}
											</p>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy parent category ID'"
												:aria-label="'Copy parent category ID'"
												:disabled="!viewingItem.category_id"
												@click="copyId(viewingItem.category_id, 'Parent Category ID')"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</div>
									</div>
									<div class="rounded-lg border border-border/60 bg-muted/20 p-3">
										<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
											Subcategory ID
										</p>
										<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
											<p class="min-w-0 break-all text-sm text-foreground">
												{{ viewingItem.sub_category_id || "-" }}
											</p>
											<Button
												type="button"
												variant="ghost"
												size="icon"
												class="h-11 w-11 shrink-0"
												:title="'Copy subcategory ID'"
												:aria-label="'Copy subcategory ID'"
												:disabled="!viewingItem.sub_category_id"
												@click="copyId(viewingItem.sub_category_id, 'Subcategory ID')"
											>
												<Copy class="h-4 w-4" />
											</Button>
										</div>
									</div>
								</div>
								<div class="mt-4 space-y-1">
									<p class="text-sm font-medium text-muted-foreground">Description</p>
									<p class="text-sm leading-relaxed text-foreground">
										{{ viewingItem.description || "No description provided." }}
									</p>
								</div>
								<Button
									type="button"
									variant="outline"
									class="mt-4 h-11 w-full justify-between px-4 text-left"
									@click="openCategoryDetail"
								>
									<span class="text-sm font-medium">Open parent category details</span>
									<ChevronDown class="h-4 w-4 -rotate-90" />
								</Button>
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
											<div class="space-y-1 sm:col-span-2">
												<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
													Record ID
												</dt>
												<dd class="flex items-center gap-2">
													<span class="min-w-0 break-all text-foreground">
														{{ viewingItem.id || "-" }}
													</span>
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
												</dd>
											</div>
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
				<div class="border-b border-border/70 bg-muted/20 px-4 py-4 sm:px-6">
					<SheetHeader class="space-y-1">
						<SheetTitle class="text-lg">Category Details</SheetTitle>
						<SheetDescription class="text-sm">
							Problem type category information
						</SheetDescription>
					</SheetHeader>
				</div>

				<div class="flex-1 overflow-y-auto px-4 py-4 sm:px-6">
						<div v-if="viewingCategory" class="space-y-4">
							<div class="rounded-2xl border border-border/70 bg-card p-5 shadow-sm">
								<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
									Parent category
								</p>
								<h3 class="mt-2 text-2xl font-semibold tracking-tight text-foreground">
									{{ viewingCategory.type_name || "Unknown category" }}
								</h3>
								<div class="mt-3 rounded-lg border border-border/60 bg-muted/20 p-3">
									<p class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
										Category ID
									</p>
									<div class="mt-2 flex min-w-0 items-center justify-between gap-2">
										<p class="min-w-0 break-all text-sm text-foreground">
											{{ viewingCategory.category_id || "-" }}
										</p>
										<Button
											type="button"
											variant="ghost"
											size="icon"
											class="h-11 w-11 shrink-0"
											:title="'Copy category ID'"
											:aria-label="'Copy category ID'"
											:disabled="!viewingCategory.category_id"
											@click="copyId(viewingCategory.category_id, 'Category ID')"
										>
											<Copy class="h-4 w-4" />
										</Button>
									</div>
										</div>
									<div class="mt-4 space-y-1">
										<p class="text-sm font-medium text-muted-foreground">Description</p>
										<p class="text-sm leading-relaxed text-foreground">
										{{ viewingCategory.description || "No description provided." }}
								</p>
							</div>
						</div>

						<Collapsible v-model:open="showCategoryTechnicalDetails" class="space-y-2">
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
										{{ showCategoryTechnicalDetails ? "Hide" : "Show" }}
										<ChevronDown
											class="h-4 w-4 transition-transform duration-200"
											:class="showCategoryTechnicalDetails ? 'rotate-180' : ''"
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
											<dd class="flex items-center gap-2">
												<span class="min-w-0 break-all text-foreground">
													{{ viewingCategory.id || "-" }}
												</span>
												<Button
													type="button"
													variant="ghost"
													size="icon"
													class="h-11 w-11 shrink-0"
													:title="'Copy record ID'"
													:aria-label="'Copy record ID'"
													:disabled="!viewingCategory.id"
													@click="copyId(viewingCategory.id, 'Record ID')"
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
												{{ viewingCategory.created_at ? formatDate(viewingCategory.created_at) : "-" }}
											</dd>
										</div>
										<div class="space-y-1">
											<dt class="text-[11px] font-semibold uppercase tracking-[0.2em] text-muted-foreground">
												Updated
											</dt>
											<dd class="break-words text-foreground">
												{{ viewingCategory.updated_at ? formatDate(viewingCategory.updated_at) : "-" }}
											</dd>
										</div>
								</dl>
							</div>
						</CollapsibleContent>
					</Collapsible>
					</div>

						<div
							v-else-if="loadingCategory"
							class="mt-6 flex items-center justify-center py-8"
						>
							<div class="flex items-center gap-2 text-muted-foreground">
								<Loader2 class="h-4 w-4 animate-spin" />
								<span class="text-sm">Loading parent category details...</span>
							</div>
						</div>
						<div
							v-else-if="categoryLoadError"
							class="mt-6 rounded-2xl border border-destructive/40 bg-destructive/5 p-4"
						>
							<div class="flex items-start gap-3">
								<AlertCircle class="mt-0.5 h-4 w-4 shrink-0 text-destructive" />
								<div class="space-y-2">
									<p class="text-sm font-medium text-foreground">Couldn’t load parent category</p>
									<p class="text-sm text-muted-foreground">
										{{ categoryLoadError }}
									</p>
									<Button
										type="button"
										variant="outline"
										size="sm"
										class="h-10"
										@click="openCategoryDetail"
									>
										Try again
									</Button>
								</div>
							</div>
						</div>
						<div
							v-else
							class="mt-6 rounded-2xl border border-border/70 bg-muted/20 p-4"
						>
							<p class="text-sm text-muted-foreground">
								Category details are unavailable for this subcategory.
							</p>
						</div>
					</div>

				<div class="border-t border-border/70 bg-background px-4 py-4 sm:px-6">
					<SheetFooter>
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
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import ImportModal from "@/components/admin/ImportModal.vue";
import ExportModal from "@/components/admin/ExportModal.vue";
import ProblemModal from "@/components/admin/ProblemModal.vue";
import { formatDate } from "@/utils/formatDate";

// shadcn-vue components
import { Toaster } from "@/components/ui/toast";
import { useToast } from "@/components/ui/toast/use-toast";
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
import { ChevronDown, Loader2, HelpCircle, Plus, Copy, AlertCircle } from "lucide-vue-next";
import { useOnboarding } from "@/composables/useOnboarding";
import {
	Collapsible,
	CollapsibleContent,
	CollapsibleTrigger,
} from "@/components/ui/collapsible";

// Composables
const { supabase } = useSupabase();
const { startTour } = useOnboarding();
const { toast } = useToast();

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
} = useDatasetManagement("problems", { is_active: "true" });

// Detail view state
const showDetailSheet = ref(false);
const viewingItem = ref(null);
const showTechnicalDetails = ref(false);

// Category detail view state
const showCategorySheet = ref(false);
const viewingCategory = ref(null);
const showCategoryTechnicalDetails = ref(false);
const loadingCategory = ref(false);
const categoryLoadError = ref("");
const problemCategories = ref([]);
const subCategories = ref([]);

const fetchCategories = async () => {
	try {
		const { data: catData, error: catError } = await supabase
			.from("problem_types")
			.select("type_name")
			.eq("is_active", true)
			.order("type_name", { ascending: true });

		if (catError) throw catError;
		problemCategories.value = catData.map((c) => c.type_name);
	} catch (err) {
		console.error("Error fetching categories:", err);
	}
};

const fetchSubCategories = async () => {
	try {
		const { data: subData, error: subError } = await supabase
			.from("problems")
			.select("sub_category_id, problem_name")
			.eq("is_active", true)
			.order("sub_category_id", { ascending: true });

		if (subError) throw subError;

		// Get unique entries based on sub_category_id
		const seenIds = new Set();
		const formattedSubCategories = [];

		for (const item of subData) {
			if (!seenIds.has(item.sub_category_id)) {
				seenIds.add(item.sub_category_id);
				formattedSubCategories.push({
					id: item.sub_category_id,
					name: item.problem_name,
				});
			}
		}

		subCategories.value = formattedSubCategories;
	} catch (err) {
		console.error("Error fetching subcategories:", err);
	}
};

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
	const parentCategoryIdRaw = viewingItem.value?.category_id;
	const parentCategoryNameRaw = viewingItem.value?.category;
	const parentCategoryId =
		typeof parentCategoryIdRaw === "string"
			? parentCategoryIdRaw.trim()
			: parentCategoryIdRaw;
	const parentCategoryName =
		typeof parentCategoryNameRaw === "string"
			? parentCategoryNameRaw.trim()
			: parentCategoryNameRaw;

	showCategoryTechnicalDetails.value = false;
	categoryLoadError.value = "";
	showCategorySheet.value = true;
	viewingCategory.value = null;

	if (!parentCategoryId && !parentCategoryName) {
		loadingCategory.value = false;
		categoryLoadError.value =
			"This subcategory does not have a parent category assigned yet.";
		return;
	}

	loadingCategory.value = true;

	try {
		let categoryData = null;

		if (parentCategoryId) {
			const { data, error } = await supabase
				.from("problem_types")
				.select("*")
				.eq("category_id", parentCategoryId)
				.eq("is_active", true)
				.maybeSingle();

			if (error) throw error;
			categoryData = data;
		}

		if (!categoryData && parentCategoryName) {
			const { data, error } = await supabase
				.from("problem_types")
				.select("*")
				.eq("type_name", parentCategoryName)
				.eq("is_active", true)
				.maybeSingle();

			if (error) throw error;
			categoryData = data;
		}

		if (!categoryData) {
			viewingCategory.value = null;
			categoryLoadError.value =
				"We couldn't find an active parent category for this subcategory.";
			return;
		}

		viewingCategory.value = categoryData;
		categoryLoadError.value = "";
	} catch (err) {
		console.error("Error fetching category:", err);
		viewingCategory.value = null;
		categoryLoadError.value =
			"We couldn't load parent category details. Please try again.";
	} finally {
		loadingCategory.value = false;
	}
};

const closeCategorySheet = () => {
	showCategorySheet.value = false;
	setTimeout(() => {
		viewingCategory.value = null;
		showCategoryTechnicalDetails.value = false;
		loadingCategory.value = false;
		categoryLoadError.value = "";
	}, 300);
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

// Lifecycle
onMounted(() => {
	refreshData();
	fetchCategories();
	fetchSubCategories();
});
</script>
