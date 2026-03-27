<script setup lang="ts">
import { computed, onMounted, ref } from "vue";
import {
	AlertCircle,
	ArrowRight,
	CheckCircle2,
	Database,
	LayoutGrid,
	Layers,
	MessageSquare,
	RefreshCw,
	Zap,
} from "lucide-vue-next";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import { Button } from "@/components/ui/button";
import { useToast } from "@/components/ui/toast/use-toast";
import { datasetLabels } from "@/composables/useDatasetManagement";
import { useSupabase } from "@/composables/useSupabase";

interface DatasetUpdate {
	id: string;
	name: string;
	updated_at: string;
	type: string;
}

interface ActiveTypeStats {
	active: number;
	recent_updates: DatasetUpdate[];
}

interface AttentionStats {
	feedbackPromptsMissingPromptId: number;
	emptyNextActionText: number;
	emptySuggestionText: number;
}

interface DashboardStats {
	overall: {
		active_records: number;
		last_updated: string;
	};
	by_type: Record<string, ActiveTypeStats>;
	recent_activity: DatasetUpdate[];
	attention: AttentionStats;
	timestamp: string;
}

const DATASET_CONFIG = [
	{
		key: "problems",
		icon: Layers,
		route: "/problems",
		colorClass: "text-blue-600 dark:text-blue-400",
	},
	{
		key: "assessments",
		icon: Zap,
		route: "/assessments",
		colorClass: "text-amber-600 dark:text-amber-400",
	},
	{
		key: "problem_types",
		icon: LayoutGrid,
		route: "/problem-types",
		colorClass: "text-indigo-600 dark:text-indigo-400",
	},
	{
		key: "suggestions",
		icon: MessageSquare,
		route: "/suggestions",
		colorClass: "text-emerald-600 dark:text-emerald-400",
	},
] as const;

const NAME_FIELDS: Record<string, string> = {
	problems: "problem_name",
	assessments: "question_text",
	problem_types: "type_name",
	suggestions: "suggestion_text",
	feedback_prompts: "prompt_text",
	next_actions: "action_text",
	training_examples: "problem",
};

const QUICK_ACTIONS = [
	{ label: "Manage Suggestions", route: "/suggestions" },
	{ label: "Manage Assessments", route: "/assessments" },
];

const buildEmptyByType = (): Record<string, ActiveTypeStats> => {
	const result: Record<string, ActiveTypeStats> = {};
	DATASET_CONFIG.forEach((dataset) => {
		result[dataset.key] = { active: 0, recent_updates: [] };
	});
	return result;
};

const normalizeRecentUpdates = (value: unknown): DatasetUpdate[] => {
	if (!Array.isArray(value)) return [];
	return value.map((row: any) => ({
		id: String(row?.id ?? ""),
		name: String(row?.name ?? row?.id ?? "-"),
		updated_at: String(row?.updated_at ?? ""),
		type: String(row?.type ?? ""),
	}));
};

const normalizeDashboardStats = (value: unknown): DashboardStats | null => {
	const payload: any = Array.isArray(value) ? value[0] : value;
	if (!payload || typeof payload !== "object") return null;

	const byType = buildEmptyByType();
	DATASET_CONFIG.forEach((dataset) => {
		const rawType = payload?.by_type?.[dataset.key];
		if (!rawType || typeof rawType !== "object") return;
		byType[dataset.key] = {
			active: Number(rawType.active) || 0,
			recent_updates: normalizeRecentUpdates(rawType.recent_updates),
		};
	});

	const attention = payload?.attention || {};
	const timestamp = new Date().toISOString();

	return {
		overall: {
			active_records: Number(payload?.overall?.active_records) || 0,
			last_updated: String(payload?.overall?.last_updated || timestamp),
		},
		by_type: byType,
		recent_activity: normalizeRecentUpdates(payload?.recent_activity),
		attention: {
			feedbackPromptsMissingPromptId:
				Number(attention.feedbackPromptsMissingPromptId) || 0,
			emptyNextActionText: Number(attention.emptyNextActionText) || 0,
			emptySuggestionText: Number(attention.emptySuggestionText) || 0,
		},
		timestamp: String(payload?.timestamp || timestamp),
	};
};

const { supabase } = useSupabase();
const { toast } = useToast();

const loading = ref(true);
const error = ref<string | null>(null);
const dashboardData = ref<DashboardStats | null>(null);

const fetchDashboardData = async () => {
	loading.value = true;
	error.value = null;

	try {
		const { data: rpcData, error: rpcError } = await supabase.rpc(
			"get_admin_dashboard_active_stats",
		);
		if (!rpcError) {
			const normalized = normalizeDashboardStats(rpcData);
			if (normalized) {
				dashboardData.value = normalized;
				return;
			}
		} else {
			console.warn(
				"RPC get_admin_dashboard_active_stats unavailable, using fallback dashboard queries:",
				rpcError.message,
			);
		}

		const stats: DashboardStats = {
			overall: {
				active_records: 0,
				last_updated: new Date().toISOString(),
			},
			by_type: buildEmptyByType(),
			recent_activity: [],
			attention: {
				feedbackPromptsMissingPromptId: 0,
				emptyNextActionText: 0,
				emptySuggestionText: 0,
			},
			timestamp: new Date().toISOString(),
		};

		const tableQueries = DATASET_CONFIG.map(async (dataset) => {
			const type = dataset.key;
			const nameField = NAME_FIELDS[type] || "id";
			const { data: recentData, count, error: datasetError } = await (
				supabase
					.from(type)
					.select(`id, ${nameField}, updated_at`, { count: "exact" }) as any
			)
				.eq("is_active", true)
				.order("updated_at", { ascending: false })
				.limit(5);

			if (datasetError) throw datasetError;

			const active = count || 0;
			const updates = (recentData || []).map((item: any) => ({
				id: item.id,
				name: item[nameField] || item.id,
				updated_at: item.updated_at,
				type,
			}));

			stats.by_type[type] = {
				active,
				recent_updates: updates,
			};
			stats.overall.active_records += active;
		});

		await Promise.all(tableQueries);

		const [
			{ count: missingPromptIdCount, error: missingPromptIdError },
			{ count: emptyActionTextCount, error: actionTextError },
			{ count: emptySuggestionTextCount, error: suggestionTextError },
		] = await Promise.all([
			supabase
				.from("feedback_prompts")
				.select("*", { count: "exact", head: true })
				.eq("is_active", true)
				.or("prompt_id.is.null,prompt_id.eq."),
			supabase
				.from("next_actions")
				.select("*", { count: "exact", head: true })
				.eq("is_active", true)
				.or("action_text.is.null,action_text.eq."),
			supabase
				.from("suggestions")
				.select("*", { count: "exact", head: true })
				.eq("is_active", true)
				.or("suggestion_text.is.null,suggestion_text.eq."),
		]);

		if (missingPromptIdError) throw missingPromptIdError;
		if (actionTextError) throw actionTextError;
		if (suggestionTextError) throw suggestionTextError;

		stats.attention = {
			feedbackPromptsMissingPromptId: missingPromptIdCount || 0,
			emptyNextActionText: emptyActionTextCount || 0,
			emptySuggestionText: emptySuggestionTextCount || 0,
		};

		let maxUpdatedAt = "";
		Object.values(stats.by_type).forEach((typeStats) => {
			typeStats.recent_updates.forEach((update) => {
				if (update.updated_at && update.updated_at > maxUpdatedAt) {
					maxUpdatedAt = update.updated_at;
				}
			});
		});
		stats.overall.last_updated = maxUpdatedAt || stats.timestamp;
		stats.recent_activity = Object.values(stats.by_type)
			.flatMap((typeStats) => typeStats.recent_updates)
			.sort(
				(a, b) =>
					new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime(),
			)
			.slice(0, 10);

		dashboardData.value = stats;
	} catch (err: any) {
		console.error("Dashboard Fetch Error:", err);
		error.value = err?.message || "Failed to load dashboard data";
		toast({
			title: "Could not refresh dashboard",
			description:
				"There was a problem loading active records. Please try again.",
			variant: "destructive",
		});
	} finally {
		loading.value = false;
	}
};

const formatNumber = (num: number) =>
	numberFormatter.format(num || 0);

const numberFormatter = new Intl.NumberFormat("en-US");
const dateTimeFormatter = new Intl.DateTimeFormat("en-US", {
	month: "short",
	day: "numeric",
	hour: "numeric",
	minute: "numeric",
});

const formatDateRelative = (dateString: string) => {
	if (!dateString) return "N/A";
	const date = new Date(dateString);
	if (isNaN(date.getTime())) return "N/A";
	const now = new Date();
	const diffInSeconds = Math.floor((now.getTime() - date.getTime()) / 1000);

	if (diffInSeconds < 60) return "Just now";
	if (diffInSeconds < 3600) return `${Math.floor(diffInSeconds / 60)} min ago`;
	if (diffInSeconds < 86400) return `${Math.floor(diffInSeconds / 3600)} hr ago`;
	return dateTimeFormatter.format(date);
};

const getTypeLabel = (typeKey: string) =>
	(datasetLabels as any)[typeKey] || typeKey;

const activeCards = computed(() =>
	DATASET_CONFIG.map((dataset) => ({
		...dataset,
		label: getTypeLabel(dataset.key),
		active: dashboardData.value?.by_type[dataset.key]?.active || 0,
	})),
);

const recentActivity = computed(() => {
	return dashboardData.value?.recent_activity || [];
});

const attentionItems = computed(() => {
	if (!dashboardData.value) return [];
	const attention = dashboardData.value.attention;
	return [
		{
			key: "empty-suggestions",
			label: "Suggestions missing suggestion text",
			count: attention.emptySuggestionText,
			description: "Active suggestion records have empty suggestion_text.",
			route: "/suggestions",
		},
	].filter((item) => item.count > 0);
});

const isEmptyActive = computed(
	() =>
		dashboardData.value !== null && dashboardData.value.overall.active_records === 0,
);

onMounted(() => {
	fetchDashboardData();
});
</script>

<template>
	<div class="min-h-screen w-full max-w-screen overflow-x-hidden bg-muted/25">
		<div
			class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8"
		>
			<DatasetPageHeader
				eyebrow="Overview"
				title="Dashboard"
				description="Monitor active records, recent updates, and items that need attention."
				:total="dashboardData?.overall.active_records ?? null"
				total-label="active records"
			>
				<template #actions>
					<Button
						@click="fetchDashboardData"
						:disabled="loading"
						variant="outline"
						class="h-11 gap-2 px-4 text-sm font-medium"
					>
						<RefreshCw class="w-4 h-4" :class="{ 'animate-spin': loading }" />
						Refresh
					</Button>
				</template>
			</DatasetPageHeader>

			<div class="space-y-12">
				<div
					v-if="error"
					class="flex items-start justify-between gap-4 rounded-2xl border border-destructive/20 bg-destructive/10 p-5 text-destructive min-h-[44px]"
				>
					<div class="flex items-start gap-3">
						<AlertCircle class="w-6 h-6 shrink-0 mt-0.5" />
						<div>
							<p class="font-semibold text-lg leading-snug">
								Unable to load active dashboard data
							</p>
							<p class="text-base mt-1 opacity-80">{{ error }}</p>
						</div>
					</div>
					<Button
						@click="fetchDashboardData"
						class="h-11 shrink-0 px-4 text-sm font-medium"
					>
						Try again
					</Button>
				</div>

				<div
					v-if="loading"
					class="animate-pulse space-y-10"
					aria-busy="true"
					aria-label="Loading dashboard data"
				>
					<div
						class="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
					>
						<div v-for="i in 8" :key="i" class="h-28 rounded-2xl bg-muted" />
					</div>
					<div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
						<div class="h-72 rounded-2xl bg-muted" />
						<div class="h-72 rounded-2xl bg-muted" />
					</div>
				</div>

				<div
					v-else-if="isEmptyActive"
					class="flex flex-col items-center justify-center gap-6 py-24 text-center"
				>
					<div class="flex h-16 w-16 items-center justify-center rounded-full bg-muted">
						<Database class="w-8 h-8 text-muted-foreground" />
					</div>
					<div class="space-y-2 max-w-md">
						<h2 class="text-2xl font-semibold text-foreground">
							No active data yet
						</h2>
						<p class="text-base text-muted-foreground">
							Start by creating active records in one of your core datasets.
						</p>
					</div>
					<div class="mt-2 flex flex-wrap justify-center gap-3">
						<NuxtLink
							v-for="action in QUICK_ACTIONS"
							:key="action.route"
							:to="action.route"
							class="inline-flex h-12 items-center gap-2 rounded-xl border border-border/70 bg-card px-5 text-base font-medium transition-colors hover:bg-muted/50 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2"
						>
							{{ action.label }}
						</NuxtLink>
					</div>
				</div>

				<div v-else-if="dashboardData" class="space-y-10 animate-in fade-in duration-500">
					<section aria-labelledby="active-datasets-heading">
						<h2
							id="active-datasets-heading"
							class="mb-6 text-sm font-semibold uppercase tracking-widest text-foreground/80"
						>
							Active Datasets
						</h2>
						<div
							class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
						>
							<NuxtLink
								v-for="card in activeCards"
								:key="card.key"
								:to="card.route"
								class="group rounded-2xl border border-border/70 bg-card p-5 transition-colors hover:border-primary/50 hover:bg-muted/30 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-inset"
							>
								<div class="flex items-center justify-between gap-3">
									<div class="flex items-center gap-2 min-w-0">
										<component
											:is="card.icon"
											class="h-4 w-4 shrink-0"
											:class="card.colorClass"
										/>
										<span class="truncate text-sm font-medium text-foreground/80">{{
											card.label
										}}</span>
									</div>
									<ArrowRight
										class="h-4 w-4 shrink-0 text-foreground/40 transition-all group-hover:translate-x-0.5 group-hover:text-primary"
									/>
								</div>
								<div class="mt-4 text-3xl font-semibold tabular-nums text-foreground">
									{{ formatNumber(card.active) }}
								</div>
								<p class="mt-1 text-sm text-muted-foreground">active records</p>
							</NuxtLink>
						</div>
					</section>

					<div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
						<section class="rounded-2xl border border-border/70 bg-card p-5">
							<h2 class="text-lg font-semibold text-foreground">Needs Attention</h2>

							<div v-if="attentionItems.length === 0" class="mt-6 flex items-start gap-3">
								<CheckCircle2 class="h-5 w-5 shrink-0 text-emerald-600 dark:text-emerald-400 mt-0.5" />
								<div>
									<p class="text-sm font-medium text-foreground">
										No active data issues detected
									</p>
									<p class="text-sm text-muted-foreground mt-1">
										All monitored active records look healthy.
									</p>
								</div>
							</div>

							<div v-else class="mt-4 space-y-3">
								<NuxtLink
									v-for="item in attentionItems"
									:key="item.key"
									:to="item.route"
									class="block rounded-xl border border-border/70 p-4 transition-colors hover:border-primary/50 hover:bg-muted/20"
								>
									<div class="flex items-start justify-between gap-3">
										<div class="min-w-0">
											<p class="text-sm font-medium text-foreground">
												{{ item.label }}
											</p>
											<p class="mt-1 text-sm text-muted-foreground">
												{{ item.description }}
											</p>
										</div>
										<div class="text-lg font-semibold tabular-nums text-destructive">
											{{ item.count }}
										</div>
									</div>
								</NuxtLink>
							</div>
						</section>

						<section class="rounded-2xl border border-border/70 bg-card p-5">
							<h2 class="text-lg font-semibold text-foreground">Recent Changes</h2>

							<div v-if="recentActivity.length > 0" class="mt-4 space-y-1">
								<div
									v-for="update in recentActivity"
									:key="update.id + '-' + update.type"
									class="group flex flex-col justify-between border-b border-border/50 py-3 last:border-0 sm:flex-row sm:items-center"
								>
									<div class="mb-1 min-w-0 sm:mb-0">
										<div
											class="truncate pr-4 text-sm font-medium text-foreground transition-colors group-hover:text-primary"
										>
											{{ update.name }}
										</div>
										<div class="mt-0.5 text-xs font-medium text-foreground/60">
											{{ getTypeLabel(update.type) }}
										</div>
									</div>
									<div class="whitespace-nowrap tabular-nums text-xs text-foreground/60">
										{{ formatDateRelative(update.updated_at) }}
									</div>
								</div>
							</div>

							<div v-else class="mt-5 text-sm text-muted-foreground">
								No recent updates in active records yet.
							</div>
						</section>
					</div>

					<section class="rounded-2xl border border-border/70 bg-card p-5">
						<h2 class="text-lg font-semibold text-foreground">Quick Actions</h2>
						<div class="mt-4 flex flex-wrap gap-3">
							<NuxtLink
								v-for="action in QUICK_ACTIONS"
								:key="action.route"
								:to="action.route"
								class="inline-flex h-11 items-center rounded-xl border border-border/70 px-4 text-sm font-medium transition-colors hover:bg-muted/30 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2"
							>
								{{ action.label }}
							</NuxtLink>
						</div>
					</section>

					<div class="text-sm text-muted-foreground">
						Showing active records only. Last updated
						<span class="font-medium text-foreground">
							{{ formatDateRelative(dashboardData.overall.last_updated) }}
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<style scoped>
@reference "../assets/css/tailwind.css";

@media (prefers-reduced-motion: reduce) {
	.animate-pulse {
		animation: none;
		opacity: 0.7;
	}
	.animate-in {
		animation: none !important;
	}
}

.animate-pulse {
	animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
	0%,
	100% {
		opacity: 1;
	}
	50% {
		opacity: 0.5;
	}
}
</style>
