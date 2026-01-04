<template>
	<div class="h-full flex flex-col bg-background text-foreground">
		<!-- Header -->
		<header
			class="flex flex-col gap-4 border-b border-border p-4 sm:flex-row sm:items-center sm:justify-between"
		>
			<div class="flex items-center gap-3">
				<Button variant="ghost" size="sm" class="gap-2" @click="emit('exit')">
					<ArrowLeft class="h-4 w-4" />
					Exit
				</Button>
				<Separator orientation="vertical" class="h-6" />
				<div>
					<h3 class="text-base font-semibold tracking-tight">Bulk Edit Mode</h3>
					<p class="text-xs text-muted-foreground">
						{{ localData.length }} rows
						<span
							v-if="dirtyRowIds.size > 0"
							class="text-amber-600 font-medium"
						>
							· {{ dirtyRowIds.size }} unsaved
						</span>
					</p>
				</div>
			</div>

			<div class="flex items-center gap-2">
				<Button
					variant="outline"
					size="sm"
					class="gap-2"
					:disabled="dirtyRowIds.size === 0"
					@click="discardChanges"
				>
					<RotateCcw class="h-3.5 w-3.5" />
					Discard
				</Button>
				<Button
					size="sm"
					class="gap-2"
					:disabled="dirtyRowIds.size === 0 || saving"
					@click="saveAllChanges"
				>
					<Loader2 v-if="saving" class="h-3.5 w-3.5 animate-spin" />
					<Save v-else class="h-3.5 w-3.5" />
					Save All
				</Button>
			</div>
		</header>

		<!-- Spreadsheet Grid -->
		<div class="flex-1 overflow-hidden relative">
			<ScrollArea class="h-full w-full">
				<div class="min-w-[1200px]">
					<table class="w-full border-collapse text-xs">
						<!-- Header Row -->
						<thead class="sticky top-0 z-10 bg-muted/80 backdrop-blur-sm">
							<tr>
								<th
									class="w-10 border-b border-r border-border p-2 text-center"
								>
									#
								</th>
								<th
									v-for="col in displayColumns"
									:key="col.key"
									class="border-b border-r border-border p-2 text-left font-medium text-muted-foreground min-w-[120px]"
									:class="{
										'min-w-[300px]': col.key === 'question_text',
										'bg-muted/30': col.type === 'readonly',
									}"
								>
									{{ col.label }}
									<span v-if="col.required" class="text-red-500">*</span>
								</th>
								<th class="w-10 border-b border-border p-2"></th>
							</tr>
						</thead>

						<!-- Data Rows -->
						<tbody>
							<tr
								v-for="(row, rowIndex) in localData"
								:key="row._tempId || row.id"
								class="group"
								:class="{
									'bg-amber-50/50': dirtyRowIds.has(row._tempId || row.id),
									'bg-green-50/30': row._isNew,
								}"
							>
								<td
									class="border-b border-r border-border p-2 text-center text-muted-foreground font-mono text-[10px]"
								>
									{{ rowIndex + 1 }}
								</td>

								<td
									v-for="col in displayColumns"
									:key="col.key"
									class="border-b border-r border-border p-0 relative"
									:class="{
										'ring-2 ring-primary ring-inset':
											activeCell?.row === rowIndex &&
											activeCell?.col === col.key &&
											col.type !== 'readonly',
										'bg-amber-100/50': dirtyCells.has(
											`${row._tempId || row.id}:${col.key}`
										),
										'bg-muted/30 cursor-not-allowed': col.type === 'readonly',
									}"
									@click="
										col.type !== 'readonly' && activateCell(rowIndex, col.key)
									"
								>
									<!-- Readonly field -->
									<template v-if="col.type === 'readonly'">
										<div
											class="px-2 py-1.5 h-8 flex items-center text-muted-foreground font-mono text-[10px] truncate"
										>
											{{
												row[col.key] || (row._isNew ? "Auto-generated" : "-")
											}}
										</div>
									</template>

									<!-- Dropdown for select type -->
									<template v-else-if="col.type === 'select'">
										<Select
											v-if="
												activeCell?.row === rowIndex &&
												activeCell?.col === col.key
											"
											:model-value="row[col.key] || ''"
											@update:model-value="(v) => updateCell(row, col.key, v)"
										>
											<SelectTrigger
												class="h-8 rounded-none border-0 text-xs focus:ring-0"
											>
												<SelectValue
													:placeholder="col.placeholder || 'Select...'"
												/>
											</SelectTrigger>
											<SelectContent>
												<SelectItem
													v-for="opt in col.options"
													:key="opt.value"
													:value="opt.value"
												>
													{{ opt.label }}
												</SelectItem>
											</SelectContent>
										</Select>
										<div
											v-else
											class="px-2 py-1.5 h-8 flex items-center cursor-pointer hover:bg-muted/50"
										>
											{{ row[col.key] || "-" }}
										</div>
									</template>

									<!-- Textarea for multiline -->
									<template v-else-if="col.multiline">
										<textarea
											v-if="
												activeCell?.row === rowIndex &&
												activeCell?.col === col.key
											"
											:ref="(el) => setCellRef(rowIndex, col.key, el)"
											:value="row[col.key] || ''"
											class="w-full min-h-[60px] p-2 text-xs border-0 focus:outline-none focus:ring-0 resize-none bg-transparent"
											@input="(e) => updateCell(row, col.key, (e.target as HTMLTextAreaElement).value)"
											@keydown="(e) => handleKeydown(e, rowIndex, col.key)"
											@blur="handleBlur"
										/>
										<div
											v-else
											class="px-2 py-1.5 min-h-[32px] cursor-pointer hover:bg-muted/50 line-clamp-2"
										>
											{{ row[col.key] || "-" }}
										</div>
									</template>

									<!-- Text input -->
									<template v-else>
										<input
											v-if="
												activeCell?.row === rowIndex &&
												activeCell?.col === col.key
											"
											:ref="(el) => setCellRef(rowIndex, col.key, el)"
											type="text"
											:value="row[col.key] || ''"
											class="w-full h-8 px-2 text-xs border-0 focus:outline-none focus:ring-0 bg-transparent"
											@input="(e) => updateCell(row, col.key, (e.target as HTMLInputElement).value)"
											@keydown="(e) => handleKeydown(e, rowIndex, col.key)"
											@blur="handleBlur"
										/>
										<div
											v-else
											class="px-2 py-1.5 h-8 flex items-center cursor-pointer hover:bg-muted/50 truncate"
										>
											{{ row[col.key] || "-" }}
										</div>
									</template>
								</td>

								<!-- Delete row button -->
								<td class="border-b border-border p-1 text-center">
									<Button
										variant="ghost"
										size="icon"
										class="h-6 w-6 opacity-0 group-hover:opacity-100 text-red-500 hover:text-red-600 hover:bg-red-50"
										@click="deleteRow(rowIndex)"
									>
										<Trash2 class="h-3.5 w-3.5" />
									</Button>
								</td>
							</tr>

							<!-- Add Row Button -->
							<tr>
								<td
									:colspan="displayColumns.length + 2"
									class="border-b border-border p-0"
								>
									<button
										class="w-full py-2 text-xs text-muted-foreground hover:bg-muted/50 hover:text-foreground flex items-center justify-center gap-2 transition-colors"
										@click="addNewRow"
									>
										<Plus class="h-3.5 w-3.5" />
										Add new row
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</ScrollArea>
		</div>

		<!-- Footer Status -->
		<div
			v-if="validationErrors.length > 0"
			class="flex items-center gap-2 p-3 bg-red-50 border-t border-red-200 text-red-700 text-xs"
		>
			<AlertCircle class="h-4 w-4 shrink-0" />
			<span>{{ validationErrors[0] }}</span>
		</div>
	</div>
</template>

<script setup lang="ts">
import { ref, computed, nextTick, watch } from "vue";
import {
	ArrowLeft,
	Save,
	RotateCcw,
	Plus,
	Trash2,
	Loader2,
	AlertCircle,
} from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { useToast } from "@/components/ui/toast/use-toast";

interface Column {
	key: string;
	label: string;
	type?: "text" | "select" | "readonly";
	multiline?: boolean;
	required?: boolean;
	options?: { value: string; label: string }[];
	placeholder?: string;
}

interface Props {
	data: any[];
	columns: Column[];
	dataType: string;
}

const props = defineProps<Props>();

const emit = defineEmits<{
	(e: "exit"): void;
	(e: "save", items: any[]): Promise<void>;
}>();

const { toast } = useToast();

// Local copy of data for editing
const localData = ref<any[]>([]);
const originalData = ref<any[]>([]);
const saving = ref(false);
const validationErrors = ref<string[]>([]);

// Track dirty state
const dirtyCells = ref(new Set<string>());
const dirtyRowIds = computed(() => {
	const ids = new Set<string>();
	dirtyCells.value.forEach((key) => {
		const [rowId] = key.split(":");
		ids.add(rowId);
	});
	// Also include new rows
	localData.value.forEach((row) => {
		if (row._isNew) {
			ids.add(row._tempId);
		}
	});
	return ids;
});

// Active cell tracking
const activeCell = ref<{ row: number; col: string } | null>(null);
const cellRefs = ref<Record<string, HTMLInputElement | HTMLTextAreaElement>>(
	{}
);

// All columns for display (including readonly)
const displayColumns = computed<Column[]>(() => props.columns);

// Filter to only editable columns (for validation and keyboard nav)
const editableColumns = computed<Column[]>(() => {
	return props.columns.filter((col) => col.type !== "readonly");
});

// Initialize local data
const initializeData = () => {
	localData.value = props.data.map((item) => ({
		...item,
		_tempId:
			item.id || `temp_${Date.now()}_${Math.random().toString(36).slice(2)}`,
	}));
	originalData.value = JSON.parse(JSON.stringify(props.data));
	dirtyCells.value.clear();
};

watch(() => props.data, initializeData, { immediate: true });

// Cell management
const setCellRef = (row: number, col: string, el: any) => {
	if (el) {
		cellRefs.value[`${row}:${col}`] = el;
	}
};

const activateCell = (row: number, col: string) => {
	activeCell.value = { row, col };
	nextTick(() => {
		const ref = cellRefs.value[`${row}:${col}`];
		if (ref) {
			ref.focus();
			if ("select" in ref) {
				ref.select();
			}
		}
	});
};

const handleBlur = () => {
	// Delay to allow click events on other cells
	setTimeout(() => {
		// Keep cell active for now - only deactivate on escape or save
	}, 100);
};

const updateCell = (row: any, key: string, value: any) => {
	const rowId = row._tempId || row.id;
	row[key] = value;

	// Mark as dirty if different from original
	const original = originalData.value.find((o) => o.id === row.id);
	if (!row._isNew && original && original[key] !== value) {
		dirtyCells.value.add(`${rowId}:${key}`);
	} else if (!row._isNew && original && original[key] === value) {
		dirtyCells.value.delete(`${rowId}:${key}`);
	}
};

// Keyboard navigation
const handleKeydown = (e: KeyboardEvent, rowIndex: number, colKey: string) => {
	const colIndex = editableColumns.value.findIndex((c) => c.key === colKey);

	switch (e.key) {
		case "Tab":
			e.preventDefault();
			if (e.shiftKey) {
				// Previous cell
				if (colIndex > 0) {
					activateCell(rowIndex, editableColumns.value[colIndex - 1].key);
				} else if (rowIndex > 0) {
					activateCell(
						rowIndex - 1,
						editableColumns.value[editableColumns.value.length - 1].key
					);
				}
			} else {
				// Next cell
				if (colIndex < editableColumns.value.length - 1) {
					activateCell(rowIndex, editableColumns.value[colIndex + 1].key);
				} else if (rowIndex < localData.value.length - 1) {
					activateCell(rowIndex + 1, editableColumns.value[0].key);
				}
			}
			break;

		case "Enter":
			if (!e.shiftKey) {
				e.preventDefault();
				// Move down
				if (rowIndex < localData.value.length - 1) {
					activateCell(rowIndex + 1, colKey);
				}
			}
			break;

		case "Escape":
			e.preventDefault();
			activeCell.value = null;
			break;

		case "ArrowUp":
			if (!editableColumns.value.find((c) => c.key === colKey)?.multiline) {
				e.preventDefault();
				if (rowIndex > 0) {
					activateCell(rowIndex - 1, colKey);
				}
			}
			break;

		case "ArrowDown":
			if (!editableColumns.value.find((c) => c.key === colKey)?.multiline) {
				e.preventDefault();
				if (rowIndex < localData.value.length - 1) {
					activateCell(rowIndex + 1, colKey);
				}
			}
			break;
	}
};

// Row operations
const addNewRow = () => {
	const newRow: any = {
		_tempId: `new_${Date.now()}_${Math.random().toString(36).slice(2)}`,
		_isNew: true,
	};

	// Initialize with empty values for each column
	editableColumns.value.forEach((col) => {
		newRow[col.key] = "";
	});

	localData.value.push(newRow);

	// Activate first cell of new row
	nextTick(() => {
		activateCell(localData.value.length - 1, editableColumns.value[0].key);
	});
};

const deleteRow = (index: number) => {
	const row = localData.value[index];
	if (row._isNew) {
		// Just remove from local data
		localData.value.splice(index, 1);
	} else {
		// Mark for deletion or handle via emit
		localData.value.splice(index, 1);
		// Track that we need to delete this on save
		dirtyCells.value.add(`${row._tempId || row.id}:__deleted__`);
	}
};

// Save and discard
const discardChanges = () => {
	initializeData();
	activeCell.value = null;
	toast({
		title: "Changes discarded",
		description: "All unsaved changes have been reverted.",
	});
};

const validate = (): boolean => {
	validationErrors.value = [];

	for (const row of localData.value) {
		for (const col of editableColumns.value) {
			if (col.required && !row[col.key]?.toString().trim()) {
				validationErrors.value.push(
					`Row ${localData.value.indexOf(row) + 1}: ${col.label} is required`
				);
				return false;
			}
		}
	}

	return true;
};

const saveAllChanges = async () => {
	if (!validate()) return;

	saving.value = true;
	validationErrors.value = [];

	try {
		// Get items that have changes
		const changedItems = localData.value.filter((row) => {
			const rowId = row._tempId || row.id;
			if (row._isNew) return true;
			return Array.from(dirtyCells.value).some((key) =>
				key.startsWith(`${rowId}:`)
			);
		});

		// Clean up temp properties before saving
		const itemsToSave = changedItems.map((item) => {
			const { _tempId, _isNew, ...rest } = item;
			return rest;
		});

		await emit("save", itemsToSave);

		toast({
			title: "Changes saved",
			description: `Successfully saved ${itemsToSave.length} item(s).`,
		});

		// Reset dirty state
		dirtyCells.value.clear();
		localData.value.forEach((row) => {
			delete row._isNew;
		});
		originalData.value = JSON.parse(JSON.stringify(localData.value));
	} catch (error) {
		console.error("Save error:", error);
		toast({
			title: "Error",
			description: "Failed to save changes. Please try again.",
			variant: "destructive",
		});
	} finally {
		saving.value = false;
	}
};
</script>

<style scoped>
table {
	border-spacing: 0;
}

input:focus,
textarea:focus {
	outline: none;
}
</style>
