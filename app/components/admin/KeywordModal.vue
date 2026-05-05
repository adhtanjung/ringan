<template>
	<Dialog :open="isOpen" @update:open="closeModal">
		<DialogContent
			class="w-[92vw] sm:max-w-xl max-h-[92dvh] p-0 flex flex-col overflow-hidden"
		>
			<div class="px-6 py-5 border-b">
				<DialogHeader>
					<DialogTitle>
						{{ isEditing ? "Edit Keyword" : "Create Keyword" }}
					</DialogTitle>
					<DialogDescription>
						{{
							isEditing
								? "Update the keyword and its category or subcategory link."
								: "Add a keyword or phrase the AI should detect, and link it to a category or subcategory."
						}}
					</DialogDescription>
				</DialogHeader>
			</div>

			<form
				@submit.prevent="saveItem"
				class="flex-1 flex flex-col min-h-0 overflow-hidden"
			>
				<div class="flex-1 overflow-y-auto min-h-0 px-6">
					<div class="py-6 space-y-6">

						<!-- Keyword text -->
						<div>
							<Label for="keyword" class="text-sm font-medium text-foreground">
								Keyword / Phrase
								<span class="ml-1 text-destructive">*</span>
							</Label>
							<Input
								id="keyword"
								v-model="formData.keyword"
								placeholder="e.g., can't sleep, feeling hopeless"
								required
								class="mt-1"
								@blur="handleKeywordBlur"
							/>
							<p
								v-if="keywordError"
								class="mt-1 text-sm leading-6 text-destructive"
								aria-live="polite"
							>
								{{ keywordError }}
							</p>
							<p v-else class="mt-1 text-sm leading-6 text-muted-foreground">
								{{ keywordHelperText }}
							</p>
						</div>

						<!-- Category -->
						<div>
							<Label for="category_id" class="text-sm font-medium text-foreground">
								Category
							</Label>
							<Select
								:model-value="formData.category_id ?? undefined"
								@update:model-value="handleCategoryChange"
								:disabled="loadingCategories"
							>
								<SelectTrigger id="category_id" class="mt-1 h-11 w-full">
									<SelectValue placeholder="Select a category (optional)" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="__none__">— None —</SelectItem>
									<SelectItem
										v-for="cat in categories"
										:key="cat.category_id"
										:value="cat.category_id"
									>
										{{ cat.type_name }}
									</SelectItem>
								</SelectContent>
							</Select>
							<p class="mt-1 text-sm leading-6 text-muted-foreground">
								{{ loadingCategories ? "Loading categories…" : "Link this keyword to a top-level category." }}
							</p>
						</div>

						<!-- Subcategory -->
						<div>
							<Label for="sub_category_id" class="text-sm font-medium text-foreground">
								Subcategory
							</Label>
							<Select
								:model-value="formData.sub_category_id ?? undefined"
								@update:model-value="handleSubCategoryChange"
								:disabled="loadingSubCategories"
							>
								<SelectTrigger id="sub_category_id" class="mt-1 h-11 w-full">
									<SelectValue placeholder="Select a subcategory (optional)" />
								</SelectTrigger>
								<SelectContent>
									<SelectItem value="__none__">— None —</SelectItem>
									<SelectItem
										v-for="sub in filteredSubCategories"
										:key="sub.sub_category_id"
										:value="sub.sub_category_id"
									>
										{{ sub.problem_name }}
									</SelectItem>
								</SelectContent>
							</Select>
							<p class="mt-1 text-sm leading-6 text-muted-foreground">
								<template v-if="loadingSubCategories">Loading subcategories…</template>
								<template v-else-if="filteredSubCategories.length === 0 && formData.category_id">
									No subcategories found for this category.
								</template>
								<template v-else>
									Optionally narrow this keyword to a specific subcategory.
								</template>
							</p>
						</div>

					</div>
				</div>

				<div class="px-6 py-4 border-t bg-background">
					<DialogFooter class="flex flex-col-reverse sm:flex-row sm:justify-end gap-2">
						<Button
							type="button"
							variant="outline"
							@click="closeModal"
							:disabled="isSaving"
							class="w-full sm:w-auto"
						>
							Cancel
						</Button>
						<Button
							type="submit"
							class="w-full sm:w-auto"
							:disabled="isSaving || isGeneratingKeywordId"
						>
							<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
							{{ isSaving ? "Saving..." : "Save Keyword" }}
						</Button>
					</DialogFooter>
				</div>
			</form>
		</DialogContent>
	</Dialog>
</template>

<script setup lang="ts">
import { ref, computed, watch, reactive, nextTick } from "vue";
import { Loader2 } from "lucide-vue-next";
import { useSupabase } from "@/composables/useSupabase";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";

// ─── Types ────────────────────────────────────────────────────────────────────

interface Keyword {
	id?: string;
	keyword_id: string;
	keyword: string;
	category_id: string | null;
	sub_category_id: string | null;
	is_active: boolean;
	created_at?: string;
	updated_at?: string;
}

interface Category {
	category_id: string;
	type_name: string;
}

interface SubCategory {
	sub_category_id: string;
	problem_name: string;
	category_id: string;
}

// ─── Props / Emits ────────────────────────────────────────────────────────────

const props = defineProps<{
	isOpen: boolean;
	item: Keyword | null;
}>();

const emit = defineEmits<{
	close: [];
	save: [data: Keyword];
}>();

// ─── Composables ──────────────────────────────────────────────────────────────

const { supabase } = useSupabase();

// ─── State ────────────────────────────────────────────────────────────────────

const formData = reactive<Keyword>({
	keyword_id: "",
	keyword: "",
	category_id: null,
	sub_category_id: null,
	is_active: true,
});

const isSaving = ref(false);
const isGeneratingKeywordId = ref(false);
const keywordIdError = ref("");
const keywordIdRequestId = ref(0);
const hasSubmitted = ref(false);
const fieldTouched = reactive({ keyword: false });
const initialFormSnapshot = ref("");

const categories = ref<Category[]>([]);
const subCategories = ref<SubCategory[]>([]);
const loadingCategories = ref(false);
const loadingSubCategories = ref(false);

// ─── Computed ─────────────────────────────────────────────────────────────────

const isEditing = computed(() => !!props.item);
const keywordTrimmed = computed(() => formData.keyword.trim());

const filteredSubCategories = computed(() => {
	if (!formData.category_id) return subCategories.value;
	return subCategories.value.filter((s) => s.category_id === formData.category_id);
});

const showKeywordFeedback = computed(() => hasSubmitted.value || fieldTouched.keyword);

const keywordError = computed(() => {
	if (!showKeywordFeedback.value) return "";
	if (!keywordTrimmed.value) return "Keyword is required.";
	if (keywordIdError.value) return keywordIdError.value;
	return "";
});

const keywordHelperText = computed(() => {
	if (keywordIdError.value) return "";
	if (isGeneratingKeywordId.value) return "Generating keyword ID…";
	if (isEditing.value) return "Keyword ID stays the same while you edit.";
	return formData.keyword_id
		? "Keyword ID generated automatically."
		: "Keyword ID will be generated automatically.";
});

const createFormSnapshot = () =>
	JSON.stringify({
		keyword: formData.keyword || "",
		keyword_id: formData.keyword_id || "",
		category_id: formData.category_id || null,
		sub_category_id: formData.sub_category_id || null,
		is_active: formData.is_active ?? true,
	});

const hasUnsavedChanges = computed(
	() => createFormSnapshot() !== initialFormSnapshot.value,
);

// ─── Methods ──────────────────────────────────────────────────────────────────

const closeModal = (force = false) => {
	if (!isSaving.value || force) {
		if (
			!force &&
			hasUnsavedChanges.value &&
			typeof window !== "undefined" &&
			!window.confirm("Discard unsaved changes?")
		) {
			return;
		}
		resetForm();
		emit("close");
	}
};

const resetForm = () => {
	formData.keyword_id = "";
	formData.keyword = "";
	formData.category_id = null;
	formData.sub_category_id = null;
	formData.is_active = true;
	isSaving.value = false;
	isGeneratingKeywordId.value = false;
	keywordIdError.value = "";
	keywordIdRequestId.value += 1;
	hasSubmitted.value = false;
	fieldTouched.keyword = false;
};

const initializeForm = () => {
	isSaving.value = false;
	isGeneratingKeywordId.value = false;
	keywordIdError.value = "";
	hasSubmitted.value = false;
	fieldTouched.keyword = false;

	if (props.item) {
		formData.keyword_id = props.item.keyword_id || "";
		formData.keyword = props.item.keyword || "";
		formData.category_id = props.item.category_id || null;
		formData.sub_category_id = props.item.sub_category_id || null;
		formData.is_active = props.item.is_active ?? true;
	} else {
		formData.keyword_id = "";
		formData.keyword = "";
		formData.category_id = null;
		formData.sub_category_id = null;
		formData.is_active = true;
	}

	initialFormSnapshot.value = createFormSnapshot();
};

const fetchCategories = async () => {
	loadingCategories.value = true;
	try {
		const { data, error } = await supabase
			.from("problem_types")
			.select("category_id, type_name")
			.eq("is_active", true)
			.order("type_name");
		if (error) throw error;
		categories.value = data || [];
	} catch (err) {
		console.error("Error fetching categories:", err);
		categories.value = [];
	} finally {
		loadingCategories.value = false;
	}
};

const fetchSubCategories = async () => {
	loadingSubCategories.value = true;
	try {
		const { data, error } = await supabase
			.from("problems")
			.select("sub_category_id, problem_name, category_id")
			.eq("is_active", true)
			.order("problem_name");
		if (error) throw error;
		subCategories.value = data || [];
	} catch (err) {
		console.error("Error fetching subcategories:", err);
		subCategories.value = [];
	} finally {
		loadingSubCategories.value = false;
	}
};

const generateKeywordId = async (): Promise<string> => {
	// Fetch the highest existing keyword_id number and increment
	const { data } = await supabase
		.from("category_keywords")
		.select("keyword_id")
		.order("keyword_id", { ascending: false })
		.limit(1);

	const last = data?.[0]?.keyword_id || "KW000";
	const match = last.match(/KW(\d+)/i);
	const nextNum = match ? parseInt(match[1], 10) + 1 : 1;
	return `KW${String(nextNum).padStart(3, "0")}`;
};

const autoGenerateKeywordId = async () => {
	if (isEditing.value || !keywordTrimmed.value) return false;

	const currentRequestId = ++keywordIdRequestId.value;
	isGeneratingKeywordId.value = true;
	keywordIdError.value = "";

	try {
		const id = await generateKeywordId();
		if (currentRequestId !== keywordIdRequestId.value) return false;
		formData.keyword_id = id;
		return true;
	} catch (err) {
		if (currentRequestId === keywordIdRequestId.value) {
			console.error("Error generating keyword ID:", err);
			keywordIdError.value = "Unable to generate keyword ID. Try again.";
			formData.keyword_id = "";
		}
		return false;
	} finally {
		if (currentRequestId === keywordIdRequestId.value) {
			isGeneratingKeywordId.value = false;
		}
	}
};

const handleKeywordBlur = async () => {
	fieldTouched.keyword = true;
	if (!keywordTrimmed.value) return;
	await autoGenerateKeywordId();
};

const handleCategoryChange = (value?: string) => {
	const newVal = (!value || value === "__none__") ? null : value;
	formData.category_id = newVal;
	// Clear subcategory if it no longer belongs to the selected category
	if (formData.sub_category_id && newVal) {
		const stillValid = subCategories.value.some(
			(s) => s.sub_category_id === formData.sub_category_id && s.category_id === newVal,
		);
		if (!stillValid) formData.sub_category_id = null;
	}
};

const handleSubCategoryChange = (value?: string) => {
	const newVal = (!value || value === "__none__") ? null : value;
	formData.sub_category_id = newVal;
	// Auto-fill category from subcategory if not already set
	if (newVal && !formData.category_id) {
		const sub = subCategories.value.find((s) => s.sub_category_id === newVal);
		if (sub?.category_id) formData.category_id = sub.category_id;
	}
};

const saveItem = async () => {
	hasSubmitted.value = true;
	fieldTouched.keyword = true;

	if (!keywordTrimmed.value) return;

	if (!isEditing.value && !formData.keyword_id) {
		const generated = await autoGenerateKeywordId();
		if (!generated) return;
	}

	if (keywordError.value) return;

	isSaving.value = true;
	try {
		emit("save", { ...formData });
		closeModal(true);
	} catch (err) {
		console.error("Save error:", err);
	} finally {
		isSaving.value = false;
	}
};

// ─── Watchers ─────────────────────────────────────────────────────────────────

watch(
	() => props.isOpen,
	async (open) => {
		if (open) {
			await nextTick();
			await Promise.all([fetchCategories(), fetchSubCategories()]);
			initializeForm();
		}
	},
);

watch(
	() => props.item,
	() => {
		if (props.isOpen) initializeForm();
	},
	{ deep: true },
);

watch(
	() => formData.keyword,
	() => {
		keywordIdRequestId.value += 1;
		keywordIdError.value = "";
		if (!isEditing.value) formData.keyword_id = "";
	},
);
</script>
