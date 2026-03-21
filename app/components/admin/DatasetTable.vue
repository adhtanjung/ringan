<template>
	<div
		:class="
			cn('h-full flex flex-col bg-background text-foreground', props.class)
		"
	>
		<header
			v-if="!hideToolbar"
			class="flex flex-col gap-4 border-b border-border p-4 sm:flex-row sm:items-start sm:justify-between"
		>
			<div class="min-w-0 flex items-center gap-2">
				<slot name="header-title">
					<div class="space-y-1">
						<h3 class="text-base font-semibold tracking-tight">{{ title }}</h3>
						<p class="text-xs text-muted-foreground">{{ totalItems }} items</p>
					</div>
				</slot>
			</div>

			<div class="flex flex-1 flex-wrap items-center justify-end gap-2">
				<div class="relative w-full min-w-[220px] max-w-[340px] flex-1" id="tour-search">
					<Search
						class="absolute left-3 top-3 h-4 w-4 text-muted-foreground"
					/>
					<Input
						v-model="localSearchQuery"
						@input="handleSearchInput"
						placeholder="Search records..."
						aria-label="Search records"
						class="h-10 w-full pl-9 text-sm bg-muted/40"
					/>
				</div>

				<Button
					v-if="showFilters"
					variant="outline"
					size="sm"
					class="h-10 gap-2 px-4 text-sm font-medium"
					:class="
						cn(
							hasActiveFilters &&
								'border-primary/20 bg-primary/5 text-foreground',
							showFilterBar && 'border-primary/20 bg-primary/5',
						)
					"
					@click="showFilterBar = !showFilterBar"
					id="tour-filter-toggle"
				>
					<ListFilter class="h-4 w-4" />
					Filters
					<Badge
						v-if="activeFilterCount > 0"
						variant="secondary"
						class="ml-auto h-5 min-w-5 px-1 text-[11px]"
						>{{ activeFilterCount }}</Badge
					>
				</Button>

				<Separator orientation="vertical" class="hidden h-6 sm:block" />

				<div class="flex flex-wrap items-center gap-1">
					<TooltipProvider>
						<Tooltip>
							<TooltipTrigger as-child>
								<Button
									variant="ghost"
									size="icon"
									class="h-10 w-10"
									aria-label="Refresh data"
									@click="emit('refresh')"
									:disabled="loading"
									id="tour-refresh"
								>
									<RotateCw
										class="h-4 w-4"
										:class="cn(loading && 'animate-spin')"
									/>
								</Button>
							</TooltipTrigger>
							<TooltipContent>Refresh Data</TooltipContent>
						</Tooltip>
					</TooltipProvider>

						<DropdownMenu>
							<DropdownMenuTrigger as-child id="tour-import-export">
								<Button
									variant="outline"
									size="icon"
									class="h-10 w-10"
									aria-label="Import or export CSV"
								>
									<Download class="h-4 w-4" />
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
							v-if="showCreateButton"
							size="sm"
							class="ml-1 h-10 gap-2 px-4 text-sm font-medium"
							@click="openCreateModal"
							id="tour-create-new"
						>
							<Plus class="h-4 w-4" />
							New
						</Button>
					</div>
			</div>
		</header>

		<!-- Inline Filter Bar -->
		<div
			v-if="showFilters && showFilterBar"
			id="tour-filter-bar"
				class="animate-in fade-in slide-in-from-top-2 flex flex-wrap items-center gap-6 border-b border-border bg-muted/20 px-4 py-3 duration-200"
			>
				<div class="flex items-center gap-4 flex-wrap flex-1">
					<template
					v-if="dataType === 'problem_types' || title === 'Problem Categories'"
				>
						<div class="flex min-w-[180px] flex-col gap-1.5">
							<Label
								class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
								:class="
								cn(
									props.filters.domain
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Domain
							<span
								v-if="props.filters.domain"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.domain || '__all__'"
								@update:model-value="
									(v) => handleFilterChange('domain', v === '__all__' ? null : v)
								"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Globe class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue placeholder="All domains" class="truncate" />
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All domains</SelectItem
								>
								<SelectItem
									v-for="d in uniqueDomains"
									:key="d"
									:value="d"
									class="text-sm"
									>{{ d }}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>
				</template>

				<template v-if="dataType === 'problems' || title === 'Subcategories'">
						<div class="flex min-w-[180px] flex-col gap-1.5">
						<Label
							class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
							:class="
								cn(
									props.filters.category
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Category
							<span
								v-if="props.filters.category"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.category || '__all__'"
								@update:model-value="
									(v) =>
										handleFilterChange('category', v === '__all__' ? null : v)
								"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Tag class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue placeholder="All categories" class="truncate" />
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All categories</SelectItem
								>
								<SelectItem
									v-for="c in uniqueCategories"
									:key="c"
									:value="c"
									class="text-sm"
									>{{ c }}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>

						<div class="flex min-w-[180px] flex-col gap-1.5">
						<Label
							class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
							:class="
								cn(
									props.filters.sub_category_id
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Subcategory
							<span
								v-if="props.filters.sub_category_id"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.sub_category_id || '__all__'"
								@update:model-value="
								(v) =>
									handleFilterChange(
										'sub_category_id',
										v === '__all__' ? null : v,
									)
							"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Layers class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue
										placeholder="All subcategories"
										class="truncate"
									/>
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All subcategories</SelectItem
								>
								<SelectItem
									v-for="sc in uniqueSubCategories"
									:key="sc.id"
									:value="sc.id"
									class="text-sm"
									>{{
										sc.id === sc.name ? sc.id : sc.id + " - " + sc.name
									}}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>
				</template>

				<template v-if="dataType === 'assessments'">
						<div class="flex min-w-[180px] flex-col gap-1.5">
						<Label
							class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
							:class="
								cn(
									props.filters.sub_category_id
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Subcategory
							<span
								v-if="props.filters.sub_category_id"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.sub_category_id || '__all__'"
								@update:model-value="
								(v) =>
									handleFilterChange(
										'sub_category_id',
										v === '__all__' ? null : v,
									)
							"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Layers class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue
										placeholder="All subcategories"
										class="truncate"
									/>
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All subcategories</SelectItem
								>
								<SelectItem
									v-for="sc in uniqueSubCategories"
									:key="sc.id"
									:value="sc.id"
									class="text-sm"
									>{{
										sc.id === sc.name ? sc.id : sc.id + " - " + sc.name
									}}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>
				</template>

				<template v-if="dataType === 'suggestions'">
						<div class="flex min-w-[180px] flex-col gap-1.5">
						<Label
							class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
							:class="
								cn(
									props.filters.cluster
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Cluster
							<span
								v-if="props.filters.cluster"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.cluster || '__all__'"
								@update:model-value="
								(v) => handleFilterChange('cluster', v === '__all__' ? null : v)
							"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Layers class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue placeholder="All clusters" class="truncate" />
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All clusters</SelectItem
								>
								<SelectItem
									v-for="c in uniqueClusters"
									:key="c"
									:value="c"
									class="text-sm"
									>{{ c }}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>
				</template>

				<template v-if="dataType === 'feedback_prompts'">
						<div class="flex min-w-[180px] flex-col gap-1.5">
						<Label
							class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
							:class="
								cn(
									props.filters.stage
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Stage
							<span
								v-if="props.filters.stage"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.stage || '__all__'"
								@update:model-value="
								(v) => handleFilterChange('stage', v === '__all__' ? null : v)
							"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Activity class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue placeholder="All stages" class="truncate" />
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All stages</SelectItem
								>
								<SelectItem
									v-for="s in uniqueStages"
									:key="s"
									:value="s"
									class="text-sm"
									>{{ s }}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>
				</template>

				<template v-if="dataType === 'training_examples'">
						<div class="flex min-w-[180px] flex-col gap-1.5">
						<Label
							class="text-xs font-medium uppercase tracking-wider flex items-center gap-1.5"
							:class="
								cn(
									props.filters.user_intent
										? 'text-primary'
										: 'text-muted-foreground',
								)
							"
							>Intent
							<span
								v-if="props.filters.user_intent"
								class="h-1 w-1 rounded-full bg-primary"
							/>
						</Label>
							<Select
								:model-value="props.filters.user_intent || '__all__'"
								@update:model-value="
								(v) =>
									handleFilterChange('user_intent', v === '__all__' ? null : v)
							"
							>
							<SelectTrigger
								class="h-10 border-input bg-background text-sm shadow-none"
							>
								<div class="flex items-center gap-2 overflow-hidden">
									<Activity class="h-4 w-4 shrink-0 text-muted-foreground" />
									<SelectValue placeholder="All intents" class="truncate" />
								</div>
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="__all__" class="text-sm"
									>All intents</SelectItem
								>
								<SelectItem
									v-for="i in uniqueUserIntents"
									:key="i"
									:value="i"
									class="text-sm"
									>{{ i }}</SelectItem
								>
							</SelectContent>
						</Select>
					</div>
				</template>
				</div>

			<div class="flex flex-wrap items-center gap-2 self-end pb-0.5">
				<Button
					v-if="hasActiveFilters"
					variant="ghost"
					size="sm"
					class="h-9 px-3 text-sm text-muted-foreground hover:text-destructive"
					@click="handleClearFilters"
				>
					<Trash2 class="mr-1 h-4 w-4" />
					Reset
				</Button>
				<Button
					variant="ghost"
					size="sm"
					class="h-9 px-3 text-sm"
					@click="showFilterBar = false"
				>
					Close
				</Button>
			</div>
		</div>

		<div class="flex-1 overflow-hidden relative">
			<ScrollArea class="h-full w-full">
				<div class="min-w-[800px]">
					<Table>
						<TableHeader
							class="sticky top-0 z-10 bg-muted/40 backdrop-blur-sm"
							id="tour-table-headers"
						>
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
									class="h-10 cursor-pointer select-none px-3 text-xs font-bold uppercase tracking-wide text-foreground/80 transition-colors hover:text-foreground"
									@click="sortBy(column.key)"
								>
									<div class="flex items-center gap-1">
										{{ column.label }}
										<component
											:is="ArrowUpDown"
											class="h-3 w-3 transition-opacity"
											:class="sortColumn === column.key ? 'opacity-80' : 'opacity-25'"
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
								<TableRow
									v-memo="[
										selectedItemsSet.has(item[props.idKey]),
										expandedRows.has(item[props.idKey]),
										item,
										variant,
									]"
									class="group cursor-pointer border-b border-border transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary/30 focus-visible:ring-inset"
									:class="[
										expandedRows.has(item[props.idKey]) ? 'bg-muted/30' : '',
										variant === 'compact' ? 'h-8 text-xs' : 'h-10',
									]"
									:data-state="
										selectedItems.includes(item[props.idKey]) ? 'selected' : ''
									"
									tabindex="0"
									@click="emit('view', item)"
									@keydown.enter="emit('view', item)"
									@keydown.space.prevent="emit('view', item)"
								>
									<TableCell
										v-if="enableExpansion"
										class="text-center"
										:class="cn(variant === 'compact' ? 'p-1' : 'p-2')"
										@click.stop
									>
										<Button
											variant="ghost"
											size="icon"
											class="h-5 w-5 p-0 hover:bg-muted"
											@click="(e: MouseEvent) => toggleRowExpansion(item, e)"
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
										:class="cn(variant === 'compact' ? 'p-1' : 'p-2')"
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
													getNestedValue(item, column.key),
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
														? 'bg-primary/10 text-primary border-primary/20'
														: 'bg-destructive/10 text-destructive border-destructive/20'
												"
											>
												{{ getNestedValue(item, column.key) ? "Yes" : "No" }}
											</Badge>
										</div>

										<span v-else-if="column.type === 'date'">{{
											formatDate(getNestedValue(item, column.key))
										}}</span>

										<span v-else>{{
											getNestedValue(item, column.key) || "-"
										}}</span>
									</TableCell>

									<TableCell
										class="text-right sticky right-0 z-10 bg-background group-hover:bg-muted/50 data-[state=selected]:bg-muted shadow-[inset_1px_0_0_0_hsl(var(--border))]"
										:class="cn(variant === 'compact' ? 'p-1' : 'p-2')"
										@click.stop
									>
										<DropdownMenu>
											<DropdownMenuTrigger as-child>
												<Button
													variant="ghost"
													size="icon"
													class="opacity-100 transition-opacity"
													:class="
														cn(variant === 'compact' ? 'h-5 w-5' : 'h-6 w-6')
													"
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
													class="text-destructive focus:text-destructive"
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
			:class="cn(variant === 'compact' ? 'p-1 px-3 min-h-[36px]' : 'p-2 px-4')"
		>
			<div class="text-xs text-muted-foreground hidden sm:block">
				{{ selectedItems.length }} selected
			</div>

			<div class="flex items-center gap-4 ml-auto">
				<div class="flex items-center gap-2">
					<span class="text-xs text-muted-foreground">Rows per page</span>
					<Select
						:model-value="props.pagination.limit.toString()"
						@update:model-value="(v) => emit('page-size-change', parseInt(String(v ?? '10')))"
					>
						<SelectTrigger
							class="w-[60px] text-xs"
							:class="cn(variant === 'compact' ? 'h-6' : 'h-7')"
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
						:class="cn(variant === 'compact' ? 'h-6 w-6' : 'h-7 w-7')"
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
			:columns="(columns as any)"
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
					<DialogTitle>Delete "{{ itemToDeleteLabel }}"?</DialogTitle>
					<DialogDescription>This will permanently remove this record. This action cannot be undone.</DialogDescription>
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

<script setup lang="ts">
import { ref, computed, watch } from "vue";
import { cn } from "@/lib/utils";
import {
	Search,
	RotateCw,
	Download,
	ListFilter,
	ChevronLeft,
	ChevronRight,
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
import { SimpleCheckbox } from "@/components/ui/simple-checkbox";
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
import { formatDate } from "@/utils/formatDate";

// --- Types ---
interface TableColumn {
	key: string;
	label: string;
	type?: 'text' | 'badge' | 'boolean' | string;
}
interface SubCategory {
	id: string;
	name: string;
}
interface Pagination {
	skip: number;
	limit: number;
	total: number;
}

// --- Props ---
const props = withDefaults(defineProps<{
	title: string;
	data: any[];
	columns: TableColumn[];
	loading?: boolean;
	pageSize?: number;
	pagination?: Pagination;
	currentPage?: number;
	totalPages?: number;
	searchQuery?: string;
	filters?: Record<string, any>;
	dataType?: string;
	orderBy?: string;
	orderDirection?: string;
	enableExpansion?: boolean;
	variant?: 'default' | 'compact';
	hideToolbar?: boolean;
	showCreateButton?: boolean;
	indentLevel?: number;
	nameColumnKey?: string;
	idKey?: string;
	class?: string;
	categories?: any[];
	subCategories?: SubCategory[];
	allSelectableIds?: Array<string | number>;
}>(), {
	loading: false,
	pageSize: 20,
	pagination: () => ({ skip: 0, limit: 10, total: 0 }),
	currentPage: 1,
	totalPages: 1,
	searchQuery: '',
	filters: () => ({}),
	dataType: '',
	orderBy: '',
	orderDirection: 'asc',
	enableExpansion: false,
	variant: 'default',
	hideToolbar: false,
	showCreateButton: true,
	indentLevel: 0,
	nameColumnKey: '',
	idKey: 'id',
	class: '',
	categories: () => [],
	subCategories: () => [],
	allSelectableIds: () => [],
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
	"bulk-update",
]);

// --- State ---
const selectedItems = ref<any[]>([]);
const selectedItemsSet = computed(() => new Set(selectedItems.value));
const sortColumn = ref(props.orderBy || "");
const sortDirection = ref(props.orderDirection || "asc");
const expandedRows = ref(new Set());
const showDeleteDialog = ref(false);
const itemToDelete = ref<any>(null);
const localSearchQuery = ref(props.searchQuery || '');
const showFilterBar = ref(false);
const showBulkEdit = ref(false);
const showBulkDelete = ref(false);

// Label shown in delete confirmation dialog
const itemToDeleteLabel = computed(() => {
	if (!itemToDelete.value) return 'this item';
	if (props.nameColumnKey) {
		const val = getNestedValue(itemToDelete.value, props.nameColumnKey);
		if (val) return String(val).slice(0, 60);
	}
	return itemToDelete.value[props.idKey]
		? `#${String(itemToDelete.value[props.idKey]).slice(0, 20)}`
		: 'this item';
});

// --- Computed Helpers ---
const filteredData = computed(() => props.data); // Assuming filtered server-side
const totalItems = computed(
	() => props.pagination.total || filteredData.value.length,
);
const activeFilterCount = computed(() => {
	return Object.entries(props.filters).filter(([key, v]) => {
		if (v === null || v === "__all__") return false;
		// Don't count is_active=true as an "active" filter if it's the default
		if (key === "is_active" && v === "true") return false;
		return String(v).trim() !== "";
	}).length;
});
const hasActiveFilters = computed(() => activeFilterCount.value > 0);
const isAllSelected = computed(
	() =>
		filteredData.value.length > 0 &&
		filteredData.value.every((item: any) =>
			selectedItemsSet.value.has(item[props.idKey]),
		),
);
const isIndeterminate = computed(
	() => {
		const currentPageHasSelection = filteredData.value.some((item: any) =>
			selectedItemsSet.value.has(item[props.idKey]),
		);
		return currentPageHasSelection && !isAllSelected.value;
	},
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
	const filterableTypes = [
		'problem_types',
		'problems',
		'assessments',
		'suggestions',
		'feedback_prompts',
		'next_actions',
		'training_examples',
	];
	return filterableTypes.includes(props.dataType);
});

// Unique value extractors (Simplified for brevity)
const extractUnique = (key: string): any[] =>
	[
		...new Set(props.data.map((i) => getNestedValue(i, key)).filter(Boolean)),
	].sort();
const uniqueDomains = computed(() => extractUnique("domain"));
const uniqueCategories = computed(() => {
	if (props.categories && props.categories.length > 0) {
		return props.categories;
	}
	return extractUnique("category");
});
const uniqueSubCategories = computed(() => {
	if (props.subCategories && props.subCategories.length > 0) {
		return props.subCategories;
	}
	// Fallback to extraction from data, but format as objects for consistency
	return extractUnique("sub_category_id").map((id) => ({ id, name: id }));
});
const uniqueClusters = computed(() => extractUnique("cluster"));
const uniqueStages = computed(() => extractUnique("stage"));
const uniqueUserIntents = computed(() => extractUnique("user_intent"));

// --- Actions ---
const getNestedValue = (obj: any, path: string): any =>
	path.split('.').reduce((curr: any, key: string) => curr?.[key], obj);
const normalizeArray = (val: any): any[] => (Array.isArray(val) ? val : val ? [val] : []);
const handleSearchInput = () => emit('search-change', localSearchQuery.value);
const handleFilterChange = (k: string, v: any) => emit('filter-change', k, v);
const handleClearFilters = () => emit('clear-filters');

const toggleSelectAll = (checked: boolean | 'indeterminate') => {
	if (checked && checked !== 'indeterminate') {
		const ids = props.allSelectableIds.length
			? props.allSelectableIds
			: filteredData.value.map((i: any) => i[props.idKey]);
		selectedItems.value = Array.from(new Set(ids.filter(Boolean)));
	} else {
		selectedItems.value = [];
	}
};
const handleRowSelect = (id: any, checked: boolean) => {
	if (checked) {
		if (!selectedItemsSet.value.has(id)) selectedItems.value.push(id);
	}
	else selectedItems.value = selectedItems.value.filter((i: any) => i !== id);
};

const sortBy = (key: string) => {
	if (sortColumn.value === key)
		sortDirection.value = sortDirection.value === "asc" ? "desc" : "asc";
	else {
		sortColumn.value = key;
		sortDirection.value = "asc";
	}
	emit("sort", { column: sortColumn.value, direction: sortDirection.value });
};

const editItem = (item: any) => emit('edit', item);
const confirmDelete = (item: any) => {
	itemToDelete.value = item;
	showDeleteDialog.value = true;
};
const handleDeleteConfirm = () => {
	if (!itemToDelete.value) return;
	emit("delete", itemToDelete.value);
	showDeleteDialog.value = false;
	itemToDelete.value = null;
};
const openCreateModal = () => emit('create');
const goToPage = (page: number) => emit('page-change', page);

// Style helper for Badges
const getBadgeColorClass = (val: any, key: string) => {
	return 'bg-secondary text-secondary-foreground hover:bg-secondary/80';
};

watch(
	() => props.searchQuery,
	(v) => (localSearchQuery.value = v || ""),
);

watch(
	() => props.orderBy,
	(v) => (sortColumn.value = v || ""),
);

watch(
	() => props.orderDirection,
	(v) => (sortDirection.value = v || "asc"),
);

const confirmBulkDelete = () => {
	emit("bulk-delete", selectedItems.value);
	showBulkDelete.value = false;
	selectedItems.value = [];
};

const confirmBulkEdit = (data: any) => {
	emit("bulk-update", { ids: selectedItems.value, ...data });
	showBulkEdit.value = false;
	selectedItems.value = [];
};

const showHistory = ref(false);
const historyRecordId = ref("");

const openHistory = (item: any) => {
	historyRecordId.value = item[props.idKey];
	showHistory.value = true;
};

// Expansion Logic
const toggleRowExpansion = (item: any, event: Event) => {
	event.stopPropagation();
	const id = item[props.idKey];
	if (expandedRows.value.has(id)) {
		expandedRows.value.delete(id);
	} else {
		expandedRows.value.add(id);
	}
};
</script>
