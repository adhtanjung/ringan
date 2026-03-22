# Product Specification

## Document Control

- Title: Mental Health Assessment Knowledge Base
- Status: Draft
- Owner: Project team
- Source of truth: This repository

## 1. Overview

The product is a structured knowledge base for mental health assessment content. It will be consumed by an AI or LLM system to generate assessments, interpret responses, and recommend approved next-step guidance when an end user may be struggling with mental health.

This repository contains the administration layer for that knowledge base: a Nuxt-based data management interface backed by Supabase tables for categories, subcategories, assessment questions, suggestions, next actions, feedback prompts, and training examples.

## 2. Product Objective

The objective is to establish a controlled, auditable content system that supports safe mental health assessment generation. The system must provide stable taxonomy, structured questions, and curated guidance so downstream AI workflows can produce consistent outputs from approved content.

## 3. Scope

### 3.1 In Scope

- Category management
- Subcategory management
- Assessment question management
- Suggestion management
- Next action management
- Feedback prompt management
- Training example management
- Search, filter, sort, import, export, bulk edit, and record review workflows
- Dataset metadata and dashboard summaries

### 3.2 Out of Scope

- Diagnosing or treating mental health conditions
- Replacing licensed mental health professionals
- A consumer-facing assessment experience
- General CRM, project tracking, or unrelated business workflows that may exist in the underlying schema export

## 4. Users

### 4.1 Primary Users

- Content administrators
- Mental health program maintainers
- Operations staff responsible for updating assessment content

### 4.2 Secondary Users

- AI or ML engineers consuming the dataset for retrieval, routing, or generation
- Reviewers validating safety, consistency, and completeness

## 5. Information Model

### 5.1 Categories

Top-level mental health topics used to organize the taxonomy.

Representative fields:

- `type_name`
- `category_id`
- `description`
- `is_active`

### 5.2 Subcategories

More specific mental health problem areas nested under a category.

Representative fields:

- `problem_name`
- `category`
- `category_id`
- `sub_category_id`
- `description`
- `severity_level`
- `is_active`

### 5.3 Assessment Questions

Structured questions used in an assessment flow.

Representative fields:

- `question_id`
- `sub_category_id`
- `question_text`
- `response_type`
- `scale_min`
- `scale_max`
- `scale_labels`
- `next_step`
- `clusters`
- `batch_id`
- `order_number`
- `is_active`

### 5.4 Suggestions

Approved supportive guidance shown after assessment or in escalation-sensitive flows.

Representative fields:

- `suggestion_id`
- `sub_category_id`
- `cluster`
- `suggestion_text`
- `resource_link`
- `evidence_base`
- `difficulty_level`
- `estimated_duration`
- `tags`
- `is_active`

### 5.5 Supporting Tables

- `next_actions` defines follow-up actions used by downstream workflows.
- `feedback_prompts` defines prompts used to collect follow-up input or user reflection.
- `training_examples` stores conversation or completion examples for model improvement and evaluation.

## 6. Functional Requirements

### 6.1 Record Management

- The system must allow create, edit, view, delete, and bulk-delete operations for supported datasets.
- The system must support record-level metadata review, including created and updated timestamps.
- The system must support inactive records without removing historical data.

### 6.2 Search and Navigation

- The system must support search across supported dataset tables.
- The system must support filtering by relevant attributes such as active status.
- The system must support pagination and table-level browsing for large datasets.

### 6.3 Import and Export

- The system must support import from CSV, JSON, and Excel files.
- The system must support export for review, migration, and downstream processing.
- The system must provide templates or example files for supported dataset types.

### 6.4 Taxonomy Integrity

- Every subcategory must reference a valid category.
- Every assessment question must reference a valid subcategory.
- Every suggestion must reference the relevant subcategory.
- Human-readable IDs must remain stable enough for downstream AI use.

### 6.5 Assessment Support

- Assessment questions must support scale-based and text-based response types.
- Scale labels must be editable and persist consistently.
- Assessment questions must support ordering and grouping fields where required.

## 7. Safety and Governance Requirements

- The knowledge base must not imply diagnosis from a single answer.
- Suggestions must be supportive, non-judgmental, and aligned with approved guidance.
- High-acuity or crisis scenarios must route to a dedicated safety path rather than generic content.
- Content with user impact should remain reviewable by humans before activation.
- AI output must remain constrained to approved content and must not invent unsupported guidance.

## 8. Non-Functional Requirements

- The system must be easy to use for non-technical maintainers.
- The interface must prioritize clarity, accessibility, and low cognitive load.
- Content changes must be auditable.
- The data model must be compatible with AI retrieval and prompt construction.
- The taxonomy must be extensible without requiring a rewrite of the existing structure.

## 9. Success Metrics

- Coverage of the target mental health taxonomy
- Reduction in duplicate or inconsistent records
- Faster content maintenance through search, bulk edit, import, and export
- Fewer records missing required fields or stable identifiers
- Improved consistency in downstream AI-generated assessments and guidance

## 10. Risks

- Content drift if categories, questions, and suggestions are updated independently
- Unsafe AI use if the knowledge base is consumed without governance controls
- Naming or ID inconsistency in imported data
- Schema complexity if optional fields become informally required
- Over-focus on breadth at the expense of content quality

## 11. Acceptance Criteria

- The project goal is documented in a version-controlled markdown spec.
- The spec clearly defines the taxonomy, the AI use case, and the admin workflow.
- The spec includes explicit safety and governance requirements.
- The spec matches the current structure of this repository.

## 12. Open Questions

1. Which categories are in scope for the first release?
2. What review process is required before content can be activated?
3. Should crisis-related content live in this repository or in a separate safety workflow?
4. Which downstream AI workflow will consume this knowledge base first?

## 13. References

- App shell and routing: [`app/pages/index.vue`](../app/pages/index.vue), [`app/pages/dashboard.vue`](../app/pages/dashboard.vue)
- Taxonomy pages: [`app/pages/problem-types.vue`](../app/pages/problem-types.vue), [`app/pages/problems.vue`](../app/pages/problems.vue), [`app/pages/assessments.vue`](../app/pages/assessments.vue), [`app/pages/suggestions.vue`](../app/pages/suggestions.vue), [`app/pages/next-actions.vue`](../app/pages/next-actions.vue)
- Shared dataset behavior: [`app/composables/useDatasetManagement.ts`](../app/composables/useDatasetManagement.ts)
- Field schemas: [`app/config/formSchemas.ts`](../app/config/formSchemas.ts)
- Database schema: [`sql/schema.sql`](../sql/schema.sql)
