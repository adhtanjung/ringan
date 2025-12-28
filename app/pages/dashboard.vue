<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useToast } from "@/components/ui/toast/use-toast";
import { datasetLabels } from "@/composables/useDatasetManagement";
import { useSupabase } from "@/composables/useSupabase";

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
			}>;
		};
	};
	timestamp: string;
}

const { supabase } = useSupabase();
const { toast } = useToast();

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
			// 1. Get total and active counts
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

			// 3. Domain breakdown for problems
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
		error.value = err?.message || "Failed to load dashboard data from Supabase";
		toast({
			title: "Error",
			description: error.value || "An unknown error occurred",
			variant: "destructive",
		});
	} finally {
		loading.value = false;
	}
};

const formatDate = (dateString: string) => {
	if (!dateString || dateString.startsWith("1970")) return "N/A";
	try {
		const date = new Date(dateString);
		return new Intl.DateTimeFormat("en-US", {
			year: "numeric",
			month: "short",
			day: "numeric",
			hour: "2-digit",
			minute: "2-digit",
		}).format(date);
	} catch {
		return dateString;
	}
};

const formatNumber = (num: number) => {
	return new Intl.NumberFormat("en-US").format(num);
};

const totalItems = computed(() => {
	if (!dashboardData.value?.overall) return 0;
	const overall = dashboardData.value.overall;
	return (
		overall.problems_count +
		overall.assessment_questions_count +
		overall.suggestions_count +
		overall.feedback_prompts_count +
		overall.next_actions_count +
		overall.training_examples_count
	);
});

const totalActive = computed(() => {
	if (!dashboardData.value?.by_type) return 0;
	return Object.values(dashboardData.value.by_type).reduce(
		(sum, type) => sum + type.active,
		0
	);
});

const activePercentage = computed(() => {
	if (totalItems.value === 0) return 0;
	return Math.round((totalActive.value / totalItems.value) * 100);
});

onMounted(() => {
	fetchDashboardData();
});
</script>

<template>
	<div
		class="min-h-screen bg-gradient-to-br from-background via-background to-muted/20 pb-12"
	>
		<div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-8 space-y-8">
			<!-- Header with Refresh -->
			<div class="flex items-center justify-between">
				<div>
					<h1
						class="text-4xl font-bold tracking-tight bg-gradient-to-r from-foreground to-foreground/70 bg-clip-text text-transparent"
					>
						Dataset Dashboard
					</h1>
					<p class="text-muted-foreground mt-2 text-lg">
						Monitor and manage all datasets in one place
					</p>
				</div>
				<button
					v-if="!loading && dashboardData"
					@click="fetchDashboardData"
					class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-primary text-primary-foreground hover:bg-primary/90 transition-all hover:scale-105 shadow-sm"
				>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-4 w-4"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2"
					>
						<path d="M21 12a9 9 0 0 0-9-9 9.75 9.75 0 0 0-6.74 2.74L3 8" />
						<path d="M3 3v5h5" />
						<path d="M3 12a9 9 0 0 0 9 9 9.75 9.75 0 0 0 6.74-2.74L21 16" />
						<path d="M16 16h5v5" />
					</svg>
					Refresh
				</button>
			</div>

			<!-- Loading State -->
			<div v-if="loading" class="flex items-center justify-center py-24">
				<div class="text-center space-y-4">
					<div class="relative">
						<div
							class="animate-spin rounded-full h-16 w-16 border-4 border-muted border-t-primary mx-auto"
						></div>
						<div
							class="absolute inset-0 rounded-full h-16 w-16 border-4 border-muted/20 mx-auto"
						></div>
					</div>
					<p class="text-muted-foreground font-medium">
						Loading dashboard data...
					</p>
				</div>
			</div>

			<!-- Error State -->
			<div
				v-else-if="error"
				class="rounded-2xl border-2 border-destructive/50 bg-destructive/5 backdrop-blur-sm p-8 shadow-lg"
			>
				<div class="flex items-start space-x-4">
					<div class="flex-shrink-0">
						<svg
							class="h-6 w-6 text-destructive"
							fill="none"
							viewBox="0 0 24 24"
							stroke="currentColor"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								stroke-width="2"
								d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
							/>
						</svg>
					</div>
					<div class="flex-1">
						<h3 class="font-semibold text-destructive text-lg mb-1">
							Failed to Load Dashboard
						</h3>
						<p class="text-sm text-muted-foreground">{{ error }}</p>
						<button
							@click="fetchDashboardData"
							class="mt-4 inline-flex items-center gap-2 text-sm font-medium text-destructive hover:text-destructive/80 transition-colors"
						>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								class="h-4 w-4"
								viewBox="0 0 24 24"
								fill="none"
								stroke="currentColor"
								stroke-width="2"
							>
								<path d="M21 12a9 9 0 0 0-9-9 9.75 9.75 0 0 0-6.74 2.74L3 8" />
								<path d="M3 3v5h5" />
								<path d="M3 12a9 9 0 0 0 9 9 9.75 9.75 0 0 0 6.74-2.74L21 16" />
								<path d="M16 16h5v5" />
							</svg>
							Try again
						</button>
					</div>
				</div>
			</div>

			<!-- Dashboard Content -->
			<div v-else-if="dashboardData" class="space-y-8">
				<!-- Key Metrics Cards -->
				<div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
					<!-- Total Items -->
					<div
						class="group relative overflow-hidden rounded-2xl border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-md transition-all hover:scale-[1.02]"
					>
						<div
							class="absolute top-0 right-0 w-32 h-32 bg-primary/5 rounded-full -mr-16 -mt-16 group-hover:scale-110 transition-transform"
						></div>
						<div class="relative">
							<div class="flex items-center gap-3 mb-3">
								<div class="p-2 rounded-lg bg-primary/10">
									<svg
										class="h-5 w-5 text-primary"
										fill="none"
										viewBox="0 0 24 24"
										stroke="currentColor"
										stroke-width="2"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"
										/>
									</svg>
								</div>
								<h3 class="text-sm font-medium text-muted-foreground">
									Total Items
								</h3>
							</div>
							<div class="text-3xl font-bold mb-1">
								{{ formatNumber(totalItems) }}
							</div>
							<p class="text-xs text-muted-foreground">Across all datasets</p>
						</div>
					</div>

					<!-- Active Items -->
					<div
						class="group relative overflow-hidden rounded-2xl border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-md transition-all hover:scale-[1.02]"
					>
						<div
							class="absolute top-0 right-0 w-32 h-32 bg-emerald-500/5 rounded-full -mr-16 -mt-16 group-hover:scale-110 transition-transform"
						></div>
						<div class="relative">
							<div class="flex items-center gap-3 mb-3">
								<div class="p-2 rounded-lg bg-emerald-500/10">
									<svg
										class="h-5 w-5 text-emerald-600 dark:text-emerald-400"
										fill="none"
										viewBox="0 0 24 24"
										stroke="currentColor"
										stroke-width="2"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
										/>
									</svg>
								</div>
								<h3 class="text-sm font-medium text-muted-foreground">
									Active Items
								</h3>
							</div>
							<div class="text-3xl font-bold mb-1">
								{{ formatNumber(totalActive) }}
							</div>
							<div class="flex items-center gap-2">
								<div class="flex-1 h-1.5 bg-muted rounded-full overflow-hidden">
									<div
										class="h-full bg-emerald-500 rounded-full transition-all"
										:style="`width: ${activePercentage}%`"
									></div>
								</div>
								<span
									class="text-xs font-medium text-emerald-600 dark:text-emerald-400"
									>{{ activePercentage }}%</span
								>
							</div>
						</div>
					</div>

					<!-- Problems -->
					<div
						class="group relative overflow-hidden rounded-2xl border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-md transition-all hover:scale-[1.02]"
					>
						<div
							class="absolute top-0 right-0 w-32 h-32 bg-blue-500/5 rounded-full -mr-16 -mt-16 group-hover:scale-110 transition-transform"
						></div>
						<div class="relative">
							<div class="flex items-center gap-3 mb-3">
								<div class="p-2 rounded-lg bg-blue-500/10">
									<svg
										class="h-5 w-5 text-blue-600 dark:text-blue-400"
										fill="none"
										viewBox="0 0 24 24"
										stroke="currentColor"
										stroke-width="2"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
										/>
									</svg>
								</div>
								<h3 class="text-sm font-medium text-muted-foreground">
									Problems
								</h3>
							</div>
							<div class="text-3xl font-bold mb-1">
								{{ formatNumber(dashboardData.overall.problems_count) }}
							</div>
							<p class="text-xs text-muted-foreground">Problem categories</p>
						</div>
					</div>

					<!-- Assessments -->
					<div
						class="group relative overflow-hidden rounded-2xl border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-md transition-all hover:scale-[1.02]"
					>
						<div
							class="absolute top-0 right-0 w-32 h-32 bg-purple-500/5 rounded-full -mr-16 -mt-16 group-hover:scale-110 transition-transform"
						></div>
						<div class="relative">
							<div class="flex items-center gap-3 mb-3">
								<div class="p-2 rounded-lg bg-purple-500/10">
									<svg
										class="h-5 w-5 text-purple-600 dark:text-purple-400"
										fill="none"
										viewBox="0 0 24 24"
										stroke="currentColor"
										stroke-width="2"
									>
										<path
											stroke-linecap="round"
											stroke-linejoin="round"
											d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"
										/>
									</svg>
								</div>
								<h3 class="text-sm font-medium text-muted-foreground">
									Assessments
								</h3>
							</div>
							<div class="text-3xl font-bold mb-1">
								{{
									formatNumber(dashboardData.overall.assessment_questions_count)
								}}
							</div>
							<p class="text-xs text-muted-foreground">Assessment questions</p>
						</div>
					</div>
				</div>

				<!-- Dataset Type Breakdown -->
				<div>
					<h2 class="text-2xl font-bold mb-6">Dataset Overview</h2>
					<div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
						<div
							v-for="dataType in datasetTypes"
							:key="dataType"
							class="group rounded-2xl border bg-card p-6 shadow-sm hover:shadow-md transition-all hover:scale-[1.02]"
						>
							<div class="flex items-start justify-between mb-6">
								<div>
									<h3 class="text-lg font-semibold mb-1">
										{{ (datasetLabels as any)[dataType] || dataType }}
									</h3>
									<p class="text-sm text-muted-foreground">
										{{
											formatNumber(dashboardData.by_type[dataType]?.total || 0)
										}}
										total
									</p>
								</div>
								<span
									class="inline-flex items-center gap-1.5 text-xs font-medium px-3 py-1.5 rounded-full transition-colors"
									:class="
										(dashboardData.by_type[dataType]?.active || 0) > 0
											? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400'
											: 'bg-muted text-muted-foreground'
									"
								>
									<span
										class="w-1.5 h-1.5 rounded-full"
										:class="
											(dashboardData.by_type[dataType]?.active || 0) > 0
												? 'bg-emerald-500'
												: 'bg-muted-foreground'
										"
									></span>
									{{ dashboardData.by_type[dataType]?.active || 0 }} active
								</span>
							</div>

							<div class="space-y-4">
								<!-- Stats Grid -->
								<div class="grid grid-cols-2 gap-4">
									<div class="rounded-lg bg-muted/50 p-3">
										<div class="text-xs text-muted-foreground mb-1">Active</div>
										<div
											class="text-xl font-bold text-emerald-600 dark:text-emerald-400"
										>
											{{
												formatNumber(
													dashboardData.by_type[dataType]?.active || 0
												)
											}}
										</div>
									</div>
									<div class="rounded-lg bg-muted/50 p-3">
										<div class="text-xs text-muted-foreground mb-1">
											Inactive
										</div>
										<div class="text-xl font-bold text-muted-foreground">
											{{
												formatNumber(
													dashboardData.by_type[dataType]?.inactive || 0
												)
											}}
										</div>
									</div>
								</div>

								<!-- Domain Breakdown -->
								<div
									v-if="
										dataType === 'problems' &&
										dashboardData.by_type[dataType]?.domain_breakdown &&
										Object.keys(
											dashboardData.by_type[dataType].domain_breakdown || {}
										).length > 0
									"
									class="pt-4 border-t space-y-3"
								>
									<p
										class="text-xs font-semibold text-muted-foreground uppercase tracking-wide"
									>
										By Domain
									</p>
									<div class="space-y-2">
										<div
											v-for="[domain, count] in Object.entries(
												dashboardData.by_type[dataType].domain_breakdown || {}
											)"
											:key="domain"
											class="flex items-center justify-between text-sm group/item hover:bg-muted/50 rounded-lg p-2 -mx-2 transition-colors"
										>
											<span class="text-foreground truncate mr-2 font-medium">{{
												domain
											}}</span>
											<span
												class="text-xs font-semibold bg-primary/10 text-primary px-2 py-1 rounded"
												>{{ count }}</span
											>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Recent Updates -->
				<div class="rounded-2xl border bg-card p-8 shadow-sm">
					<div class="flex items-center gap-3 mb-6">
						<div class="p-2 rounded-lg bg-primary/10">
							<svg
								class="h-5 w-5 text-primary"
								fill="none"
								viewBox="0 0 24 24"
								stroke="currentColor"
								stroke-width="2"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
								/>
							</svg>
						</div>
						<h2 class="text-2xl font-bold">Recent Updates</h2>
					</div>
					<div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
						<div
							v-for="dataType in datasetTypes"
							:key="dataType"
							class="space-y-3"
						>
							<h4
								class="text-sm font-semibold text-muted-foreground uppercase tracking-wide"
							>
								{{ (datasetLabels as any)[dataType] || dataType }}
							</h4>
							<div
								v-if="
									dashboardData.by_type[dataType]?.recent_updates &&
									dashboardData.by_type[dataType].recent_updates.length > 0
								"
								class="space-y-3"
							>
								<div
									v-for="update in dashboardData.by_type[
										dataType
									].recent_updates.slice(0, 3)"
									:key="update.id"
									class="group/update p-3 rounded-lg border bg-muted/30 hover:bg-muted/50 transition-colors"
								>
									<p
										class="font-medium text-sm truncate mb-1 group-hover/update:text-primary transition-colors"
									>
										{{ update.name }}
									</p>
									<div
										class="flex items-center gap-1.5 text-xs text-muted-foreground"
									>
										<svg
											class="h-3 w-3"
											fill="none"
											viewBox="0 0 24 24"
											stroke="currentColor"
											stroke-width="2"
										>
											<path
												stroke-linecap="round"
												stroke-linejoin="round"
												d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
											/>
										</svg>
										{{ formatDate(update.updated_at) }}
									</div>
								</div>
							</div>
							<div
								v-else
								class="p-4 rounded-lg border border-dashed bg-muted/20"
							>
								<p class="text-xs text-muted-foreground text-center italic">
									No recent updates
								</p>
							</div>
						</div>
					</div>
				</div>

				<!-- Footer Info -->
				<div
					class="rounded-2xl border bg-gradient-to-r from-card to-muted/20 p-6 shadow-sm"
				>
					<div class="flex items-center justify-between">
						<div class="flex items-center gap-3">
							<div class="p-2 rounded-lg bg-primary/10">
								<svg
									class="h-4 w-4 text-primary"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
									stroke-width="2"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
									/>
								</svg>
							</div>
							<div>
								<p class="text-sm font-medium">Last Updated</p>
								<p class="text-xs text-muted-foreground">
									{{ formatDate(dashboardData.overall.last_updated) }}
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
