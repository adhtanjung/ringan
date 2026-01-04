<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useToast } from "@/components/ui/toast/use-toast";
import { datasetLabels } from "@/composables/useDatasetManagement";
import { useSupabase } from "@/composables/useSupabase";
import {
	VisXYContainer,
	VisStackedBar,
	VisAxis,
	VisTooltip,
	VisDonut,
	VisSingleContainer,
} from "@unovis/vue";
import { Donut } from "@unovis/ts";
import {
	LayoutDashboard,
	RefreshCw,
	Database,
	Activity,
	Zap,
	Clock,
	AlertCircle,
	CheckCircle2,
	FileText,
} from "lucide-vue-next";

// --- Types ---
interface DashboardStats {
	overall: {
		problems_count: number;
		assessment_questions_count: number;
		suggestions_count: number;
		feedback_prompts_count: number;
		next_actions_count: number;
		training_examples_count: number;
		last_updated: string;
	};
	by_type: {
		[key: string]: {
			total: number;
			active: number;
			inactive: number;
			domain_breakdown?: { [key: string]: number };
			recent_updates: Array<{
				id: string;
				name: string;
				updated_at: string;
				type: string; // Added type here for the unified feed
			}>;
		};
	};
	timestamp: string;
}

// --- Composables ---
const { supabase } = useSupabase();
const { toast } = useToast();

// --- State ---
const loading = ref(true);
const error = ref<string | null>(null);
const dashboardData = ref<DashboardStats | null>(null);

const datasetTypes = [
	"problems",
	"assessments",
	"suggestions",
	"feedback_prompts",
	"next_actions",
	"training_examples",
	"problem_types",
];

// --- Data Fetching ---
const fetchDashboardData = async () => {
	loading.value = true;
	error.value = null;

	try {
		const stats: DashboardStats = {
			overall: {
				problems_count: 0,
				assessment_questions_count: 0,
				suggestions_count: 0,
				feedback_prompts_count: 0,
				next_actions_count: 0,
				training_examples_count: 0,
				last_updated: new Date().toISOString(),
			},
			by_type: {},
			timestamp: new Date().toISOString(),
		};

		const tableQueries = datasetTypes.map(async (type) => {
			// 1. Get counts
			const [totalRes, activeRes] = await Promise.all([
				supabase.from(type).select("*", { count: "exact", head: true }),
				supabase
					.from(type)
					.select("*", { count: "exact", head: true })
					.eq("is_active", true),
			]);

			// 2. Get recent updates
			let nameField = "id";
			if (type === "problems") nameField = "problem_name";
			else if (type === "assessments") nameField = "question_text";
			else if (type === "problem_types") nameField = "type_name";
			else if (type === "suggestions") nameField = "suggestion_text";
			else if (type === "feedback_prompts") nameField = "prompt_text";
			else if (type === "next_actions") nameField = "action_text";
			else if (type === "training_examples") nameField = "problem";

			const { data: recentData } = await (
				supabase.from(type).select(`id, ${nameField}, updated_at`) as any
			)
				.order("updated_at", { ascending: false })
				.limit(5);

			// 3. Domain breakdown
			let domainBreakdown = {};
			if (type === "problems") {
				const { data: categories } = await supabase
					.from("problems")
					.select("category");
				if (categories) {
					domainBreakdown = categories.reduce((acc: any, curr: any) => {
						const cat = curr.category || "Uncategorized";
						acc[cat] = (acc[cat] || 0) + 1;
						return acc;
					}, {});
				}
			}

			const total = totalRes.count || 0;
			const active = activeRes.count || 0;

			stats.by_type[type] = {
				total,
				active,
				inactive: total - active,
				domain_breakdown: domainBreakdown,
				recent_updates: (recentData || []).map((item: any) => ({
					id: item.id,
					name: item[nameField] || item.id,
					updated_at: item.updated_at,
					type: type, // Inject type for the feed
				})),
			};

			// Map to overall counts
			if (type === "problems") stats.overall.problems_count = total;
			if (type === "assessments")
				stats.overall.assessment_questions_count = total;
			if (type === "suggestions") stats.overall.suggestions_count = total;
			if (type === "feedback_prompts")
				stats.overall.feedback_prompts_count = total;
			if (type === "next_actions") stats.overall.next_actions_count = total;
			if (type === "training_examples")
				stats.overall.training_examples_count = total;
		});

		await Promise.all(tableQueries);

		// Calculate generic last updated
		let maxDate = new Date(0).toISOString();
		Object.values(stats.by_type).forEach((typeStats) => {
			typeStats.recent_updates.forEach((u) => {
				if (u.updated_at > maxDate) maxDate = u.updated_at;
			});
		});
		stats.overall.last_updated = maxDate;

		dashboardData.value = stats;
	} catch (err: any) {
		console.error("Error fetching dashboard data:", err);
		error.value = err?.message || "Failed to load dashboard data";
		toast({
			title: "Error",
			description: error.value || "An unknown error occurred",
			variant: "destructive",
		});
	} finally {
		loading.value = false;
	}
};

// --- Computed & Formatting ---

const formatNumber = (num: number) =>
	new Intl.NumberFormat("en-US").format(num);

const formatDateRelative = (dateString: string) => {
	if (!dateString) return "N/A";
	const date = new Date(dateString);
	const now = new Date();
	const diffInSeconds = Math.floor((now.getTime() - date.getTime()) / 1000);

	if (diffInSeconds < 60) return "Just now";
	if (diffInSeconds < 3600) return `${Math.floor(diffInSeconds / 60)}m ago`;
	if (diffInSeconds < 86400) return `${Math.floor(diffInSeconds / 3600)}h ago`;
	return new Intl.DateTimeFormat("en-US", {
		month: "short",
		day: "numeric",
	}).format(date);
};

// 1. Totals Logic
const totalItems = computed(() => {
	if (!dashboardData.value?.by_type) return 0;
	return Object.values(dashboardData.value.by_type).reduce(
		(acc, curr) => acc + curr.total,
		0
	);
});

const totalActive = computed(() => {
	if (!dashboardData.value?.by_type) return 0;
	return Object.values(dashboardData.value.by_type).reduce(
		(acc, curr) => acc + curr.active,
		0
	);
});

const activeRate = computed(() => {
	if (totalItems.value === 0) return 0;
	return Math.round((totalActive.value / totalItems.value) * 100);
});

// 2. Main Bar Chart Data
const barChartData = computed(() => {
	if (!dashboardData.value) return [];
	return datasetTypes.map((type) => {
		const data = dashboardData.value?.by_type[type];
		return {
			type: (datasetLabels as any)[type] || type,
			active: data?.active || 0,
			inactive: data?.inactive || 0,
		};
	});
});

const xAccessor = (d: any) => d.type;
const yAccessors = [(d: any) => d.active, (d: any) => d.inactive];

// 3. Donut Chart Data (Problems)
const donutData = computed(() => {
	const breakdown =
		dashboardData.value?.by_type["problems"]?.domain_breakdown || {};
	return Object.entries(breakdown).map(([key, value]) => ({ key, value }));
});
const donutValue = (d: any) => d.value;
const donutLabel = (d: any) => d.key;

// 4. Unified Activity Feed
const unifiedFeed = computed(() => {
	if (!dashboardData.value) return [];
	const allUpdates: any[] = [];

	Object.values(dashboardData.value.by_type).forEach((type) => {
		allUpdates.push(...type.recent_updates);
	});

	return allUpdates
		.sort(
			(a, b) =>
				new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime()
		)
		.slice(0, 10); // Show top 10 most recent across all types
});

const getTypeLabel = (typeKey: string) =>
	(datasetLabels as any)[typeKey] || typeKey;

onMounted(() => {
	fetchDashboardData();
});
</script>

<template>
	<div class="min-h-screen bg-background pb-12 text-foreground">
		<div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 space-y-8">
			<div
				class="flex flex-col sm:flex-row sm:items-center justify-between gap-4"
			>
				<div>
					<h1 class="text-3xl font-bold tracking-tight">Dataset Overview</h1>
					<p class="text-muted-foreground mt-1">
						Real-time insights into dataset quality and volume.
					</p>
				</div>
				<div class="flex items-center gap-3">
					<div
						v-if="dashboardData"
						class="hidden sm:block text-xs text-right text-muted-foreground mr-2"
					>
						<p>Last synced</p>
						<p class="font-medium text-foreground">
							{{ formatDateRelative(dashboardData.overall.last_updated) }}
						</p>
					</div>
					<button
						@click="fetchDashboardData"
						:disabled="loading"
						class="inline-flex items-center gap-2 px-4 py-2 rounded-md bg-primary text-primary-foreground hover:bg-primary/90 transition-all shadow-sm disabled:opacity-50"
					>
						<RefreshCw class="h-4 w-4" :class="{ 'animate-spin': loading }" />
						<span>{{ loading ? "Syncing..." : "Refresh" }}</span>
					</button>
				</div>
			</div>

			<div
				v-if="error"
				class="rounded-lg border border-destructive/50 bg-destructive/10 p-4 text-destructive flex items-center gap-3"
			>
				<AlertCircle class="h-5 w-5" />
				<p>{{ error }}</p>
			</div>

			<div
				v-if="dashboardData && !loading"
				class="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-500"
			>
				<div class="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
					<div
						class="rounded-xl border bg-card text-card-foreground shadow-sm p-6"
					>
						<div class="flex items-center justify-between space-y-0 pb-2">
							<p class="text-sm font-medium text-muted-foreground">
								Total Datasets
							</p>
							<Database class="h-4 w-4 text-muted-foreground" />
						</div>
						<div class="text-2xl font-bold">{{ formatNumber(totalItems) }}</div>
						<p class="text-xs text-muted-foreground mt-1">
							+{{ formatNumber(dashboardData.overall.problems_count) }} problems
						</p>
					</div>

					<div
						class="rounded-xl border bg-card text-card-foreground shadow-sm p-6"
					>
						<div class="flex items-center justify-between space-y-0 pb-2">
							<p class="text-sm font-medium text-muted-foreground">
								Active Usage
							</p>
							<Activity class="h-4 w-4 text-emerald-500" />
						</div>
						<div class="text-2xl font-bold">{{ activeRate }}%</div>
						<div
							class="w-full bg-secondary h-1.5 rounded-full mt-2 overflow-hidden"
						>
							<div
								class="bg-emerald-500 h-full transition-all duration-1000"
								:style="{ width: `${activeRate}%` }"
							></div>
						</div>
					</div>

					<div
						class="rounded-xl border bg-card text-card-foreground shadow-sm p-6"
					>
						<div class="flex items-center justify-between space-y-0 pb-2">
							<p class="text-sm font-medium text-muted-foreground">
								Active Items
							</p>
							<CheckCircle2 class="h-4 w-4 text-muted-foreground" />
						</div>
						<div class="text-2xl font-bold">
							{{ formatNumber(totalActive) }}
						</div>
						<p class="text-xs text-muted-foreground mt-1">
							Available for production
						</p>
					</div>

					<div
						class="rounded-xl border bg-card text-card-foreground shadow-sm p-6"
					>
						<div class="flex items-center justify-between space-y-0 pb-2">
							<p class="text-sm font-medium text-muted-foreground">
								Draft / Inactive
							</p>
							<Clock class="h-4 w-4 text-orange-500" />
						</div>
						<div class="text-2xl font-bold">
							{{ formatNumber(totalItems - totalActive) }}
						</div>
						<p class="text-xs text-muted-foreground mt-1">Requires review</p>
					</div>
				</div>

				<div class="grid gap-4 md:grid-cols-7">
					<div
						class="col-span-4 rounded-xl border bg-card text-card-foreground shadow-sm"
					>
						<div class="p-6">
							<h3 class="font-semibold leading-none tracking-tight mb-4">
								Volume Distribution
							</h3>
							<div class="h-[350px] w-full">
								<VisXYContainer :data="barChartData" :height="350">
									<VisStackedBar
										:x="xAccessor"
										:y="yAccessors"
										:color="(d, i) => (i === 0 ? '#10b981' : '#e2e8f0')"
									/>
									<VisAxis type="x" :tickFormat="(d) => d" />
									<VisAxis type="y" />
									<VisTooltip />
								</VisXYContainer>
							</div>
							<div class="flex items-center justify-center gap-6 mt-4 text-sm">
								<div class="flex items-center gap-2">
									<span class="w-3 h-3 rounded-full bg-emerald-500"></span>
									<span class="text-muted-foreground">Active</span>
								</div>
								<div class="flex items-center gap-2">
									<span class="w-3 h-3 rounded-full bg-slate-200"></span>
									<span class="text-muted-foreground">Inactive</span>
								</div>
							</div>
						</div>
					</div>

					<div
						class="col-span-3 rounded-xl border bg-card text-card-foreground shadow-sm flex flex-col"
					>
						<div class="p-6 flex-1">
							<h3 class="font-semibold leading-none tracking-tight mb-4">
								Problem Domains
							</h3>
							<div
								class="h-[300px] w-full flex items-center justify-center relative"
							>
								<VisSingleContainer :data="donutData" :height="300">
									<VisDonut :value="donutValue" :arcWidth="40" />
									<VisTooltip
										:triggers="{
											[Donut.selectors.segment]: (d) =>
												`${d.data.key}: ${d.data.value}`,
										}"
									/>
								</VisSingleContainer>
								<div
									class="absolute inset-0 flex items-center justify-center pointer-events-none"
								>
									<div class="text-center">
										<span class="block text-2xl font-bold">{{
											dashboardData.overall.problems_count
										}}</span>
										<span class="text-xs text-muted-foreground uppercase"
											>Problems</span
										>
									</div>
								</div>
							</div>
							<div class="mt-4 grid grid-cols-2 gap-2 text-xs">
								<div
									v-for="(item, index) in donutData.slice(0, 6)"
									:key="item.key"
									class="flex items-center justify-between"
								>
									<span
										class="text-muted-foreground truncate max-w-[100px]"
										:title="item.key"
										>{{ item.key }}</span
									>
									<span class="font-mono font-medium">{{ item.value }}</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="rounded-xl border bg-card text-card-foreground shadow-sm">
					<div class="p-6">
						<div class="flex items-center justify-between mb-6">
							<h3 class="font-semibold leading-none tracking-tight">
								Recent Activity
							</h3>
							<span
								class="text-xs text-muted-foreground bg-muted px-2 py-1 rounded-md"
								>Last 10 updates</span
							>
						</div>

						<div class="relative">
							<div class="absolute left-4 top-0 bottom-0 w-px bg-border"></div>

							<div class="space-y-6">
								<div
									v-for="update in unifiedFeed"
									:key="update.id"
									class="relative pl-10 group"
								>
									<div
										class="absolute left-0 top-1 w-8 h-8 rounded-full bg-background border flex items-center justify-center z-10 group-hover:border-primary group-hover:text-primary transition-colors"
									>
										<FileText
											v-if="update.type === 'problems'"
											class="w-4 h-4"
										/>
										<Zap v-else class="w-4 h-4" />
									</div>

									<div
										class="flex flex-col sm:flex-row sm:items-center justify-between gap-1"
									>
										<div>
											<p class="text-sm font-medium leading-none">
												{{ update.name }}
											</p>
											<p class="text-xs text-muted-foreground mt-1">
												Modified in
												<span class="font-medium text-foreground">{{
													getTypeLabel(update.type)
												}}</span>
											</p>
										</div>
										<time
											class="text-xs text-muted-foreground font-mono whitespace-nowrap"
										>
											{{ formatDateRelative(update.updated_at) }}
										</time>
									</div>
								</div>
							</div>

							<div
								v-if="unifiedFeed.length === 0"
								class="py-8 text-center text-muted-foreground text-sm"
							>
								No recent activity recorded.
							</div>
						</div>
					</div>
				</div>
			</div>

			<div
				v-else
				class="grid gap-4 md:grid-cols-2 lg:grid-cols-4 animate-pulse"
			>
				<div v-for="i in 4" :key="i" class="h-32 rounded-xl bg-muted/50"></div>
				<div class="col-span-4 h-96 rounded-xl bg-muted/50"></div>
			</div>
		</div>
	</div>
</template>

<style scoped>
@reference "../assets/css/tailwind.css";

/* Unovis Customizations to match Shadcn/Tailwind */
:deep(.unovis-tooltip) {
	@apply bg-popover text-popover-foreground border shadow-md rounded-md px-3 py-1.5 text-xs font-medium;

	--vis-tooltip-background-color: transparent;
	--vis-tooltip-text-color: inherit;

	--vis-tooltip-border-color: transparent;
}

:deep(.vis-axis-grid) {
	@apply stroke-border stroke-[1px];
	stroke-dasharray: 4;
}

:deep(.vis-axis-tick-label) {
	@apply fill-muted-foreground text-xs font-sans;
}
</style>
