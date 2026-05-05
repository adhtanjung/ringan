-- Migration: Create category_keywords table
-- Date: 2026-05-05
-- Purpose: Keywords used to train the AI to detect and route users to the
--          correct category or subcategory based on what they say.

create table if not exists public.category_keywords (
  -- Primary key
  id              uuid primary key default gen_random_uuid(),

  -- Business identifier (e.g. "KW001") — unique
  keyword_id      text not null unique,

  -- The keyword or phrase the AI should detect
  keyword         text not null,

  -- Optional: link to a top-level category (problem_types.category_id)
  category_id     text,

  -- Optional: link to a subcategory (problems.sub_category_id)
  sub_category_id text,

  -- Soft delete flag
  is_active       boolean not null default true,

  -- Timestamps
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

-- Indexes
create index if not exists idx_category_keywords_is_active
  on public.category_keywords (is_active);

create index if not exists idx_category_keywords_keyword_id
  on public.category_keywords (keyword_id);

create index if not exists idx_category_keywords_category_id
  on public.category_keywords (category_id);

create index if not exists idx_category_keywords_sub_category_id
  on public.category_keywords (sub_category_id);

-- Auto-update updated_at on row modification
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger category_keywords_set_updated_at
  before update on public.category_keywords
  for each row execute function public.set_updated_at();

-- Row Level Security
alter table public.category_keywords enable row level security;

create policy "Authenticated users can read category_keywords"
  on public.category_keywords for select
  to authenticated
  using (true);

create policy "Authenticated users can insert category_keywords"
  on public.category_keywords for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update category_keywords"
  on public.category_keywords for update
  to authenticated
  using (true)
  with check (true);

create policy "Authenticated users can delete category_keywords"
  on public.category_keywords for delete
  to authenticated
  using (true);
