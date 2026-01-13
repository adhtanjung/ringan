<template>
	<div class="h-full flex flex-col bg-background text-foreground">
		<header
			v-if="!hideToolbar"
			class="flex flex-col gap-4 border-b border-border p-4 sm:flex-row sm:items-center sm:justify-between"
		>
			<div class="flex items-center gap-2">
				<slot name="header-title">
					<div>
						<h3 class="text-base font-semibold tracking-tight">{{ title }}</h3>
						<p class="text-xs text-muted-foreground">{{ totalItems }} items</p>
					</div>
				</slot>
			</div>

			<div class="flex flex-1 items-center justify-end gap-2">
				<div class="relative w-full max-w-[250px]">
					<Search
						class="absolute left-2 top-2.5 h-3.5 w-3.5 text-muted-foreground"
					/>
					<Input
						v-model="localSearchQuery"
						@input="handleSearchInput"
						placeholder="Search..."
						class="h-8 w-full pl-8 text-xs bg-muted/50"
					/>
				</div>

				<Sheet v-if="showFilters">
					<SheetTrigger as-child>
						<Button
							variant="outline"
							size="sm"
							class="h-8 gap-2 px-2 text-xs"
							:class="{
								'bg-blue-50 border-blue-200 text-blue-700': hasActiveFilters,
							}"
						>
							<ListFilter class="h-3.5 w-3.5" />
							Filters
							<Badge
								v-if="activeFilterCount > 0"
								variant="secondary"
								class="ml-auto h-5 min-w-5 px-1"
								>{{ activeFilterCount }}</Badge
							>
						</Button>
					</SheetTrigger>
					<SheetContent
						class="sm:max-w-md flex flex-col h-full bg-background border-l-border"
					>
						<SheetHeader class="pb-6 border-b border-border/50 space-y-2">
							<div class="flex items-center gap-2">
								<div class="p-2 bg-primary/10 rounded-lg">
									<ListFilter class="h-5 w-5 text-primary" />
								</div>
								<div>
									<SheetTitle
										class="text-xl font-bold tracking-tight text-foreground"
									>
										Filter {{ title }}
									</SheetTitle>
									<SheetDescription
										class="text-xs text-muted-foreground font-medium"
									>
										{{ activeFilterCount }} active filters applied
									</SheetDescription>
								</div>
							</div>
						</SheetHeader>

						<ScrollArea class="flex-1 -mx-6 px-6">
							<div class="grid gap-8 py-6">
								<div v-if="showFilters" class="space-y-6">
									<template
										v-if="
											title === 'Problem Categories' || dataType === 'problems'
										"
									>
										<!-- Classification Section -->
										<div class="space-y-4">
											<div class="flex items-center justify-between">
												<h4
													class="text-[11px] font-bold text-muted-foreground uppercase tracking-widest"
												>
													Classification
												</h4>
												<div class="h-[1px] flex-1 bg-border/50 ml-4"></div>
											</div>

											<div class="space-y-4 px-1">
												<div class="space-y-1.5">
													<Label
														class="text-xs font-semibold text-foreground/80"
														>Domain</Label
													>
													<Select
														:model-value="props.filters.domain || '__all__'"
														@update:model-value="
															(v) =>
																handleFilterChange(
																	'domain',
																	v === '__all__' ? null : v
																)
														"
													>
														<SelectTrigger
															class="bg-muted/30 border-input/60 shadow-sm h-9 hover:bg-muted/50 transition-colors"
														>
															<div
																class="flex items-center gap-2 text-muted-foreground"
															>
																<Globe class="h-3.5 w-3.5" />
																<SelectValue
																	placeholder="All domains"
																	class="text-foreground"
																/>
															</div>
														</SelectTrigger>
														<SelectContent>
															<SelectItem value="__all__" class="text-xs"
																>All domains</SelectItem
															>
															<SelectItem
																v-for="d in uniqueDomains"
																:key="d"
																:value="d"
																class="text-xs"
																>{{ d }}</SelectItem
															>
														</SelectContent>
													</Select>
												</div>

												<div class="space-y-1.5">
													<Label
														class="text-xs font-semibold text-foreground/80"
														>Category</Label
													>
													<Select
														:model-value="props.filters.category || '__all__'"
														@update:model-value="
															(v) =>
																handleFilterChange(
																	'category',
																	v === '__all__' ? null : v
																)
														"
													>
														<SelectTrigger
															class="bg-muted/30 border-input/60 shadow-sm h-9 hover:bg-muted/50 transition-colors"
														>
															<div
																class="flex items-center gap-2 text-muted-foreground"
															>
																<Tag class="h-3.5 w-3.5" />
																<SelectValue
																	placeholder="All categories"
																	class="text-foreground"
																/>
															</div>
														</SelectTrigger>
														<SelectContent>
															<SelectItem value="__all__" class="text-xs"
																>All categories</SelectItem
															>
															<SelectItem
																v-for="c in uniqueCategories"
																:key="c"
																:value="c"
																class="text-xs"
																>{{ c }}</SelectItem
															>
														</SelectContent>
													</Select>
												</div>
											</div>
										</div>
									</template>

									<template v-if="dataType === 'assessments'">
										<div class="space-y-4">
											<div class="flex items-center justify-between">
												<h4
													class="text-[11px] font-bold text-muted-foreground uppercase tracking-widest"
												>
													Grouping
												</h4>
												<div class="h-[1px] flex-1 bg-border/50 ml-4"></div>
											</div>
											<div class="space-y-1.5 px-1">
												<Label class="text-xs font-semibold text-foreground/80"
													>Subcategory</Label
												>
												<Select
													:model-value="
														props.filters.sub_category_id || '__all__'
													"
													@update:model-value="
														(v) =>
															handleFilterChange(
																'sub_category_id',
																v === '__all__' ? null : v
															)
													"
												>
													<SelectTrigger
														class="bg-muted/30 border-input/60 shadow-sm h-9 hover:bg-muted/50 transition-colors"
													>
														<div
															class="flex items-center gap-2 text-muted-foreground"
														>
															<Layers class="h-3.5 w-3.5" />
															<SelectValue
																placeholder="All subcategories"
																class="text-foreground"
															/>
														</div>
													</SelectTrigger>
													<SelectContent>
														<SelectItem value="__all__" class="text-xs"
															>All subcategories</SelectItem
														>
														<SelectItem
															v-for="sc in uniqueSubCategories"
															:key="sc"
															:value="sc"
															class="text-xs"
															>{{ sc }}</SelectItem
														>
													</SelectContent>
												</Select>
											</div>
										</div>
									</template>

									<div class="space-y-4">
										<div class="flex items-center justify-between">
											<h4
												class="text-[11px] font-bold text-muted-foreground uppercase tracking-widest"
											>
												Status & State
											</h4>
											<div class="h-[1px] flex-1 bg-border/50 ml-4"></div>
										</div>
										<div class="space-y-1.5 px-1">
											<Label class="text-xs font-semibold text-foreground/80"
												>Status</Label
											>
											<Select
												:model-value="props.filters.is_active || '__all__'"
												@update:model-value="
													(v) =>
														handleFilterChange(
															'is_active',
															v === '__all__' ? null : v
														)
												"
											>
												<SelectTrigger
													class="bg-muted/30 border-input/60 shadow-sm h-9 hover:bg-muted/50 transition-colors"
												>
													<div
														class="flex items-center gap-2 text-muted-foreground"
													>
														<Activity class="h-3.5 w-3.5" />
														<SelectValue
															placeholder="All Statuses"
															class="text-foreground"
														/>
													</div>
												</SelectTrigger>
												<SelectContent>
													<SelectItem value="__all__" class="text-xs"
														>All Statuses</SelectItem
													>
													<SelectItem value="true" class="text-xs"
														>Active</SelectItem
													>
													<SelectItem value="false" class="text-xs"
														>Inactive</SelectItem
													>
												</SelectContent>
											</Select>
										</div>
									</div>
								</div>
							</div>
						</ScrollArea>

						<SheetFooter class="pt-6 border-t border-border mt-auto pb-2">
							<Button
								v-if="hasActiveFilters"
								variant="outline"
								@click="handleClearFilters"
								class="w-full text-destructive hover:text-destructive hover:bg-destructive/5 hover:border-destructive/30 h-10 gap-2 font-medium transition-all"
							>
								<Trash2 class="h-4 w-4" />
								Clear all filters
							</Button>
							<div
								v-else
								class="text-center w-full text-xs text-muted-foreground py-2 italic opacity-60"
							>
								No active filters
							</div>
						</SheetFooter>
					</SheetContent>
				</Sheet>

				<Separator orientation="vertical" class="h-6" />

				<div class="flex items-center gap-1">
					<TooltipProvider>
						<Tooltip>
							<TooltipTrigger as-child>
								<Button
									variant="ghost"
									size="icon"
									class="h-8 w-8"
									@click="emit('refresh')"
									:disabled="loading"
								>
									<RotateCw
										class="h-3.5 w-3.5"
										:class="{ 'animate-spin': loading }"
									/>
								</Button>
							</TooltipTrigger>
							<TooltipContent>Refresh Data</TooltipContent>
						</Tooltip>
					</TooltipProvider>

					<DropdownMenu>
						<DropdownMenuTrigger as-child>
							<Button variant="outline" size="icon" class="h-8 w-8">
								<Download class="h-3.5 w-3.5" />
							</Button>
						</DropdownMenuTrigger>
						<DropdownMenuContent align="end">
							<DropdownMenuItem @click="emit('import')"
								>Import CSV</DropdownMenuItem
							>
							<DropdownMenuItem @click="emit('export')"
								>Export CSV</DropdownMenuItem
							>
						</DropdownMenuContent>
					</DropdownMenu>

					<Button
						size="sm"
						class="h-8 gap-1 ml-2 text-xs"
						@click="openCreateModal"
					>
						<Plus class="h-3.5 w-3.5" />
						New
					</Button>
				</div>
			</div>
		</header>

		<div class="flex-1 overflow-hidden relative">
			<ScrollArea class="h-full w-full">
				<div class="min-w-[800px]">
					<Table>
						<TableHeader class="sticky top-0 z-10 bg-muted/40 backdrop-blur-sm">
							<TableRow class="hover:bg-transparent border-b border-border/60">
								<!-- Expansion Toggle Header -->
								<TableHead
									v-if="enableExpansion"
									class="w-[40px] px-2"
								></TableHead>

								<!-- Checkbox Header -->
								<TableHead class="w-[40px] px-2 text-center">
									<SimpleCheckbox
										:checked="isIndeterminate ? 'indeterminate' : isAllSelected"
										@update:checked="toggleSelectAll"
									/>
								</TableHead>

								<TableHead
									v-for="column in columns"
									:key="column.key"
									class="h-10 px-3 text-xs font-bold text-foreground/80 uppercase tracking-wide select-none cursor-pointer hover:text-foreground transition-colors"
									@click="sortBy(column.key)"
								>
									<div class="flex items-center gap-1">
										{{ column.label }}
										<ArrowUpDown
											v-if="sortColumn === column.key"
											class="h-3 w-3"
										/>
									</div>
								</TableHead>

								<TableHead
									class="w-[50px] px-2 sticky right-0 z-20 bg-muted/40 backdrop-blur-sm shadow-[inset_1px_0_0_0_hsl(var(--border))]"
								></TableHead>
							</TableRow>
						</TableHeader>

						<TableBody>
							<template v-if="loading">
								<TableRow v-for="i in 10" :key="i">
									<TableCell class="p-2"
										><Skeleton class="h-4 w-4"
									/></TableCell>
									<TableCell v-for="c in columns" :key="c.key" class="p-2">
										<Skeleton class="h-4 w-[80%]" />
									</TableCell>
									<TableCell
										class="p-2 sticky right-0 z-10 bg-background shadow-[inset_1px_0_0_0_hsl(var(--border))]"
										><Skeleton class="h-4 w-4"
									/></TableCell>
								</TableRow>
							</template>

							<TableRow v-else-if="filteredData.length === 0">
								<TableCell
									:colspan="columns.length + (enableExpansion ? 3 : 2)"
									class="p-0 h-[400px]"
								>
									<EmptyState
										:dataset-type="dataType"
										:has-filters="hasActiveFilters || searchQuery !== ''"
										@import="emit('import')"
										@create="openCreateModal"
										@clear-search="handleClearFilters"
									/>
								</TableCell>
							</TableRow>

							<template
								v-else
								v-for="(item, index) in paginatedData"
								:key="item[props.idKey] || index"
							>
								<!-- Main Row -->
								<TableRow
									class="group border-b border-border hover:bg-muted/50 data-[state=selected]:bg-muted cursor-pointer transition-colors"
									:class="[
										expandedRows.has(item[props.idKey]) ? 'bg-muted/30' : '',
										variant === 'compact' ? 'h-8 text-xs' : 'h-10',
									]"
									:data-state="
										selectedItems.includes(item[props.idKey]) ? 'selected' : ''
									"
									@click="emit('view', item)"
								>
									<!-- Expand/Collapse Toggle -->
									<TableCell
										v-if="enableExpansion"
										class="text-center"
										:class="variant === 'compact' ? 'p-1' : 'p-2'"
										@click.stop
									>
										<Button
											variant="ghost"
											size="icon"
											class="h-5 w-5 p-0 hover:bg-muted"
											@click="(e) => toggleRowExpansion(item, e)"
										>
											<component
												:is="expandedRows.has(item[props.idKey]) ? Minus : Plus"
												class="h-3 w-3"
											/>
										</Button>
									</TableCell>

									<!-- Checkbox -->
									<TableCell
										class="text-center"
										:class="variant === 'compact' ? 'p-1' : 'p-2'"
										@click.stop
									>
										<SimpleCheckbox
											:checked="selectedItemsSet.has(item[props.idKey])"
											@update:checked="
												(checked) => handleRowSelect(item[props.idKey], checked)
											"
										/>
									</TableCell>

									<!-- Data Columns -->
									<TableCell
										v-for="column in columns"
										:key="column.key"
										class="px-3"
										:class="[
											variant === 'compact'
												? 'py-1 text-[11px]'
												: 'py-2 text-xs',
										]"
									>
										<div v-if="column.type === 'text'" class="max-w-[300px]">
											<span
												v-if="column.key !== 'question_text'"
												class="truncate block"
												:title="getNestedValue(item, column.key)"
											>
												{{ getNestedValue(item, column.key) || "-" }}
											</span>
											<div v-else>
												<p
													:class="
														expandedRows.has(item.id) ? '' : 'line-clamp-1'
													"
													class="text-xs text-foreground/90"
												>
													{{ getNestedValue(item, column.key) || "-" }}
												</p>
											</div>
										</div>

										<div
											v-else-if="column.type === 'badge'"
											class="flex flex-wrap gap-1"
										>
											<Badge
												v-for="tag in normalizeArray(
													getNestedValue(item, column.key)
												)"
												:key="tag"
												variant="secondary"
												class="px-1.5 py-0 h-5 text-[10px] font-normal border-0"
												:class="getBadgeColorClass(tag, column.key)"
											>
												{{ tag }}
											</Badge>
										</div>

										<div v-else-if="column.type === 'boolean'">
											<Badge
												variant="outline"
												class="h-5 px-1.5 text-[10px]"
												:class="
													getNestedValue(item, column.key)
														? 'bg-green-50 text-green-700 border-green-200'
														: 'bg-red-50 text-red-700 border-red-200'
												"
											>
												{{ getNestedValue(item, column.key) ? "Yes" : "No" }}
											</Badge>
										</div>

										<span v-else>{{
											getNestedValue(item, column.key) || "-"
										}}</span>
									</TableCell>

									<TableCell
										class="text-right sticky right-0 z-10 bg-background group-hover:bg-muted/50 data-[state=selected]:bg-muted shadow-[inset_1px_0_0_0_hsl(var(--border))]"
										:class="variant === 'compact' ? 'p-1' : 'p-2'"
										@click.stop
									>
										<DropdownMenu>
											<DropdownMenuTrigger as-child>
												<Button
													variant="ghost"
													size="icon"
													class="opacity-100 transition-opacity"
													:class="variant === 'compact' ? 'h-5 w-5' : 'h-6 w-6'"
												>
													<MoreHorizontal class="h-3.5 w-3.5" />
												</Button>
											</DropdownMenuTrigger>
											<DropdownMenuContent align="end">
												<DropdownMenuItem @click="editItem(item)"
													>Edit</DropdownMenuItem
												>
												<DropdownMenuItem @click="openHistory(item)"
													>View History</DropdownMenuItem
												>
												<DropdownMenuSeparator />
												<DropdownMenuItem
													@click="confirmDelete(item)"
													class="text-red-600 focus:text-red-600"
												>
													Delete
												</DropdownMenuItem>
											</DropdownMenuContent>
										</DropdownMenu>
									</TableCell>
								</TableRow>

								<!-- Nested Row -->
								<TableRow
									v-if="enableExpansion && expandedRows.has(item[props.idKey])"
									class="bg-muted/30 hover:bg-muted/30"
								>
									<TableCell :colspan="columns.length + 2" class="p-0">
										<slot name="row-expansion" :item="item" />
									</TableCell>
								</TableRow>
							</template>
						</TableBody>
					</Table>
				</div>
			</ScrollArea>
		</div>

		<div
			class="flex items-center justify-between border-t border-border bg-muted/20"
			:class="variant === 'compact' ? 'p-1 px-3 min-h-[36px]' : 'p-2 px-4'"
		>
			<div class="text-xs text-muted-foreground hidden sm:block">
				{{ selectedItems.length }} selected
			</div>

			<div class="flex items-center gap-4 ml-auto">
				<div class="flex items-center gap-2">
					<span class="text-xs text-muted-foreground">Rows per page</span>
					<Select
						:model-value="props.pagination.limit.toString()"
						@update:model-value="(v) => emit('page-size-change', parseInt(v))"
					>
						<SelectTrigger
							class="w-[60px] text-xs"
							:class="variant === 'compact' ? 'h-6' : 'h-7'"
						>
							<SelectValue />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="10">10</SelectItem>
							<SelectItem value="25">25</SelectItem>
							<SelectItem value="50">50</SelectItem>
							<SelectItem value="100">100</SelectItem>
						</SelectContent>
					</Select>
				</div>

				<div class="flex items-center gap-1 text-xs text-muted-foreground">
					Page {{ props.currentPage }} of {{ totalPages }}
				</div>

				<div class="flex items-center gap-1">
					<Button
						variant="outline"
						size="icon"
						:class="variant === 'compact' ? 'h-6 w-6' : 'h-7 w-7'"
						:disabled="props.currentPage <= 1"
						@click="goToPage(props.currentPage - 1)"
					>
						<ChevronLeft class="h-3.5 w-3.5" />
					</Button>
					<Button
						variant="outline"
						size="icon"
						:class="variant === 'compact' ? 'h-6 w-6' : 'h-7 w-7'"
						:disabled="props.currentPage >= totalPages"
						@click="goToPage(props.currentPage + 1)"
					>
						<ChevronRight class="h-3.5 w-3.5" />
					</Button>
				</div>
			</div>
		</div>

		<BulkActionsBar
			:selected-count="selectedItems.length"
			:total-count="totalItems"
			@clear="selectedItems = []"
			@delete="showBulkDelete = true"
			@edit="showBulkEdit = true"
			@status-change="handleBulkStatusChange"
		/>

		<BulkDeleteDialog
			:is-open="showBulkDelete"
			:count="selectedItems.length"
			:is-deleting="loading"
			@close="showBulkDelete = false"
			@confirm="confirmBulkDelete"
		/>

		<BulkEditDialog
			:is-open="showBulkEdit"
			:count="selectedItems.length"
			:columns="columns"
			:is-saving="loading"
			@close="showBulkEdit = false"
			@confirm="confirmBulkEdit"
		/>

		<HistoryDialog
			:is-open="showHistory"
			:record-id="historyRecordId"
			:table-name="dataType"
			@close="showHistory = false"
		/>

		<Dialog :open="showDeleteDialog" @update:open="showDeleteDialog = $event">
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Delete item?</DialogTitle>
					<DialogDescription>This action cannot be undone.</DialogDescription>
				</DialogHeader>
				<DialogFooter>
					<Button variant="outline" @click="showDeleteDialog = false"
						>Cancel</Button
					>
					<Button variant="destructive" @click="handleDeleteConfirm"
						>Delete</Button
					>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	</div>
</template>

<script setup>
import { ref, computed, watch } from "vue";
import {
	Search,
	RotateCw,
	Download,
	ListFilter,
	ChevronLeft,
	ChevronRight,
	ChevronDown,
	ArrowUpDown,
	MoreHorizontal,
	Inbox,
	AlertTriangle,
	Plus,
	Minus,
	Globe,
	Tag,
	Trash2,
	Layers,
	Activity,
} from "lucide-vue-next";

// Admin Components
import EmptyState from "@/components/admin/EmptyState.vue";
import BulkActionsBar from "@/components/admin/BulkActionsBar.vue";
import BulkDeleteDialog from "@/components/admin/BulkDeleteDialog.vue";
import BulkEditDialog from "@/components/admin/BulkEditDialog.vue";
import HistoryDialog from "@/components/admin/HistoryDialog.vue";

// Shadcn Components (Assumed Imports based on your setup)
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import SimpleCheckbox from "@/components/ui/SimpleCheckbox.vue";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Separator } from "@/components/ui/separator";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Label } from "@/components/ui/label";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
	DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetHeader,
	SheetTitle,
	SheetTrigger,
	SheetFooter,
} from "@/components/ui/sheet";
import {
	Tooltip,
	TooltipContent,
	TooltipProvider,
	TooltipTrigger,
} from "@/components/ui/tooltip";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";

// --- Props & Emits (Kept mostly same as original to ensure logic compatibility) ---
const props = defineProps({
	title: { type: String, required: true },
	data: { type: Array, default: () => [] },
	columns: { type: Array, required: true },
	loading: { type: Boolean, default: false },
	pageSize: { type: Number, default: 20 },
	pagination: {
		type: Object,
		default: () => ({ skip: 0, limit: 10, total: 0 }),
	},
	currentPage: { type: Number, default: 1 },
	totalPages: { type: Number, default: 1 },
	searchQuery: { type: String, default: "" },
	filters: { type: Object, default: () => ({}) },
	dataType: { type: String, default: "" },
	orderBy: { type: String, default: "" },
	orderDirection: { type: String, default: "asc" },
	enableExpansion: { type: Boolean, default: false },
	variant: { type: String, default: "default" }, // 'default' | 'compact'
	hideToolbar: { type: Boolean, default: false },
	indentLevel: { type: Number, default: 0 },
	nameColumnKey: { type: String, default: "" },
	idKey: { type: String, default: "id" },
});

const emit = defineEmits([
	"create",
	"edit",
	"delete",
	"bulk-delete",
	"refresh",
	"import",
	"export",
	"page-change",
	"page-size-change",
	"next-page",
	"prev-page",
	"search-change",
	"filter-change",
	"clear-filters",
	"view",
	"sort",
]);

// --- State ---
const selectedItems = ref([]);
const selectedItemsSet = computed(() => new Set(selectedItems.value));
const sortColumn = ref(props.orderBy || "");
const sortDirection = ref(props.orderDirection || "asc");
const expandedRows = ref(new Set());
const showDeleteDialog = ref(false);
const itemToDelete = ref(null);
const localSearchQuery = ref(props.searchQuery || "");

// --- Computed Helpers ---
const filteredData = computed(() => props.data); // Assuming filtered server-side
const totalItems = computed(
	() => props.pagination.total || filteredData.value.length
);
const activeFilterCount = computed(
	() =>
		Object.values(props.filters).filter((v) => v !== null && v !== "__all__")
			.length
);
const hasActiveFilters = computed(() => activeFilterCount.value > 0);
const isAllSelected = computed(
	() =>
		filteredData.value.length > 0 &&
		selectedItems.value.length === filteredData.value.length
);
const isIndeterminate = computed(
	() =>
		selectedItems.value.length > 0 &&
		selectedItems.value.length < filteredData.value.length
);
const paginatedData = computed(() => {
	// Sorting logic for current page view
	if (!sortColumn.value) return filteredData.value;
	return [...filteredData.value].sort((a, b) => {
		const valA = String(getNestedValue(a, sortColumn.value) || "");
		const valB = String(getNestedValue(b, sortColumn.value) || "");
		const comp = valA.localeCompare(valB, undefined, {
			numeric: true,
			sensitivity: "base",
		});
		return sortDirection.value === "asc" ? comp : -comp;
	});
});

// Logic to show filters based on title (Copied from logic)
const showFilters = computed(() => {
	const filterableTitles = [
		"Problem Categories",
		"Therapeutic Suggestions",
		"Assessment Questions",
		"Feedback Prompts",
		"Next Actions",
		"Fine-tuning Examples",
		"Subcategories", // New label for problems
	];
	const filterableTypes = [
		"problems",
		"assessments",
		"suggestions",
		"feedback_prompts",
		"next_actions",
		"training_examples",
	];
	return (
		filterableTitles.includes(props.title) ||
		filterableTypes.includes(props.dataType)
	);
});

// Unique value extractors (Simplified for brevity)
const extractUnique = (key) =>
	[
		...new Set(props.data.map((i) => getNestedValue(i, key)).filter(Boolean)),
	].sort();
const uniqueDomains = computed(() => extractUnique("domain"));
const uniqueCategories = computed(() => extractUnique("category"));
const uniqueSubCategories = computed(() => extractUnique("sub_category_id"));

// --- Actions ---
const getNestedValue = (obj, path) =>
	path.split(".").reduce((curr, key) => curr?.[key], obj);
const normalizeArray = (val) => (Array.isArray(val) ? val : val ? [val] : []);

const handleSearchInput = () => emit("search-change", localSearchQuery.value);
const handleFilterChange = (k, v) => emit("filter-change", k, v);
const handleClearFilters = () => emit("clear-filters");

const toggleSelectAll = (checked) => {
	selectedItems.value = checked
		? filteredData.value.map((i) => i[props.idKey])
		: [];
};
const handleRowSelect = (id, checked) => {
	if (checked) selectedItems.value.push(id);
	else selectedItems.value = selectedItems.value.filter((i) => i !== id);
};

const sortBy = (key) => {
	if (sortColumn.value === key)
		sortDirection.value = sortDirection.value === "asc" ? "desc" : "asc";
	else {
		sortColumn.value = key;
		sortDirection.value = "asc";
	}
	emit("sort", { column: sortColumn.value, direction: sortDirection.value });
};

const editItem = (item) => emit("edit", item);
const confirmDelete = (item) => {
	itemToDelete.value = item;
	showDeleteDialog.value = true;
};
const handleDeleteConfirm = () => {
	emit("delete", itemToDelete.value);
	showDeleteDialog.value = false;
};
const openCreateModal = () => emit("create");
const goToPage = (page) => emit("page-change", page);
const previousPage = () => {
	if (props.currentPage > 1) emit("prev-page");
};
const nextPage = () => {
	if (props.currentPage < props.totalPages) emit("next-page");
};

// Style helper for Badges
const getBadgeColorClass = (val, key) => {
	// You can map specific classes here if needed, or stick to default Shadcn variants
	// For 'dense' UI, subtle backgrounds are better than bright ones
	return "bg-secondary text-secondary-foreground hover:bg-secondary/80";
};

watch(
	() => props.searchQuery,
	(v) => (localSearchQuery.value = v || "")
);

watch(
	() => props.orderBy,
	(v) => (sortColumn.value = v || "")
);

watch(
	() => props.orderDirection,
	(v) => (sortDirection.value = v || "asc")
);
const showBulkEdit = ref(false);
const showBulkDelete = ref(false);

const handleBulkStatusChange = async (active) => {
	emit("bulk-update", {
		ids: selectedItems.value,
		field: "is_active",
		value: active,
	});
	selectedItems.value = [];
};

const confirmBulkDelete = () => {
	emit("bulk-delete", selectedItems.value);
	showBulkDelete.value = false;
	selectedItems.value = [];
};

const confirmBulkEdit = (data) => {
	emit("bulk-update", { ids: selectedItems.value, ...data });
	showBulkEdit.value = false;
	selectedItems.value = [];
};

const showHistory = ref(false);
const historyRecordId = ref("");

const openHistory = (item) => {
	historyRecordId.value = item[props.idKey];
	showHistory.value = true;
};

// Expansion Logic
const toggleRowExpansion = (item, event) => {
	event.stopPropagation();
	const id = item[props.idKey];
	if (expandedRows.value.has(id)) {
		expandedRows.value.delete(id);
	} else {
		expandedRows.value.add(id);
	}
};
</script>

<style scoped>
/* Tailwind 4 usually handles this via plugin, but if you need custom scrollbars: */
.overflow-hidden {
	scrollbar-width: thin;
}
</style>
