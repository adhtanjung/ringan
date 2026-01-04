<script setup lang="ts">
import { ref, onMounted } from "vue";
import {
	History,
	User,
	Calendar,
	ArrowRight,
	Loader2,
	Clock,
} from "lucide-vue-next";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { useSupabase } from "@/composables/useSupabase";

const props = defineProps<{
	isOpen: boolean;
	recordId: string;
	tableName: string;
}>();

const emit = defineEmits(["close"]);

const { supabase } = useSupabase();

const logs = ref<any[]>([]);
const isLoading = ref(false);

const fetchLogs = async () => {
	if (!props.recordId) return;

	isLoading.value = true;
	try {
		const { data, error } = await supabase
			.from("audit_log")
			.select("*")
			.eq("table_name", props.tableName)
			.eq("record_id", props.recordId)
			.order("changed_at", { ascending: false });

		if (error) throw error;
		logs.value = data || [];
	} catch (err) {
		console.error("Error fetching logs:", err);
	} finally {
		isLoading.value = false;
	}
};

watch(
	() => props.isOpen,
	(val) => {
		if (val) fetchLogs();
	}
);

const formatDate = (dateString: string) => {
	const date = new Date(dateString);
	return date.toLocaleString("en-US", {
		month: "short",
		day: "numeric",
		hour: "2-digit",
		minute: "2-digit",
	});
};

const getActionColor = (action: string) => {
	switch (action.toLowerCase()) {
		case "insert":
			return "bg-green-100 text-green-700 border-green-200";
		case "update":
			return "bg-blue-100 text-blue-700 border-blue-200";
		case "delete":
			return "bg-red-100 text-red-700 border-red-200";
		default:
			return "bg-gray-100 text-gray-700 border-gray-200";
	}
};
</script>

<template>
	<Dialog :open="isOpen" @update:open="(v) => !v && emit('close')">
		<DialogContent class="max-w-2xl h-[80vh] flex flex-col p-0">
			<DialogHeader class="p-6 pb-2">
				<div class="flex items-center gap-3 text-primary mb-2">
					<div
						class="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center"
					>
						<History class="h-5 w-5" />
					</div>
					<DialogTitle class="text-xl">Change History</DialogTitle>
				</div>
				<DialogDescription>
					Tracking all modifications to record
					<code class="bg-muted px-1.5 py-0.5 rounded text-[10px]">{{
						recordId
					}}</code>
				</DialogDescription>
			</DialogHeader>

			<div class="flex-1 overflow-hidden">
				<ScrollArea class="h-full">
					<div
						v-if="isLoading"
						class="flex flex-col items-center justify-center py-20 gap-3"
					>
						<Loader2 class="h-8 w-8 animate-spin text-muted-foreground" />
						<p class="text-sm text-muted-foreground">Loading audit trail...</p>
					</div>

					<div
						v-else-if="logs.length === 0"
						class="flex flex-col items-center justify-center py-20 opacity-50"
					>
						<Clock class="h-12 w-12 mb-4" />
						<p class="text-sm">No history found for this record</p>
					</div>

					<div v-else class="p-6 space-y-8">
						<div
							v-for="(log, index) in logs"
							:key="log.id"
							class="relative pl-8 border-l-2 border-muted last:border-l-0 pb-8 last:pb-0"
						>
							<!-- Timeline Dot -->
							<div
								class="absolute left-[-9px] top-0 h-4 w-4 rounded-full bg-background border-2 border-primary z-10"
							></div>

							<div class="space-y-3">
								<div class="flex items-center justify-between">
									<div class="flex items-center gap-2">
										<Badge
											variant="outline"
											:class="getActionColor(log.action)"
											class="text-[10px] font-bold uppercase tracking-widest px-1.5 h-5"
										>
											{{ log.action }}
										</Badge>
										<span class="text-xs font-semibold text-foreground/70">{{
											formatDate(log.changed_at)
										}}</span>
									</div>
									<div
										class="flex items-center gap-1 text-[10px] text-muted-foreground"
									>
										<User class="h-3 w-3" />
										{{ log.changed_by_email || "System" }}
									</div>
								</div>

								<div
									v-if="log.action === 'UPDATE'"
									class="bg-muted/30 rounded-lg p-4 space-y-3 border border-dashed"
								>
									<div class="flex items-center justify-between">
										<span
											class="text-xs font-bold text-muted-foreground uppercase tracking-wider"
											>{{ log.field_name }}</span
										>
									</div>
									<div
										class="grid grid-cols-1 sm:grid-cols-[1fr,auto,1fr] items-center gap-4"
									>
										<div
											class="p-2 rounded bg-red-50/50 border border-red-100 text-xs break-all"
										>
											<span
												class="text-[10px] uppercase font-bold text-red-400 block mb-1"
												>Before</span
											>
											{{ log.old_value || "(empty)" }}
										</div>
										<ArrowRight
											class="h-4 w-4 text-muted-foreground hidden sm:block"
										/>
										<div
											class="p-2 rounded bg-green-50/50 border border-green-100 text-xs break-all"
										>
											<span
												class="text-[10px] uppercase font-bold text-green-400 block mb-1"
												>After</span
											>
											{{ log.new_value || "(empty)" }}
										</div>
									</div>
								</div>

								<div v-else class="text-sm text-foreground/70 italic">
									Record was {{ log.action.toLowerCase() }}ed.
								</div>
							</div>
						</div>
					</div>
				</ScrollArea>
			</div>

			<div class="p-4 border-t bg-muted/20 flex justify-end">
				<Button variant="outline" size="sm" @click="emit('close')"
					>Close History</Button
				>
			</div>
		</DialogContent>
	</Dialog>
</template>
