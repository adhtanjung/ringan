<script setup lang="ts">
import LoginForm from '@/components/login-01/components/LoginForm.vue'

useSeoMeta({
	title: 'Sign In — Ringan',
	description: 'Sign in to the Ringan administration system.',
})

const { supabase } = useSupabase()
const router = useRouter()

const email = ref('')
const password = ref('')
const loading = ref(false)
const error = ref('')

const handleLogin = async () => {
	if (!email.value || !password.value) return

	loading.value = true
	error.value = ''

	try {
		const { error: authError } = await supabase.auth.signInWithPassword({
			email: email.value,
			password: password.value,
		})

		if (authError) {
			// Human-readable error messages for common Supabase errors
			if (authError.message.includes('Invalid login credentials')) {
				error.value = 'Incorrect email or password. Please try again.'
			} else if (authError.message.includes('Email not confirmed')) {
				error.value = 'Please confirm your email address before signing in.'
			} else if (authError.message.includes('Too many requests')) {
				error.value = 'Too many sign-in attempts. Please wait a moment and try again.'
			} else {
				error.value = 'Unable to sign in. Please check your connection and try again.'
			}
			return
		}

		await router.push('/dashboard')
	} catch (e) {
		error.value = 'Something went wrong. Please try again.'
	} finally {
		loading.value = false
	}
}
</script>

<template>
	<div class="flex min-h-svh w-full items-center justify-center bg-muted/30 p-6 md:p-10">
		<div class="w-full max-w-sm">
			<LoginForm
				v-model:email="email"
				v-model:password="password"
				:loading="loading"
				:error="error"
				@submit="handleLogin"
			/>
		</div>
	</div>
</template>
