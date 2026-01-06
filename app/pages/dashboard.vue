<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useToast } from "@/components/ui/toast/use-toast";
import { datasetLabels } from "@/composables/useDatasetManagement";
import { useSupabase } from "@/composables/useSupabase";
import { VisTooltip, VisDonut, VisSingleContainer } from "@unovis/vue";
import { Donut } from "@unovis/ts";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import {
	RefreshCw,
	Database,
	Zap,
	Clock,
	AlertCircle,
	CheckCircle2,
	FileText,
	LayoutGrid,
	TrendingUp,
	ArrowRight,
} from "lucide-vue-next";
import PageHeader from "@/components/PageHeader.vue";
import { Button } from "@/components/ui/button";

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
				type: string;
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

const datasetTypes = ["problems", "assessments", "problem_types"];

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
			const [totalRes, activeRes] = await Promise.all([
				supabase.from(type).select("*", { count: "exact", head: true }),
				supabase
					.from(type)
					.select("*", { count: "exact", head: true })
					.eq("is_active", true),
			]);

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
				.limit(3);

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
					type: type,
				})),
			};

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

// Totals Logic
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

// Bar Chart Data - compact for 3 main types
const barChartData = computed(() => {
	if (!dashboardData.value) return [];
	const mainTypes = ["problems", "problem_types", "assessments"];
	return mainTypes.map((type) => {
		const data = dashboardData.value?.by_type[type];
		return {
			type:
				type === "problem_types"
					? "Types"
					: (datasetLabels as any)[type]?.split(" ")[0] || type,
			active: data?.active || 0,
			inactive: data?.inactive || 0,
		};
	});
});

type BarData = (typeof barChartData.value)[number];
const xAccessor = (d: BarData) => d.type;
const yAccessors = [(d: BarData) => d.active, (d: BarData) => d.inactive];

// Donut Chart Data
const donutData = computed(() => {
	const breakdown =
		dashboardData.value?.by_type["problems"]?.domain_breakdown || {};
	return Object.entries(breakdown)
		.map(([key, value]) => ({ key, value }))
		.slice(0, 5);
});
type DonutData = (typeof donutData.value)[number];
const donutValue = (d: DonutData) => d.value;

// Helper functions
const getActiveRate = (
	typeData: { total: number; active: number } | undefined
) => {
	if (!typeData || typeData.total === 0) return 0;
	return Math.round((typeData.active / typeData.total) * 100);
};

const getTypeLabel = (typeKey: string) =>
	(datasetLabels as any)[typeKey] || typeKey;

// Feature cards config
const featureCards = computed(() => [
	{
		key: "problems",
		label: "Problems",
		icon: FileText,
		color: "text-chart-1",
		bgColor: "bg-chart-1/10",
		route: "/problems",
	},
	{
		key: "problem_types",
		label: "Types",
		icon: LayoutGrid,
		color: "text-chart-2",
		bgColor: "bg-chart-2/10",
		route: "/problem-types",
	},
	{
		key: "assessments",
		label: "Assessments",
		icon: Zap,
		color: "text-chart-3",
		bgColor: "bg-chart-3/10",
		route: "/assessments",
	},
]);

// Recent activity - combined feed (top 5)
const recentActivity = computed(() => {
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
		.slice(0, 5);
});

onMounted(() => {
	fetchDashboardData();
});
</script>

<template>
	<div class="min-h-screen bg-background text-foreground">
		<div class="mx-auto max-w-7xl px-4 py-4 space-y-4">
			<!-- Header Row -->
			<PageHeader title="Dashboard" description="Dataset overview">
				<template #actions>
					<Button
						@click="fetchDashboardData"
						:disabled="loading"
						size="sm"
						class="gap-1.5"
					>
						<RefreshCw class="h-3 w-3" :class="{ 'animate-spin': loading }" />
						<span>{{ loading ? "..." : "Refresh" }}</span>
					</Button>
				</template>
			</PageHeader>

			<!-- Error State -->
			<div
				v-if="error"
				class="rounded-lg border border-destructive/50 bg-destructive/10 p-3 text-destructive flex items-center gap-2 text-sm"
			>
				<AlertCircle class="h-4 w-4" />
				<p>{{ error }}</p>
			</div>

			<!-- Main Dashboard -->
			<div
				v-if="dashboardData && !loading"
				class="space-y-4 animate-in fade-in duration-300"
			>
				<!-- Stats Row - 3 Feature Cards -->
				<div class="grid grid-cols-3 gap-3">
					<Card class="py-3">
						<CardContent class="p-0 px-4">
							<div class="flex items-center gap-3">
								<div
									class="h-8 w-8 rounded-lg bg-chart-1/10 flex items-center justify-center"
								>
									<FileText class="h-4 w-4 text-chart-1" />
								</div>
								<div>
									<p class="text-2xl font-bold leading-none">
										{{
											formatNumber(
												dashboardData?.by_type?.problems?.active || 0
											)
										}}
									</p>
									<p class="text-xs text-muted-foreground mt-0.5">Problems</p>
								</div>
							</div>
						</CardContent>
					</Card>

					<Card class="py-3">
						<CardContent class="p-0 px-4">
							<div class="flex items-center gap-3">
								<div
									class="h-8 w-8 rounded-lg bg-chart-2/10 flex items-center justify-center"
								>
									<LayoutGrid class="h-4 w-4 text-chart-2" />
								</div>
								<div>
									<p class="text-2xl font-bold leading-none">
										{{
											formatNumber(
												dashboardData?.by_type?.problem_types?.active || 0
											)
										}}
									</p>
									<p class="text-xs text-muted-foreground mt-0.5">Types</p>
								</div>
							</div>
						</CardContent>
					</Card>

					<Card class="py-3">
						<CardContent class="p-0 px-4">
							<div class="flex items-center gap-3">
								<div
									class="h-8 w-8 rounded-lg bg-chart-3/10 flex items-center justify-center"
								>
									<Zap class="h-4 w-4 text-chart-3" />
								</div>
								<div>
									<p class="text-2xl font-bold leading-none">
										{{
											formatNumber(
												dashboardData?.by_type?.assessments?.active || 0
											)
										}}
									</p>
									<p class="text-xs text-muted-foreground mt-0.5">
										Assessments
									</p>
								</div>
							</div>
						</CardContent>
					</Card>
				</div>

				<!-- Charts Row -->
				<div class="grid grid-cols-5 gap-4">
					<!-- Active Counts Distribution -->
					<Card class="col-span-2">
						<CardHeader class="pb-2 pt-4 px-4">
							<CardTitle class="text-sm font-medium">Active Records</CardTitle>
						</CardHeader>
						<CardContent class="px-4 pb-4 space-y-3">
							<!-- Simple Bars for Active Counts -->
							<div
								v-for="item in barChartData"
								:key="item.type"
								class="space-y-1"
							>
								<div class="flex justify-between text-xs">
									<span class="font-medium">{{ item.type }}</span>
									<span class="font-semibold text-chart-1">{{
										item.active
									}}</span>
								</div>
								<div class="h-3 bg-muted rounded-full overflow-hidden">
									<div
										class="bg-chart-1 h-full rounded-full transition-all duration-500"
										:style="{
											width: `${Math.min((item.active / 500) * 100, 100)}%`,
										}"
									></div>
								</div>
							</div>
						</CardContent>
					</Card>

					<!-- Donut Chart -->
					<Card class="col-span-2">
						<CardHeader class="pb-2 pt-4 px-4">
							<CardTitle class="text-sm font-medium"
								>Problem Categories</CardTitle
							>
						</CardHeader>
						<CardContent class="px-4 pb-4">
							<div
								class="h-[160px] w-full flex items-center justify-center relative"
							>
								<VisSingleContainer
									:data="donutData"
									:height="160"
									:width="160"
								>
									<VisDonut
										:value="donutValue"
										:color="(_d: any, i: number) => `var(--chart-${(i % 5) + 1})`"
										:arc-width="24"
										:pad-angle="0.02"
									/>
									<VisTooltip
										:triggers="{
											[Donut.selectors.segment]: (d: { data: DonutData }) =>
												`${d.data.key}: ${d.data.value}`,
										}"
									/>
								</VisSingleContainer>
								<div
									class="absolute inset-0 flex items-center justify-center pointer-events-none"
								>
									<div class="text-center">
										<span class="block text-xl font-bold">{{
											dashboardData.overall.problems_count
										}}</span>
										<span class="text-[10px] text-muted-foreground uppercase"
											>Problems</span
										>
									</div>
								</div>
							</div>
							<!-- Category Legend -->
							<div
								class="flex flex-wrap gap-x-3 gap-y-1 justify-center mt-2 text-xs text-muted-foreground"
							>
								<span
									v-for="item in donutData.slice(0, 4)"
									:key="item.key"
									class="truncate max-w-[80px]"
								>
									{{ item.key }}: {{ item.value }}
								</span>
							</div>
						</CardContent>
					</Card>

					<!-- Recent Activity -->
					<Card class="col-span-1">
						<CardHeader class="pb-2 pt-4 px-4">
							<CardTitle class="text-sm font-medium">Recent</CardTitle>
						</CardHeader>
						<CardContent class="px-4 pb-4">
							<div class="space-y-2">
								<div
									v-for="update in recentActivity"
									:key="update.id"
									class="text-xs border-l-2 border-primary/20 pl-2 py-0.5"
								>
									<p
										class="font-medium truncate max-w-[120px]"
										:title="update.name"
									>
										{{ update.name?.slice(0, 20)
										}}{{ update.name?.length > 20 ? "..." : "" }}
									</p>
									<p class="text-muted-foreground text-[10px]">
										{{ getTypeLabel(update.type)?.split(" ")[0] }} ·
										{{ formatDateRelative(update.updated_at) }}
									</p>
								</div>
								<div
									v-if="recentActivity.length === 0"
									class="text-xs text-muted-foreground py-4 text-center"
								>
									No recent activity
								</div>
							</div>
						</CardContent>
					</Card>
				</div>

				<!-- Feature Cards Row - Compact -->
				<div class="grid grid-cols-3 gap-3">
					<NuxtLink
						v-for="card in featureCards"
						:key="card.key"
						:to="card.route"
						class="block"
					>
						<Card
							class="hover:shadow-md transition-shadow cursor-pointer group"
						>
							<CardContent class="p-4">
								<div class="flex items-center justify-between mb-3">
									<div class="flex items-center gap-2">
										<div
											:class="[
												card.bgColor,
												'h-7 w-7 rounded-md flex items-center justify-center',
											]"
										>
											<component
												:is="card.icon"
												:class="[card.color, 'h-3.5 w-3.5']"
											/>
										</div>
										<span class="font-medium text-sm">{{ card.label }}</span>
									</div>
									<ArrowRight
										class="h-4 w-4 text-muted-foreground opacity-0 group-hover:opacity-100 transition-opacity"
									/>
								</div>

								<div class="space-y-2">
									<div class="flex items-baseline justify-between">
										<span class="text-2xl font-bold">{{
											formatNumber(
												dashboardData?.by_type[card.key]?.active || 0
											)
										}}</span>
										<span class="text-xs text-muted-foreground"
											>active records</span
										>
									</div>
								</div>
							</CardContent>
						</Card>
					</NuxtLink>
				</div>

				<!-- Other Datasets Row - Mini Cards -->
				<div class="grid grid-cols-4 gap-2"></div>

				<!-- Last Updated Footer -->
				<div class="text-center text-xs text-muted-foreground pt-2">
					Last synced
					{{ formatDateRelative(dashboardData.overall.last_updated) }}
				</div>
			</div>

			<!-- Loading State -->
			<div v-else class="grid grid-cols-4 gap-3 animate-pulse">
				<div v-for="i in 4" :key="i" class="h-20 rounded-xl bg-muted/50"></div>
				<div class="col-span-2 h-48 rounded-xl bg-muted/50"></div>
				<div class="col-span-2 h-48 rounded-xl bg-muted/50"></div>
				<div class="col-span-3 h-32 rounded-xl bg-muted/50"></div>
			</div>
		</div>
	</div>
</template>

<style scoped>
@reference "../assets/css/tailwind.css";

/* Unovis Customizations */
:deep(.unovis-tooltip) {
	@apply bg-popover text-popover-foreground border shadow-md rounded-md px-2 py-1 text-xs font-medium;
	--vis-tooltip-background-color: transparent;
	--vis-tooltip-text-color: inherit;
	--vis-tooltip-border-color: transparent;
}

:deep(.vis-axis-tick-label) {
	@apply fill-muted-foreground text-[10px] font-sans;
}
</style>
