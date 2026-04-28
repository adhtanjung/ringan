-- Migration: Create response_types table
-- Date: 2026-04-28
-- Purpose: Safety framework response types (R001–R010) that define how the
--          system should respond to detected risk signals, including required
--          elements, tone guidance, example openers, and things to avoid.

create table if not exists public.response_types (
  -- Primary key
  id                uuid primary key default gen_random_uuid(),

  -- Business identifier (e.g. "R001") — unique
  response_id       text not null unique,

  -- Short label for the response type (e.g. "Emotional Support Response")
  response_type     text not null,

  -- When this response should be used
  when_used         text,

  -- Required elements / actions for this response
  required_elements text,

  -- Tone guidance (e.g. "Gentle, warm, non-clinical, non-judgmental")
  tone              text,

  -- Example opening phrase
  example_opener    text,

  -- Things to avoid when using this response
  avoid             text,

  -- Soft delete flag
  is_active         boolean not null default true,

  -- Timestamps
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);

-- Indexes
create index if not exists idx_response_types_is_active
  on public.response_types (is_active);

create index if not exists idx_response_types_response_id
  on public.response_types (response_id);

-- Auto-update updated_at on row modification
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger response_types_set_updated_at
  before update on public.response_types
  for each row execute function public.set_updated_at();

-- Row Level Security
alter table public.response_types enable row level security;

create policy "Authenticated users can read response_types"
  on public.response_types for select
  to authenticated
  using (true);

create policy "Authenticated users can insert response_types"
  on public.response_types for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update response_types"
  on public.response_types for update
  to authenticated
  using (true)
  with check (true);

create policy "Authenticated users can delete response_types"
  on public.response_types for delete
  to authenticated
  using (true);

-- Seed data from the image
insert into public.response_types
  (response_id, response_type, when_used, required_elements, tone, example_opener, avoid)
values
  (
    'R001',
    'Emotional Support Response',
    'Tier 1 distress without suicide/violence content',
    'Validate feelings, reflect the stressor, invite more detail, offer one small coping step.',
    'Gentle, warm, non-clinical, non-judgmental.',
    'I''m really sorry this feels so heavy right now. If you want, you can tell me what happened today.',
    'Do not minimize, rush to crisis language, or over-question.'
  ),
  (
    'R002',
    'Isolation Support Response',
    'Tier 2 loneliness, worthlessness, disconnection',
    'Validate, counter aloneness, ask who could be with them, suggest a trusted person.',
    'Warm and connective.',
    'I''m sorry you''re feeling so alone. What you''re feeling matters, and we can think about one person you could reach out to today.',
    'Do not promise secrecy if safeguarding is needed.'
  ),
  (
    'R003',
    'Passive Death Wish Response',
    'Tier 3 passive death language',
    'Acknowledge seriousness, check immediate safety, encourage not being alone, move toward real-world support.',
    'Calm, direct, supportive.',
    'I''m really glad you said that. When thoughts about not wanting to be here show up, are you safe right now? Is there a trusted person you could be with?',
    'Do not stay only reflective; must include a safety check.'
  ),
  (
    'R004',
    'Suicide Ideation Support Response',
    'Tier 4 active suicidal ideation or recent self-harm',
    'State concern clearly, ask immediate safety question, urge trusted-person contact now, present local crisis options.',
    'Direct, supportive, safety-focused.',
    'I''m really concerned about your safety. Are you in immediate danger right now? Please reach out to a trusted person or local crisis support now while we focus on keeping you safe.',
    'Do not debate reasons for living or provide detailed problem-solving before safety.'
  ),
  (
    'R005',
    'Immediate Safety Response',
    'Tier 5 imminent self-harm or suicide attempt',
    'Interrupt normal flow, direct to emergency/crisis help, encourage immediate human contact, pause non-essential chat.',
    'Brief, urgent, clear.',
    'Your safety is the priority right now. Please contact emergency services or local crisis support immediately, and reach out to a trusted person right now if you can.',
    'Do not continue exploratory conversation after imminent danger is identified.'
  ),
  (
    'R006',
    'Immediate Violence De-escalation Response',
    'Imminent violence toward others or severe agitation',
    'Reduce intensity, urge distance from the person/scene, support contacting emergency/crisis help, avoid tactical advice.',
    'Calm, firm, de-escalating.',
    'I''m concerned someone could get hurt. Please move away from the person or situation right now and contact emergency support or a trusted adult immediately.',
    'Do not validate revenge, target, or violent solutions.'
  ),
  (
    'R007',
    'Abuse Disclosure Safety Response',
    'Abuse, exploitation, or fear of harm from others',
    'Validate, avoid blame, ask whether the user is safe now, guide to trusted adult/protective support.',
    'Warm, protective.',
    'I''m sorry this is happening to you. You do not deserve it. Are you safe right now, and is there a trusted adult or support service you can contact?',
    'Do not pressure for detailed disclosure.'
  ),
  (
    'R008',
    'Panic / Grounding Response',
    'Panic, acute overwhelm, dissociation, trauma activation',
    'Name what is happening, slow the pace, offer a simple grounding step, then reassess safety.',
    'Steady, simple, low-word-count.',
    'Let''s slow this down together. Can you notice your feet on the floor and name one thing you can see right now?',
    'Do not overload with multiple instructions.'
  ),
  (
    'R009',
    'Self-harm / Substance Safety Response',
    'Self-harm urge, recent self-harm, or intoxication-linked risk',
    'Reduce immediate danger, ask about injuries/intoxication severity, encourage not being alone, move to urgent support.',
    'Direct, supportive.',
    'I''m sorry you''re carrying so much. Are you hurt right now, or have you taken anything that could put you in danger? Please get another person with you now.',
    'Do not offer self-harm management tips beyond immediate safety and support-seeking.'
  ),
  (
    'R010',
    'Referral / Follow-up Bridge',
    'When risk is lowering but handoff is still needed',
    'Summarize next safe step, confirm who/when the user will contact, keep bridge to human care.',
    'Practical, clear.',
    'Before we finish, what is the next real-world step you can take in the next 10 minutes, and who can you contact?',
    'Do not close without confirming a next step when risk remains elevated.'
  );
