<script setup lang="ts">
// await navigateTo("/dashboard");
const items = ref(['System', 'Light', 'Dark'])
const value = ref(['System'])
</script>

<template>
	<!-- <div /> -->
	 <UCheckboxGroup v-model="value" :items="items" />
</template>
