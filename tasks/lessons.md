# Lessons

## 2026-03-26 - Route Availability Verification
- **Correction trigger**: User reported `Page not found: /assessment-demo` with Vue Router `No match found`.
- **Pattern**: UI/page changes were delivered without explicit runtime route verification for the target path.
- **Rule**: After adding or modifying a page route, always verify target paths by:
  1. Running the dev server.
  2. Requesting the route directly (`curl`/browser).
  3. Confirming no `No match found` router warnings.
- **Prevention**: Add defensive route registration when environment-specific route discovery can drift.

## 2026-03-26 - Full-Scope Refactor Completion
- **Correction trigger**: User asked to refactor drawers for all scoped pages after partial implementation.
- **Pattern**: Structural refactor was started but not completed across the full declared scope before handoff.
- **Rule**: For multi-page refactors, define the exact in-scope file list up front and do not report completion until every listed file is migrated and build-verified.
- **Prevention**: Track page-by-page completion in `tasks/todo.md`, run a scope grep for legacy patterns, then run `pnpm build` before final response.

## 2026-03-27 - Relation UX Must Show Human Context First
- **Correction trigger**: User reported drawer relation context remained confusing, especially in assessment details.
- **Pattern**: IDs and relation actions were present, but human-readable linked context was not prominent or complete enough (e.g., missing category context fallback).
- **Rule**: For every relation ID in detail drawers, show linked title + relation context + stable ID on open, without requiring extra clicks.
- **Prevention**: Validate each relation block against a checklist: `title visible`, `context subtitle visible`, `ID visible`, `loading/error/missing/not-found states`, and `action still works`.

## 2026-03-27 - Filter Options Must Not Come From Paginated Rows
- **Correction trigger**: User reported filters only worked against currently displayed paginated items.
- **Pattern**: Filter dropdown options were derived from `props.data` (current page slice), creating incomplete option lists and misleading filtering behavior.
- **Rule**: Never derive filter options from paginated table rows for server-backed datasets. Fetch options from server with the same query context (search + other filters) but without pagination.
- **Prevention**: Keep `filterOptions` in dataset composable, reuse shared query builder with `omitFilterKey`, and validate that option lists contain values not visible on the current page.
