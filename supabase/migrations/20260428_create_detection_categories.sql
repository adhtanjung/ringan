-- Migration: Create detection_categories table
-- Date: 2026-04-28
-- Purpose: Safety framework detection categories (D001–D015) that map
--          detected signals to default tiers, linked responses, and workflows.

create table if not exists public.detection_categories (
  -- Primary key
  id                    uuid primary key default gen_random_uuid(),

  -- Business identifier (e.g. "D001") — unique
  code                  text not null unique,

  -- Whether this is an 'Existing' or 'Added' category
  status                text not null check (status in ('Existing', 'Added')),

  -- Short label for the detection type (e.g. "Emotional distress")
  detection_type        text not null,

  -- Full definition of what this category covers
  definition            text not null,

  -- Typical trigger examples / example phrases
  typical_trigger_examples text,

  -- Default tier assignment (free text to allow ranges like "Tier 3–5")
  default_tier          text,

  -- Linked response code (e.g. "R001")
  linked_response       text,

  -- Linked workflow code (e.g. "W001")
  linked_workflow       text,

  -- Soft delete flag
  is_active             boolean not null default true,

  -- Timestamps
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now()
);

-- Indexes
create index if not exists idx_detection_categories_is_active
  on public.detection_categories (is_active);

create index if not exists idx_detection_categories_code
  on public.detection_categories (code);

create index if not exists idx_detection_categories_status
  on public.detection_categories (status);

-- Auto-update updated_at on row modification
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger detection_categories_set_updated_at
  before update on public.detection_categories
  for each row execute function public.set_updated_at();

-- Row Level Security
alter table public.detection_categories enable row level security;

create policy "Authenticated users can read detection_categories"
  on public.detection_categories for select
  to authenticated
  using (true);

create policy "Authenticated users can insert detection_categories"
  on public.detection_categories for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update detection_categories"
  on public.detection_categories for update
  to authenticated
  using (true)
  with check (true);

create policy "Authenticated users can delete detection_categories"
  on public.detection_categories for delete
  to authenticated
  using (true);

-- Seed data from the image
insert into public.detection_categories
  (code, status, detection_type, definition, typical_trigger_examples, default_tier, linked_response, linked_workflow)
values
  (
    'D001', 'Existing', 'Emotional distress',
    'Low to moderate emotional pain without self-harm language.',
    'Sad, overwhelmed, exhausted, crying, academic/family pressure.',
    'Tier 1', 'R001', 'W001'
  ),
  (
    'D002', 'Existing', 'Isolation / worthlessness',
    'Disconnection, burden beliefs, invisibility, shame.',
    '''Nobody cares'', ''I''m a burden'', ''I don''t matter''.',
    'Tier 2', 'R002', 'W002'
  ),
  (
    'D003', 'Existing', 'Passive death wishes',
    'Wishing to disappear or not wake up without active plan.',
    '''I wish I wasn''t here'', ''I want everything to stop''.',
    'Tier 3', 'R003', 'W003'
  ),
  (
    'D004', 'Existing', 'Suicidal ideation',
    'Direct statements about wanting to die or kill oneself.',
    '''I want to die'', ''I''m thinking about suicide''.',
    'Tier 4', 'R004', 'W004'
  ),
  (
    'D005', 'Existing', 'Imminent suicide attempt',
    'Attempt reported, attempt in progress, or immediate lethal intent.',
    '''I already took pills'', ''I''m ending it now''.',
    'Tier 5', 'R005', 'W005 / E001'
  ),
  (
    'D006', 'Existing', 'Self-harm behavior',
    'Cutting, burning, hitting self, or other self-injury.',
    '''I cut myself'', ''I hurt myself after the fight''.',
    'Tier 4', 'R004 or R009', 'W006'
  ),
  (
    'D007', 'Existing', 'Violence toward others',
    'Threats or intent to seriously harm another person.',
    '''I''m going to hurt him'', target/time/means language.',
    'Tier 5', 'R006', 'W007 / E002'
  ),
  (
    'D008', 'Existing', 'Abuse or harm disclosure',
    'User reports abuse, coercion, exploitation, or harm from others.',
    'Physical/sexual abuse, threats at home, stalking.',
    'Tier 3–5 depending on immediacy', 'R007', 'W008'
  ),
  (
    'D009', 'Added', 'Panic / acute overwhelm',
    'High physiological arousal or panic-like loss of control.',
    '''Can''t breathe'', shaking, racing heart, ''I can''t calm down''.',
    'Tier 2', 'R008', 'W009'
  ),
  (
    'D010', 'Added', 'Trauma / fear response',
    'Flashbacks, fear, nightmares, hypervigilance, freeze response.',
    '''I keep seeing it happen again'', ''I''m scared he''ll come back''.',
    'Tier 2–4', 'R008 or R007', 'W010'
  ),
  (
    'D011', 'Added', 'Substance-related safety risk',
    'Alcohol/drug use that amplifies self-harm or suicide risk.',
    'Intoxicated plus despair, overdose concerns, impaired judgment.',
    'Tier 3–5 depending on intent', 'R009 or R005', 'W011'
  ),
  (
    'D012', 'Added', 'Dissociation / numbness / detachment',
    'Feeling unreal, empty, disconnected, or emotionally absent.',
    '''I feel numb'', ''nothing feels real''.',
    'Tier 2–3', 'R008', 'W012'
  ),
  (
    'D013', 'Added', 'Preparatory behavior / access to means',
    'Gathering pills, looking for methods, holding a weapon, goodbye messages.',
    'Means access, rehearsal, giving away items.',
    'Tier 4–5', 'R004 or R005', 'W013'
  ),
  (
    'D014', 'Added', 'Severe agitation / impulsive escalation',
    'Rapidly escalating anger, revenge thinking, inability to slow down.',
    'Threat bursts, pacing, ''I might do something bad''.',
    'Tier 3–5', 'R006', 'W007 or W014'
  ),
  (
    'D015', 'Added', 'Social withdrawal / functional decline',
    'Marked dropout from daily life that may precede higher risk.',
    'Stopped attending school, isolating, not eating, not sleeping.',
    'Tier 2–3', 'R002', 'W015'
  );
