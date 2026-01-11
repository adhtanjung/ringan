<template>
	<div class="border-l-2 border-primary/30 ml-4 bg-muted/5">
		<div v-if="loading" class="p-4 space-y-2">
			<Skeleton class="h-8 w-full" />
			<Skeleton class="h-8 w-full" />
			<Skeleton class="h-8 w-full" />
		</div>

		<div v-else-if="error" class="text-red-500 text-xs p-4">
			{{ error }}
		</div>

		<div v-else>
			<DatasetTable
				v-if="data && data.length > 0"
				:title="dataType"
				:data-type="dataType"
				:data="data"
				:columns="columns"
				:loading="loading"
				:enable-expansion="enableNestedExpansion"
				:pagination="pagination"
				:current-page="currentPage"
				:total-pages="totalPages"
				:search-query="searchQuery"
				variant="compact"
				:hide-toolbar="true"
				@page-change="goToPage"
				@page-size-change="changePageSize"
				@next-page="nextPage"
				@prev-page="prevPage"
				@search-change="(value) => (searchQuery = value)"
			>
				<template #header-title>
					<span class="hidden"></span>
				</template>

				<template #row-expansion="{ item }">
					<NestedDataList
						v-if="dataType === 'problems'"
						data-type="assessments"
						filter-key="sub_category_id"
						:filter-value="item.sub_category_id"
						:level="level + 1"
						:icon="FileQuestion"
					/>
				</template>
			</DatasetTable>

			<div v-else class="text-xs text-muted-foreground italic p-4">
				No {{ dataTypeLabel.toLowerCase() }} found.
			</div>
		</div>
	</div>
</template>

<script setup>
import { onMounted, watch, computed } from "vue";
import DatasetTable from "@/components/admin/DatasetTable.vue";
import { Skeleton } from "@/components/ui/skeleton";
import { FileQuestion } from "lucide-vue-next";

const props = defineProps({
	dataType: {
		type: String,
		required: true,
	},
	filterKey: {
		type: String,
		required: true,
	},
	filterValue: {
		type: [String, Number],
		required: true,
	},
	title: {
		type: String,
		default: "",
	},
	icon: {
		type: Object,
		default: null,
	},
	level: {
		type: Number,
		default: 0,
	},
});

// Determine nameColumnKey based on dataType
const nameColumnKey = computed(() => {
	if (props.dataType === "problems") return "problem_name";
	if (props.dataType === "assessments") return "question_text";
	return "";
});

// Import the composable
const {
	loading,
	error,
	data,
	pagination,
	columns,
	dataTypeLabel,
	currentPage,
	totalPages,
	searchQuery,
	filters,
	refreshData,
	setFilter,
	goToPage,
	changePageSize,
	nextPage,
	prevPage,
} = useDatasetManagement(props.dataType);

// Determine if this nested list should also be expandable
// Currently hardcoded logic: 'problems' (Subcategories) contain 'assessments'
const enableNestedExpansion = computed(() => {
	return props.dataType === "problems";
});

// Initial load
onMounted(() => {
	setFilter(props.filterKey, props.filterValue);
});

// If filter value changes (unlikely for row expansion but good for correctness)
watch(
	() => props.filterValue,
	(newVal) => {
		if (newVal) {
			setFilter(props.filterKey, newVal);
		}
	}
);
</script>
