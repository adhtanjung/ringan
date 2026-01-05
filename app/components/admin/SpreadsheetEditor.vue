<template>
	<div
		class="h-screen flex flex-col bg-background text-foreground overflow-hidden"
	>
		<!-- Header -->
		<header
			class="flex flex-col gap-4 border-b border-border p-4 sm:flex-row sm:items-center sm:justify-between"
		>
			<div class="flex items-center gap-3">
				<Button variant="ghost" size="sm" class="gap-2" @click="handleExit">
					<ArrowLeft class="h-4 w-4" />
					Exit
				</Button>
				<Separator orientation="vertical" class="h-6" />
				<div>
					<h3 class="text-base font-semibold tracking-tight">Bulk Edit Mode</h3>
					<p class="text-xs text-muted-foreground">
						{{ rowData.length }} rows
						<span v-if="hasChanges" class="text-amber-600 font-medium">
							· Unsaved changes
						</span>
					</p>
				</div>
			</div>

			<div class="flex items-center gap-2">
				<Button
					variant="outline"
					size="sm"
					class="gap-2"
					:disabled="!hasChanges"
					@click="discardChanges"
				>
					<RotateCcw class="h-3.5 w-3.5" />
					Discard
				</Button>
				<Button
					size="sm"
					class="gap-2"
					:disabled="!hasChanges || saving"
					@click="saveAllChanges"
				>
					<Loader2 v-if="saving" class="h-3.5 w-3.5 animate-spin" />
					<Save v-else class="h-3.5 w-3.5" />
					Save All
				</Button>
			</div>
		</header>

		<!-- AG Grid Container - explicit height calculation -->
		<div
			class="ag-theme-alpine"
			style="height: calc(100vh - 160px); width: 100%"
		>
			<AgGridVue
				class="h-full w-full"
				:rowData="rowData"
				:columnDefs="columnDefs"
				:defaultColDef="defaultColDef"
				:getRowId="getRowId"
				:animateRows="true"
				:enableCellTextSelection="true"
				:undoRedoCellEditing="true"
				:undoRedoCellEditingLimit="20"
				:stopEditingWhenCellsLoseFocus="true"
				@cellValueChanged="onCellValueChanged"
				@cellFocused="onCellFocused"
				@gridReady="onGridReady"
			/>
		</div>

		<!-- Footer with Add Row -->
		<div
			class="flex items-center justify-between p-3 border-t border-border bg-muted/20"
		>
			<Button variant="outline" size="sm" class="gap-2" @click="addNewRow">
				<Plus class="h-3.5 w-3.5" />
				Add New Row
			</Button>

			<div class="text-xs text-muted-foreground">
				<kbd class="px-1 py-0.5 bg-muted rounded text-[10px]">Ctrl+C</kbd> Copy
				· <kbd class="px-1 py-0.5 bg-muted rounded text-[10px]">Ctrl+X</kbd> Cut
				·
				<kbd class="px-1 py-0.5 bg-muted rounded text-[10px]">Ctrl+V</kbd> Paste
				·
				<kbd class="px-1 py-0.5 bg-muted rounded text-[10px]">Ctrl+Z</kbd> Undo
				·
				<kbd class="px-1 py-0.5 bg-muted rounded text-[10px]">Ctrl+Y</kbd> Redo
			</div>
		</div>
	</div>
</template>

<script setup lang="ts">
import { ref, computed, watch, onMounted, onUnmounted } from "vue";
import { AgGridVue } from "ag-grid-vue3";
import {
	ModuleRegistry,
	AllCommunityModule,
	type ColDef,
	type GridApi,
	type GridReadyEvent,
	type CellValueChangedEvent,
} from "ag-grid-community";
import "ag-grid-community/styles/ag-grid.css";
import "ag-grid-community/styles/ag-theme-alpine.css";

// Register AG Grid modules (required for v35+)
ModuleRegistry.registerModules([AllCommunityModule]);

import { ArrowLeft, Save, RotateCcw, Plus, Loader2 } from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
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
	(e: "save", payload: { items: any[]; deletedIds: string[] }): Promise<void>;
}>();

const { toast } = useToast();

// Grid state
const gridApi = ref<GridApi | null>(null);
const rowData = ref<any[]>([]);
const originalData = ref<any[]>([]);
const modifiedRows = ref(new Set<string>());
const deletedRowIds = ref(new Set<string>());
const saving = ref(false);

// Computed
const hasChanges = computed(
	() => modifiedRows.value.size > 0 || deletedRowIds.value.size > 0
);

// Convert our column format to AG Grid column defs
const columnDefs = computed<ColDef[]>(() => {
	const cols: ColDef[] = props.columns.map((col) => {
		const colDef: ColDef = {
			field: col.key,
			headerName: col.label,
			editable: col.type !== "readonly",
			sortable: true,
			filter: true,
			resizable: true,
			minWidth: 100,
		};

		// Readonly columns styling
		if (col.type === "readonly") {
			colDef.cellStyle = { backgroundColor: "#f5f5f5", color: "#888" };
		}

		// Select type - use dropdown editor
		if (col.type === "select" && col.options) {
			colDef.cellEditor = "agSelectCellEditor";
			colDef.cellEditorParams = {
				values: col.options.map((opt) => opt.value),
			};
		}

		// Multiline - use larger text editor
		if (col.multiline) {
			colDef.cellEditor = "agLargeTextCellEditor";
			colDef.cellEditorPopup = true;
			colDef.minWidth = 300;
		}

		// Question text - wider column
		if (col.key === "question_text") {
			colDef.flex = 2;
			colDef.wrapText = true;
			colDef.autoHeight = true;
		}

		return colDef;
	});

	// Add delete action column
	cols.push({
		headerName: "",
		field: "_actions",
		width: 60,
		editable: false,
		sortable: false,
		filter: false,
		cellRenderer: (params: any) => {
			if (!params.data) return "";
			const button = document.createElement("button");
			button.innerHTML = "🗑️";
			button.className = "opacity-50 hover:opacity-100 cursor-pointer";
			button.onclick = () => deleteRow(params.data);
			return button;
		},
	});

	return cols;
});

const defaultColDef = computed<ColDef>(() => ({
	editable: true,
	sortable: true,
	filter: true,
	resizable: true,
	minWidth: 100,
}));

// Row ID getter
const getRowId = (params: any) => {
	return params.data._tempId || params.data.id || `row_${Math.random()}`;
};

// Initialize data
const initializeData = () => {
	rowData.value = props.data.map((item) => ({
		...item,
		_tempId:
			item.id || `temp_${Date.now()}_${Math.random().toString(36).slice(2)}`,
	}));
	originalData.value = JSON.parse(JSON.stringify(props.data));
	modifiedRows.value.clear();
	deletedRowIds.value.clear();
};

watch(() => props.data, initializeData, { immediate: true });

// Grid events
const onGridReady = (params: GridReadyEvent) => {
	gridApi.value = params.api;
	params.api.sizeColumnsToFit();
};

const onCellValueChanged = (event: CellValueChangedEvent) => {
	if (!event.data) return;

	const rowId = event.data._tempId || event.data.id;
	const original = originalData.value.find((o) => o.id === event.data.id);

	// Check if the row is actually modified
	let isModified = false;
	if (event.data._isNew) {
		isModified = true;
	} else if (original) {
		isModified = event.oldValue !== event.newValue;
	}

	if (isModified) {
		modifiedRows.value.add(rowId);
	}
};

// Cell focus tracking for clipboard
const focusedCell = ref<{ rowIndex: number; colKey: string } | null>(null);
const clipboardValue = ref<string>("");

const onCellFocused = (event: any) => {
	if (event.rowIndex !== null && event.column) {
		focusedCell.value = {
			rowIndex: event.rowIndex,
			colKey: event.column.getColId(),
		};
	}
};

// Clipboard operations
const copyCell = async () => {
	if (!focusedCell.value || !gridApi.value) return;

	const rowNode = gridApi.value.getDisplayedRowAtIndex(
		focusedCell.value.rowIndex
	);
	if (!rowNode?.data) return;

	const value = rowNode.data[focusedCell.value.colKey];
	clipboardValue.value = value || "";

	try {
		await navigator.clipboard.writeText(clipboardValue.value);
	} catch (e) {
		console.warn("Clipboard write failed, using internal clipboard");
	}
};

const cutCell = async () => {
	if (!focusedCell.value || !gridApi.value) return;

	await copyCell();

	// Clear the cell value
	const rowNode = gridApi.value.getDisplayedRowAtIndex(
		focusedCell.value.rowIndex
	);
	if (rowNode?.data) {
		const colKey = focusedCell.value.colKey;
		const colDef = columnDefs.value.find((c: ColDef) => c.field === colKey);
		if (colDef?.editable !== false) {
			rowNode.setDataValue(colKey, "");
		}
	}
};

const pasteCell = async () => {
	if (!focusedCell.value || !gridApi.value) return;

	let valueToUse = clipboardValue.value;

	// Try to read from system clipboard
	try {
		valueToUse = await navigator.clipboard.readText();
	} catch (e) {
		console.warn("Clipboard read failed, using internal clipboard");
	}

	const rowNode = gridApi.value.getDisplayedRowAtIndex(
		focusedCell.value.rowIndex
	);
	if (rowNode?.data) {
		const colKey = focusedCell.value.colKey;
		const colDef = columnDefs.value.find((c: ColDef) => c.field === colKey);
		if (colDef?.editable !== false) {
			rowNode.setDataValue(colKey, valueToUse);
		}
	}
};

// Keyboard handler
const handleKeydown = (event: KeyboardEvent) => {
	// Only handle when not editing
	if (
		document.activeElement?.tagName === "INPUT" ||
		document.activeElement?.tagName === "TEXTAREA"
	) {
		return;
	}

	const isMac = navigator.platform.toUpperCase().indexOf("MAC") >= 0;
	const ctrlKey = isMac ? event.metaKey : event.ctrlKey;

	if (ctrlKey && event.key === "c") {
		event.preventDefault();
		copyCell();
	} else if (ctrlKey && event.key === "x") {
		event.preventDefault();
		cutCell();
	} else if (ctrlKey && event.key === "v") {
		event.preventDefault();
		pasteCell();
	}
};

// Setup keyboard listeners

onMounted(() => {
	document.addEventListener("keydown", handleKeydown);
});

onUnmounted(() => {
	document.removeEventListener("keydown", handleKeydown);
});

// Row operations
const addNewRow = () => {
	const newRow: any = {
		_tempId: `new_${Date.now()}_${Math.random().toString(36).slice(2)}`,
		_isNew: true,
	};

	// Initialize with empty values
	props.columns.forEach((col) => {
		if (col.type !== "readonly") {
			newRow[col.key] = "";
		}
	});

	rowData.value = [...rowData.value, newRow];
	modifiedRows.value.add(newRow._tempId);

	// Scroll to bottom and start editing
	setTimeout(() => {
		if (gridApi.value) {
			const lastRowIndex = rowData.value.length - 1;
			gridApi.value.ensureIndexVisible(lastRowIndex);
			const firstEditableCol = props.columns.find((c) => c.type !== "readonly");
			if (firstEditableCol) {
				gridApi.value.startEditingCell({
					rowIndex: lastRowIndex,
					colKey: firstEditableCol.key,
				});
			}
		}
	}, 100);
};

const deleteRow = (rowToDelete: any) => {
	if (rowToDelete._isNew) {
		// Just remove from data
		rowData.value = rowData.value.filter(
			(r) => r._tempId !== rowToDelete._tempId
		);
		modifiedRows.value.delete(rowToDelete._tempId);
	} else {
		// Track for deletion and remove from view
		deletedRowIds.value.add(rowToDelete.id);
		rowData.value = rowData.value.filter((r) => r.id !== rowToDelete.id);
	}

	toast({
		title: "Row marked for deletion",
		description: "Click 'Save All' to confirm deletion.",
	});
};

// Save and discard
const discardChanges = () => {
	initializeData();
	toast({
		title: "Changes discarded",
		description: "All unsaved changes have been reverted.",
	});
};

const handleExit = () => {
	if (hasChanges.value) {
		if (!confirm("You have unsaved changes. Are you sure you want to exit?")) {
			return;
		}
	}
	emit("exit");
};

const saveAllChanges = async () => {
	saving.value = true;

	try {
		// Get modified rows
		const itemsToSave = rowData.value
			.filter((row) => {
				const rowId = row._tempId || row.id;
				return modifiedRows.value.has(rowId);
			})
			.map((row) => {
				const { _tempId, _isNew, _actions, ...rest } = row;
				return rest;
			});

		// Get deleted IDs
		const deletedIds = Array.from(deletedRowIds.value);

		await emit("save", { items: itemsToSave, deletedIds });

		const totalChanges = itemsToSave.length + deletedIds.length;
		toast({
			title: "Changes saved",
			description: `Successfully processed ${totalChanges} change(s).`,
		});

		// Reset state
		modifiedRows.value.clear();
		deletedRowIds.value.clear();
		rowData.value.forEach((row) => {
			delete row._isNew;
		});
		originalData.value = JSON.parse(JSON.stringify(rowData.value));
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

<style>
/* Override AG Grid theme to match app design */
.ag-theme-alpine {
	--ag-background-color: transparent;
	--ag-header-background-color: hsl(var(--muted));
	--ag-odd-row-background-color: transparent;
	--ag-row-hover-color: hsl(var(--muted) / 0.5);
	--ag-selected-row-background-color: hsl(var(--primary) / 0.1);
	--ag-range-selection-border-color: hsl(var(--primary));
	--ag-font-family: inherit;
	--ag-font-size: 12px;
	--ag-grid-size: 4px;
	--ag-row-height: 36px;
	--ag-header-height: 40px;
}

.ag-theme-alpine .ag-header-cell-label {
	font-weight: 500;
	color: hsl(var(--muted-foreground));
}

.ag-theme-alpine .ag-cell {
	display: flex;
	align-items: center;
}

.ag-theme-alpine .ag-cell-edit-wrapper {
	height: 100%;
}

.ag-theme-alpine input[class^="ag-"]:focus {
	outline: none;
	border-color: hsl(var(--primary));
}
</style>
