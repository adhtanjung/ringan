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

const { supabase, session, isInitialized, init } = useSupabase();

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
							<h2 class="text-sm font-semibold text-gray-700">Ringan Data</h2>
						</div>
						<div class="flex items-center gap-4">
							<span class="text-xs text-gray-500 hidden sm:inline">{{
								session.user.email
							}}</span>
							<button
								@click="supabase.auth.signOut()"
								class="px-3 py-1.5 text-xs font-semibold text-red-600 hover:bg-red-50 rounded-md border border-red-100 transition-all"
							>
								Sign Out
							</button>
						</div>
					</header>
					<main class="flex-1 overflow-auto">
						<NuxtPage />
					</main>
				</SidebarInset>
			</SidebarProvider>
		</template>
	</div>
</template>
