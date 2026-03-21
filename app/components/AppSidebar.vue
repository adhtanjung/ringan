<script setup lang="ts">
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
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
} from "@/components/ui/sidebar";

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
	</Sidebar>
</template>
