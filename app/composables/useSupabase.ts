import { createClient, type Session } from "@supabase/supabase-js";

export const useSupabase = () => {
	const config = useRuntimeConfig();
	const supabase = createClient(
		config.public.supabaseUrl,
		config.public.supabasePublishableKey
	);

	const session = useState<Session | null>("supabase:session", () => null);
	const isInitialized = useState<boolean>("supabase:initialized", () => false);
	const user = computed(() => session.value?.user ?? null);

	const init = async () => {
		if (isInitialized.value) return;

		const { data } = await supabase.auth.getSession();
		session.value = data.session;

		supabase.auth.onAuthStateChange((_event, _session) => {
			session.value = _session;
		});

		isInitialized.value = true;
	};

	return {
		supabase,
		session,
		user,
		isInitialized,
		init,
	};
};
