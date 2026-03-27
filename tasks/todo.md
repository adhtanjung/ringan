# Relation Context UX Plan (All Relation Drawers)

## Checklist
- [x] Add shared `RelationContextBlock` component with loading/resolved/missing/not-found/error states.
- [x] Extend drawer summary types and relation summary builders.
- [x] Add on-open relation summary fetching + cached list prefetch in all `use*Drawers` composables.
- [x] Wire relation summary props into all relation-enabled drawers.
- [x] Validate `AssessmentDetailDrawer` shows connected subcategory context immediately.
- [x] Run `pnpm build` and fix regressions.

## Review
- Added a reusable relation-context component at `app/components/admin/drawers/RelationContextBlock.vue` to standardize linked-entity clarity and state handling.
- Extended `app/composables/drawers/types.ts` with shared relation summary types/state and added summary builders in `app/composables/drawerRelations.ts`.
- Upgraded all drawer composables (`useProblemsDrawers`, `useProblemTypesDrawers`, `useAssessmentsDrawers`, `useSuggestionsDrawers`, `useNextActionsDrawers`) to:
  - prefetch relation summaries when detail drawers open
  - expose relation-summary state to drawer components
  - reuse cached linked-list query results when opening `LinkedRecordsSheet`.
- Updated all scoped relation drawers to render `RelationContextBlock` and keep existing relation actions/copy-id behavior intact.
- Updated page integrations to pass context props and retry handlers to drawers.
- Verification: `pnpm build` passes successfully.

# Global Filter Scope Fix (Server Options, Not Page Slice)

## Checklist
- [x] Refactor Supabase query composition in `useDatasetManagement` so search/filter application is reusable.
- [x] Add `filterOptions` state and server-side option fetching with `omitFilterKey` support.
- [x] Keep option queries pagination-free while preserving server-side row filtering.
- [x] Update `DatasetTable` to consume external `filterOptions` with fallback behavior.
- [x] Replace Problem Types legacy `domain` filter UI with `category_id`.
- [x] Pass `filterOptions` from all active table pages (`problems`, `problem-types`, `assessments`, `suggestions`, `next-actions`).
- [x] Run `pnpm build` and validate no regressions.

## Review
- Added reusable query helpers (`applySearchToQuery`, `applyFiltersToQuery`, `buildSupabaseQuery`) in `useDatasetManagement` to standardize query context handling.
- Added composable-level `filterOptions` that fetches distinct option values from Supabase using current search + other active filters while explicitly ignoring pagination.
- Implemented mapping-specific option hydration:
  - `problems`: `category`, `sub_category_id` (with name)
  - `assessments`: `sub_category_id` (enriched from `problems`)
  - `suggestions`: `cluster`
  - `problem_types`: `category_id`
- Updated `DatasetTable` to prioritize server-provided options (including correctly preserving empty option sets), with fallback only when options are not provided.
- Updated Problem Types filter key/label from `domain` to `category_id`.
- Wired `filterOptions` prop in all active page integrations.
- Verification: `pnpm build` passes successfully.
