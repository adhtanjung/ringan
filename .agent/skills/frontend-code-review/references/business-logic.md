# Rule Catalog — Business Logic

## Composable execution context

IsUrgent: True

### Description

Many Nuxt composables (like `useRuntimeConfig`, `useRoute`, `useSupabase`) rely on the Nuxt context and must be executed during `setup()` or at the top level of a component/composable. Avoid calling them inside async callbacks or nested functions that might execute after the component is initialized.

### Suggested Fix

Call composables at the top level and store the result for later use.

Wrong:

```ts
const handleAction = async () => {
	const config = useRuntimeConfig(); // Error in some contexts
	await clearData(config.public.adminApiUrl);
};
```

Right:

```ts
const config = useRuntimeConfig();
const handleAction = async () => {
	await clearData(config.public.adminApiUrl);
};
```

## Dataset Type consistency

IsUrgent: True

### Description

When using `useDatasetManagement(dataType)`, ensure the `dataType` matches the expected database table name or API endpoint segment. Passing mismatched types can lead to schema errors or silent failures.
