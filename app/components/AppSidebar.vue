<script setup lang="ts">
import { computed } from "vue";
import {
	IconCamera,
	IconChartBar,
	IconDashboard,
	IconDatabase,
	IconFileAi,
	IconFileDescription,
	IconFolder,
	IconHelp,
	IconInnerShadowTop,
	IconListDetails,
	IconReport,
	IconSearch,
	IconSettings,
	IconUsers,
} from "@tabler/icons-vue";

import NavDocuments from "@/components/NavDocuments.vue";
import NavMain from "@/components/NavMain.vue";
import NavSecondary from "@/components/NavSecondary.vue";
import {
	Sidebar,
	SidebarContent,
	SidebarHeader,
	SidebarFooter,
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
} from "@/components/ui/sidebar";
import { FlaskConical, Sparkles } from "lucide-vue-next";

const route = useRoute();
const isAssessmentDemoActive = computed(() => route.path === "/assessment-demo");

const data = {
	navMain: [
		{
			title: "Dashboard",
			url: "/dashboard",
			icon: IconDashboard,
		},
		// {
		// 	title: "Lifecycle",
		// 	url: "#",
		// 	icon: IconListDetails,
		// },
		// {
		// 	title: "Analytics",
		// 	url: "#",
		// 	icon: IconChartBar,
		// },
		// {
		// 	title: "Projects",
		// 	url: "#",
		// 	icon: IconFolder,
		// },
		// {
		// 	title: "Team",
		// 	url: "#",
		// 	icon: IconUsers,
		// },
	],
	// navClouds: [
	// 	{
	// 		title: "Capture",
	// 		icon: IconCamera,
	// 		isActive: true,
	// 		url: "#",
	// 		items: [
	// 			{
	// 				title: "Active Proposals",
	// 				url: "#",
	// 			},
	// 			{
	// 				title: "Archived",
	// 				url: "#",
	// 			},
	// 		],
	// 	},
	// 	{
	// 		title: "Proposal",
	// 		icon: IconFileDescription,
	// 		url: "#",
	// 		items: [
	// 			{
	// 				title: "Active Proposals",
	// 				url: "#",
	// 			},
	// 			{
	// 				title: "Archived",
	// 				url: "#",
	// 			},
	// 		],
	// 	},
	// 	{
	// 		title: "Prompts",
	// 		icon: IconFileAi,
	// 		url: "#",
	// 		items: [
	// 			{
	// 				title: "Active Proposals",
	// 				url: "#",
	// 			},
	// 			{
	// 				title: "Archived",
	// 				url: "#",
	// 			},
	// 		],
	// 	},
	// ],
	// navSecondary: [
	// 	{
	// 		title: "Settings",
	// 		url: "#",
	// 		icon: IconSettings,
	// 	},
	// 	{
	// 		title: "Get Help",
	// 		url: "#",
	// 		icon: IconHelp,
	// 	},
	// 	{
	// 		title: "Search",
	// 		url: "#",
	// 		icon: IconSearch,
	// 	},
	// ],
	dataset: [
		{
			name: "Categories",
			url: "/problem-types",
			icon: IconFileDescription,
		},
		{
			name: "Subcategories",
			url: "/problems",
			icon: IconFileDescription,
		},

		{
			name: "Assessment Questions",
			url: "/assessments",
			icon: IconListDetails,
		},
		{
			name: "Therapeutic Suggestions",
			url: "/suggestions",
			icon: IconFileAi,
		},
		{
			name: "Next Actions",
			url: "/next-actions",
			icon: IconReport,
		},
	],
};
</script>

<template>
	<Sidebar collapsible="offcanvas">
		<SidebarHeader>
			<SidebarMenu>
				<SidebarMenuItem>
					<SidebarMenuButton
						as-child
						class="data-[slot=sidebar-menu-button]:p-1.5!"
					>
						<a href="#">
							<IconInnerShadowTop class="size-5!" />
							<span class="text-base font-semibold"
								>Ringan Data Management</span
							>
						</a>
					</SidebarMenuButton>
				</SidebarMenuItem>
			</SidebarMenu>
		</SidebarHeader>
		<SidebarContent>
			<NavMain :items="data.navMain" />
			<NavDocuments :items="data.dataset" />
			<!-- <NavSecondary :items="data.navSecondary" class="mt-auto" /> -->
		</SidebarContent>
		<SidebarFooter class="mt-auto border-t border-sidebar-border/70 px-2 pb-3 pt-3">
			<div class="px-2 pb-2 text-[10px] font-semibold uppercase tracking-[0.22em] text-sidebar-foreground/55 group-data-[collapsible=icon]:sr-only">
				Lab tools
			</div>
			<SidebarMenu>
				<SidebarMenuItem>
					<SidebarMenuButton
						as-child
						tooltip="Assessment demo"
						variant="outline"
						size="lg"
						:is-active="isAssessmentDemoActive"
						class="group relative overflow-hidden rounded-2xl border border-cyan-500/20 bg-gradient-to-br from-cyan-500/10 via-sidebar to-indigo-500/10 px-3 text-sidebar-foreground shadow-sm transition-all duration-200 hover:-translate-y-0.5 hover:border-cyan-500/35 hover:shadow-[0_16px_40px_-20px_rgba(34,211,238,0.65)] focus-visible:border-cyan-500/40"
					>
						<NuxtLink
							to="/assessment-demo"
							class="flex w-full items-center gap-3"
						>
							<span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-xl bg-cyan-500/15 text-cyan-600 ring-1 ring-inset ring-cyan-400/20 transition-colors group-hover:bg-cyan-500/20 group-hover:text-cyan-500 dark:text-cyan-300 dark:group-hover:text-cyan-200">
								<FlaskConical class="h-4 w-4" />
							</span>
							<span class="min-w-0 flex-1 text-left group-data-[collapsible=icon]:hidden">
								<span class="flex items-center gap-2 text-sm font-semibold leading-none">
									Assessment demo
									<span class="rounded-full border border-cyan-500/20 bg-cyan-500/10 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-[0.18em] text-cyan-600 dark:text-cyan-200">
										Lab
									</span>
								</span>
								<span class="mt-1 block text-[11px] leading-none text-sidebar-foreground/60">
									Open the sandbox route
								</span>
							</span>
							<Sparkles class="h-4 w-4 shrink-0 text-cyan-500/80 opacity-0 transition-opacity duration-200 group-hover:opacity-100 dark:text-cyan-300 group-data-[collapsible=icon]:hidden" />
						</NuxtLink>
					</SidebarMenuButton>
				</SidebarMenuItem>
			</SidebarMenu>
		</SidebarFooter>
	</Sidebar>
</template>
