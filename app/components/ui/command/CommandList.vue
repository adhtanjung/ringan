<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import { ComboboxContent, type ComboboxContentEmits, type ComboboxContentProps, useForwardPropsEmits } from 'reka-ui'
import { cn } from '@/lib/utils'

const props = defineProps<ComboboxContentProps & { class?: HTMLAttributes['class'] }>()
const emits = defineEmits<ComboboxContentEmits>()

const forwarded = useForwardPropsEmits(props, emits)
</script>

<template>
  <ComboboxContent v-bind="forwarded" :class="cn('max-h-[300px] overflow-y-auto overflow-x-hidden', props.class)">
    <div role="presentation">
      <slot />
    </div>
  </ComboboxContent>
</template>
