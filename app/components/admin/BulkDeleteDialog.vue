<script setup lang="ts">
import { ref, watch } from "vue";
import { AlertTriangle, Trash2, Loader2 } from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { Alert, AlertDescription } from "@/components/ui/alert";

const props = defineProps<{
	isOpen: boolean;
	count: number;
	isDeleting: boolean;
}>();

const emit = defineEmits(["close", "confirm"]);

const confirmationText = ref("");
const isValid = ref(false);

watch(confirmationText, (val) => {
	isValid.value = val.toUpperCase() === "DELETE";
});

const handleClose = () => {
	confirmationText.value = "";
	emit("close");
};

const handleConfirm = () => {
	if (isValid.value) {
		emit("confirm");
	}
};
</script>

<template>
	<Dialog :open="isOpen" @update:open="(v: boolean) => !v && handleClose()">
		<DialogContent class="max-w-md">
			<DialogHeader>
				<div class="flex items-center gap-3 text-red-600 mb-2">
					<div
						class="h-10 w-10 rounded-full bg-red-50 flex items-center justify-center"
					>
						<Trash2 class="h-5 w-5" />
					</div>
					<DialogTitle class="text-xl">Bulk Delete Items</DialogTitle>
				</div>
				<div class="text-foreground/80 space-y-4">
					<DialogDescription>
						You are about to delete
						<span class="font-bold text-foreground">{{ count }}</span> items.
						This action is permanent and cannot be undone.
					</DialogDescription>

					<Alert
						variant="destructive"
						class="bg-red-50 border-red-200 text-red-800"
					>
						<AlertTriangle class="h-4 w-4" />
						<AlertDescription class="text-xs font-medium">
							Deleting these items may affect related data and analytics.
						</AlertDescription>
					</Alert>

					<div class="space-y-3 pt-2">
						<label
							class="text-sm font-semibold flex items-center gap-2 text-foreground"
						>
							Type
							<span class="px-2 py-0.5 rounded bg-muted font-mono text-xs"
								>DELETE</span
							>
							to confirm
						</label>
						<Input
							v-model="confirmationText"
							placeholder="Type DELETE..."
							class="border-red-200 focus-visible:ring-red-500 uppercase font-mono text-center tracking-widest text-foreground"
							:disabled="isDeleting"
							@keyup.enter="handleConfirm"
						/>
					</div>
				</div>
			</DialogHeader>

			<DialogFooter class="mt-6 flex flex-row gap-2 justify-end">
				<Button variant="ghost" @click="handleClose" :disabled="isDeleting">
					Cancel
				</Button>
				<Button
					variant="destructive"
					@click="handleConfirm"
					:disabled="!isValid || isDeleting"
					class="min-w-[120px]"
				>
					<Loader2 v-if="isDeleting" class="mr-2 h-4 w-4 animate-spin" />
					{{ isDeleting ? "Deleting..." : "Confirm Delete" }}
				</Button>
			</DialogFooter>
		</DialogContent>
	</Dialog>
</template>
