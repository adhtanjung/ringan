<template>
	<div class="w-full">
		<Command
			v-model="selectedValue"
			v-model:open="open"
			:open-on-focus="true"
			:open-on-click="true"
			:ignore-filter="true"
			:reset-search-term-on-select="true"
			class="w-full"
		>
			<div class="relative">
				<CommandInput
					:id="inputId"
					v-model="searchTerm"
					:placeholder="placeholder"
					:display-value="displayValueForSelection"
					:auto-focus="false"
					class="pr-10"
				/>
				<div class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3">
					<Loader2
						v-if="loading"
						class="h-4 w-4 animate-spin text-muted-foreground"
						aria-hidden="true"
					/>
				</div>
			</div>

			<CommandList class="mt-2 max-h-72 overflow-hidden rounded-md border border-border bg-popover text-popover-foreground shadow-md">
				<div
					v-if="loading && !results.length"
					role="status"
					aria-live="polite"
					class="flex items-center gap-2 px-3 py-3 text-sm text-muted-foreground"
				>
					<Loader2 class="h-4 w-4 animate-spin" aria-hidden="true" />
					<span>Searching...</span>
				</div>

				<template v-else>
					<CommandEmpty>
						{{ searchTerm ? "No matching results." : "Type to search." }}
					</CommandEmpty>

					<CommandGroup v-if="results.length" heading="Results">
						<CommandItem
							v-for="item in results"
							:key="valueForItem(item)"
							:value="valueForItem(item)"
							class="py-3"
							@select="selectItem(item)"
						>
							<div class="flex min-w-0 flex-col">
								<span class="truncate">{{ labelForItem(item) }}</span>
								<span
									v-if="summaryForItem(item)"
									class="truncate text-xs text-muted-foreground"
								>
									{{ summaryForItem(item) }}
								</span>
							</div>
						</CommandItem>
					</CommandGroup>

					<div v-if="hasMore" class="border-t p-2">
						<Button
							type="button"
							variant="outline"
							size="sm"
							class="h-11 w-full"
							@click="loadMore"
							:disabled="loading"
						>
							<Loader2
								v-if="loading"
								class="mr-2 h-4 w-4 animate-spin"
								aria-hidden="true"
							/>
							Load more
						</Button>
					</div>
				</template>
			</CommandList>
		</Command>
	</div>
</template>

<script setup lang="ts">
import { computed, ref, watch } from "vue";
import { Loader2 } from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import {
	Command,
	CommandEmpty,
	CommandGroup,
	CommandInput,
	CommandItem,
	CommandList,
} from "@/components/ui/command";
import { useSupabase } from "@/composables/useSupabase";

type OptionRecord = Record<string, any>;

const props = defineProps({
	modelValue: { type: String, default: "" },
	inputId: { type: String, default: "" },
	placeholder: { type: String, default: "Type to search..." },
	fetchUrl: { type: String, default: "" },
	tableName: { type: String, default: "" },
	searchFields: { type: Array, default: () => [] },
	valueField: { type: String, default: "" },
	displayFields: { type: Array, default: () => [] },
	labelExtractor: {
		type: Function,
		default: (item: OptionRecord) =>
			item.label ??
			item.name ??
			item.title ??
			item.problem_name ??
			item.sub_category_id ??
			item.category_id ??
			item.id ??
			"",
	},
	valueExtractor: {
		type: Function,
		default: (item: OptionRecord) =>
			item.value ??
			item.id ??
			item.sub_category_id ??
			item.category_id ??
			item.question_id ??
			item.prompt_id ??
			item.action_id ??
			item.suggestion_id ??
			"",
	},
});

const emit = defineEmits(["update:modelValue", "select"]);

const { supabase } = useSupabase();

const USE_SUPABASE_FOR = [
	"problem_types",
	"problems",
	"assessments",
	"suggestions",
	"feedback_prompts",
	"next_actions",
	"training_examples",
];

const open = ref(false);
const searchTerm = ref("");
const loading = ref(false);
const results = ref<OptionRecord[]>([]);
const page = ref(1);
const hasMore = ref(false);
const selectedRecord = ref<OptionRecord | null>(null);
const cachedOptions = ref(new Map<string, OptionRecord>());

const normalizeModelValue = (value: unknown): string => {
	if (typeof value === "string" || typeof value === "number") {
		return String(value);
	}

	if (value && typeof value === "object") {
		const record = value as OptionRecord;
		if (record.value !== undefined && record.value !== null) {
			return String(record.value);
		}
		if (record.id !== undefined && record.id !== null) {
			return String(record.id);
		}
		if (
			record.sub_category_id !== undefined &&
			record.sub_category_id !== null
		) {
			return String(record.sub_category_id);
		}
	}

	return "";
};

const selectedValue = computed({
	get: () => normalizeModelValue(props.modelValue),
	set: (value) => {
		const normalizedValue = normalizeModelValue(value);
		if (normalizedValue !== props.modelValue) {
			emit("update:modelValue", normalizedValue);
		}
	},
});

const valueForItem = (item: OptionRecord) => {
	if (props.valueField) return String(item[props.valueField]);
	return String(props.valueExtractor(item));
};

const labelForItem = (item: OptionRecord) => {
	if (props.displayFields && props.displayFields.length > 0) {
		return props.displayFields
			.map((field: string) => item[field])
			.filter(Boolean)
			.join(" - ");
	}
	return String(props.labelExtractor(item));
};

const summaryForItem = (item: OptionRecord) => {
	if (!props.displayFields || props.displayFields.length < 2) return "";
	return props.displayFields
		.slice(1)
		.map((field: string) => item[field])
		.filter(Boolean)
		.join(" • ");
};

const cacheItems = (items: OptionRecord[]) => {
	items.forEach((item) => {
		cachedOptions.value.set(valueForItem(item), item);
	});
};

const selectedLabelForValue = (value: string) => {
	const cached = cachedOptions.value.get(value) || selectedRecord.value;
	if (cached && valueForItem(cached) === value) return labelForItem(cached);
	return value;
};

const displayValueForSelection = (value: string) =>
	selectedLabelForValue(normalizeModelValue(value));

let debounceTimer: ReturnType<typeof setTimeout> | undefined;

watch(searchTerm, () => {
	if (debounceTimer) clearTimeout(debounceTimer);
	if (!open.value) return;

	debounceTimer = setTimeout(() => {
		page.value = 1;
		results.value = [];
		void fetchResults();
	}, 250);
});

watch(
	() => props.modelValue,
	async (value) => {
		if (!value) {
			selectedRecord.value = null;
			return;
		}

		const key = String(value);
		const cached = cachedOptions.value.get(key);
		if (cached) {
			selectedRecord.value = cached;
			return;
		}

		if (props.tableName) {
			await hydrateSelectedRecord(key);
		}
	},
	{ immediate: true },
);

const hydrateSelectedRecord = async (value: string) => {
	try {
		const lookupField = props.valueField || "id";
		const { data, error } = await supabase
			.from(props.tableName)
			.select("*")
			.eq(lookupField, value)
			.maybeSingle();

		if (error) throw error;
		if (!data) return;

		selectedRecord.value = data;
		cacheItems([data]);
	} catch (error) {
		console.error("AsyncSearchSelect hydrate error:", error);
	}
};

const fetchResults = async () => {
	try {
		loading.value = true;

		const targetTable =
			props.tableName ||
			(props.fetchUrl
				? USE_SUPABASE_FOR.find((table) => props.fetchUrl.includes(table))
				: null);

		if (targetTable) {
			let query = supabase.from(targetTable).select("*", { count: "exact" });

			const search = searchTerm.value.trim();
			if (search) {
				if (targetTable === "problems") {
					query = query.or(
						`problem_name.ilike.%${search}%,description.ilike.%${search}%,sub_category_id.ilike.%${search}%`,
					);
				} else if (targetTable === "problem_types") {
					query = query.or(`type_name.ilike.%${search}%,description.ilike.%${search}%`);
				}
			}

			const limit = 20;
			const from = (page.value - 1) * limit;
			const to = from + limit - 1;
			const orderBy =
				targetTable === "problem_types"
					? "type_name"
					: targetTable === "problems"
						? "problem_name"
						: "created_at";

			query = query.order(orderBy, { ascending: true }).range(from, to);

			const { data, count, error } = await query;
			if (error) throw error;

			const items = (data || []) as OptionRecord[];
			cacheItems(items);

			if (page.value === 1) results.value = items;
			else results.value = [...results.value, ...items];

			hasMore.value = from + items.length < (count || 0);
			return;
		}

		if (props.fetchUrl) {
			const config = useRuntimeConfig();
			const adminApiUrl =
				config.public.adminApiUrl || "http://localhost:8000/api/v1/admin";
			const params = new URLSearchParams();
			if (searchTerm.value) params.set("q", searchTerm.value);
			params.set("limit", "20");
			params.set("page", String(page.value));
			const url = `${adminApiUrl}${props.fetchUrl}?${params.toString()}`;
			const resp = await $fetch(url);
			const items = (resp?.data?.items ?? []) as OptionRecord[];
			const more = Boolean(resp?.data?.has_more ?? false);

			cacheItems(items);
			if (page.value === 1) results.value = items;
			else results.value = [...results.value, ...items];
			hasMore.value = more;
		}
	} catch (error) {
		console.error("AsyncSearchSelect error:", error);
	} finally {
		loading.value = false;
	}
};

const loadMore = () => {
	if (loading.value || !hasMore.value) return;
	page.value += 1;
	void fetchResults();
};

const selectItem = (item: OptionRecord) => {
	const value = valueForItem(item);
	selectedRecord.value = item;
	cacheItems([item]);
	emit("update:modelValue", value);
	emit("select", item);
	open.value = false;
};
</script>
