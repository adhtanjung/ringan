-- Migration: Create risk_classifications table
-- Date: 2026-04-28
-- Purpose: Safety framework risk classification tiers (Tier 1–4) with
--          expanded definitions, indicators, decision boundaries, response goals,
--          referral guidance, and linked response codes.

create table if not exists public.risk_classifications (
  -- Primary key
  id                      uuid primary key default gen_random_uuid(),

  -- Business identifier (e.g. "RC001") — unique, used in routing/linking logic
  classification_id       text not null unique,

  -- Tier number (1–4)
  tier                    integer not null check (tier between 1 and 10),

  -- Short label for the tier (e.g. "Emotional distress")
  framework_label         text not null,

  -- Full expanded definition of this tier
  expanded_definition     text not null,

  -- Typical indicators / example phrases
  typical_indicators      text,

  -- Decision boundary — when to use this tier vs adjacent tiers
  decision_boundary       text,

  -- Primary response goal for this tier
  primary_response_goal   text,

  -- Referral / handoff guidance
  referral_guidance       text,

  -- Linked response code (e.g. "R001 Emotional Support")
  linked_response         text,

  -- Soft delete flag
  is_active               boolean not null default true,

  -- Timestamps
  created_at              timestamptz not null default now(),
  updated_at              timestamptz not null default now()
);

-- Indexes
create index if not exists idx_risk_classifications_is_active
  on public.risk_classifications (is_active);

create index if not exists idx_risk_classifications_tier
  on public.risk_classifications (tier);

create index if not exists idx_risk_classifications_classification_id
  on public.risk_classifications (classification_id);

-- Auto-update updated_at on row modification
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger risk_classifications_set_updated_at
  before update on public.risk_classifications
  for each row execute function public.set_updated_at();

-- Row Level Security
alter table public.risk_classifications enable row level security;

create policy "Authenticated users can read risk_classifications"
  on public.risk_classifications for select
  to authenticated
  using (true);

create policy "Authenticated users can insert risk_classifications"
  on public.risk_classifications for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update risk_classifications"
  on public.risk_classifications for update
  to authenticated
  using (true)
  with check (true);

create policy "Authenticated users can delete risk_classifications"
  on public.risk_classifications for delete
  to authenticated
  using (true);

-- Seed data from the image
insert into public.risk_classifications
  (classification_id, tier, framework_label, expanded_definition, typical_indicators, decision_boundary, primary_response_goal, referral_guidance, linked_response)
values
  (
    'RC001', 1, 'Emotional distress',
    'Low-intensity emotional pain without direct self-harm or suicide content. The user may sound sad, overwhelmed, discouraged, or frustrated, but there is no expressed wish to die and no stated danger to self or others.',
    'Sadness, stress, crying, hopeless tone, sleep problems, academic or relationship strain, "I feel empty", "everything is too heavy".',
    'Use Tier 1 when distress is present but there is no worthlessness/burden language that meaningfully increases concern, and no self-harm, suicide, or violence content.',
    'Keep the user engaged, and monitor for escalation. Offer self-help tools and invite support-seeking.',
    'Suggest a trusted adult, peer, mentor, or school counselor if the user wants more help. Human escalation is optional, not automatic.',
    'R001 Emotional Support'
  ),
  (
    'RC002', 2, 'Isolation or worthlessness',
    'Moderate emotional risk marked by loneliness, burden beliefs, invisibility, shame, or functional decline, but without an expressed wish to die. This tier matters because social disconnection can precede suicidal language in adolescents and young adults.',
    '"Nobody cares", "I''m a burden", social withdrawal, no one to talk to, not eating, not attending school/college, panic, or shutdown without suicide content.',
    'Use Tier 2 when distress is coupled with isolation, worthlessness, or marked passive death wishes, but the user is not yet expressing passive death wishes.',
    'Reduce isolation, check whether the user is alone, and increase connection to a trusted person or support.',
    'Recommend contacting a trusted adult/friend; suggest school or campus counselor, youth worker, or mental health support if issues are persistent or worsening. Consider same-day human review if the user is a minor, highly withdrawn, or deteriorating quickly.',
    'R002 Isolation Support'
  ),
  (
    'RC003', 3, 'Passive death wishes',
    'High concern. The user expresses not wanting to exist, wishing to disappear, or wishing they would not wake up, but does not yet state an active plan or clear intent to end their life.',
    '"I wish I wasn''t born", "I wish I could disappear", "I don''t want to wake up tomorrow", repeated hopelessness plus death-related language.',
    'Use Tier 3 when death is referenced as a desired state, but there is no clear active suicide statement, no plan, and no imminent action reported.',
    'Acknowledge the seriousness, perform a safety check, keep the user talking, and move quickly toward real-world support.',
    'Warm handoff is recommended; encourage immediate contact with a trusted adult/family member/friend and provide crisis options. For minors, same-day human review is strongly preferred.',
    'R003 Passive Death Wish'
  ),
  (
    'RC004', 4, 'Suicidal ideation',
    'Urgent risk. The user expresses wanting to die, kill themself, hurt themself, or end their life, but has not clearly reported an attempt in progress or an immediate lethal action underway.',
    '"I want to die", "I want to kill myself", "I''m thinking about suicide", self-harm behaviour, preparatory thoughts, access-to-means concerns, severe intoxication plus suicidal thinking.',
    'Use Tier 4 when there is active self-harm or suicide ideation, or when the user reports recent self-harm or suicide-related thinking without a confirmed attempt in progress.',
    'Shift from supportive conversation to safety-oriented intervention and urgent human support.',
    'Immediate escalation to human review. Encourage the user to contact a trusted adult/person now and present local crisis options. If the user is a minor, the system should bias toward guardian/trusted-adult involvement according to product/legal policy.',
    'R004 Suicidal Ideation Support'
  );
