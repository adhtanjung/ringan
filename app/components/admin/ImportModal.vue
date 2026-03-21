	<template>
		<Sheet :open="isOpen" @update:open="handleOpenChange">
		<SheetContent
			side="right"
			class="w-full max-w-full sm:max-w-lg md:max-w-2xl lg:max-w-3xl xl:max-w-4xl h-full overflow-y-auto p-0"
		>
			<div class="flex h-full flex-col">
				<SheetHeader class="border-b bg-background px-6 py-5">
					<SheetTitle class="text-lg sm:text-xl" id="tour-import-modal-title">
						Import Data
					</SheetTitle>
					<SheetDescription class="text-sm leading-6 text-muted-foreground">
						Upload a CSV, JSON, or Excel file to add or update records in the
						selected dataset.
					</SheetDescription>
				</SheetHeader>

				<div class="flex-1 overflow-y-auto bg-muted/10 px-6 py-6">
					<div class="space-y-4">
						<div
							id="tour-import-file"
							class="space-y-3 rounded-2xl border border-border/70 bg-background px-4 py-4 sm:px-5"
						>
							<label class="block text-sm font-semibold text-foreground">
								Select File
							</label>
							<div
								class="flex justify-center rounded-xl border-2 border-dashed border-border/70 px-4 pb-5 pt-5 transition-colors hover:border-foreground/30"
								:class="{
									'border-primary/40 bg-primary/5': isDragOver,
									'border-emerald-400 bg-emerald-50': selectedFile,
								}"
								@drop="handleDrop"
								@dragover="handleDragOver"
								@dragleave="handleDragLeave"
							>
								<div class="max-w-md space-y-4 text-center">
									<div v-if="!selectedFile" class="space-y-4">
										<svg
											class="mx-auto h-12 w-12 sm:h-14 sm:w-14 text-muted-foreground"
											fill="none"
											stroke="currentColor"
											viewBox="0 0 24 24"
											aria-hidden="true"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												stroke-width="1.5"
												d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
											/>
										</svg>

										<div class="space-y-2">
											<label
												for="file-upload"
												class="inline-flex h-11 cursor-pointer items-center gap-2 rounded-md bg-primary px-4 text-sm font-medium text-primary-foreground shadow-sm transition-colors hover:bg-primary/90 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
											>
												<svg
													class="h-4 w-4"
													fill="none"
													stroke="currentColor"
													viewBox="0 0 24 24"
												>
													<path
														stroke-linecap="round"
														stroke-linejoin="round"
														stroke-width="2"
														d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
													/>
												</svg>
												Choose File
												<input
													id="file-upload"
													name="file-upload"
													type="file"
													class="sr-only"
													:accept="acceptedFileTypes"
													@change="handleFileSelect"
												/>
											</label>

											<p class="text-sm text-muted-foreground">
												or drag and drop here
											</p>
											<p class="text-xs text-muted-foreground/80">
												{{ acceptedFileTypesText }}
											</p>
										</div>

										<p class="text-xs leading-5 text-muted-foreground">
											Upload actual data rows, not blank template files.
										</p>
									</div>

									<div v-else class="space-y-2">
										<svg
											class="mx-auto h-10 w-10 sm:h-12 sm:w-12 text-emerald-600"
											fill="none"
											stroke="currentColor"
											viewBox="0 0 24 24"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												stroke-width="2"
												d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
											/>
										</svg>
										<div
											class="break-all px-2 text-center text-sm font-medium text-foreground"
										>
											{{ selectedFile.name }}
										</div>
										<div class="text-center text-xs text-muted-foreground">
											{{ formatFileSize(selectedFile.size) }}
										</div>
										<button
											@click="removeFile"
											class="text-sm font-medium text-destructive hover:text-destructive/80"
										>
											Remove file
										</button>
									</div>
								</div>
							</div>
						</div>

						<div class="space-y-4">
								<div v-if="!dataType">
									<label
										class="mb-2 block text-sm font-semibold text-foreground"
										for="import-data-type"
									>
										Data Type
									</label>
									<div id="tour-import-type">
										<Select v-model="selectedDataType">
											<SelectTrigger id="import-data-type" class="h-11">
												<SelectValue placeholder="Select a data type" />
											</SelectTrigger>
										<SelectContent>
											<SelectItem
												v-for="dataType in dataTypes"
												:key="dataType.value"
												:value="dataType.value"
											>
												{{ dataType.label }}
											</SelectItem>
										</SelectContent>
									</Select>
								</div>
								</div>

								<div v-else>
									<label class="mb-2 block text-sm font-semibold text-foreground">
										Data Type
									</label>
									<div
										id="import-data-type"
										class="rounded-xl border border-border/70 bg-background px-3 py-2.5"
									>
										<span class="text-sm text-foreground">{{
											dataTypes[0]?.label
										}}</span>
								</div>
							</div>

							<div class="space-y-3" id="tour-import-templates">
								<div
									class="flex flex-col gap-3 rounded-2xl border border-border/70 bg-background p-4 sm:flex-row sm:items-center sm:justify-between"
								>
									<div class="space-y-1">
										<h4 class="text-sm font-semibold text-foreground">
											Download Template
										</h4>
										<p class="text-xs leading-5 text-muted-foreground">
											{{
												selectedDataType
													? "Get a template file to fill out with your data"
													: "Select a data type first"
											}}
										</p>
									</div>
									<div class="flex flex-wrap gap-2">
											<Button
												@click="downloadTemplate('csv')"
												variant="outline"
												:disabled="!selectedDataType"
												class="flex-1 min-w-0 sm:flex-none"
											>
											CSV
										</Button>
											<Button
												@click="downloadTemplate('xlsx')"
												variant="outline"
												:disabled="!selectedDataType"
												class="flex-1 min-w-0 sm:flex-none"
											>
											Excel
										</Button>
											<Button
												@click="downloadTemplate('json')"
												variant="outline"
												:disabled="!selectedDataType"
												class="flex-1 min-w-0 sm:flex-none"
											>
											JSON
										</Button>
									</div>
								</div>

								<div
									class="flex flex-col gap-3 rounded-2xl border border-border/70 bg-background p-4 sm:flex-row sm:items-center sm:justify-between"
								>
									<div class="flex-1 space-y-1">
										<h4 class="text-sm font-semibold text-foreground">
											Download Example
										</h4>
										<p class="text-xs leading-5 text-muted-foreground">
											{{
												selectedDataType
													? "Get sample data to see the correct format"
													: "Select a data type first"
											}}
										</p>
									</div>
										<Button
											@click="downloadExample"
											variant="outline"
											class="w-full sm:w-auto"
											:disabled="!selectedDataType"
										>
										Example
									</Button>
								</div>
							</div>
						</div>

							<div
								v-if="isUploading"
								class="space-y-2 rounded-2xl border border-border/70 bg-background px-4 py-4"
								role="status"
								aria-live="polite"
							>
							<div class="flex items-center justify-between">
								<span class="text-sm font-medium text-foreground">
									Uploading...
								</span>
								<span class="text-sm text-muted-foreground">{{
									uploadProgress
								}}%</span>
							</div>
							<div class="h-2 w-full rounded-full bg-muted">
								<div
									class="h-2 rounded-full bg-primary transition-all duration-300"
									:style="{ width: uploadProgress + '%' }"
								></div>
							</div>
						</div>

							<div
								v-if="errorMessage || allErrors.length > 0"
								class="space-y-3 rounded-2xl border border-destructive/20 bg-destructive/5 px-4 py-4"
								role="alert"
								aria-live="assertive"
							>
							<div class="flex items-start gap-3">
								<div class="flex-shrink-0 rounded-full bg-background p-1.5">
									<svg
										class="h-4 w-4 text-destructive"
										fill="none"
										stroke="currentColor"
										viewBox="0 0 24 24"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											stroke-width="2"
											d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"
										/>
									</svg>
								</div>
								<div class="flex-1 space-y-1">
									<h3 class="text-sm font-semibold text-foreground">
										Import Error
									</h3>
									<p class="text-sm leading-6 text-muted-foreground">
										{{ errorMessage || "One or more rows could not be imported." }}
									</p>
								</div>
							</div>

							<div v-if="allErrors.length > 0" class="space-y-2">
								<div
									v-for="(error, index) in showAllErrors ? allErrors : allErrors.slice(0, 5)"
									:key="index"
									class="flex items-start gap-2 rounded-lg border border-border/70 bg-background px-3 py-2"
								>
									<span class="flex-shrink-0 font-mono text-xs text-muted-foreground">
										{{ index + 1 }}.
									</span>
									<span class="min-w-0 flex-1 break-words text-sm text-foreground">
										{{ error }}
									</span>
								</div>
								<div v-if="allErrors.length > 5">
									<button
										@click="showAllErrors = !showAllErrors"
										class="rounded-md px-2 py-1 text-sm font-medium text-foreground underline decoration-foreground/30 underline-offset-4 transition-colors hover:text-foreground/80 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
									>
										{{
											showAllErrors
												? `Show less (showing all ${allErrors.length} errors)`
												: `Show all ${allErrors.length} errors`
										}}
									</button>
								</div>
							</div>

							<div
								v-if="
									(errorMessage && errorMessage.includes('validation errors')) ||
									allErrors.length > 0
								"
								class="space-y-2 rounded-xl border border-border/70 bg-background px-3 py-3"
							>
								<h4 class="text-xs font-semibold uppercase tracking-wide text-muted-foreground">
									Quick Fix Tips
								</h4>
								<ul class="space-y-1 text-xs leading-5 text-muted-foreground">
									<li>Upload actual data rows, not the blank template file.</li>
									<li>Make sure the first row contains the column headers.</li>
									<li>Confirm required columns are present and filled in.</li>
								</ul>
							</div>
						</div>

							<div
								v-if="successMessage"
								class="rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-4"
								role="status"
								aria-live="polite"
							>
							<div class="flex items-start gap-3">
								<div class="flex-shrink-0 rounded-full bg-background p-1.5">
									<svg
										class="h-4 w-4 text-emerald-600"
										fill="none"
										stroke="currentColor"
										viewBox="0 0 24 24"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											stroke-width="2"
											d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
										/>
									</svg>
								</div>
								<div class="space-y-1">
									<h3 class="text-sm font-semibold text-foreground">
										Import Successful
									</h3>
									<p class="text-sm leading-6 text-muted-foreground">
										{{ successMessage }}
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>

				<SheetFooter class="border-t bg-background px-6 py-4">
					<div class="flex w-full flex-col-reverse gap-3 sm:flex-row sm:justify-end">
							<Button
								variant="outline"
								class="w-full sm:w-auto"
								@click="closeModal"
								:disabled="isUploading"
							>
							Cancel
						</Button>
						<Button
							class="w-full sm:w-auto"
							@click="startImport"
							:disabled="!canImport || isUploading"
							id="tour-import-btn"
						>
							<svg
								v-if="isUploading"
								class="-ml-1 mr-2 h-4 w-4 animate-spin"
								fill="none"
								viewBox="0 0 24 24"
							>
								<circle
									class="opacity-25"
									cx="12"
									cy="12"
									r="10"
									stroke="currentColor"
									stroke-width="4"
								></circle>
								<path
									class="opacity-75"
									fill="currentColor"
									d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
								></path>
							</svg>
							{{ isUploading ? "Importing..." : "Import Data" }}
						</Button>
					</div>
				</SheetFooter>
			</div>
			<ImportPreviewModal
				:is-open="showPreviewModal"
				:data="previewData"
				:data-type="selectedDataType"
				@cancel="showPreviewModal = false"
				@confirm="handleConfirmImport"
			/>
		</SheetContent>
	</Sheet>
</template>

<script setup>
import { ref, computed, watch, onBeforeUnmount } from "vue";
import { Button } from "@/components/ui/button";
import {
	Sheet,
	SheetContent,
	SheetDescription,
	SheetFooter,
	SheetHeader,
	SheetTitle,
} from "@/components/ui/sheet";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { useSupabase } from "@/composables/useSupabase";
import { parseCSV } from "@/utils/csvParser";
import { generateCategoryId } from "@/utils/categoryIdGenerator";
import { generateSubCategoryId } from "@/utils/subCategoryIdGenerator";
import {
	createActionIdAllocator,
	createSuggestionIdAllocator,
	isValidActionId,
	isValidSuggestionId,
} from "@/utils/commonIdGenerator";
import * as XLSX from "xlsx";
import ImportPreviewModal from "./ImportPreviewModal.vue";

// Props
const props = defineProps({
	isOpen: {
		type: Boolean,
		default: false,
	},
	dataType: {
		type: String,
		default: null,
	},
});

// Emits
const emit = defineEmits(["close", "import-success"]);

// Reactive data
const selectedFile = ref(null);
const selectedDataType = ref(props.dataType || "");
const isDragOver = ref(false);
const isUploading = ref(false);
const uploadProgress = ref(0);
const errorMessage = ref("");
const successMessage = ref("");
const allErrors = ref([]);
const showAllErrors = ref(false);
const showPreviewModal = ref(false);
const previewData = ref([]);
const overwriteExisting = ref(true); // Always overwrite when importing
const validateData = ref(true);

// List of data types migrated to Supabase
const USE_SUPABASE_FOR = [
	"problem_types",
	"problems",
	"assessments",
	"suggestions",
	"feedback_prompts",
	"next_actions",
	"training_examples",
];

const SUPABASE_TABLE_COLUMNS = {
	problem_types: ["type_name", "category_id", "description", "is_active"],
	problems: [
		"problem_name",
		"category",
		"category_id",
		"sub_category_id",
		"description",
		"severity_level",
		"is_active",
	],
	assessments: [
		"question_id",
		"sub_category_id",
		"question_text",
		"response_type",
		"scale_min",
		"scale_max",
		"scale_labels",
		"next_step",
		"clusters",
		"batch_id",
		"scale_label_1",
		"scale_label_2",
		"scale_label_3",
		"scale_label_4",
		"order_number",
		"is_active",
	],
	suggestions: [
		"suggestion_id",
		"sub_category_id",
		"cluster",
		"suggestion_text",
		"resource_link",
		"evidence_base",
		"difficulty_level",
		"estimated_duration",
		"tags",
		"is_active",
	],
	feedback_prompts: ["prompt_id", "prompt_text", "is_active"],
	next_actions: ["action_id", "action_text", "is_active"],
	training_examples: [
		"example_id",
		"problem",
		"conversation_id",
		"user_intent",
		"prompt",
		"completion",
		"context",
		"quality_score",
		"tags",
		"is_active",
	],
};

const IMPORT_FIELD_ALIASES = {
	problems: {
		subcategory_name: "problem_name",
		sub_category_name: "problem_name",
	},
	next_actions: {
		action_name: "action_text",
		description: "action_text",
	},
	feedback_prompts: {
		prompt: "prompt_text",
		question: "prompt_text",
	},
};

// Supabase client
const { supabase } = useSupabase();

// Data types configuration
const allDataTypes = [
	{ value: "problems", label: "Subcategories" },
	{ value: "assessments", label: "Assessment Questions" },
	{ value: "suggestions", label: "Therapeutic Suggestions" },
	{ value: "feedback_prompts", label: "Feedback Prompts" },
	{ value: "next_actions", label: "Next Actions" },
	{ value: "training_examples", label: "Fine-tuning Examples" },
	{ value: "problem_types", label: "Categories" },
	{ value: "domain_types", label: "Domain Types" },
];

// Computed properties
const dataTypes = computed(() => {
	if (props.dataType) {
		// Filter to only show the specified data type
		return allDataTypes.filter((dt) => dt.value === props.dataType);
	}
	return allDataTypes;
});
const acceptedFileTypes = computed(() => {
	return ".csv,.json,.xlsx";
});

const acceptedFileTypesText = computed(() => {
	return "CSV, JSON, Excel files up to 10MB";
});

const canImport = computed(() => {
	return selectedFile.value && selectedDataType.value;
});

let legacyProgressInterval = null;

const clearLegacyProgressInterval = () => {
	if (legacyProgressInterval) {
		clearInterval(legacyProgressInterval);
		legacyProgressInterval = null;
	}
};

const handleOpenChange = (open) => {
	if (!open) {
		closeModal();
	}
};

const readFileAsText = (file) =>
	new Promise((resolve, reject) => {
		const reader = new FileReader();
		reader.onload = (event) => resolve(String(event?.target?.result || ""));
		reader.onerror = () => reject(new Error("Failed to read the selected file."));
		reader.readAsText(file);
	});

const readFileAsArrayBuffer = (file) =>
	new Promise((resolve, reject) => {
		const reader = new FileReader();
		reader.onload = (event) => resolve(event?.target?.result);
		reader.onerror = () => reject(new Error("Failed to read the selected file."));
		reader.readAsArrayBuffer(file);
	});

const parseBoolean = (value, fallback = true) => {
	if (typeof value === "boolean") return value;
	if (typeof value === "number") return value !== 0;
	if (typeof value === "string") {
		const normalized = value.trim().toLowerCase();
		if (["true", "1", "yes", "y"].includes(normalized)) return true;
		if (["false", "0", "no", "n"].includes(normalized)) return false;
	}
	return fallback;
};

const parseTextArray = (value) => {
	if (Array.isArray(value)) {
		return value.map((item) => String(item).trim()).filter(Boolean);
	}
	if (typeof value !== "string") return [];

	const trimmed = value.trim();
	if (!trimmed) return [];

	if (trimmed.startsWith("[") && trimmed.endsWith("]")) {
		try {
			const parsed = JSON.parse(trimmed);
			if (Array.isArray(parsed)) {
				return parsed.map((item) => String(item).trim()).filter(Boolean);
			}
		} catch {
			// Fallback to comma parsing below.
		}
	}

	return trimmed
		.split(",")
		.map((item) => item.trim())
		.filter(Boolean);
};

const normalizeImportedItem = (rawItem, dataType) => {
	const item = rawItem && typeof rawItem === "object" ? rawItem : {};
	const aliases = IMPORT_FIELD_ALIASES[dataType] || {};
	const normalized = {};

	for (const [key, value] of Object.entries(item)) {
		const canonicalKey = aliases[key] || aliases[String(key).toLowerCase()] || key;
		normalized[canonicalKey] = value;
	}

	if (!SUPABASE_TABLE_COLUMNS[dataType]) {
		return normalized;
	}

	const cleaned = {};
	for (const key of SUPABASE_TABLE_COLUMNS[dataType]) {
		if (normalized[key] !== undefined) {
			cleaned[key] = normalized[key];
		}
	}

	if (Object.prototype.hasOwnProperty.call(cleaned, "is_active")) {
		cleaned.is_active = parseBoolean(cleaned.is_active, true);
	}

	if (dataType === "suggestions" || dataType === "training_examples") {
		if (cleaned.tags !== undefined) {
			cleaned.tags = parseTextArray(cleaned.tags);
		}
	}

	if (dataType === "next_actions" && typeof cleaned.action_text === "string") {
		cleaned.action_text = cleaned.action_text.trim();
	}

	if (dataType === "feedback_prompts" && typeof cleaned.prompt_text === "string") {
		cleaned.prompt_text = cleaned.prompt_text.trim();
	}

	if (dataType === "problems" && normalized.sub_category_name && !cleaned.problem_name) {
		cleaned.problem_name = normalized.sub_category_name;
	}

	return cleaned;
};

// Methods
const closeModal = () => {
	if (!isUploading.value) {
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	clearLegacyProgressInterval();
	selectedFile.value = null;
	selectedDataType.value = props.dataType || "";
	isDragOver.value = false;
	isUploading.value = false;
	uploadProgress.value = 0;
	errorMessage.value = "";
	successMessage.value = "";
	allErrors.value = [];
	showAllErrors.value = false;
};

onBeforeUnmount(() => {
	clearLegacyProgressInterval();
});

const handleFileSelect = async (event) => {
	const file = event.target.files[0];
	if (file) {
		await validateAndSetFile(file);
	}
};

const handleDrop = async (event) => {
	event.preventDefault();
	isDragOver.value = false;

	const files = event.dataTransfer.files;
	if (files.length > 0) {
		await validateAndSetFile(files[0]);
	}
};

const handleDragOver = (event) => {
	event.preventDefault();
	isDragOver.value = true;
};

const handleDragLeave = (event) => {
	event.preventDefault();
	isDragOver.value = false;
};

const validateAndSetFile = async (file) => {
	// Reset messages
	errorMessage.value = "";
	successMessage.value = "";
	allErrors.value = [];
	showAllErrors.value = false;

	// Check file type
	const allowedTypes = [
		"text/csv",
		"application/json",
		"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
		"application/vnd.ms-excel",
	];
	const allowedExtensions = [".csv", ".json", ".xlsx", ".xls"];

	const isValidType =
		allowedTypes.includes(file.type) ||
		allowedExtensions.some((ext) => file.name.toLowerCase().endsWith(ext));

	if (!isValidType) {
		errorMessage.value = "Please select a valid CSV, JSON, or Excel file.";
		return;
	}

	// Check file size (10MB limit)
	const maxSize = 10 * 1024 * 1024; // 10MB
	if (file.size > maxSize) {
		errorMessage.value = "File size must be less than 10MB.";
		return;
	}

	// Template file validation removed - accepting all valid files

	selectedFile.value = file;
};

const removeFile = () => {
	selectedFile.value = null;
	errorMessage.value = "";
	successMessage.value = "";
	allErrors.value = [];
	showAllErrors.value = false;
};

const formatFileSize = (bytes) => {
	if (bytes === 0) return "0 Bytes";

	const k = 1024;
	const sizes = ["Bytes", "KB", "MB", "GB"];
	const i = Math.floor(Math.log(bytes) / Math.log(k));

	return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
};

const startImport = async () => {
	if (!canImport.value) return;

	isUploading.value = true;
	uploadProgress.value = 0;
	errorMessage.value = "";
	successMessage.value = "";
	allErrors.value = [];
	showAllErrors.value = false;

	try {
		if (USE_SUPABASE_FOR.includes(selectedDataType.value)) {
			// Import into Supabase
			const file = selectedFile.value;
			const lowerName = String(file.name || "").toLowerCase();
			let items = [];

			// Parse file based on type
			if (lowerName.endsWith(".json")) {
				try {
					const fileData = await readFileAsText(file);
					items = JSON.parse(fileData);
					if (!Array.isArray(items)) items = [items];
				} catch {
					throw new Error("Invalid JSON format.");
				}
			} else if (lowerName.endsWith(".csv")) {
				try {
					const fileData = await readFileAsText(file);
					const parsed = parseCSV(fileData);
					items = parsed.data;
				} catch (e) {
					throw new Error("Invalid CSV format: " + (e.message || e));
				}
			} else if (lowerName.endsWith(".xlsx") || lowerName.endsWith(".xls")) {
				try {
					const data = await readFileAsArrayBuffer(file);
					const workbook = XLSX.read(new Uint8Array(data), { type: "array" });
					const firstSheetName = workbook.SheetNames[0];
					const worksheet = workbook.Sheets[firstSheetName];
					items = XLSX.utils.sheet_to_json(worksheet);
				} catch (e) {
					throw new Error("Invalid Excel format: " + (e.message || e));
				}
			} else {
				throw new Error(
					"Unsupported file format. Please use CSV, JSON, or Excel files.",
				);
			}

			if (items.length === 0) {
				throw new Error(
					"No data found in file. Make sure the file contains data rows, not just headers.",
				);
			}

			items = items.map((item) => normalizeImportedItem(item, selectedDataType.value));
			const hasValidPayload = items.some((item) => Object.keys(item).length > 0);
			if (!hasValidPayload) {
				throw new Error(
					"The file does not contain recognized columns for this data type. Download the latest template and try again.",
				);
			}

			// Instead of importing directly, show preview modal
			previewData.value = items;
			showPreviewModal.value = true;
			isUploading.value = false;
			return;
		}

		// Existing API Import logic
		// Create FormData
		const formData = new FormData();
		formData.append("file", selectedFile.value);
		formData.append("overwrite", overwriteExisting.value);
		formData.append("validate", validateData.value);

		// Simulate upload progress
		clearLegacyProgressInterval();
		legacyProgressInterval = setInterval(() => {
			if (uploadProgress.value < 90) {
				uploadProgress.value += Math.random() * 10;
			}
		}, 200);

		// Make API call
		const config = useRuntimeConfig();
		const adminApiUrl =
			config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";

		const response = await $fetch(
			`${adminApiUrl}/import-export/import/${selectedDataType.value}`,
			{
				method: "POST",
				body: formData,
			},
		);

		clearLegacyProgressInterval();
		uploadProgress.value = 100;

		if (response.success) {
			// Complete success
			successMessage.value = `Successfully imported ${response.imported_count} records.`;
			errorMessage.value = ""; // Clear any previous errors
			emit("import-success", response);

			// Auto-close after success
			setTimeout(() => {
				closeModal();
			}, 2000);
		} else if (response.imported_count > 0) {
			// Partial success - some records imported, some failed
			successMessage.value = `Import completed with issues: ${response.imported_count} records imported, ${response.failed_count} failed.`;
			if (response.errors && response.errors.length > 0) {
				// Store all errors for expandable display
				allErrors.value = response.errors;
				showAllErrors.value = false;
				errorMessage.value = `Some records failed to import (${
					response.errors.length
				} error${response.errors.length > 1 ? "s" : ""}):`;
			}
			emit("import-success", response);
		} else {
			// Complete failure - show detailed errors only (no success message)
			successMessage.value = ""; // Clear any success message
			if (response.errors && response.errors.length > 0) {
				// Store all errors for expandable display
				allErrors.value = response.errors;
				showAllErrors.value = false;
				errorMessage.value = `Import failed with ${
					response.errors.length
				} error${response.errors.length > 1 ? "s" : ""}:`;
			} else {
				errorMessage.value =
					response.message ||
					"Import failed. Please check your file and try again.";
				allErrors.value = [];
			}
		}
	} catch (error) {
		console.error("Import error:", error);

		// Handle different types of errors
		if (error.data && error.data.errors) {
			// Backend validation errors
			allErrors.value = error.data.errors;
			showAllErrors.value = false;
			errorMessage.value = `Import failed with ${
				error.data.errors.length
			} validation error${error.data.errors.length > 1 ? "s" : ""}:`;
		} else if (error.message) {
			errorMessage.value = error.message;
			allErrors.value = [];
		} else {
			errorMessage.value = "An error occurred during import. Please try again.";
			allErrors.value = [];
		}
	} finally {
		clearLegacyProgressInterval();
		isUploading.value = false;
	}
};

const handleConfirmImport = async (validItems) => {
	showPreviewModal.value = false;
	isUploading.value = true;
	uploadProgress.value = 0;

	try {
		let items = [...validItems];

		// Deduplicate only for problems where category + subcategory name is the unique intent.
		// Applying this globally can collapse valid rows for other datasets (e.g. suggestions).
		if (selectedDataType.value === "problems") {
			const seenItems = new Set();
			items = validItems.filter((item) => {
				const name = item.problem_name || item.sub_category_name;
				const compositeKey = `${selectedDataType.value}|${
					item.category_id || ""
				}|${name || ""}`;
				if (seenItems.has(compositeKey)) return false;
				seenItems.add(compositeKey);
				return true;
			});
		}

		uploadProgress.value = 30;

		// Auto-generate category_ids for problem_types if missing
		if (selectedDataType.value === "problem_types") {
			for (const item of items) {
				const hasValidCategoryId =
					item.category_id && /^[A-Z]{1,4}_\d{3}$/.test(item.category_id);

				if (!hasValidCategoryId && item.type_name) {
					try {
						item.category_id = await generateCategoryId(
							supabase,
							item.type_name,
						);
					} catch (error) {
						console.error(
							"Failed to auto-generate category_id for",
							item.type_name,
							error,
						);
						throw new Error(
							`Failed to auto-generate category_id for "${item.type_name}": ${error.message}`,
						);
					}
				}
			}
		}

		uploadProgress.value = 70;

		// Batch insert
		const cleanedItems = items.map((item) => {
			const normalizedItem = normalizeImportedItem(item, selectedDataType.value);
			const { id, _id, created_at, updated_at, category_display, ...rest } =
				normalizedItem;

			// Ensure required fields for problems are never null/undefined
			if (selectedDataType.value === "problems") {
				if (!rest.category) rest.category = rest.category_id || "Uncategorized";
				if (!rest.problem_name) rest.problem_name = "Untitled Subcategory";
			}

			// Keep imported inactive rows if explicitly provided; default to active otherwise.
			const dataToInsert = {
				...rest,
				is_active: parseBoolean(rest.is_active, true),
				updated_at: new Date().toISOString(),
			};

			return dataToInsert;
		});

		// Specialized logic for problems: match by category_id + problem_name (case-insensitive)
		if (selectedDataType.value === "problems") {
			const { data: existing } = await supabase
				.from("problems")
				.select("problem_name, sub_category_id, category_id");

			const existingMap = new Map();
			if (existing) {
				for (const e of existing) {
					const normName = e.problem_name?.trim()?.toLowerCase() || "";
					existingMap.set(`${e.category_id}|${normName}`, e.sub_category_id);
				}
			}

			const { data: catTypes } = await supabase
				.from("problem_types")
				.select("category_id, type_name");
			const catMap = new Map(
				catTypes?.map((c) => [c.category_id, c.type_name]) || [],
			);

			for (const item of cleanedItems) {
				const name = item.problem_name || item.sub_category_name;
				const normName = name?.trim()?.toLowerCase() || "";

				// Alias mapping
				if (item.sub_category_name && !item.problem_name) {
					item.problem_name = item.sub_category_name;
				}

				// Category backfill
				if (item.category_id && !item.category) {
					item.category =
						catMap.get(item.category_id) || item.category_id || "Uncategorized";
				}

				const key = `${item.category_id}|${normName}`;
				const existingId = existingMap.get(key);

				if (existingId) {
					item.sub_category_id = existingId;
				} else {
					const hasValidId =
						item.sub_category_id &&
						/^[A-Z]{1,4}_\d{3}$/.test(item.sub_category_id);
					if (!hasValidId && item.problem_name) {
						item.sub_category_id = await generateSubCategoryId(
							supabase,
							item.problem_name,
						);
						existingMap.set(key, item.sub_category_id);
					}
				}
			}
		}

		// Specialized logic for assessments: match by question_text + sub_category_id + batch_id
		if (selectedDataType.value === "assessments") {
			// Get all existing assessments to match against
			const { data: existingAssessments } = await supabase
				.from("assessments")
				.select("question_id, question_text, sub_category_id, batch_id");

			// Build a lookup map for existing assessments
			const existingMap = new Map();
			let maxSequence = 0;

			if (existingAssessments && existingAssessments.length > 0) {
				for (const assessment of existingAssessments) {
					const normText =
						assessment.question_text?.trim()?.toLowerCase() || "";
					const key = `${normText}|${assessment.sub_category_id || ""}|${
						assessment.batch_id || ""
					}`;
					existingMap.set(key, assessment.question_id);

					const match = assessment.question_id?.match(/^Q(\d+)$/);
					if (match) {
						const seq = parseInt(match[1], 10);
						if (seq > maxSequence) maxSequence = seq;
					}
				}
			}

			for (const item of cleanedItems) {
				const normText = item.question_text?.trim()?.toLowerCase() || "";
				const key = `${normText}|${item.sub_category_id || ""}|${
					item.batch_id || ""
				}`;
				const existingId = existingMap.get(key);

				if (existingId) {
					item.question_id = existingId;
				} else if (!item.question_id) {
					maxSequence++;
					item.question_id = `Q${String(maxSequence).padStart(8, "0")}`;
					existingMap.set(key, item.question_id);
				}
			}
		}

		// Specialized logic for suggestions:
		// - enforce sub_category_id relation
		// - preserve existing IDs for same (sub_category_id + suggestion_text)
		// - auto-generate canonical suggestion_id when missing/invalid
		if (selectedDataType.value === "suggestions") {
			const [{ data: existingSuggestions }, { data: existingSubCategories }] =
				await Promise.all([
					supabase
						.from("suggestions")
						.select("suggestion_id, suggestion_text, sub_category_id"),
					supabase.from("problems").select("sub_category_id"),
				]);

			const validSubCategoryIdSet = new Set(
				(existingSubCategories || [])
					.map((row) => row.sub_category_id)
					.filter(Boolean),
			);

			const existingMap = new Map();
			for (const suggestion of existingSuggestions || []) {
				const key = `${
					suggestion.sub_category_id || ""
				}|${String(suggestion.suggestion_text || "").trim().toLowerCase()}`;
				if (suggestion.suggestion_id && key !== "|") {
					existingMap.set(key, suggestion.suggestion_id);
				}
			}

			const nextSuggestionId = await createSuggestionIdAllocator(supabase);

			for (const item of cleanedItems) {
				if (!item.sub_category_id || !validSubCategoryIdSet.has(item.sub_category_id)) {
					throw new Error(
						`Invalid sub_category_id "${item.sub_category_id || ""}" for suggestion import`,
					);
				}
				if (!item.suggestion_text) {
					throw new Error("Suggestion text is required for suggestion import");
				}

				const key = `${item.sub_category_id}|${String(item.suggestion_text)
					.trim()
					.toLowerCase()}`;
				const existingId = existingMap.get(key);

				if (existingId) {
					item.suggestion_id = existingId;
					continue;
				}

				if (!item.suggestion_id || !isValidSuggestionId(item.suggestion_id)) {
					item.suggestion_id = nextSuggestionId();
				}

				existingMap.set(key, item.suggestion_id);
			}
		}

		// Specialized logic for next actions:
		// - preserve existing IDs for same action_text
		// - auto-generate canonical action_id when missing/invalid
		if (selectedDataType.value === "next_actions") {
			const { data: existingActions } = await supabase
				.from("next_actions")
				.select("action_id, action_text");

			const existingMap = new Map();
			for (const action of existingActions || []) {
				const key = String(action.action_text || "")
					.trim()
					.toLowerCase();
				if (action.action_id && key) {
					existingMap.set(key, action.action_id);
				}
			}

			const nextActionId = await createActionIdAllocator(supabase);

			for (const item of cleanedItems) {
				if (!item.action_text) {
					throw new Error("Action text is required for next actions import");
				}

				const key = String(item.action_text).trim().toLowerCase();
				const existingId = existingMap.get(key);

				if (existingId) {
					item.action_id = existingId;
					continue;
				}

				if (!item.action_id || !isValidActionId(item.action_id)) {
					item.action_id = nextActionId();
				}

				existingMap.set(key, item.action_id);
			}
		}

		// Ensure feedback prompt rows map to the current schema.
		if (selectedDataType.value === "feedback_prompts") {
			for (const item of cleanedItems) {
				if (!item.prompt_text || !String(item.prompt_text).trim()) {
					throw new Error("Prompt text is required for feedback prompts import");
				}
			}
		}

		// Determine the conflict column based on data type
		const conflictColumns = {
			assessments: "question_id",
			problem_types: "category_id",
			problems: "sub_category_id",
			suggestions: "suggestion_id",
			feedback_prompts: "prompt_id",
			next_actions: "action_id",
			training_examples: "example_id",
		};

		const onConflictColumn = conflictColumns[selectedDataType.value];

		// Final deduplication: Ensure no two items have the same value for the conflict column
		// This prevents "ON CONFLICT DO UPDATE command cannot affect row a second time"
		let finalItemsToUpsert = cleanedItems;
		if (onConflictColumn) {
			const uniqueMap = new Map();
			for (const item of cleanedItems) {
				const key = item[onConflictColumn];
				if (key) {
					uniqueMap.set(key, item); // Last one wins
				} else {
					// Check if we should generate a random ID or if it's handled by DB
					// For purposes of this fix, we assume items without the constrained key are distinct inserts
					// But we should be careful. For now, if no key, we push to a separate list or handle gracefully.
					// In our case (problems, assessments), we generate keys, so this branch might be rare.
					// Let's just include them
				}
			}
			// If we have keyed items, use the deduped list. What about unkeyed?
			// Simpler approach: filter invalid items if they absolutely need the key, or just pass the map values.
			// Since we generated IDs for problems/assessments, they will be in the map.
			if (uniqueMap.size > 0) {
				const keyedItems = Array.from(uniqueMap.values());
				const unkeyedItems = cleanedItems.filter((i) => !i[onConflictColumn]);
				finalItemsToUpsert = [...keyedItems, ...unkeyedItems];
			}
		}

		// Use upsert to handle duplicates (update existing, insert new)
		const { data, error: supabaseError } = await supabase
			.from(selectedDataType.value)
			.upsert(finalItemsToUpsert, {
				onConflict: onConflictColumn,
				ignoreDuplicates: !overwriteExisting.value, // Only update if overwrite is checked
			});

		if (supabaseError) throw supabaseError;

		uploadProgress.value = 100;
		successMessage.value = `Successfully imported ${finalItemsToUpsert.length} records into Supabase.`;
		emit("import-success", {
			success: true,
			imported_count: finalItemsToUpsert.length,
		});

		setTimeout(() => {
			closeModal();
		}, 2000);
	} catch (error) {
		console.error("Supabase import error:", error);
		errorMessage.value = error.message || "An error occurred during import.";
	} finally {
		isUploading.value = false;
	}
};

// Download methods
const downloadTemplate = async (format) => {
	if (!selectedDataType.value) {
		errorMessage.value = "Please select a data type first";
		return;
	}

	try {
		// Check if this data type uses Supabase
		if (USE_SUPABASE_FOR.includes(selectedDataType.value)) {
			// Define template structures for Supabase data types
			const templates = {
				problem_types: [
					{
						type_name: "Anxiety Disorders",
						category_id: "ANX_001",
						description: "Conditions involving excessive fear or anxiety",
						is_active: true,
					},
				],
				problems: [
					{
						category_id: "ANX_001",
						sub_category_name: "Panic Attack",
						description: "Sudden episode of intense fear",
					},
					{
						category_id: "ANX_001",
						sub_category_name: "Social Phobia",
						description: "Fear of being judged by others",
					},
				],
					assessments: [
						{
							sub_category_id: "P005-7",
						question_text: "How often do you feel nervous or anxious?",
						response_type: "scale",
						scale_label_1: "Not at all",
						scale_label_2: "Several days",
						scale_label_3: "More than half the days",
							scale_label_4: "Nearly every day",
							next_step: "continue",
							clusters: "c1",
							batch_id: "B001",
							order_number: 1,
						},
					{
						sub_category_id: "P005-7",
						question_text: "Do you have trouble sleeping at night?",
						response_type: "text",
						scale_label_1: "",
						scale_label_2: "",
						scale_label_3: "",
						scale_label_4: "",
						next_step: "continue",
						clusters: "c1",
						batch_id: "B001",
						order_number: 2,
					},
				],
					suggestions: [
						{
							sub_category_id: "P005-7",
							cluster: "c1",
							suggestion_text: "Try deep breathing exercises for 5 minutes.",
							evidence_base: "CBT",
						},
					],
					feedback_prompts: [
						{
							prompt_id: "FP_001",
							prompt_text: "How are you feeling today?",
							is_active: true,
						},
					],
				next_actions: [
					{
						action_id: "A_0001",
						action_text: "Standard empathetic response",
						is_active: true,
					},
				],
				training_examples: [
					{
						example_id: "EX_001",
						problem: "Anxiety",
						conversation_id: "C_001",
						user_intent: "expression_of_worry",
						prompt: "I feel so stressed about work.",
						completion: "It sounds like you're carrying a lot right now.",
						context: "work_stress",
						quality_score: "5",
						tags: "stress, empathy",
						is_active: true,
					},
				],
			};

			const template = templates[selectedDataType.value];
			if (!template) {
				throw new Error("Template not found for this data type");
			}

			// Generate CSV
			if (format === "csv") {
				const headers = Object.keys(template[0]);
				const csvRows = [headers.join(",")];

					template.forEach((row) => {
						const values = headers.map((key) => {
							const v = row[key];
							if (typeof v === "boolean") return v ? "true" : "false";
							if (v === null || v === undefined) return "";
							// Escape delimiters, quotes, and line breaks.
							const s = String(v);
							if (s.includes(",") || s.includes('"') || s.includes("\n")) {
								return `"${s.replace(/"/g, '""')}"`;
							}
							return s;
						});
						csvRows.push(values.join(","));
					});

				const csvContent = csvRows.join("\n");

				const blob = new Blob([csvContent], {
					type: "text/csv;charset=utf-8;",
				});
				const url = window.URL.createObjectURL(blob);
				const link = document.createElement("a");
				link.setAttribute("href", url);
				link.setAttribute("download", `${selectedDataType.value}_template.csv`);
				link.style.visibility = "hidden";
				document.body.appendChild(link);
				link.click();
				document.body.removeChild(link);
				window.URL.revokeObjectURL(url);
			} else if (format === "json") {
				const jsonContent = JSON.stringify(template, null, 2);

				const blob = new Blob([jsonContent], { type: "application/json" });
				const url = window.URL.createObjectURL(blob);
				const link = document.createElement("a");
				link.setAttribute("href", url);
				link.setAttribute(
					"download",
					`${selectedDataType.value}_template.json`,
				);
				link.style.visibility = "hidden";
				document.body.appendChild(link);
				link.click();
				document.body.removeChild(link);
				window.URL.revokeObjectURL(url);
			} else if (format === "excel" || format === "xlsx") {
				// Generate Excel file
				const worksheet = XLSX.utils.json_to_sheet(template);
				const workbook = XLSX.utils.book_new();
				XLSX.utils.book_append_sheet(workbook, worksheet, "Template");

				// Generate Excel file and download
				XLSX.writeFile(workbook, `${selectedDataType.value}_template.xlsx`);
			}
		} else {
			// Use legacy API for non-migrated data types
			const config = useRuntimeConfig();
			const adminApiUrl =
				config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";

			const downloadUrl = `${adminApiUrl}/import-export/template/${selectedDataType.value}?format=${format}`;

			// Create download link
			const link = document.createElement("a");
			link.href = downloadUrl;
			link.download = `${selectedDataType.value}_template.${format}`;
			document.body.appendChild(link);
			link.click();
			document.body.removeChild(link);
		}
	} catch (error) {
		console.error("Template download failed:", error);
		errorMessage.value = "Failed to download template. Please try again.";
	}
};

const downloadExample = async () => {
	if (!selectedDataType.value) {
		errorMessage.value = "Please select a data type first";
		return;
	}

	try {
		let sampleData = [];

		// Check if this data type uses Supabase
		if (USE_SUPABASE_FOR.includes(selectedDataType.value)) {
			// Fetch sample data from Supabase (limit to 5 records)
			const { data, error } = await supabase
				.from(selectedDataType.value)
				.select("*")
				.limit(5);

			if (error) throw error;

			if (!data || data.length === 0) {
				errorMessage.value = "No example data available for this data type";
				return;
			}

			// Remove system fields that shouldn't be in the template
			sampleData = data.map((item) => {
				const { id, created_at, updated_at, ...rest } = item;
				return rest;
			});
		} else {
			// Use legacy API for non-migrated data types
			const config = useRuntimeConfig();
			const adminApiUrl =
				config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";

			const response = await $fetch(
				`${adminApiUrl}/import-export/test-data/${selectedDataType.value}`,
			);

			if (response.sample_data && response.sample_data.length > 0) {
				sampleData = response.sample_data;
			} else {
				errorMessage.value = "No example data available for this data type";
				return;
			}
		}

		// Convert to CSV format
		const headers = Object.keys(sampleData[0]);
		const csvContent = [
			headers.join(","),
			...sampleData.map((row) =>
				headers
					.map((header) => {
						const value = row[header];
						// Escape CSV values
						if (
							typeof value === "string" &&
							(value.includes(",") ||
								value.includes('"') ||
								value.includes("\n"))
						) {
							return `"${value.replace(/"/g, '""')}"`;
						}
						return value ?? "";
					})
					.join(","),
			),
		].join("\n");

		// Create and download file
		const blob = new Blob([csvContent], { type: "text/csv" });
		const url = window.URL.createObjectURL(blob);
		const link = document.createElement("a");
		link.href = url;
		link.download = `${selectedDataType.value}_example.csv`;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
		window.URL.revokeObjectURL(url);
	} catch (error) {
		console.error("Example download failed:", error);
		errorMessage.value = "Failed to download example data. Please try again.";
	}
};

watch(
	() => props.isOpen,
	(newValue) => {
		if (newValue) {
			resetForm();
		}
	},
);
</script>

<style scoped>
/* Custom file input styling */
input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	white-space: nowrap;
	border: 0;
}

/* Drag and drop animations */
.border-dashed {
	transition: all 0.2s ease-in-out;
}

/* Progress bar animation */
.transition-all {
	transition-property: all;
	transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
	transition-duration: 300ms;
}

/* Modal animations */
.modal-enter-active,
.modal-leave-active {
	transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
	opacity: 0;
}

/* Spinner animation */
@keyframes spin {
	from {
		transform: rotate(0deg);
	}
	to {
		transform: rotate(360deg);
	}
}

.animate-spin {
	animation: spin 1s linear infinite;
}
</style>
