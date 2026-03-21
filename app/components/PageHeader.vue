<script setup lang="ts">
import { Separator } from "@/components/ui/separator";

defineProps<{
  title: string;
  description?: string;
}>();
</script>

<template>
  <div class="space-y-4 px-4 py-6 md:px-8">
    <div class="flex items-center justify-between space-y-2">
      <div class="space-y-1">
        <h1 class="text-2xl font-bold tracking-tight">{{ title }}</h1>
        <p v-if="description" class="text-base text-muted-foreground">
          {{ description }}
        </p>
      </div>
      <div class="flex items-center space-x-2">
        <slot name="actions" />
      </div>
    </div>
    <Separator />
    <slot />
  </div>
</template>
