# Rule Catalog — Code Quality

## Conditional class names use utility function

IsUrgent: True
Category: Code Quality

### Description

Ensure conditional CSS is handled via the shared `cn` utility (from `@/lib/utils`) instead of custom ternaries, string concatenation, or template strings in `:class` bindings when logic is complex. Centralizing class logic keeps components consistent and easier to maintain.

### Suggested Fix

```ts
import { cn } from '@/lib/utils'
// In script:
const classNames = cn(isActive ? 'text-primary-600' : 'text-gray-500')
// In template:
<div :class="cn('base-class', isActive && 'active-class', className)"></div>
```

## Tailwind-first styling

IsUrgent: True
Category: Code Quality

### Description

Favor Tailwind CSS utility classes instead of adding new `.module.css` files or `<style>` blocks unless a Tailwind combination cannot achieve the required styling. Keeping styles in Tailwind improves consistency and reduces maintenance overhead.

Update this file when adding, editing, or removing Code Quality rules so the catalog remains accurate.

## Classname ordering for easy overrides

### Description

When writing components, always place the incoming `className` (or `class` in Vue) prop after the component’s own class values in the `cn` utility so that downstream consumers can override or extend the styling.

Example:

```vue
<script setup>
import { cn } from "@/lib/utils";
const props = defineProps({
	class: { type: String, default: "" },
});
</script>

<template>
	<div :class="cn('bg-primary-600 px-4 py-2', props.class)">
		<slot />
	</div>
</template>
```
