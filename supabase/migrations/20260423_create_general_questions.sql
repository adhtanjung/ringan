-- Migration: Create general_questions table
-- Date: 2026-04-23
-- Purpose: Decision-tree questions that guide the AI conversation before routing
--          users to a specific mental health category/subcategory.

create table if not exists public.general_questions (
  -- Primary key
  id                    uuid primary key default gen_random_uuid(),

  -- Business identifier (e.g. "Q001") — unique, used in routing logic
  question_id           text not null unique,

  -- The question text shown to the user
  question_text         text not null,

  -- How the user answers: 'yes/no' | 'multiple choice' | 'auto-route'
  response_type         text not null,

  -- Optional top-level mental health category tag
  category              text,

  -- For 'auto-route': directly routes to this subcategory code
  leads_to_subcategory  text,

  -- For 'yes/no': typed destination fields
  yes_destination_type  text,   -- 'subcategory' | 'suggestion' | 'question'
  yes_destination_value text,

  no_destination_type   text,   -- 'subcategory' | 'suggestion' | 'question'
  no_destination_value  text,

  -- Legacy yes/no fields (kept for backward compatibility)
  next_question_if_yes  text,
  next_question_if_no   text,

  -- For 'multiple choice': JSON array of { option_text, destination_type, destination_value }
  choices               jsonb,

  -- Display order within the decision tree
  order_number          integer,

  -- Soft delete flag
  is_active             boolean not null default true,

  -- Timestamps
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now()
);

-- Index for common query patterns
create index if not exists idx_general_questions_is_active
  on public.general_questions (is_active);

create index if not exists idx_general_questions_question_id
  on public.general_questions (question_id);

create index if not exists idx_general_questions_category
  on public.general_questions (category);

create index if not exists idx_general_questions_response_type
  on public.general_questions (response_type);

create index if not exists idx_general_questions_order_number
  on public.general_questions (order_number);

-- Auto-update updated_at on row modification
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger general_questions_set_updated_at
  before update on public.general_questions
  for each row execute function public.set_updated_at();

-- Enable Row Level Security (adjust policies to match your auth setup)
alter table public.general_questions enable row level security;

-- Allow authenticated users full access (adjust as needed)
create policy "Authenticated users can read general_questions"
  on public.general_questions for select
  to authenticated
  using (true);

create policy "Authenticated users can insert general_questions"
  on public.general_questions for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update general_questions"
  on public.general_questions for update
  to authenticated
  using (true)
  with check (true);

create policy "Authenticated users can delete general_questions"
  on public.general_questions for delete
  to authenticated
  using (true);
