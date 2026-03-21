<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from '@/components/ui/card'
import { Label } from '@/components/ui/label'
import { Input } from '@/components/ui/input'
import { Eye, EyeOff, AlertCircle } from 'lucide-vue-next'

const props = defineProps<{
	class?: HTMLAttributes['class']
	loading?: boolean
	error?: string
}>()

const email = defineModel<string>('email', { default: '' })
const password = defineModel<string>('password', { default: '' })

const emit = defineEmits<{
	(e: 'submit'): void
}>()

// Show/hide password toggle
const showPassword = ref(false)

// Per-field validation
const emailTouched = ref(false)
const passwordTouched = ref(false)

const emailError = computed(() => {
	if (!emailTouched.value) return ''
	if (!email.value) return 'Email is required.'
	if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) return 'Please enter a valid email address.'
	return ''
})

const passwordError = computed(() => {
	if (!passwordTouched.value) return ''
	if (!password.value) return 'Password is required.'
	if (password.value.length < 6) return 'Password must be at least 6 characters.'
	return ''
})

const handleSubmit = () => {
	emailTouched.value = true
	passwordTouched.value = true
	if (emailError.value || passwordError.value) return
	emit('submit')
}
</script>

<template>
	<div :class="cn(props.class)">
		<Card>
			<CardHeader class="space-y-1">
				<CardTitle class="text-xl">Welcome back</CardTitle>
				<CardDescription>
					Sign in to the Ringan administration system.
				</CardDescription>
			</CardHeader>

			<CardContent>
				<!-- Auth error banner -->
				<div
					v-if="error"
					role="alert"
					class="mb-4 flex items-start gap-2 rounded-md border border-destructive/30 bg-destructive/10 px-3 py-2.5 text-sm text-destructive"
				>
					<AlertCircle class="mt-0.5 h-4 w-4 shrink-0" aria-hidden="true" />
					<span>{{ error }}</span>
				</div>

				<form
					aria-label="Sign in form"
					class="flex flex-col gap-4"
					@submit.prevent="handleSubmit"
					novalidate
				>
					<!-- Email -->
					<div class="flex flex-col gap-1.5">
						<Label for="email">Email</Label>
						<Input
							id="email"
							v-model="email"
							type="email"
							placeholder="you@example.com"
							autocomplete="email"
							:aria-invalid="!!emailError"
							:aria-describedby="emailError ? 'email-error' : undefined"
							@blur="emailTouched = true"
						/>
						<p
							v-if="emailError"
							id="email-error"
							class="text-xs text-destructive flex items-center gap-1"
							role="alert"
						>
							<AlertCircle class="h-3 w-3 shrink-0" aria-hidden="true" />
							{{ emailError }}
						</p>
					</div>

					<!-- Password -->
					<div class="flex flex-col gap-1.5">
						<Label for="password">Password</Label>
						<div class="relative">
							<Input
								id="password"
								v-model="password"
								:type="showPassword ? 'text' : 'password'"
								placeholder="••••••••"
								autocomplete="current-password"
								class="pr-10"
								:aria-invalid="!!passwordError"
								:aria-describedby="passwordError ? 'password-error' : undefined"
								@blur="passwordTouched = true"
							/>
							<button
								type="button"
								class="absolute inset-y-0 right-0 flex items-center justify-center w-10 text-muted-foreground hover:text-foreground transition-colors"
								:aria-label="showPassword ? 'Hide password' : 'Show password'"
								@click="showPassword = !showPassword"
							>
								<component :is="showPassword ? EyeOff : Eye" class="h-4 w-4" aria-hidden="true" />
							</button>
						</div>
						<p
							v-if="passwordError"
							id="password-error"
							class="text-xs text-destructive flex items-center gap-1"
							role="alert"
						>
							<AlertCircle class="h-3 w-3 shrink-0" aria-hidden="true" />
							{{ passwordError }}
						</p>
					</div>

					<!-- Submit -->
					<Button
						type="submit"
						class="w-full h-11 mt-1"
						:disabled="loading"
						:aria-busy="loading"
					>
						<span v-if="loading" class="flex items-center gap-2">
							<svg
								class="h-4 w-4 animate-spin"
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								aria-hidden="true"
							>
								<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
								<path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
							</svg>
							Signing in…
						</span>
						<span v-else>Sign In</span>
					</Button>
				</form>
			</CardContent>
		</Card>
	</div>
</template>
