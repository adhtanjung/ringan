<template>
	<Dialog :open="isOpen" @update:open="$emit('cancel')">
		<DialogContent
			class="sm:max-w-[95vw] max-h-[95vh] flex flex-col p-0 overflow-hidden"
		>
			<DialogHeader class="p-6 pb-2 border-b">
				<div class="flex items-center justify-between">
					<div>
						<DialogTitle class="text-xl"
							>Import Preview & Validation</DialogTitle
						>
						<DialogDescription>
							Previewing {{ data.length }} records for {{ dataTypeLabel }}. Rows
							with issues are highlighted in red.
						</DialogDescription>
					</div>
					<div class="flex gap-4 text-sm">
						<div
							class="flex flex-col items-center px-3 py-1 bg-green-50 border border-green-100 rounded"
						>
							<span class="font-bold text-green-700">{{
								validItems.length
							}}</span>
							<span class="text-[10px] text-green-600 uppercase">Valid</span>
						</div>
						<div
							class="flex flex-col items-center px-3 py-1 bg-red-50 border border-red-100 rounded"
						>
							<span class="font-bold text-red-700">{{
								invalidItems.length
							}}</span>
							<span class="text-[10px] text-red-600 uppercase">Errors</span>
						</div>
					</div>
				</div>
			</DialogHeader>

			<div class="flex-1 overflow-auto p-0">
				<Table>
					<TableHeader class="sticky top-0 bg-background z-10 shadow-sm">
						<TableRow>
							<TableHead class="w-[50px] text-center">Status</TableHead>
							<TableHead v-for="col in columns" :key="col.key">
								{{ col.label }}
							</TableHead>
						</TableRow>
					</TableHeader>
					<TableBody>
						<TableRow
							v-for="(row, index) in validationResults"
							:key="index"
							:class="{ 'bg-red-50/50': !row.isValid }"
						>
							<TableCell class="text-center">
								<TooltipProvider>
									<Tooltip>
										<TooltipTrigger>
											<CheckCircle
												v-if="row.isValid"
												class="h-4 w-4 text-green-500 mx-auto"
											/>
											<AlertCircle
												v-else
												class="h-4 w-4 text-red-500 mx-auto"
											/>
										</TooltipTrigger>
										<TooltipContent v-if="!row.isValid" class="max-w-xs">
											<ul class="text-xs list-disc pl-3">
												<li v-for="err in row.errors" :key="err">{{ err }}</li>
											</ul>
										</TooltipContent>
									</Tooltip>
								</TooltipProvider>
							</TableCell>
							<TableCell
								v-for="col in columns"
								:key="col.key"
								:class="{
									'text-red-600 font-medium': row.fieldErrors[col.key],
								}"
							>
								<div
									class="max-w-[200px] truncate"
									:title="String(row.data[col.key] || '')"
								>
									<span v-if="row.data[col.key]" class="text-foreground">
										{{ row.data[col.key] }}
									</span>
									<span v-else class="text-muted-foreground italic text-xs">
										{{
											row.data[col.key] === undefined ? "(missing)" : "(empty)"
										}}
									</span>
								</div>
							</TableCell>
						</TableRow>
					</TableBody>
				</Table>
			</div>

			<DialogFooter
				class="p-4 border-t bg-gray-50/50 flex flex-col sm:flex-row gap-3"
			>
				<div
					class="flex-1 flex items-center text-sm text-muted-foreground mr-auto"
				>
					<Info class="h-4 w-4 mr-2" />
					{{
						invalidItems.length > 0
							? "Only valid records will be imported."
							: "All records are valid."
					}}
				</div>
				<Button variant="outline" @click="$emit('cancel')"> Cancel </Button>
				<Button
					@click="confirmImport"
					:disabled="validItems.length === 0"
					class="min-w-[140px]"
				>
					Import {{ validItems.length }} Valid Rows
				</Button>
			</DialogFooter>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { computed, ref, watch, onMounted } from "vue";
import { CheckCircle, AlertCircle, Info } from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import {
	Tooltip,
	TooltipContent,
	TooltipProvider,
	TooltipTrigger,
} from "@/components/ui/tooltip";
import {
	columnConfigs,
	datasetLabels,
} from "@/composables/useDatasetManagement";
import { useSupabase } from "@/composables/useSupabase";
const props = defineProps<{
	isOpen: boolean;
	data: any[];
	dataType: string;
}>();

const emit = defineEmits(["cancel", "confirm"]);

const { supabase } = useSupabase();
const validSubCategoryIds = ref<string[]>([]);
const validCategoryIds = ref<string[]>([]);
const isLoadingValidationData = ref(false);

const fetchValidationData = async () => {
	if (!props.isOpen) return;

	isLoadingValidationData.value = true;
	try {
		// Fetch subcategory IDs from problems table
		const { data: subCats } = await supabase
			.from("problems")
			.select("sub_category_id");

		if (subCats) {
			validSubCategoryIds.value = subCats
				.map((s: any) => s.sub_category_id)
				.filter(Boolean);
		}

		// Fetch category IDs from problem_types table
		const { data: categories } = await supabase
			.from("problem_types")
			.select("category_id");

		if (categories) {
			validCategoryIds.value = categories
				.map((c: any) => c.category_id)
				.filter(Boolean);
		}
	} catch (err) {
		console.error("Error fetching validation data:", err);
	} finally {
		isLoadingValidationData.value = false;
	}
};

watch(
	() => props.isOpen,
	(newVal) => {
		if (newVal) {
			fetchValidationData();
		}
	},
	{ immediate: true }
);

const dataTypeLabel = computed(
	() => (datasetLabels as any)[props.dataType] || props.dataType
);
const EXCLUDED_FIELDS = [
	"id",
	"question_id",
	"created_at",
	"updated_at",
	"is_active",
];
const columns = computed(() => {
	const allCols = (columnConfigs as any)[props.dataType] || [];
	return allCols.filter((col: any) => !EXCLUDED_FIELDS.includes(col.key));
});

const normalizedData = computed(() => {
	if (!props.data || props.data.length === 0) return [];

	return props.data.map((item) => {
		const normalizedItem: Record<string, any> = {};

		// Map existing keys to internal keys if possible
		columns.value.forEach((col: any) => {
			const key = col.key;
			const label = col.label.toLowerCase();

			// Try to find a matching key in the item
			// 1. Exact match
			if (item[key] !== undefined) {
				normalizedItem[key] = item[key];
			}
			// 2. Case-insensitive match or match with label
			else {
				const itemKeys = Object.keys(item);
				const matchedKey = itemKeys.find((k) => {
					const lk = k.toLowerCase();
					return (
						lk === key.toLowerCase() ||
						lk === label ||
						lk.replace(/\s/g, "_") === key ||
						key.replace(/_/g, " ") === lk
					);
				});

				if (matchedKey) {
					normalizedItem[key] = item[matchedKey];
				} else {
					normalizedItem[key] = item[key]; // Keep as is (likely empty strings from template)
				}
			}
		});

		return normalizedItem;
	});
});

const validationResults = computed(() => {
	return normalizedData.value.map((item) => {
		const errors: string[] = [];
		const fieldErrors: Record<string, boolean> = {};

		// Validation logic based on dataType
		if (props.dataType === "assessments") {
			if (!item.sub_category_id) {
				errors.push("Subcategory ID is required");
				fieldErrors.sub_category_id = true;
			} else if (
				!isLoadingValidationData.value &&
				!validSubCategoryIds.value.includes(item.sub_category_id)
			) {
				errors.push(
					`Subcategory ID "${item.sub_category_id}" does not exist in the database`
				);
				fieldErrors.sub_category_id = true;
			}

			if (!item.question_text) {
				errors.push("Question text is required");
				fieldErrors.question_text = true;
			}
			if (!item.response_type) {
				errors.push("Response type is required");
				fieldErrors.response_type = true;
			} else if (
				!["scale", "text"].includes(String(item.response_type).toLowerCase())
			) {
				errors.push('Response type must be "scale" or "text"');
				fieldErrors.response_type = true;
			}

			if (String(item.response_type)?.toLowerCase() === "scale") {
				[
					"scale_label_1",
					"scale_label_2",
					"scale_label_3",
					"scale_label_4",
				].forEach((key) => {
					if (!item[key]) {
						errors.push(
							`${key.replace(/_/g, " ")} is required for scale questions`
						);
						fieldErrors[key] = true;
					}
				});
			}
		} else if (props.dataType === "problems") {
			if (!item.problem_name) {
				errors.push("Problem name is required");
				fieldErrors.problem_name = true;
			}
			if (!item.sub_category_id) {
				errors.push("Subcategory ID is required");
				fieldErrors.sub_category_id = true;
			}
			// Only validate if we are NOT in the process of generating new IDs (overwrite case)
			// But for import, it's safer to just check if it already exists or keep it simple
			if (
				item.category_id &&
				!isLoadingValidationData.value &&
				!validCategoryIds.value.includes(item.category_id)
			) {
				errors.push(
					`Category ID "${item.category_id}" does not exist in the database`
				);
				fieldErrors.category_id = true;
			}
		} else if (props.dataType === "problem_types") {
			if (!item.type_name) {
				errors.push("Type name is required");
				fieldErrors.type_name = true;
			}
			if (!item.category_id) {
				errors.push("Category ID is required");
				fieldErrors.category_id = true;
			}
			// Check for valid alphanumeric/underscore format for category_id
			if (item.category_id && !/^[a-z0-9_]+$/i.test(item.category_id)) {
				errors.push(
					"Category ID must contain only letters, numbers, and underscores"
				);
				fieldErrors.category_id = true;
			}
			if (!item.description) {
				errors.push("Description is required");
				fieldErrors.description = true;
			}
		}

		return {
			data: item,
			isValid: errors.length === 0,
			errors,
			fieldErrors,
		};
	});
});

const validItems = computed(() =>
	validationResults.value.filter((r) => r.isValid).map((r) => r.data)
);

const invalidItems = computed(() =>
	validationResults.value.filter((r) => !r.isValid)
);

const confirmImport = () => {
	emit("confirm", validItems.value);
};
</script>
