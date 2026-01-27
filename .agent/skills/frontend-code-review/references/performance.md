# Rule Catalog — Performance

## Efficient Data Reactivity

IsUrgent: True
Category: Performance

### Description

For large datasets, prefer `shallowRef` or `shallowReactive` over `ref` or `reactive` if the items themselves don't need to be deeply reactive. This avoids the overhead of observer creation for deeply nested objects that are only updated via re-assignment.

## Computed vs Watch

IsUrgent: True
Category: Performance

### Description

Favor `computed` properties for derived data instead of using `watch` with a `ref`. Computed properties are cached and only re-evaluate when their dependencies change, whereas `watch` can lead to unnecessary multi-step updates and complexity.

## v-memo usage

Category: Performance

### Description

Use `v-memo` for complex lists (like `v-for` on long tables) to skip updates of component subtrees when data hasn't changed. This is particularly useful for rows in a large table where only one row might change at a time.

Update this file when adding, editing, or removing Performance rules so the catalog remains accurate.

Wrong:

```vue
<script setup>
const props = defineProps(['items'])
const processedItems = ref([])
watch(() => props.items, (newVal) => {
  processedItems.value = newVal.map(...)
}, { immediate: true })
</script>
```

Right:

```vue
<script setup>
const props = defineProps(['items'])
const processedItems = computed(() => props.items.map(...))
</script>
```
