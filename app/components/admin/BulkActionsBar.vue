<script setup lang="ts">
import {
	Trash2,
	Edit3,
	X,
	Download,
	MoreHorizontal,
} from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

const props = defineProps<{
	selectedCount: number;
	totalCount: number;
}>();

const emit = defineEmits([
	"clear",
	"delete",
	"edit",
	"export",
]);
</script>

<template>
	<div
		v-if="selectedCount > 0"
		class="fixed bottom-20 left-1/2 -translate-x-1/2 z-40 animate-in slide-in-from-bottom-4 duration-300"
	>
		<div
			class="bg-background border shadow-2xl rounded-full px-6 py-3 flex items-center gap-4 border-primary/20 bg-opacity-95 backdrop-blur-md"
		>
			<div class="flex items-center gap-3 pr-2 border-r">
				<div
					class="h-6 w-6 rounded-full bg-primary flex items-center justify-center text-[10px] font-bold text-primary-foreground"
				>
					{{ selectedCount }}
				</div>
				<div class="flex flex-col">
					<span class="text-xs font-bold leading-tight">Items Selected</span>
					<span class="text-[10px] text-muted-foreground leading-tight"
						>out of {{ totalCount }} total items</span
					>
				</div>
			</div>

			<div class="flex items-center gap-1">
				<Button
					variant="ghost"
					size="sm"
					class="h-9 px-3 text-xs gap-2 hover:bg-muted font-medium"
					@click="emit('edit')"
				>
					<Edit3 class="h-3.5 w-3.5 text-blue-500" />
					Bulk Edit
				</Button>

				<DropdownMenu>
					<DropdownMenuTrigger as-child>
						<Button
							variant="ghost"
							size="sm"
							class="h-9 px-3 text-xs gap-2 hover:bg-muted font-medium"
						>
							<MoreHorizontal class="h-3.5 w-3.5" />
							More
						</Button>
					</DropdownMenuTrigger>
					<DropdownMenuContent align="end" class="w-48">
					<DropdownMenuItem @click="emit('export')" class="gap-2">
						<Download class="h-4 w-4 text-blue-500" />
						Export Selection
						</DropdownMenuItem>
					</DropdownMenuContent>
				</DropdownMenu>

				<Separator orientation="vertical" class="h-6 mx-1" />

				<Button
					variant="ghost"
					size="sm"
					class="h-9 px-3 text-xs gap-2 text-red-600 hover:text-red-700 hover:bg-red-50 font-semibold"
					@click="emit('delete')"
				>
					<Trash2 class="h-3.5 w-3.5" />
					Delete
				</Button>
			</div>

			<Separator orientation="vertical" class="h-6" />

			<Button
				variant="ghost"
				size="icon"
				class="h-8 w-8 rounded-full hover:bg-muted"
				@click="emit('clear')"
				title="Clear Selection"
			>
				<X class="h-4 w-4" />
			</Button>
		</div>
	</div>
</template>

<style scoped>
.shadow-2xl {
	box-shadow: 0 10px 40px -10px rgba(0, 0, 0, 0.3);
}
</style>
