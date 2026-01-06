<script setup>
import LoginForm from "@/components/login-01/components/LoginForm.vue";
import { useSupabase } from "@/composables/useSupabase";
import AppSidebar from "@/components/AppSidebar.vue";
import {
	SidebarInset,
	SidebarProvider,
	SidebarTrigger,
} from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import FeedbackWidget from "@/components/admin/FeedbackWidget.vue";
import AppFooter from "@/components/AppFooter.vue";
import {
	Breadcrumb,
	BreadcrumbItem,
	BreadcrumbLink,
	BreadcrumbList,
	BreadcrumbPage,
	BreadcrumbSeparator,
} from "@/components/ui/breadcrumb";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuGroup,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
	Avatar,
	AvatarFallback,
	AvatarImage,
} from '@/components/ui/avatar'
import {
	LogOut,
	Settings,
	User,
	ChevronsUpDown,
} from "lucide-vue-next";
import GlobalSearch from "@/components/GlobalSearch.vue";

const { supabase, session, isInitialized, init } = useSupabase();
const route = useRoute();

const breadcrumbs = computed(() => {
	const path = route.path;
	if (path === "/" || path === "/dashboard") {
		return [{ title: "Dashboard", url: "/dashboard", active: true }];
	}

	const segments = path.split("/").filter(Boolean);
	const items = segments.map((segment, index) => {
		const url = "/" + segments.slice(0, index + 1).join("/");
		return {
			title: segment.replace(/-/g, " ").replace(/\b\w/g, (l) => l.toUpperCase()),
			url,
			active: index === segments.length - 1,
		};
	});

	return [
		{ title: "Dashboard", url: "/dashboard", active: false },
		...items,
	];
});

const email = ref("");
const password = ref("");
const loading = ref(false);

async function handleLogin() {
	try {
		loading.value = true;
		const { error } = await supabase.auth.signInWithPassword({
			email: email.value,
			password: password.value,
		});
		if (error) throw error;
	} catch (error) {
		alert(error.message);
	} finally {
		loading.value = false;
	}
}

onMounted(() => {
	init();
});
</script>

<template>
	<div class="min-h-screen bg-gray-50 flex flex-col">
		<template v-if="!isInitialized">
			<div class="flex-1 flex items-center justify-center">
				<div
					class="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"
				></div>
			</div>
		</template>

		<template v-else>
			<div v-if="!session" class="flex-1 flex items-center justify-center p-4">
				<div class="w-full max-w-sm">
					<LoginForm
						v-model:email="email"
						v-model:password="password"
						:loading="loading"
						@submit="handleLogin"
					/>
				</div>
			</div>

			<SidebarProvider v-else>
				<AppSidebar />
				<SidebarInset class="min-w-0">
					<header
						class="flex h-16 shrink-0 items-center gap-2 border-b px-4 justify-between"
					>
						<div class="flex items-center gap-2">
							<SidebarTrigger class="-ml-1" />
							<Separator orientation="vertical" class="mr-2 h-4" />
							<Breadcrumb>
								<BreadcrumbList>
									<template
										v-for="(item, index) in breadcrumbs"
										:key="item.url"
									>
										<BreadcrumbItem>
											<BreadcrumbPage v-if="item.active">
												{{ item.title }}
											</BreadcrumbPage>
											<BreadcrumbLink v-else :href="item.url">
												{{ item.title }}
											</BreadcrumbLink>
										</BreadcrumbItem>
										<BreadcrumbSeparator
											v-if="index < breadcrumbs.length - 1"
										/>
									</template>
								</BreadcrumbList>
							</Breadcrumb>
						</div>
						<div class="flex items-center gap-4">
							<GlobalSearch />
							<DropdownMenu>
								<DropdownMenuTrigger as-child>
									<div class="flex items-center gap-2 cursor-pointer hover:bg-accent rounded-md p-2 transition-colors">
										<Avatar class="h-8 w-8 rounded-lg">
											<AvatarImage :src="session.user?.user_metadata?.avatar_url" :alt="session.user?.email" />
											<AvatarFallback class="rounded-lg">CN</AvatarFallback>
										</Avatar>
										<div class="grid flex-1 text-left text-sm leading-tight">
											<span class="truncate font-semibold">{{ session.user?.user_metadata?.full_name || 'User' }}</span>
											<span class="truncate text-xs">{{ session.user?.email }}</span>
										</div>
										<ChevronsUpDown class="ml-auto size-4" />
									</div>
								</DropdownMenuTrigger>
								<DropdownMenuContent
									class="w-[--radix-dropdown-menu-trigger-width] min-w-56 rounded-lg"
									side="bottom"
									align="end"
									:side-offset="4"
								>
									<DropdownMenuLabel class="p-0 font-normal">
										<div class="flex items-center gap-2 px-1 py-1.5 text-left text-sm">
											<Avatar class="h-8 w-8 rounded-lg">
												<AvatarImage :src="session.user?.user_metadata?.avatar_url" :alt="session.user?.email" />
												<AvatarFallback class="rounded-lg">CN</AvatarFallback>
											</Avatar>
											<div class="grid flex-1 text-left text-sm leading-tight">
												<span class="truncate font-semibold">{{ session.user?.user_metadata?.full_name || 'User' }}</span>
												<span class="truncate text-xs">{{ session.user?.email }}</span>
											</div>
										</div>
									</DropdownMenuLabel>
									<DropdownMenuSeparator />
									<DropdownMenuGroup>
										<DropdownMenuItem>
											<User />
											Profile
										</DropdownMenuItem>
										<DropdownMenuItem>
											<Settings />
											Settings
										</DropdownMenuItem>
									</DropdownMenuGroup>
									<DropdownMenuSeparator />
									<DropdownMenuItem @click="supabase.auth.signOut()">
										<LogOut />
										Log out
									</DropdownMenuItem>
								</DropdownMenuContent>
							</DropdownMenu>
						</div>
					</header>
					<main class="flex-1 overflow-auto">
						<NuxtPage />
					</main>
					<AppFooter />
					<FeedbackWidget />
				</SidebarInset>
			</SidebarProvider>
		</template>
	</div>
</template>
