<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import { ComboboxGroup, type ComboboxGroupProps, useForwardProps } from 'reka-ui'
import { cn } from '@/lib/utils'

const props = defineProps<ComboboxGroupProps & { class?: HTMLAttributes['class'], heading?: string }>()

const forwarded = useForwardProps(props)
</script>

<template>
  <ComboboxGroup
    v-bind="forwarded"
    :class="cn('overflow-hidden p-1 text-foreground [&_[cmdk-group-heading]]:px-2 [&_[cmdk-group-heading]]:py-1.5 [&_[cmdk-group-heading]]:text-xs [&_[cmdk-group-heading]]:font-medium [&_[cmdk-group-heading]]:text-muted-foreground', props.class)"
  >
    <div v-if="heading" class="px-2 py-1.5 text-xs font-medium text-muted-foreground" cmdk-group-heading>
      {{ heading }}
    </div>
    <slot />
  </ComboboxGroup>
</template>
