-- Migration: Create opening_questions table
-- Date: 2026-04-23
-- Purpose: Top-of-funnel questions shown before general questions.
--          Each question either continues to another opening question
--          or redirects to a category (which then routes into general questions).

create table if not exists public.opening_questions (
  id                    uuid primary key default gen_random_uuid(),

  -- Business identifier (e.g. "OQ001")
  question_id           text not null unique,

  -- The question text shown to the user
  question_text         text not null,

  -- How the user answers: 'yes/no' | 'multiple choice'
  response_type         text not null,

  -- ── Yes/No routing ──────────────────────────────────────────────────────────
  -- Each branch: destination_type = 'opening_question' | 'category'
  yes_destination_type  text,   -- 'opening_question' | 'category'
  yes_destination_value text,   -- opening question_id  OR  category name

  no_destination_type   text,
  no_destination_value  text,

  -- ── Multiple choice routing ──────────────────────────────────────────────────
  -- JSON array of { option_text, destination_type, destination_value }
  choices               jsonb,

  -- Display order
  order_number          integer,

  -- Soft delete
  is_active             boolean not null default true,

  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now()
);

create index if not exists idx_opening_questions_is_active    on public.opening_questions (is_active);
create index if not exists idx_opening_questions_question_id  on public.opening_questions (question_id);
create index if not exists idx_opening_questions_response_type on public.opening_questions (response_type);
create index if not exists idx_opening_questions_order_number on public.opening_questions (order_number);

-- Reuse the set_updated_at function (already created by general_questions migration)
create trigger opening_questions_set_updated_at
  before update on public.opening_questions
  for each row execute function public.set_updated_at();

alter table public.opening_questions enable row level security;

create policy "Authenticated users can read opening_questions"
  on public.opening_questions for select to authenticated using (true);

create policy "Authenticated users can insert opening_questions"
  on public.opening_questions for insert to authenticated with check (true);

create policy "Authenticated users can update opening_questions"
  on public.opening_questions for update to authenticated using (true) with check (true);

create policy "Authenticated users can delete opening_questions"
  on public.opening_questions for delete to authenticated using (true);
