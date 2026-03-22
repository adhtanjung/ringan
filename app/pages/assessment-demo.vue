<script setup lang="ts">
import AssessmentDemoSandbox from "@/components/admin/AssessmentDemoSandbox.vue";
import DatasetPageHeader from "@/components/admin/DatasetPageHeader.vue";
import { Button } from "@/components/ui/button";
</script>

<template>
		<div class="min-h-screen w-full max-w-full overflow-x-hidden bg-muted/25">
		<div class="mx-auto flex w-full max-w-7xl flex-col gap-6 px-4 py-6 sm:px-6 lg:px-8">
			<DatasetPageHeader
				eyebrow="Admin sandbox"
				title="Assessment Demo"
				description="Open the popup to step through one question at a time. The preview mirrors the end-user flow, while editing stays secondary."
			>
				<template #actions>
					<Button as-child variant="outline" class="h-11 gap-2 px-4 text-sm font-medium">
						<NuxtLink to="/dashboard">Back to dashboard</NuxtLink>
					</Button>
				</template>
			</DatasetPageHeader>

			<AssessmentDemoSandbox />
		</div>
	</div>
</template>
