import type { RouterConfig } from "@nuxt/schema";

export default <RouterConfig>{
	routes: (routes) => {
		if (routes.some((route) => route.path === "/assessment-demo")) {
			return routes;
		}

		return [
			...routes,
			{
				name: "assessment-demo-fallback",
				path: "/assessment-demo",
				component: () => import("@/pages/assessment-demo.vue"),
			},
		];
	},
};
