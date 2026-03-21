<script setup lang="ts">
import { computed, ref } from "vue";
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
import { Label } from "@/components/ui/label";

const props = defineProps<{
	isOpen: boolean;
	count: number;
	isDeleting: boolean;
}>();

const emit = defineEmits(["close", "confirm"]);

const confirmationInputId = "bulk-delete-confirmation";
const confirmationHelpId = "bulk-delete-confirmation-help";
const confirmationWarningId = "bulk-delete-confirmation-warning";
const confirmationMessageId = "bulk-delete-confirmation-message";

const confirmationText = ref("");
const normalizedConfirmationText = computed(() =>
	confirmationText.value.trim().replace(/\s+/g, " ").toUpperCase(),
);
const isValid = computed(() =>
	["DELETE", "DELETE ALL", "DELETE ALL ITEMS"].includes(
		normalizedConfirmationText.value,
	),
);
const confirmationError = computed(() =>
	confirmationText.value && !isValid.value
		? "Type DELETE or DELETE ALL to confirm."
		: "",
);

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
		<DialogContent class="max-w-lg max-h-[90dvh] overflow-y-auto">
			<DialogHeader>
				<div class="mb-2 flex items-center gap-3 text-destructive">
					<div
						class="flex h-11 w-11 items-center justify-center rounded-full bg-destructive/10 text-destructive"
					>
						<Trash2 class="h-5 w-5" aria-hidden="true" />
					</div>
					<DialogTitle class="text-lg font-semibold leading-tight sm:text-xl">
						Bulk Delete Items
					</DialogTitle>
				</div>
				<div class="space-y-5 text-foreground/80">
					<DialogDescription class="text-base leading-6">
						You are about to delete
						<span class="font-bold text-foreground">{{ count }}</span> items.
						This action is permanent and cannot be undone.
					</DialogDescription>

					<Alert
						variant="destructive"
						class="border-destructive/20 bg-destructive/5"
					>
						<AlertTriangle class="h-4 w-4" aria-hidden="true" />
						<AlertDescription
							:id="confirmationWarningId"
							class="text-base leading-6 font-medium"
						>
							Deleting these items may affect related data and analytics.
						</AlertDescription>
					</Alert>

					<div class="space-y-3 pt-1">
						<Label
							:for="confirmationInputId"
							class="text-sm font-semibold leading-6 text-foreground"
						>
							Type
							<span
								class="inline-flex rounded-md border border-destructive/20 bg-destructive/5 px-2 py-0.5 font-mono text-xs font-semibold uppercase tracking-[0.18em] text-destructive"
							>
								DELETE ALL
							</span>
							to confirm
						</Label>
						<p :id="confirmationHelpId" class="text-base leading-6 text-muted-foreground">
							This dialog accepts DELETE or DELETE ALL.
						</p>
						<Input
							:id="confirmationInputId"
							v-model="confirmationText"
							placeholder="Type DELETE ALL..."
							autocomplete="off"
							autocapitalize="characters"
							spellcheck="false"
							inputmode="text"
							:aria-describedby="
								`${confirmationHelpId} ${confirmationWarningId} ${confirmationMessageId}`
							"
							:aria-invalid="Boolean(confirmationError)"
							class="h-11 border-destructive/20 uppercase font-mono text-center tracking-[0.2em] text-foreground focus-visible:border-destructive focus-visible:ring-destructive/20"
							:disabled="isDeleting"
							@keyup.enter="handleConfirm"
						/>
						<p
							v-if="confirmationError"
							:id="confirmationMessageId"
							class="text-sm font-medium text-destructive"
						>
							{{ confirmationError }}
						</p>
					</div>
				</div>
			</DialogHeader>

			<DialogFooter class="mt-6 flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
				<Button
					variant="ghost"
					@click="handleClose"
					:disabled="isDeleting"
					class="h-11 w-full sm:w-auto"
				>
					Cancel
				</Button>
				<Button
					variant="destructive"
					@click="handleConfirm"
					:disabled="!isValid || isDeleting"
					class="h-11 w-full min-w-[140px] sm:w-auto"
				>
					<Loader2 v-if="isDeleting" class="mr-2 h-4 w-4 animate-spin" />
					{{ isDeleting ? "Deleting..." : "Confirm Delete" }}
				</Button>
			</DialogFooter>
		</DialogContent>
	</Dialog>
</template>
