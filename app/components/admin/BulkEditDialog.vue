<script setup lang="ts">
import { ref, computed } from "vue";
import { Edit3, CheckCircle, Loader2, Info } from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Alert, AlertDescription } from "@/components/ui/alert";

interface Column {
	key: string;
	label: string;
	type: string;
}

const props = defineProps<{
	isOpen: boolean;
	count: number;
	columns: Column[];
	isSaving: boolean;
}>();

const emit = defineEmits(["close", "confirm"]);

const selectedField = ref("");
const newValue = ref<any>(null);

const editableColumns = computed(() => {
	return props.columns.filter(
		(c) =>
			c.key !== "id" &&
			c.key !== "created_at" &&
			c.key !== "updated_at" &&
			c.key !== "question_id" &&
			c.key !== "example_id" &&
			c.key !== "sub_category_id"
	);
});

const currentFieldType = computed(() => {
	return (
		props.columns.find((c) => c.key === selectedField.value)?.type || "text"
	);
});

watch(selectedField, () => {
	if (currentFieldType.value === "boolean") {
		newValue.value = true;
	} else {
		newValue.value = "";
	}
});

const handleConfirm = () => {
	if (selectedField.value) {
		emit("confirm", {
			field: selectedField.value,
			value: newValue.value,
		});
	}
};
</script>

<template>
	<Dialog :open="isOpen" @update:open="(v) => !v && emit('close')">
		<DialogContent class="max-w-md">
			<DialogHeader>
				<div class="flex items-center gap-3 text-blue-600 mb-2">
					<div
						class="h-10 w-10 rounded-full bg-blue-50 flex items-center justify-center"
					>
						<Edit3 class="h-5 w-5" />
					</div>
					<DialogTitle class="text-xl">Bulk Edit Items</DialogTitle>
				</div>
				<DialogDescription>
					Updating
					<span class="font-bold text-foreground">{{ count }}</span> items
					simultaneously.
				</DialogDescription>
			</DialogHeader>

			<div class="space-y-6 py-4">
				<div class="space-y-2">
					<Label>Select Field to Update</Label>
					<Select v-model="selectedField">
						<SelectTrigger>
							<SelectValue placeholder="Choose a field..." />
						</SelectTrigger>
						<SelectContent>
							<SelectItem
								v-for="col in editableColumns"
								:key="col.key"
								:value="col.key"
							>
								{{ col.label }}
							</SelectItem>
						</SelectContent>
					</Select>
				</div>

				<div
					v-if="selectedField"
					class="space-y-2 animate-in fade-in slide-in-from-top-2 duration-300"
				>
					<Label>New Value</Label>

					<div
						v-if="currentFieldType === 'boolean'"
						class="flex items-center gap-3 p-3 border rounded-lg bg-muted/30"
					>
						<Switch v-model="newValue" />
						<span class="text-sm font-medium">{{
							newValue ? "Yes" : "No"
						}}</span>
					</div>

					<div v-else>
						<input
							v-model="newValue"
							type="text"
							class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
							placeholder="Enter new value..."
						/>
					</div>
				</div>

				<Alert class="bg-blue-50/50 border-blue-100">
					<Info class="h-4 w-4 text-blue-500" />
					<AlertDescription
						class="text-[10px] text-blue-700 leading-relaxed italic"
					>
						All selected items will have their
						<strong>{{ selectedField || "selected field" }}</strong> changed to
						<strong>{{ newValue === null ? "..." : newValue }}</strong
						>. This cannot be easily undone.
					</AlertDescription>
				</Alert>
			</div>

			<DialogFooter>
				<Button variant="ghost" @click="emit('close')" :disabled="isSaving"
					>Cancel</Button
				>
				<Button
					@click="handleConfirm"
					:disabled="!selectedField || isSaving"
					class="min-w-[120px]"
				>
					<Loader2 v-if="isSaving" class="mr-2 h-4 w-4 animate-spin" />
					{{ isSaving ? "Updating..." : "Apply Changes" }}
				</Button>
			</DialogFooter>
		</DialogContent>
	</Dialog>
</template>
