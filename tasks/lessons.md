# Lessons

## 2026-03-30 - One-Slide Requests Need Literal Slide Constraints
- **Correction trigger**: User asked to fit the roadmap into a single 16:9 presentation slide after previous iterations still behaved like a page or multi-section roadmap.
- **Pattern**: Even when content is concise, a page-style layout can drift away from true slide behavior unless the implementation is explicitly rebuilt around the viewport-fit slide contract.
- **Rule**: When the user asks for one slide, implement a literal single `.slide` artifact with `height: 100vh`, `height: 100dvh`, `overflow: hidden`, and content density designed for one screen only.
- **Prevention**: Verify four things before handoff: `exactly one .slide`, `viewport-fit CSS present`, `no internal scrolling`, and `content rewritten for slide density instead of page density`. If the browser window may not be 16:9, use a fixed-aspect canvas fitted inside the viewport rather than assuming viewport-filling alone will behave like a presentation slide.

## 2026-03-30 - Roadmap Views Must Reflect The Current Operating Phase
- **Correction trigger**: User asked to change the HTML roadmap from week naming to phase naming, make it denser, and emphasize that the team is currently in Phase 2 preparing assessment questions and suggestions.
- **Pattern**: A roadmap page can preserve old planning language even after the operating model has shifted, which makes the artifact feel disconnected from the team's real execution state.
- **Rule**: When updating roadmap visuals, align the naming model with the team's active planning language and visibly highlight the current phase, current work, and immediate next transition.
- **Prevention**: Before handoff, check three things explicitly: `labels match the current planning model`, `the current phase is visually dominant`, and `the page states what the team is doing right now`.

## 2026-03-30 - Spreadsheet Roadmaps Need User Framing, Not Presentation Framing
- **Correction trigger**: User asked to switch the roadmap workbook from week naming to phase naming and to treat the spreadsheet as the tracker itself.
- **Pattern**: Converting roadmap content too literally from a presentation artifact produced a workbook that looked polished but still reflected stakeholder-slide language instead of operational tracker language.
- **Rule**: When a spreadsheet is the working tool, default to tracker semantics first: phase/stage naming, editable owner/status/progress fields, dependencies, and next actions. Do not preserve week-based or presentation-only labels if the user wants an execution tracker.
- **Prevention**: Before shipping a spreadsheet converted from slides or HTML, explicitly verify these two points: `naming model matches the user's operating language` and `the workbook is actionable as a tracker, not just readable as a summary`.

## 2026-03-30 - Slide Timelines Need Deliberate Massing, Not Shrunk Page Fragments
- **Correction trigger**: User flagged the right-side phase timeline as awkward even after the overlap and viewport-fit issues were fixed.
- **Pattern**: A phase roadmap can technically fit inside a slide while still looking unresolved if the timeline is composed from narrow, text-heavy columns or page-like fragments that have been merely compressed.
- **Rule**: For slide-sized timelines, use compact milestone blocks with one dominant current-phase band. Avoid tall micro-columns, tiny stacked copy, or secondary callouts that compete with the phase sequence.
- **Prevention**: Before handoff, zoom out and judge the slide as a presentation artifact, not just a DOM layout. Verify these three points: `phase sequence reads left-to-right immediately`, `current phase is the visual anchor`, and `no phase card feels like a squeezed handout column`.

## 2026-03-30 - Do Not Fix Slide Fit By Shrinking Readability
- **Correction trigger**: User asked why the font had become really small after the timeline redesign.
- **Pattern**: After overlap or fit issues, it is easy to preserve layout by reducing typography and packing copy more tightly, which technically fits but weakens the slide as a presentation artifact.
- **Rule**: When a slide section feels cramped, reduce copy density and simplify structure before reducing type size. Protect readable presentation-scale text, especially in milestone cards and secondary panels.
- **Prevention**: Before handoff, inspect the slide at browser scale and ask: `can the secondary column be read without zooming?`, `did I shorten the copy before shrinking the type?`, and `does the solution improve hierarchy instead of only preserving fit?`

## 2026-03-29 - Frontend Slides Must Be Slide-Based
- **Correction trigger**: User asked to rewrite the roadmap into a single slide after review found a scrolling handout instead of a viewport-fit presentation.
- **Pattern**: Treating a presentation request like a long static page produces content that fails the deck workflow even if the copy is good.
- **Rule**: For `frontend-slides`, every deliverable must be a true slide deck structure with `.slide` panels, viewport-sized layout, inline navigation/controller JS, and no internal scrolling.
- **Prevention**: Check the artifact against the deck contract before handoff: single-view fit, self-contained assets, controller present, reveal logic present, and no external font or script dependencies unless explicitly allowed.

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
