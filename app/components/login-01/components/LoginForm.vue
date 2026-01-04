<script setup lang="ts">
import type { HTMLAttributes } from "vue";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import {
	Field,
	FieldDescription,
	FieldGroup,
	FieldLabel,
} from "@/components/ui/field";
import { Input } from "@/components/ui/input";

const props = defineProps<{
	class?: HTMLAttributes["class"];
	loading?: boolean;
}>();

const email = defineModel<string>("email");
const password = defineModel<string>("password");

const emit = defineEmits<{
	(e: "submit"): void;
}>();
</script>

<template>
	<div :class="cn('flex flex-col gap-6', props.class)">
		<Card>
			<CardHeader>
				<CardTitle>Login to your account</CardTitle>
				<CardDescription>
					Enter your email below to login to your account
				</CardDescription>
			</CardHeader>
			<CardContent>
				<form @submit.prevent="emit('submit')">
					<FieldGroup>
						<Field>
							<FieldLabel for="email"> Email </FieldLabel>
							<Input
								id="email"
								v-model="email"
								type="email"
								placeholder="m@example.com"
								required
							/>
						</Field>
						<Field>
							<div class="flex items-center">
								<FieldLabel for="password"> Password </FieldLabel>
							</div>
							<Input
								id="password"
								v-model="password"
								type="password"
								required
							/>
						</Field>
						<Field>
							<Button type="submit" :disabled="loading">
								{{ loading ? "Signing in..." : "Login" }}
							</Button>
						</Field>
					</FieldGroup>
				</form>
			</CardContent>
		</Card>
	</div>
</template>
