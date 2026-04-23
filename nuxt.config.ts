// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite";

export default defineNuxtConfig({
	compatibilityDate: "2025-07-15",
	devtools: {
		enabled: true,

		timeline: {
			enabled: true,
		},
	},
	modules: ["shadcn-nuxt", "@nuxt/ui"],
	css: ["~/assets/css/tailwind.css", "~/assets/css/driver-theme.css"],
	runtimeConfig: {
		public: {
			supabaseUrl: process.env.SUPABASE_URL,
			supabasePublishableKey: process.env.SUPABASE_PUBLISHABLE_KEY,
		},
	},
	vite: {
		plugins: [tailwindcss()],
		resolve: {
			alias: {
				xlsx: "xlsx/dist/xlsx.full.min.js",
			},
		},
	},
	shadcn: {
		/**
		 * Prefix for all the imported component.
		 * @default "Ui"
		 */
		prefix: "",
		/**
		 * Directory that the component lives in.
		 * Will respect the Nuxt aliases.
		 * @link https://nuxt.com/docs/api/nuxt-config#alias
		 * @default "@/components/ui"
		 */
		componentDir: "@/components/ui",
	},
});
