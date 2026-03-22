# Ringan Data

Ringan Data is the administration and knowledge-base authoring app for a mental health assessment system. It is used to manage the structured content that an AI or LLM can consume to generate assessments, interpret user responses, and surface approved follow-up suggestions.

Project spec: [docs/project-prd.md](docs/project-prd.md)

## What It Manages

- Categories
- Subcategories
- Assessment questions
- Suggestions
- Next actions
- Feedback prompts
- Training examples

The app provides search, filtering, bulk editing, import/export, record history, and dashboard summaries for these datasets.

## Tech Stack

- Nuxt 4
- Vue 3
- Supabase
- Tailwind CSS
- shadcn-nuxt

## Local Setup

### 1. Install dependencies

```bash
pnpm install
```

### 2. Create environment variables

Copy `.env.example` to `.env` and set the required values.

Required Supabase values:

- `SUPABASE_URL`
- `SUPABASE_PUBLISHABLE_KEY`

Additional values used by the local app and supporting services:

- `SUPABASE_SECRET_KEY`
- `API_BASE_URL`
- `API_SECRET`

Note: the app reads `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` in `nuxt.config.ts`.

### 3. Run the development server

```bash
pnpm dev
```

The app will be available at `http://localhost:3000`.

## Common Scripts

```bash
pnpm dev
pnpm build
pnpm generate
pnpm preview
pnpm watch
```

## Main Pages

- `/dashboard` - dataset summary and recent activity
- `/problem-types` - category management
- `/problems` - subcategory management
- `/assessments` - assessment question management
- `/suggestions` - guidance and suggestion management
- `/next-actions` - follow-up action management

## Domain Notes

This project is designed as a curated knowledge base, not a diagnostic tool.

- Categories organize the taxonomy.
- Subcategories narrow the taxonomy into specific problem areas.
- Assessment questions collect structured signals from the user.
- Suggestions provide approved next-step guidance.
- Next actions, feedback prompts, and training examples support downstream workflows.

## Safety

Mental health content must remain governed and reviewable.

- Do not treat the knowledge base as a replacement for licensed care.
- Do not infer diagnosis from a single answer.
- Keep suggestions supportive and non-judgmental.
- Route high-acuity scenarios to a dedicated safety path.

## Related Documentation

- Product specification: [docs/project-prd.md](docs/project-prd.md)
- Design context: [.impeccable.md](.impeccable.md)

