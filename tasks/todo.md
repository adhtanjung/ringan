# Data Preparation Roadmap One-Slide 16:9 Refit

## Checklist
- [x] Redesign `public/data-preparation-roadmap.html` into a single 16:9 presentation slide.
- [x] Keep the slide viewport-fit with no internal scrolling and emphasize the current Phase 2 work.
- [x] Verify the slide serves correctly and document the result.

## Review
- Rebuilt `public/data-preparation-roadmap.html` as a single-slide 16:9 presentation artifact with one `.slide` container and viewport-fit CSS.
- Reframed the content into a presentation-safe composition: title panel, current-state callout, compact status panel, and a five-card phase timeline with Phase 2 dominant.
- Kept the current work explicit: Phase 2 is preparing assessment questions and suggestions for the pilot slice.
- Tightened the right-side timeline after render feedback by simplifying each phase card and replacing the bottom two-box row with a compact inline rail.
- Added a true 16:9 canvas wrapper that scales to fit the browser window, so the slide stays centered and fully visible at 100% zoom instead of clipping against the viewport.
- Refined the awkward right-side phase section into a compact milestone ribbon with short card-style phase nodes and a single current-phase focus band, so the hierarchy reads clearly at presentation scale instead of feeling stretched or crowded.
- Verification: confirmed the file serves with `HTTP/1.0 200 OK`, confirmed exactly one `.slide` exists, confirmed `height: 100vh`, `height: 100dvh`, and `overflow: hidden` are present with no remaining `week`/`wave` labels, and visually checked the rendered slide via Playwright screenshot at `tmp/slides/data-preparation-roadmap-check.png`.

# Data Preparation Roadmap Typography Rebalance

## Checklist
- [x] Reduce over-compressed microcopy in the right-side timeline section.
- [x] Increase phase and focus typography while preserving one-slide fit.
- [x] Re-render the slide at browser scale and document the result.

## Review
- Reduced the right-side timeline copy to slide-safe phrasing instead of paragraph fragments squeezed into milestone cards.
- Increased the phase-card, timeline heading, focus-band, and rail typography so the right column reads at presentation scale without collapsing into microtype.
- Simplified the current-phase band from a three-column callout into a stronger two-column focus block with a short next-handoff pill.
- Verification: re-rendered the updated slide in-browser with Playwright and confirmed the larger type still fits cleanly in `tmp/slides/data-preparation-roadmap-check.png`.

# Data Preparation Roadmap HTML Phase Refresh

## Checklist
- [x] Rename roadmap timeline language from week-based labels to phase-based labels throughout `public/data-preparation-roadmap.html`.
- [x] Make the timeline denser and more prominent, with a clear current-state emphasis on Phase 2.
- [x] Verify the updated HTML content and document the result.

## Review
- Rebuilt `public/data-preparation-roadmap.html` as a phase-based roadmap with a denser layout, a five-phase timeline, and a compact hero that points directly at the active execution state.
- Made `Phase 2` visually dominant and explicitly framed it as preparing assessment questions and suggestions for the pilot slice.
- Verification: confirmed the file serves with `HTTP/1.0 200 OK` from a local `python3 -m http.server`, and verified there are no remaining visible `week`/`wave` labels in the HTML.

# Data Preparation Roadmap Spreadsheet Timeline

## Checklist
- [x] Extract roadmap waves, gate conditions, and assumptions from `public/data-preparation-roadmap.html`.
- [x] Create a workbook tracker artifact under `output/spreadsheet/` with phase-based naming, editable tracking fields, and structured source notes.
- [x] Verify the workbook opens cleanly and document the result.

## Review
- Updated `output/spreadsheet/data-preparation-roadmap-timeline.xlsx` into a tracker-first workbook with a `Tracker` sheet and a `Source Notes` sheet derived from the roadmap HTML.
- Reframed the sequence from week labels into `Phase 0` through `Phase 4`, while preserving the original roadmap mapping in comments and the source-notes sheet.
- Added editable tracker columns for status, owner, progress, dependencies/blockers, next action, exit criteria, and phase markers so the spreadsheet can be used as the working roadmap tracker.
- Verification: reloaded the workbook successfully with `openpyxl`, confirmed sheet names and row content, and confirmed the artifact is a valid `Microsoft Excel 2007+` file.
- Limitation: visual PDF rendering was not run because `soffice` is not installed in this environment.

# Data Preparation Roadmap Frontend-Slides Refresh

## Checklist
- [ ] Reframe `public/data-preparation-roadmap.html` from a dense single slide into a clearer multi-slide HTML presentation.
- [ ] Apply the `frontend-slides` viewport-safe base rules, stronger typography, and a distinct preset-driven visual direction.
- [ ] Keep the deck self-contained with inline CSS/JS, keyboard/wheel/touch navigation, progress UI, and reveal-on-enter motion.
- [ ] Validate no slide overflows at `1920x1080`, `1280x720`, `768x1024`, `375x667`, and `667x375`.

## Review
- In progress.

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

# Wave-Based Data Preparation HTML Roadmap

## Checklist
- [x] Create a standalone printable HTML roadmap at `public/data-preparation-roadmap.html`.
- [x] Present the plan as a release-gated roadmap with pilot slice, expansion waves, and launch readiness.
- [x] Keep the layout clear, accessible, and suitable for stakeholder review.
- [x] Verify the file loads correctly in a local HTTP server.

## Review
- Added a standalone stakeholder-facing roadmap at `public/data-preparation-roadmap.html` with a calm, high-legibility editorial layout.
- The page frames data preparation as a release-gated workflow: taxonomy lock, pilot slice, validation, expansion waves, and launch readiness.
- Included print support, responsive behavior, and a clear note that the spreadsheet remains the working source of truth.
- Verification: served the file with `python3 -m http.server 4173` and confirmed `GET /data-preparation-roadmap.html` returned `200 OK`.

# Single-Slide Frontend Slides Rewrite

## Checklist
- [x] Rewrite `public/data-preparation-roadmap.html` as a single viewport-fit slide deck.
- [x] Remove external font dependencies and keep the file self-contained.
- [x] Add keyboard, wheel, touch, and slide-index controls plus reveal-on-enter behavior.
- [x] Validate the slide fits without scrolling at common desktop and mobile sizes.

## Review
- Rewrote `public/data-preparation-roadmap.html` into a single self-contained slide with one viewport-filling `.slide`, inline CSS and JS, and no external font dependency.
- Added presentation controls for keyboard, wheel, touch, and slide-index updates, plus reveal-on-enter behavior for the slide content.
- Browser validation passed at `1920x1080`, `1280x720`, `768x1024`, `375x667`, and `667x375` with no horizontal or vertical overflow.
