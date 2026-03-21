


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."alert_severity" AS ENUM (
    'low',
    'medium',
    'high'
);


ALTER TYPE "public"."alert_severity" OWNER TO "postgres";


CREATE TYPE "public"."alert_type" AS ENUM (
    'budget_warning',
    'budget_exceeded',
    'timeline_risk',
    'margin_low'
);


ALTER TYPE "public"."alert_type" OWNER TO "postgres";


CREATE TYPE "public"."assignment_type" AS ENUM (
    'single',
    'multiple',
    'split'
);


ALTER TYPE "public"."assignment_type" OWNER TO "postgres";


CREATE TYPE "public"."cashflow_status" AS ENUM (
    'pending',
    'completed',
    'cancelled'
);


ALTER TYPE "public"."cashflow_status" OWNER TO "postgres";


CREATE TYPE "public"."cashflow_type" AS ENUM (
    'invoice_issued',
    'payment_received',
    'expense',
    'refund'
);


ALTER TYPE "public"."cashflow_type" OWNER TO "postgres";


CREATE TYPE "public"."entry_type" AS ENUM (
    'manual',
    'timer'
);


ALTER TYPE "public"."entry_type" OWNER TO "postgres";


CREATE TYPE "public"."invoice_status" AS ENUM (
    'draft',
    'sent',
    'paid',
    'overdue',
    'cancelled'
);


ALTER TYPE "public"."invoice_status" OWNER TO "postgres";


CREATE TYPE "public"."payment_method" AS ENUM (
    'bank_transfer',
    'paypal',
    'check'
);


ALTER TYPE "public"."payment_method" OWNER TO "postgres";


CREATE TYPE "public"."payment_status" AS ENUM (
    'pending',
    'processing',
    'paid',
    'failed'
);


ALTER TYPE "public"."payment_status" OWNER TO "postgres";


CREATE TYPE "public"."payment_status_detailed" AS ENUM (
    'paid',
    'pending',
    'overdue'
);


ALTER TYPE "public"."payment_status_detailed" OWNER TO "postgres";


CREATE TYPE "public"."project_health_level" AS ENUM (
    'excellent',
    'good',
    'fair',
    'poor',
    'critical'
);


ALTER TYPE "public"."project_health_level" OWNER TO "postgres";


CREATE TYPE "public"."project_health_status" AS ENUM (
    'healthy',
    'at-risk',
    'critical'
);


ALTER TYPE "public"."project_health_status" OWNER TO "postgres";


CREATE TYPE "public"."project_status" AS ENUM (
    'active',
    'completed',
    'on_hold',
    'archived'
);


ALTER TYPE "public"."project_status" OWNER TO "postgres";


CREATE TYPE "public"."project_status_detailed" AS ENUM (
    'on-track',
    'delayed',
    'completed'
);


ALTER TYPE "public"."project_status_detailed" OWNER TO "postgres";


CREATE TYPE "public"."release_status" AS ENUM (
    'planned',
    'in_progress',
    'completed'
);


ALTER TYPE "public"."release_status" OWNER TO "postgres";


CREATE TYPE "public"."resource_type" AS ENUM (
    'internal',
    'external',
    'vendor'
);


ALTER TYPE "public"."resource_type" OWNER TO "postgres";


CREATE TYPE "public"."risk_level" AS ENUM (
    'low',
    'medium',
    'high',
    'critical'
);


ALTER TYPE "public"."risk_level" OWNER TO "postgres";


CREATE TYPE "public"."risk_severity" AS ENUM (
    'low',
    'medium',
    'high',
    'critical'
);


ALTER TYPE "public"."risk_severity" OWNER TO "postgres";


CREATE TYPE "public"."risk_status" AS ENUM (
    'open',
    'in_progress',
    'resolved',
    'closed'
);


ALTER TYPE "public"."risk_status" OWNER TO "postgres";


CREATE TYPE "public"."sprint_status" AS ENUM (
    'planned',
    'in_progress',
    'completed',
    'cancelled'
);


ALTER TYPE "public"."sprint_status" OWNER TO "postgres";


CREATE TYPE "public"."task_priority" AS ENUM (
    'low',
    'medium',
    'high'
);


ALTER TYPE "public"."task_priority" OWNER TO "postgres";


CREATE TYPE "public"."task_status" AS ENUM (
    'not_started',
    'in_progress',
    'completed',
    'backlog',
    'this_week',
    'today',
    'done'
);


ALTER TYPE "public"."task_status" OWNER TO "postgres";


CREATE TYPE "public"."time_entry_status" AS ENUM (
    'draft',
    'submitted',
    'approved',
    'rejected'
);


ALTER TYPE "public"."time_entry_status" OWNER TO "postgres";


CREATE TYPE "public"."timesheet_status" AS ENUM (
    'draft',
    'submitted',
    'approved',
    'pending'
);


ALTER TYPE "public"."timesheet_status" OWNER TO "postgres";


CREATE TYPE "public"."timesheet_status_detailed" AS ENUM (
    'up-to-date',
    'pending',
    'overdue'
);


ALTER TYPE "public"."timesheet_status_detailed" OWNER TO "postgres";


CREATE TYPE "public"."user_role" AS ENUM (
    'talent',
    'admin',
    'project_manager'
);


ALTER TYPE "public"."user_role" OWNER TO "postgres";


CREATE TYPE "public"."utilization_status" AS ENUM (
    'low',
    'medium',
    'high',
    'optimal'
);


ALTER TYPE "public"."utilization_status" OWNER TO "postgres";


CREATE TYPE "public"."work_order_status" AS ENUM (
    'planned',
    'in_progress',
    'completed',
    'cancelled'
);


ALTER TYPE "public"."work_order_status" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_project_financial_health"("project_uuid" "uuid") RETURNS TABLE("project_id" "uuid", "total_value" bigint, "total_cost" bigint, "margin" bigint, "margin_percentage" numeric, "health_status" "public"."project_health_status", "risk_factors" "text"[])
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  WITH project_costs AS (
    SELECT
      p.id,
      p.budget as total_value,
      COALESCE(SUM(te.total_cost), 0) + COALESCE(pcb.total_cost, 0) as total_cost
    FROM projects p
    LEFT JOIN time_entries te ON p.id = te.project_id
    LEFT JOIN project_cost_breakdowns pcb ON p.id = pcb.project_id
    WHERE p.id = project_uuid
    GROUP BY p.id, p.budget, pcb.total_cost
  ),
  calculated_metrics AS (
    SELECT
      pc.project_id,
      pc.total_value,
      pc.total_cost,
      pc.total_value - pc.total_cost as margin,
      CASE
        WHEN pc.total_value > 0 THEN
          ((pc.total_value - pc.total_cost) / pc.total_value::DECIMAL) * 100
        ELSE 0
      END as margin_percentage
    FROM project_costs pc
  )
  SELECT
    cm.project_id,
    cm.total_value,
    cm.total_cost,
    cm.margin,
    cm.margin_percentage,
    CASE
      WHEN cm.margin_percentage < 10 THEN 'critical'::project_health_status
      WHEN cm.margin_percentage < 20 THEN 'at-risk'::project_health_status
      ELSE 'healthy'::project_health_status
    END as health_status,
    CASE
      WHEN cm.margin_percentage < 10 THEN ARRAY['Low margin (<10%)']
      WHEN cm.margin_percentage < 20 THEN ARRAY['Marginal profitability (10-20%)']
      ELSE ARRAY[]::TEXT[]
    END as risk_factors
  FROM calculated_metrics cm;
END;
$$;


ALTER FUNCTION "public"."calculate_project_financial_health"("project_uuid" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_talent_utilization"("talent_uuid" "uuid", "week_start" "date") RETURNS TABLE("talent_id" "uuid", "total_hours" numeric, "utilization_rate" numeric, "project_count" integer, "total_earnings" bigint)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  WITH talent_hours AS (
    SELECT
      u.id as talent_id,
      COALESCE(SUM(te.hours), 0) as total_hours,
      COALESCE(SUM(te.total_cost), 0) as total_earnings,
      COUNT(DISTINCT te.project_id) as project_count
    FROM users u
    LEFT JOIN time_entries te ON u.id = te.user_id
      AND te.date >= week_start
      AND te.date < week_start + INTERVAL '7 days'
    WHERE u.id = talent_uuid
    GROUP BY u.id
  )
  SELECT
    th.talent_id,
    th.total_hours,
    CASE
      WHEN th.total_hours > 0 THEN (th.total_hours / 40.0) * 100
      ELSE 0
    END as utilization_rate,
    th.project_count,
    th.total_earnings
  FROM talent_hours th;
END;
$$;


ALTER FUNCTION "public"."calculate_talent_utilization"("talent_uuid" "uuid", "week_start" "date") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."process_audit_log"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $_$
DECLARE
    ri RECORD;
    old_v TEXT;
    new_v TEXT;
    field_nm TEXT;
    user_email TEXT;
BEGIN
    -- Attempt to get the current user's email from Supabase auth context
    BEGIN
        user_email := auth.email();
    EXCEPTION WHEN OTHERS THEN
        user_email := 'System';
    END;

    IF (TG_OP = 'INSERT') THEN
        INSERT INTO public.audit_log (table_name, record_id, action, changed_by_email)
        VALUES (TG_TABLE_NAME, (NEW.id)::TEXT, 'INSERT', user_email);
        RETURN NEW;

    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO public.audit_log (table_name, record_id, action, changed_by_email)
        VALUES (TG_TABLE_NAME, (OLD.id)::TEXT, 'DELETE', user_email);
        RETURN OLD;

    ELSIF (TG_OP = 'UPDATE') THEN
        -- Loop through each column of the table
        FOR field_nm IN
            SELECT column_name
            FROM information_schema.columns
            WHERE table_schema = TG_TABLE_SCHEMA
              AND table_name = TG_TABLE_NAME
        LOOP
            -- Ignore internal tracking columns
            IF field_nm IN ('id', 'updated_at', 'created_at') THEN
                CONTINUE;
            END IF;

            -- Get old and new values as text for comparison
            EXECUTE format('SELECT ($1).%I::text, ($2).%I::text', field_nm, field_nm)
            INTO old_v, new_v
            USING OLD, NEW;

            -- If the value has changed, log it as a separate update entry
            IF (old_v IS DISTINCT FROM new_v) THEN
                INSERT INTO public.audit_log (
                    table_name,
                    record_id,
                    action,
                    field_name,
                    old_value,
                    new_value,
                    changed_by_email
                )
                VALUES (
                    TG_TABLE_NAME,
                    (NEW.id)::TEXT,
                    'UPDATE',
                    field_nm,
                    old_v,
                    new_v,
                    user_email
                );
            END IF;
        END LOOP;
        RETURN NEW;
    END IF;

    RETURN NULL;
END;
$_$;


ALTER FUNCTION "public"."process_audit_log"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_project_financial_health"("project_uuid" "uuid") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  health_data RECORD;
BEGIN
  -- Get calculated financial health data
  SELECT * INTO health_data FROM calculate_project_financial_health(project_uuid);

  -- Update or insert project financial health record
  INSERT INTO project_financial_health (
    project_id,
    project_name,
    client_name,
    total_value,
    margin,
    margin_percentage,
    status,
    risk_factors,
    projected_margin,
    delay_impact
  )
  SELECT
    p.id,
    p.name,
    p.client,
    health_data.total_value,
    health_data.margin,
    health_data.margin_percentage,
    health_data.health_status,
    health_data.risk_factors,
    GREATEST(0, health_data.margin_percentage - 15), -- 15% delay impact
    15
  FROM projects p
  WHERE p.id = project_uuid
  ON CONFLICT (project_id) DO UPDATE SET
    project_name = EXCLUDED.project_name,
    client_name = EXCLUDED.client_name,
    total_value = EXCLUDED.total_value,
    margin = EXCLUDED.margin,
    margin_percentage = EXCLUDED.margin_percentage,
    status = EXCLUDED.status,
    risk_factors = EXCLUDED.risk_factors,
    projected_margin = EXCLUDED.projected_margin,
    delay_impact = EXCLUDED.delay_impact,
    updated_at = NOW();
END;
$$;


ALTER FUNCTION "public"."update_project_financial_health"("project_uuid" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_admin_dashboard_active_stats"() RETURNS "jsonb"
    LANGUAGE "sql" STABLE
    AS $$
WITH problems_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.problems WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', p.id::text,
                    'name', COALESCE(p.problem_name, p.id::text),
                    'updated_at', p.updated_at,
                    'type', 'problems'
                )
                ORDER BY p.updated_at DESC
            )
            FROM (
                SELECT id, problem_name, updated_at
                FROM public.problems
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) p
        ), '[]'::jsonb) AS recent_updates
), assessments_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.assessments WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', a.id::text,
                    'name', COALESCE(a.question_text, a.id::text),
                    'updated_at', a.updated_at,
                    'type', 'assessments'
                )
                ORDER BY a.updated_at DESC
            )
            FROM (
                SELECT id, question_text, updated_at
                FROM public.assessments
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) a
        ), '[]'::jsonb) AS recent_updates
), problem_types_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.problem_types WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', pt.id::text,
                    'name', COALESCE(pt.type_name, pt.id::text),
                    'updated_at', pt.updated_at,
                    'type', 'problem_types'
                )
                ORDER BY pt.updated_at DESC
            )
            FROM (
                SELECT id, type_name, updated_at
                FROM public.problem_types
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) pt
        ), '[]'::jsonb) AS recent_updates
), suggestions_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.suggestions WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', s.id::text,
                    'name', COALESCE(s.suggestion_text, s.id::text),
                    'updated_at', s.updated_at,
                    'type', 'suggestions'
                )
                ORDER BY s.updated_at DESC
            )
            FROM (
                SELECT id, suggestion_text, updated_at
                FROM public.suggestions
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) s
        ), '[]'::jsonb) AS recent_updates
), feedback_prompts_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.feedback_prompts WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', fp.id::text,
                    'name', COALESCE(fp.prompt_text, fp.id::text),
                    'updated_at', fp.updated_at,
                    'type', 'feedback_prompts'
                )
                ORDER BY fp.updated_at DESC
            )
            FROM (
                SELECT id, prompt_text, updated_at
                FROM public.feedback_prompts
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) fp
        ), '[]'::jsonb) AS recent_updates
), next_actions_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.next_actions WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', na.id::text,
                    'name', COALESCE(na.action_text, na.id::text),
                    'updated_at', na.updated_at,
                    'type', 'next_actions'
                )
                ORDER BY na.updated_at DESC
            )
            FROM (
                SELECT id, action_text, updated_at
                FROM public.next_actions
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) na
        ), '[]'::jsonb) AS recent_updates
), training_examples_stats AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.training_examples WHERE is_active = true) AS active,
        COALESCE((
            SELECT jsonb_agg(
                jsonb_build_object(
                    'id', te.id::text,
                    'name', COALESCE(te.problem, te.id::text),
                    'updated_at', te.updated_at,
                    'type', 'training_examples'
                )
                ORDER BY te.updated_at DESC
            )
            FROM (
                SELECT id, problem, updated_at
                FROM public.training_examples
                WHERE is_active = true
                ORDER BY updated_at DESC NULLS LAST
                LIMIT 5
            ) te
        ), '[]'::jsonb) AS recent_updates
), recent_union AS (
    SELECT id::text, COALESCE(problem_name, id::text) AS name, updated_at, 'problems'::text AS type
    FROM (
        SELECT id, problem_name, updated_at
        FROM public.problems
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) problems_recent
    UNION ALL
    SELECT id::text, COALESCE(question_text, id::text) AS name, updated_at, 'assessments'::text AS type
    FROM (
        SELECT id, question_text, updated_at
        FROM public.assessments
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) assessments_recent
    UNION ALL
    SELECT id::text, COALESCE(type_name, id::text) AS name, updated_at, 'problem_types'::text AS type
    FROM (
        SELECT id, type_name, updated_at
        FROM public.problem_types
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) problem_types_recent
    UNION ALL
    SELECT id::text, COALESCE(suggestion_text, id::text) AS name, updated_at, 'suggestions'::text AS type
    FROM (
        SELECT id, suggestion_text, updated_at
        FROM public.suggestions
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) suggestions_recent
    UNION ALL
    SELECT id::text, COALESCE(prompt_text, id::text) AS name, updated_at, 'feedback_prompts'::text AS type
    FROM (
        SELECT id, prompt_text, updated_at
        FROM public.feedback_prompts
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) feedback_prompts_recent
    UNION ALL
    SELECT id::text, COALESCE(action_text, id::text) AS name, updated_at, 'next_actions'::text AS type
    FROM (
        SELECT id, action_text, updated_at
        FROM public.next_actions
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) next_actions_recent
    UNION ALL
    SELECT id::text, COALESCE(problem, id::text) AS name, updated_at, 'training_examples'::text AS type
    FROM (
        SELECT id, problem, updated_at
        FROM public.training_examples
        WHERE is_active = true
        ORDER BY updated_at DESC NULLS LAST
        LIMIT 5
    ) training_examples_recent
), attention AS (
    SELECT
        (SELECT COUNT(*)::integer FROM public.feedback_prompts WHERE is_active = true AND (prompt_id IS NULL OR prompt_id = '')) AS "feedbackPromptsMissingPromptId",
        (SELECT COUNT(*)::integer FROM public.next_actions WHERE is_active = true AND (action_text IS NULL OR action_text = '')) AS "emptyNextActionText",
        (SELECT COUNT(*)::integer FROM public.suggestions WHERE is_active = true AND (suggestion_text IS NULL OR suggestion_text = '')) AS "emptySuggestionText"
), overall AS (
    SELECT
        (problems_stats.active
        + assessments_stats.active
        + problem_types_stats.active
        + suggestions_stats.active
        + feedback_prompts_stats.active
        + next_actions_stats.active
        + training_examples_stats.active) AS active_records,
        COALESCE((SELECT MAX(updated_at) FROM recent_union), NOW()) AS last_updated
    FROM problems_stats, assessments_stats, problem_types_stats, suggestions_stats, feedback_prompts_stats, next_actions_stats, training_examples_stats
)
SELECT jsonb_build_object(
    'overall', jsonb_build_object(
        'active_records', overall.active_records,
        'last_updated', overall.last_updated
    ),
    'by_type', jsonb_build_object(
        'problems', jsonb_build_object('active', problems_stats.active, 'recent_updates', problems_stats.recent_updates),
        'assessments', jsonb_build_object('active', assessments_stats.active, 'recent_updates', assessments_stats.recent_updates),
        'problem_types', jsonb_build_object('active', problem_types_stats.active, 'recent_updates', problem_types_stats.recent_updates),
        'suggestions', jsonb_build_object('active', suggestions_stats.active, 'recent_updates', suggestions_stats.recent_updates),
        'feedback_prompts', jsonb_build_object('active', feedback_prompts_stats.active, 'recent_updates', feedback_prompts_stats.recent_updates),
        'next_actions', jsonb_build_object('active', next_actions_stats.active, 'recent_updates', next_actions_stats.recent_updates),
        'training_examples', jsonb_build_object('active', training_examples_stats.active, 'recent_updates', training_examples_stats.recent_updates)
    ),
    'recent_activity', COALESCE((
        SELECT jsonb_agg(
            jsonb_build_object(
                'id', r.id,
                'name', r.name,
                'updated_at', r.updated_at,
                'type', r.type
            )
            ORDER BY r.updated_at DESC
        )
        FROM (
            SELECT *
            FROM recent_union
            ORDER BY updated_at DESC NULLS LAST
            LIMIT 10
        ) r
    ), '[]'::jsonb),
    'attention', (SELECT to_jsonb(attention) FROM attention),
    'timestamp', NOW()
)
FROM problems_stats, assessments_stats, problem_types_stats, suggestions_stats, feedback_prompts_stats, next_actions_stats, training_examples_stats, overall;
$$;


ALTER FUNCTION "public"."get_admin_dashboard_active_stats"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."admin_dashboard_settings" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "dashboard_layout" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "widget_preferences" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "notification_settings" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."admin_dashboard_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."analytics_insights" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "insight_type" character varying(100) NOT NULL,
    "data" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "period_start" "date" NOT NULL,
    "period_end" "date" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."analytics_insights" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."assessments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "question_id" "text" NOT NULL,
    "sub_category_id" "text" NOT NULL,
    "question_text" "text" NOT NULL,
    "response_type" "text" NOT NULL,
    "scale_min" integer DEFAULT 1,
    "scale_max" integer DEFAULT 4,
    "scale_labels" "jsonb" DEFAULT '{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}'::"jsonb",
    "next_step" "text",
    "clusters" "text",
    "batch_id" "text",
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "scale_label_1" "text",
    "scale_label_2" "text",
    "scale_label_3" "text",
    "scale_label_4" "text",
    "order_number" integer
);


ALTER TABLE "public"."assessments" OWNER TO "postgres";


COMMENT ON COLUMN "public"."assessments"."scale_label_1" IS 'Label for scale value 1 (e.g., "Not at all")';



COMMENT ON COLUMN "public"."assessments"."scale_label_2" IS 'Label for scale value 2 (e.g., "A little")';



COMMENT ON COLUMN "public"."assessments"."scale_label_3" IS 'Label for scale value 3 (e.g., "Quite a bit")';



COMMENT ON COLUMN "public"."assessments"."scale_label_4" IS 'Label for scale value 4 (e.g., "Very much")';



COMMENT ON COLUMN "public"."assessments"."order_number" IS 'Display order of the question within a batch/cluster';



CREATE TABLE IF NOT EXISTS "public"."audit_log" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "table_name" "text" NOT NULL,
    "record_id" "text" NOT NULL,
    "action" "text" NOT NULL,
    "field_name" "text",
    "old_value" "text",
    "new_value" "text",
    "changed_by_email" "text",
    "changed_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."audit_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."budget_alerts" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "type" "public"."alert_type" NOT NULL,
    "severity" "public"."alert_severity" NOT NULL,
    "message" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."budget_alerts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."calendar_events" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "date" "date" NOT NULL,
    "type" character varying(50) NOT NULL,
    "title" character varying(255) NOT NULL,
    "description" "text",
    "hours" numeric(5,2),
    "cost" bigint,
    "status" character varying(50),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."calendar_events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."cashflow_entries" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "invoice_id" "uuid",
    "type" "public"."cashflow_type" NOT NULL,
    "amount" bigint NOT NULL,
    "currency" character varying(3) DEFAULT 'IDR'::character varying NOT NULL,
    "date" "date" NOT NULL,
    "description" "text" NOT NULL,
    "status" "public"."cashflow_status" DEFAULT 'pending'::"public"."cashflow_status" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."cashflow_entries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."client_satisfaction" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "rating" integer NOT NULL,
    "feedback" "text",
    "survey_date" "date" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "client_satisfaction_rating_check" CHECK ((("rating" >= 1) AND ("rating" <= 5)))
);


ALTER TABLE "public"."client_satisfaction" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."cost_efficiency_tracking" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "category" character varying(100) NOT NULL,
    "amount" bigint NOT NULL,
    "percentage" numeric(5,2) NOT NULL,
    "trend" character varying(20) NOT NULL,
    "efficiency" character varying(20) NOT NULL,
    "period_start" "date" NOT NULL,
    "period_end" "date" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."cost_efficiency_tracking" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."feedback" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "feedback_type" "text" NOT NULL,
    "message" "text" NOT NULL,
    "page_route" "text",
    "browser_info" "jsonb",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."feedback" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."feedback_prompts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "prompt_id" "text",
    "prompt_text" "text",
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."feedback_prompts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."financial_summaries" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "period_start" "date" NOT NULL,
    "period_end" "date" NOT NULL,
    "total_project_value" bigint NOT NULL,
    "total_project_cost" bigint NOT NULL,
    "total_margin" bigint NOT NULL,
    "margin_percentage" numeric(5,2) NOT NULL,
    "total_talent_cost" bigint NOT NULL,
    "total_operational_cost" bigint NOT NULL,
    "cash_flow_incoming" bigint NOT NULL,
    "cash_flow_outgoing" bigint NOT NULL,
    "cash_flow_net" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."financial_summaries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."projects" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "name" character varying(255) NOT NULL,
    "client" character varying(255) NOT NULL,
    "status" "public"."project_status" DEFAULT 'active'::"public"."project_status" NOT NULL,
    "budget" bigint NOT NULL,
    "hourly_rate" integer NOT NULL,
    "total_hours" integer DEFAULT 0,
    "remaining_budget" bigint NOT NULL,
    "project_value" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "archived_at" timestamp with time zone
);


ALTER TABLE "public"."projects" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."financial_summary" AS
 SELECT "count"(*) AS "total_projects",
    "count"(
        CASE
            WHEN ("status" = 'active'::"public"."project_status") THEN 1
            ELSE NULL::integer
        END) AS "active_projects",
    "count"(
        CASE
            WHEN ("status" = 'completed'::"public"."project_status") THEN 1
            ELSE NULL::integer
        END) AS "completed_projects",
    "count"(
        CASE
            WHEN ("status" = 'on_hold'::"public"."project_status") THEN 1
            ELSE NULL::integer
        END) AS "on_hold_projects",
    "sum"("project_value") AS "total_project_value",
    "sum"("budget") AS "total_budget",
    "sum"(("budget" - "remaining_budget")) AS "total_actual_spend",
    "sum"(("project_value" - ("budget" - "remaining_budget"))) AS "total_margin",
    "avg"(("project_value" - ("budget" - "remaining_budget"))) AS "avg_margin_per_project"
   FROM "public"."projects";


ALTER VIEW "public"."financial_summary" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."forecasting_data" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "forecast_type" character varying(100) NOT NULL,
    "current_month" bigint NOT NULL,
    "next_month" bigint NOT NULL,
    "month_after_next" bigint NOT NULL,
    "growth_rate" numeric(5,2) NOT NULL,
    "risk_level" "public"."risk_level" DEFAULT 'low'::"public"."risk_level" NOT NULL,
    "confidence_score" numeric(5,2) DEFAULT 50 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."forecasting_data" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."invoices" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "release_id" "uuid",
    "invoice_number" character varying(100) NOT NULL,
    "amount" bigint NOT NULL,
    "currency" character varying(3) DEFAULT 'IDR'::character varying NOT NULL,
    "issue_date" "date" NOT NULL,
    "due_date" "date" NOT NULL,
    "status" "public"."invoice_status" DEFAULT 'draft'::"public"."invoice_status" NOT NULL,
    "payment_date" "date",
    "payment_method" character varying(50),
    "notes" "text",
    "client" character varying(255) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."invoices" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."next_actions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "action_id" "text",
    "action_text" "text",
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."next_actions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."payments" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "talent_id" "uuid" NOT NULL,
    "project_id" "uuid" NOT NULL,
    "amount" bigint NOT NULL,
    "hours" numeric(5,2) NOT NULL,
    "hourly_rate" integer NOT NULL,
    "pay_period_start" "date" NOT NULL,
    "pay_period_end" "date" NOT NULL,
    "status" "public"."payment_status" DEFAULT 'pending'::"public"."payment_status" NOT NULL,
    "payment_method" "public"."payment_method" NOT NULL,
    "processed_date" "date",
    "due_date" "date" NOT NULL,
    "invoice_number" character varying(100) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."payments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."problem_types" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "type_name" "text" NOT NULL,
    "category_id" "text" NOT NULL,
    "description" "text",
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."problem_types" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."problems" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "problem_name" "text" NOT NULL,
    "category" "text" NOT NULL,
    "category_id" "text",
    "sub_category_id" "text" NOT NULL,
    "description" "text",
    "severity_level" integer,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."problems" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_cost_breakdowns" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "resources" bigint DEFAULT 0 NOT NULL,
    "accommodation" bigint DEFAULT 0 NOT NULL,
    "tools_licenses" bigint DEFAULT 0 NOT NULL,
    "architecture" bigint DEFAULT 0 NOT NULL,
    "ppn_tax" bigint DEFAULT 0 NOT NULL,
    "pph_tax" bigint DEFAULT 0 NOT NULL,
    "contingency" bigint DEFAULT 0 NOT NULL,
    "total_cost" bigint NOT NULL,
    "margin" numeric(5,2) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "miscellaneous" bigint DEFAULT 0,
    "travel_expenses" bigint DEFAULT 0,
    "equipment" bigint DEFAULT 0
);


ALTER TABLE "public"."project_cost_breakdowns" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_financial_health" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "project_name" character varying(255) NOT NULL,
    "client_name" character varying(255) NOT NULL,
    "total_value" bigint NOT NULL,
    "cost_breakdown" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "margin" bigint NOT NULL,
    "margin_percentage" numeric(5,2) NOT NULL,
    "status" "public"."project_health_status" DEFAULT 'healthy'::"public"."project_health_status" NOT NULL,
    "risk_factors" "text"[] DEFAULT '{}'::"text"[],
    "projected_margin" numeric(5,2) NOT NULL,
    "delay_impact" numeric(5,2) DEFAULT 0 NOT NULL,
    "project_status" "public"."project_status_detailed" DEFAULT 'on-track'::"public"."project_status_detailed" NOT NULL,
    "start_date" "date",
    "end_date" "date",
    "description" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_financial_health" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."project_financial_overview" AS
 SELECT "p"."id",
    "p"."name" AS "project_name",
    "p"."client",
    "p"."status" AS "project_status",
    "p"."budget" AS "total_value",
    "pfh"."total_value" AS "calculated_value",
    "pfh"."margin",
    "pfh"."margin_percentage",
    "pfh"."status" AS "health_status",
    "pfh"."risk_factors",
    "pfh"."projected_margin",
    "pfh"."delay_impact",
    "pfh"."project_status" AS "detailed_status",
    "pfh"."start_date",
    "pfh"."end_date",
    "pfh"."description",
    "p"."created_at",
    "p"."updated_at"
   FROM ("public"."projects" "p"
     LEFT JOIN "public"."project_financial_health" "pfh" ON (("p"."id" = "pfh"."project_id")));


ALTER VIEW "public"."project_financial_overview" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_health_metrics" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "budget_variance" numeric(5,2) DEFAULT 0 NOT NULL,
    "schedule_variance" numeric(5,2) DEFAULT 0 NOT NULL,
    "profit_margin_trend" numeric(5,2) DEFAULT 0 NOT NULL,
    "risk_level" "public"."project_health_level" DEFAULT 'good'::"public"."project_health_level" NOT NULL,
    "client_satisfaction" integer DEFAULT 0 NOT NULL,
    "overall_health" integer DEFAULT 0 NOT NULL,
    "calculated_at" timestamp with time zone DEFAULT "now"(),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_health_metrics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_milestones" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "description" "text",
    "due_date" "date" NOT NULL,
    "completed_date" "date",
    "is_critical" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_milestones" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_releases" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" bigint NOT NULL,
    "due_date" "date" NOT NULL,
    "status" "public"."release_status" DEFAULT 'planned'::"public"."release_status" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_releases" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tasks" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "title" character varying(255) NOT NULL,
    "description" "text",
    "estimated_hours" integer,
    "actual_hours" integer,
    "status" "public"."task_status" DEFAULT 'not_started'::"public"."task_status" NOT NULL,
    "priority" "public"."task_priority" DEFAULT 'medium'::"public"."task_priority" NOT NULL,
    "due_date" "date",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "work_order_id" "uuid",
    "sprint_id" "uuid",
    "assigned_talent" "uuid",
    "tags" "text"[] DEFAULT '{}'::"text"[],
    "progress" integer DEFAULT 0
);


ALTER TABLE "public"."tasks" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."project_portfolio_overview" AS
 SELECT "p"."id",
    "p"."name",
    "p"."client",
    "p"."status",
    "p"."project_value",
    "p"."budget",
    "p"."remaining_budget",
    ("p"."budget" - "p"."remaining_budget") AS "actual_spend",
    ("p"."project_value" - ("p"."budget" - "p"."remaining_budget")) AS "margin",
    "p"."created_at",
    "count"(DISTINCT "pr"."id") AS "release_count",
    "count"(DISTINCT "t"."id") AS "task_count",
    COALESCE("phm"."overall_health", 0) AS "health_score",
    COALESCE("phm"."risk_level", 'good'::"public"."project_health_level") AS "risk_level"
   FROM ((("public"."projects" "p"
     LEFT JOIN "public"."project_releases" "pr" ON (("p"."id" = "pr"."project_id")))
     LEFT JOIN "public"."tasks" "t" ON (("p"."id" = "t"."project_id")))
     LEFT JOIN LATERAL ( SELECT "phm_1"."overall_health",
            "phm_1"."risk_level"
           FROM "public"."project_health_metrics" "phm_1"
          WHERE ("phm_1"."project_id" = "p"."id")
          ORDER BY "phm_1"."calculated_at" DESC
         LIMIT 1) "phm" ON (true))
  GROUP BY "p"."id", "p"."name", "p"."client", "p"."status", "p"."project_value", "p"."budget", "p"."remaining_budget", "p"."created_at", "phm"."overall_health", "phm"."risk_level";


ALTER VIEW "public"."project_portfolio_overview" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_reports" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "report_type" character varying(50) NOT NULL,
    "title" character varying(255) NOT NULL,
    "data" "jsonb" NOT NULL,
    "generated_by" "uuid" NOT NULL,
    "generated_at" timestamp with time zone DEFAULT "now"(),
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_reports" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_risks" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "title" character varying(255) NOT NULL,
    "description" "text" NOT NULL,
    "severity" "public"."risk_severity" NOT NULL,
    "status" "public"."risk_status" DEFAULT 'open'::"public"."risk_status" NOT NULL,
    "mitigation_plan" "text",
    "assigned_to" "uuid",
    "due_date" "date",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_risks" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."project_sprints" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "release_id" "uuid",
    "name" character varying(255) NOT NULL,
    "description" "text",
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "budget" bigint DEFAULT 0 NOT NULL,
    "actual_cost" bigint DEFAULT 0 NOT NULL,
    "status" "public"."sprint_status" DEFAULT 'planned'::"public"."sprint_status" NOT NULL,
    "progress" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."project_sprints" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."resource_allocations" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "project_id" "uuid" NOT NULL,
    "task_id" "uuid",
    "allocation_percentage" integer DEFAULT 100 NOT NULL,
    "start_date" "date" NOT NULL,
    "end_date" "date",
    "hourly_rate" integer NOT NULL,
    "resource_type" "public"."resource_type" DEFAULT 'internal'::"public"."resource_type" NOT NULL,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."resource_allocations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."time_entries" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "project_id" "uuid" NOT NULL,
    "task_id" "uuid",
    "date" "date" NOT NULL,
    "hours" numeric(5,2) NOT NULL,
    "description" "text" NOT NULL,
    "status" "public"."time_entry_status" DEFAULT 'draft'::"public"."time_entry_status" NOT NULL,
    "entry_type" "public"."entry_type" DEFAULT 'manual'::"public"."entry_type" NOT NULL,
    "timer_session_id" character varying(255),
    "hourly_rate" integer NOT NULL,
    "total_cost" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."time_entries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "email" character varying(255) NOT NULL,
    "name" character varying(255) NOT NULL,
    "role" "public"."user_role" NOT NULL,
    "hourly_rate" integer,
    "department" character varying(100),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."users" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."resource_utilization" AS
 SELECT "u"."id" AS "user_id",
    "u"."name",
    "u"."role",
    "u"."hourly_rate",
    "ra"."project_id",
    "p"."name" AS "project_name",
    "ra"."allocation_percentage",
    "ra"."start_date",
    "ra"."end_date",
    "ra"."is_active",
    COALESCE("sum"("te"."hours"), (0)::numeric) AS "logged_hours",
    COALESCE("sum"("te"."total_cost"), (0)::numeric) AS "total_cost"
   FROM ((("public"."users" "u"
     LEFT JOIN "public"."resource_allocations" "ra" ON (("u"."id" = "ra"."user_id")))
     LEFT JOIN "public"."projects" "p" ON (("ra"."project_id" = "p"."id")))
     LEFT JOIN "public"."time_entries" "te" ON ((("u"."id" = "te"."user_id") AND ("ra"."project_id" = "te"."project_id"))))
  WHERE ("u"."role" = 'talent'::"public"."user_role")
  GROUP BY "u"."id", "u"."name", "u"."role", "u"."hourly_rate", "ra"."project_id", "p"."name", "ra"."allocation_percentage", "ra"."start_date", "ra"."end_date", "ra"."is_active";


ALTER VIEW "public"."resource_utilization" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."risk_factors" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "factor_name" character varying(255) NOT NULL,
    "description" "text",
    "risk_level" "public"."risk_level" DEFAULT 'medium'::"public"."risk_level" NOT NULL,
    "impact_score" integer DEFAULT 5 NOT NULL,
    "probability_score" integer DEFAULT 5 NOT NULL,
    "mitigation_plan" "text",
    "status" character varying(50) DEFAULT 'active'::character varying NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."risk_factors" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."suggestions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "suggestion_id" "text",
    "sub_category_id" "text",
    "cluster" "text",
    "suggestion_text" "text",
    "resource_link" "text",
    "evidence_base" "text",
    "difficulty_level" "text",
    "estimated_duration" "text",
    "tags" "text"[],
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."suggestions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."talent_assignments" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "talent_id" "uuid" NOT NULL,
    "project_id" "uuid" NOT NULL,
    "hourly_rate" integer NOT NULL,
    "assignment_type" "public"."assignment_type" DEFAULT 'single'::"public"."assignment_type" NOT NULL,
    "percentage" numeric(5,2) DEFAULT 100 NOT NULL,
    "hours_this_week" numeric(5,2) DEFAULT 0 NOT NULL,
    "hours_this_month" numeric(5,2) DEFAULT 0 NOT NULL,
    "total_earnings" bigint DEFAULT 0 NOT NULL,
    "utilization_rate" numeric(5,2) DEFAULT 0 NOT NULL,
    "capacity_hours" integer DEFAULT 40 NOT NULL,
    "actual_hours" numeric(5,2) DEFAULT 0 NOT NULL,
    "timesheet_status" "public"."timesheet_status_detailed" DEFAULT 'up-to-date'::"public"."timesheet_status_detailed" NOT NULL,
    "payment_status" "public"."payment_status_detailed" DEFAULT 'pending'::"public"."payment_status_detailed" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."talent_assignments" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."talent_utilization_overview" AS
 SELECT "u"."id" AS "talent_id",
    "u"."name" AS "talent_name",
    "u"."email",
    "u"."department",
    "u"."hourly_rate",
    COALESCE("sum"("ta"."hours_this_week"), (0)::numeric) AS "total_weekly_hours",
    COALESCE("sum"("ta"."hours_this_month"), (0)::numeric) AS "total_monthly_hours",
    COALESCE("sum"("ta"."total_earnings"), (0)::numeric) AS "total_weekly_earnings",
    COALESCE("sum"((("ta"."total_earnings")::numeric * 4.33)), (0)::numeric) AS "total_monthly_earnings",
    COALESCE("avg"("ta"."utilization_rate"), (0)::numeric) AS "avg_utilization_rate",
    "count"("ta"."project_id") AS "project_count",
    COALESCE("max"("ta"."timesheet_status"), 'up-to-date'::"public"."timesheet_status_detailed") AS "timesheet_status",
    COALESCE("max"("ta"."payment_status"), 'pending'::"public"."payment_status_detailed") AS "payment_status"
   FROM ("public"."users" "u"
     LEFT JOIN "public"."talent_assignments" "ta" ON (("u"."id" = "ta"."talent_id")))
  WHERE ("u"."role" = 'talent'::"public"."user_role")
  GROUP BY "u"."id", "u"."name", "u"."email", "u"."department", "u"."hourly_rate";


ALTER VIEW "public"."talent_utilization_overview" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."talent_utilization_tracking" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "talent_id" "uuid" NOT NULL,
    "week_starting" "date" NOT NULL,
    "total_hours" numeric(5,2) NOT NULL,
    "billable_hours" numeric(5,2) NOT NULL,
    "utilization_rate" numeric(5,2) NOT NULL,
    "efficiency_score" numeric(5,2) NOT NULL,
    "project_count" integer DEFAULT 0 NOT NULL,
    "total_earnings" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."talent_utilization_tracking" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."timer_sessions" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "project_id" "uuid" NOT NULL,
    "task_id" "uuid",
    "start_time" timestamp with time zone NOT NULL,
    "end_time" timestamp with time zone,
    "duration" integer DEFAULT 0,
    "is_active" boolean DEFAULT false,
    "is_paused" boolean DEFAULT false,
    "paused_at" timestamp with time zone,
    "total_paused_time" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."timer_sessions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."timesheet_approvals" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "talent_id" "uuid" NOT NULL,
    "week_starting" "date" NOT NULL,
    "total_hours" numeric(5,2) NOT NULL,
    "total_amount" bigint NOT NULL,
    "status" "public"."timesheet_status" DEFAULT 'pending'::"public"."timesheet_status" NOT NULL,
    "submitted_at" timestamp with time zone DEFAULT "now"(),
    "approved_at" timestamp with time zone,
    "approved_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."timesheet_approvals" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."training_examples" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "example_id" "text",
    "problem" "text",
    "conversation_id" "text",
    "user_intent" "text",
    "prompt" "text",
    "completion" "text",
    "context" "text",
    "quality_score" numeric,
    "tags" "text"[],
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."training_examples" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."work_orders" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "project_id" "uuid" NOT NULL,
    "sprint_id" "uuid",
    "name" character varying(255) NOT NULL,
    "description" "text",
    "estimated_hours" integer DEFAULT 0 NOT NULL,
    "actual_hours" integer DEFAULT 0 NOT NULL,
    "budget" bigint DEFAULT 0 NOT NULL,
    "actual_cost" bigint DEFAULT 0 NOT NULL,
    "status" "public"."work_order_status" DEFAULT 'planned'::"public"."work_order_status" NOT NULL,
    "assigned_talents" "uuid"[] DEFAULT '{}'::"uuid"[],
    "due_date" "date",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."work_orders" OWNER TO "postgres";


ALTER TABLE ONLY "public"."admin_dashboard_settings"
    ADD CONSTRAINT "admin_dashboard_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."admin_dashboard_settings"
    ADD CONSTRAINT "admin_dashboard_settings_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."analytics_insights"
    ADD CONSTRAINT "analytics_insights_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assessments"
    ADD CONSTRAINT "assessments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assessments"
    ADD CONSTRAINT "assessments_question_id_key" UNIQUE ("question_id");



ALTER TABLE ONLY "public"."audit_log"
    ADD CONSTRAINT "audit_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."budget_alerts"
    ADD CONSTRAINT "budget_alerts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."calendar_events"
    ADD CONSTRAINT "calendar_events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cashflow_entries"
    ADD CONSTRAINT "cashflow_entries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."client_satisfaction"
    ADD CONSTRAINT "client_satisfaction_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cost_efficiency_tracking"
    ADD CONSTRAINT "cost_efficiency_tracking_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."feedback"
    ADD CONSTRAINT "feedback_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."feedback_prompts"
    ADD CONSTRAINT "feedback_prompts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."feedback_prompts"
    ADD CONSTRAINT "feedback_prompts_prompt_id_key" UNIQUE ("prompt_id");



ALTER TABLE ONLY "public"."financial_summaries"
    ADD CONSTRAINT "financial_summaries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."forecasting_data"
    ADD CONSTRAINT "forecasting_data_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_invoice_number_key" UNIQUE ("invoice_number");



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."next_actions"
    ADD CONSTRAINT "next_actions_action_id_key" UNIQUE ("action_id");



ALTER TABLE ONLY "public"."next_actions"
    ADD CONSTRAINT "next_actions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_invoice_number_key" UNIQUE ("invoice_number");



ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."problem_types"
    ADD CONSTRAINT "problem_types_category_id_key" UNIQUE ("category_id");



ALTER TABLE ONLY "public"."problem_types"
    ADD CONSTRAINT "problem_types_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."problem_types"
    ADD CONSTRAINT "problem_types_type_name_key" UNIQUE ("type_name");



ALTER TABLE ONLY "public"."problems"
    ADD CONSTRAINT "problems_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."problems"
    ADD CONSTRAINT "problems_sub_category_id_key" UNIQUE ("sub_category_id");



ALTER TABLE ONLY "public"."project_cost_breakdowns"
    ADD CONSTRAINT "project_cost_breakdowns_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_financial_health"
    ADD CONSTRAINT "project_financial_health_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_health_metrics"
    ADD CONSTRAINT "project_health_metrics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_milestones"
    ADD CONSTRAINT "project_milestones_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_releases"
    ADD CONSTRAINT "project_releases_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_reports"
    ADD CONSTRAINT "project_reports_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_risks"
    ADD CONSTRAINT "project_risks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."project_sprints"
    ADD CONSTRAINT "project_sprints_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."resource_allocations"
    ADD CONSTRAINT "resource_allocations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."risk_factors"
    ADD CONSTRAINT "risk_factors_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."suggestions"
    ADD CONSTRAINT "suggestions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."suggestions"
    ADD CONSTRAINT "suggestions_suggestion_id_key" UNIQUE ("suggestion_id");



ALTER TABLE ONLY "public"."talent_assignments"
    ADD CONSTRAINT "talent_assignments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."talent_assignments"
    ADD CONSTRAINT "talent_assignments_talent_id_project_id_key" UNIQUE ("talent_id", "project_id");



ALTER TABLE ONLY "public"."talent_utilization_tracking"
    ADD CONSTRAINT "talent_utilization_tracking_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."talent_utilization_tracking"
    ADD CONSTRAINT "talent_utilization_tracking_talent_id_week_starting_key" UNIQUE ("talent_id", "week_starting");



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."time_entries"
    ADD CONSTRAINT "time_entries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."timer_sessions"
    ADD CONSTRAINT "timer_sessions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."timesheet_approvals"
    ADD CONSTRAINT "timesheet_approvals_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."training_examples"
    ADD CONSTRAINT "training_examples_example_id_key" UNIQUE ("example_id");



ALTER TABLE ONLY "public"."training_examples"
    ADD CONSTRAINT "training_examples_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."work_orders"
    ADD CONSTRAINT "work_orders_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_analytics_insights_period" ON "public"."analytics_insights" USING "btree" ("period_start", "period_end");



CREATE INDEX "idx_analytics_insights_type" ON "public"."analytics_insights" USING "btree" ("insight_type");



CREATE INDEX "idx_audit_log_record" ON "public"."audit_log" USING "btree" ("table_name", "record_id");



CREATE INDEX "idx_budget_alerts_project_id" ON "public"."budget_alerts" USING "btree" ("project_id");



CREATE INDEX "idx_cashflow_entries_project_id" ON "public"."cashflow_entries" USING "btree" ("project_id");



CREATE INDEX "idx_client_satisfaction_project_id" ON "public"."client_satisfaction" USING "btree" ("project_id");



CREATE INDEX "idx_cost_efficiency_category" ON "public"."cost_efficiency_tracking" USING "btree" ("category");



CREATE INDEX "idx_financial_summaries_period" ON "public"."financial_summaries" USING "btree" ("period_start", "period_end");



CREATE INDEX "idx_forecasting_data_type" ON "public"."forecasting_data" USING "btree" ("forecast_type");



CREATE INDEX "idx_invoices_project_id" ON "public"."invoices" USING "btree" ("project_id");



CREATE INDEX "idx_payments_status" ON "public"."payments" USING "btree" ("status");



CREATE INDEX "idx_payments_talent_id" ON "public"."payments" USING "btree" ("talent_id");



CREATE INDEX "idx_project_financial_health_project_id" ON "public"."project_financial_health" USING "btree" ("project_id");



CREATE INDEX "idx_project_financial_health_status" ON "public"."project_financial_health" USING "btree" ("status");



CREATE INDEX "idx_project_health_metrics_project_id" ON "public"."project_health_metrics" USING "btree" ("project_id");



CREATE INDEX "idx_project_milestones_project_id" ON "public"."project_milestones" USING "btree" ("project_id");



CREATE INDEX "idx_project_reports_project_id" ON "public"."project_reports" USING "btree" ("project_id");



CREATE INDEX "idx_project_risks_project_id" ON "public"."project_risks" USING "btree" ("project_id");



CREATE INDEX "idx_project_sprints_project_id" ON "public"."project_sprints" USING "btree" ("project_id");



CREATE INDEX "idx_project_sprints_release_id" ON "public"."project_sprints" USING "btree" ("release_id");



CREATE INDEX "idx_resource_allocations_project_id" ON "public"."resource_allocations" USING "btree" ("project_id");



CREATE INDEX "idx_resource_allocations_user_id" ON "public"."resource_allocations" USING "btree" ("user_id");



CREATE INDEX "idx_risk_factors_project_id" ON "public"."risk_factors" USING "btree" ("project_id");



CREATE INDEX "idx_risk_factors_status" ON "public"."risk_factors" USING "btree" ("status");



CREATE INDEX "idx_talent_assignments_project_id" ON "public"."talent_assignments" USING "btree" ("project_id");



CREATE INDEX "idx_talent_assignments_talent_id" ON "public"."talent_assignments" USING "btree" ("talent_id");



CREATE INDEX "idx_talent_assignments_utilization" ON "public"."talent_assignments" USING "btree" ("utilization_rate");



CREATE INDEX "idx_talent_utilization_talent_id" ON "public"."talent_utilization_tracking" USING "btree" ("talent_id");



CREATE INDEX "idx_talent_utilization_week" ON "public"."talent_utilization_tracking" USING "btree" ("week_starting");



CREATE INDEX "idx_tasks_project_id" ON "public"."tasks" USING "btree" ("project_id");



CREATE INDEX "idx_time_entries_date" ON "public"."time_entries" USING "btree" ("date");



CREATE INDEX "idx_time_entries_project_id" ON "public"."time_entries" USING "btree" ("project_id");



CREATE INDEX "idx_time_entries_user_id" ON "public"."time_entries" USING "btree" ("user_id");



CREATE INDEX "idx_timer_sessions_active" ON "public"."timer_sessions" USING "btree" ("is_active");



CREATE INDEX "idx_timer_sessions_user_id" ON "public"."timer_sessions" USING "btree" ("user_id");



CREATE INDEX "idx_timesheet_approvals_status" ON "public"."timesheet_approvals" USING "btree" ("status");



CREATE INDEX "idx_timesheet_approvals_talent_id" ON "public"."timesheet_approvals" USING "btree" ("talent_id");



CREATE INDEX "idx_work_orders_project_id" ON "public"."work_orders" USING "btree" ("project_id");



CREATE INDEX "idx_work_orders_sprint_id" ON "public"."work_orders" USING "btree" ("sprint_id");



CREATE OR REPLACE TRIGGER "tr_audit_assessments" AFTER INSERT OR DELETE OR UPDATE ON "public"."assessments" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "tr_audit_feedback_prompts" AFTER INSERT OR DELETE OR UPDATE ON "public"."feedback_prompts" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "tr_audit_next_actions" AFTER INSERT OR DELETE OR UPDATE ON "public"."next_actions" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "tr_audit_problem_types" AFTER INSERT OR DELETE OR UPDATE ON "public"."problem_types" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "tr_audit_problems" AFTER INSERT OR DELETE OR UPDATE ON "public"."problems" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "tr_audit_suggestions" AFTER INSERT OR DELETE OR UPDATE ON "public"."suggestions" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "tr_audit_training_examples" AFTER INSERT OR DELETE OR UPDATE ON "public"."training_examples" FOR EACH ROW EXECUTE FUNCTION "public"."process_audit_log"();



CREATE OR REPLACE TRIGGER "update_admin_dashboard_settings_updated_at" BEFORE UPDATE ON "public"."admin_dashboard_settings" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_analytics_insights_updated_at" BEFORE UPDATE ON "public"."analytics_insights" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_calendar_events_updated_at" BEFORE UPDATE ON "public"."calendar_events" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_cashflow_entries_updated_at" BEFORE UPDATE ON "public"."cashflow_entries" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_cost_efficiency_tracking_updated_at" BEFORE UPDATE ON "public"."cost_efficiency_tracking" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_financial_summaries_updated_at" BEFORE UPDATE ON "public"."financial_summaries" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_forecasting_data_updated_at" BEFORE UPDATE ON "public"."forecasting_data" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_invoices_updated_at" BEFORE UPDATE ON "public"."invoices" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_payments_updated_at" BEFORE UPDATE ON "public"."payments" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_cost_breakdowns_updated_at" BEFORE UPDATE ON "public"."project_cost_breakdowns" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_financial_health_updated_at" BEFORE UPDATE ON "public"."project_financial_health" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_health_metrics_updated_at" BEFORE UPDATE ON "public"."project_health_metrics" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_milestones_updated_at" BEFORE UPDATE ON "public"."project_milestones" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_releases_updated_at" BEFORE UPDATE ON "public"."project_releases" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_reports_updated_at" BEFORE UPDATE ON "public"."project_reports" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_risks_updated_at" BEFORE UPDATE ON "public"."project_risks" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_project_sprints_updated_at" BEFORE UPDATE ON "public"."project_sprints" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_projects_updated_at" BEFORE UPDATE ON "public"."projects" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_resource_allocations_updated_at" BEFORE UPDATE ON "public"."resource_allocations" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_risk_factors_updated_at" BEFORE UPDATE ON "public"."risk_factors" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_talent_assignments_updated_at" BEFORE UPDATE ON "public"."talent_assignments" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_talent_utilization_tracking_updated_at" BEFORE UPDATE ON "public"."talent_utilization_tracking" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_tasks_updated_at" BEFORE UPDATE ON "public"."tasks" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_time_entries_updated_at" BEFORE UPDATE ON "public"."time_entries" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_timer_sessions_updated_at" BEFORE UPDATE ON "public"."timer_sessions" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_timesheet_approvals_updated_at" BEFORE UPDATE ON "public"."timesheet_approvals" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_users_updated_at" BEFORE UPDATE ON "public"."users" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_work_orders_updated_at" BEFORE UPDATE ON "public"."work_orders" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."admin_dashboard_settings"
    ADD CONSTRAINT "admin_dashboard_settings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."budget_alerts"
    ADD CONSTRAINT "budget_alerts_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."calendar_events"
    ADD CONSTRAINT "calendar_events_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."cashflow_entries"
    ADD CONSTRAINT "cashflow_entries_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "public"."invoices"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."cashflow_entries"
    ADD CONSTRAINT "cashflow_entries_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."client_satisfaction"
    ADD CONSTRAINT "client_satisfaction_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."invoices"
    ADD CONSTRAINT "invoices_release_id_fkey" FOREIGN KEY ("release_id") REFERENCES "public"."project_releases"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_cost_breakdowns"
    ADD CONSTRAINT "project_cost_breakdowns_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_financial_health"
    ADD CONSTRAINT "project_financial_health_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_health_metrics"
    ADD CONSTRAINT "project_health_metrics_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_milestones"
    ADD CONSTRAINT "project_milestones_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_releases"
    ADD CONSTRAINT "project_releases_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_reports"
    ADD CONSTRAINT "project_reports_generated_by_fkey" FOREIGN KEY ("generated_by") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_reports"
    ADD CONSTRAINT "project_reports_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_risks"
    ADD CONSTRAINT "project_risks_assigned_to_fkey" FOREIGN KEY ("assigned_to") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."project_risks"
    ADD CONSTRAINT "project_risks_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_sprints"
    ADD CONSTRAINT "project_sprints_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."project_sprints"
    ADD CONSTRAINT "project_sprints_release_id_fkey" FOREIGN KEY ("release_id") REFERENCES "public"."project_releases"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."resource_allocations"
    ADD CONSTRAINT "resource_allocations_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."resource_allocations"
    ADD CONSTRAINT "resource_allocations_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."resource_allocations"
    ADD CONSTRAINT "resource_allocations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."risk_factors"
    ADD CONSTRAINT "risk_factors_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."talent_assignments"
    ADD CONSTRAINT "talent_assignments_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."talent_assignments"
    ADD CONSTRAINT "talent_assignments_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."talent_utilization_tracking"
    ADD CONSTRAINT "talent_utilization_tracking_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_assigned_talent_fkey" FOREIGN KEY ("assigned_talent") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_sprint_id_fkey" FOREIGN KEY ("sprint_id") REFERENCES "public"."project_sprints"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_work_order_id_fkey" FOREIGN KEY ("work_order_id") REFERENCES "public"."work_orders"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."time_entries"
    ADD CONSTRAINT "time_entries_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."time_entries"
    ADD CONSTRAINT "time_entries_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."time_entries"
    ADD CONSTRAINT "time_entries_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."timer_sessions"
    ADD CONSTRAINT "timer_sessions_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."timer_sessions"
    ADD CONSTRAINT "timer_sessions_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."timer_sessions"
    ADD CONSTRAINT "timer_sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."timesheet_approvals"
    ADD CONSTRAINT "timesheet_approvals_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "public"."users"("id");



ALTER TABLE ONLY "public"."timesheet_approvals"
    ADD CONSTRAINT "timesheet_approvals_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."work_orders"
    ADD CONSTRAINT "work_orders_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."work_orders"
    ADD CONSTRAINT "work_orders_sprint_id_fkey" FOREIGN KEY ("sprint_id") REFERENCES "public"."project_sprints"("id") ON DELETE CASCADE;





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."calculate_project_financial_health"("project_uuid" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_project_financial_health"("project_uuid" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_project_financial_health"("project_uuid" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."calculate_talent_utilization"("talent_uuid" "uuid", "week_start" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_talent_utilization"("talent_uuid" "uuid", "week_start" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_talent_utilization"("talent_uuid" "uuid", "week_start" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."process_audit_log"() TO "anon";
GRANT ALL ON FUNCTION "public"."process_audit_log"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."process_audit_log"() TO "service_role";


GRANT ALL ON FUNCTION "public"."get_admin_dashboard_active_stats"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_admin_dashboard_active_stats"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_admin_dashboard_active_stats"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_project_financial_health"("project_uuid" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."update_project_financial_health"("project_uuid" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_project_financial_health"("project_uuid" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";


















GRANT ALL ON TABLE "public"."admin_dashboard_settings" TO "anon";
GRANT ALL ON TABLE "public"."admin_dashboard_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."admin_dashboard_settings" TO "service_role";



GRANT ALL ON TABLE "public"."analytics_insights" TO "anon";
GRANT ALL ON TABLE "public"."analytics_insights" TO "authenticated";
GRANT ALL ON TABLE "public"."analytics_insights" TO "service_role";



GRANT ALL ON TABLE "public"."assessments" TO "anon";
GRANT ALL ON TABLE "public"."assessments" TO "authenticated";
GRANT ALL ON TABLE "public"."assessments" TO "service_role";



GRANT ALL ON TABLE "public"."audit_log" TO "anon";
GRANT ALL ON TABLE "public"."audit_log" TO "authenticated";
GRANT ALL ON TABLE "public"."audit_log" TO "service_role";



GRANT ALL ON TABLE "public"."budget_alerts" TO "anon";
GRANT ALL ON TABLE "public"."budget_alerts" TO "authenticated";
GRANT ALL ON TABLE "public"."budget_alerts" TO "service_role";



GRANT ALL ON TABLE "public"."calendar_events" TO "anon";
GRANT ALL ON TABLE "public"."calendar_events" TO "authenticated";
GRANT ALL ON TABLE "public"."calendar_events" TO "service_role";



GRANT ALL ON TABLE "public"."cashflow_entries" TO "anon";
GRANT ALL ON TABLE "public"."cashflow_entries" TO "authenticated";
GRANT ALL ON TABLE "public"."cashflow_entries" TO "service_role";



GRANT ALL ON TABLE "public"."client_satisfaction" TO "anon";
GRANT ALL ON TABLE "public"."client_satisfaction" TO "authenticated";
GRANT ALL ON TABLE "public"."client_satisfaction" TO "service_role";



GRANT ALL ON TABLE "public"."cost_efficiency_tracking" TO "anon";
GRANT ALL ON TABLE "public"."cost_efficiency_tracking" TO "authenticated";
GRANT ALL ON TABLE "public"."cost_efficiency_tracking" TO "service_role";



GRANT ALL ON TABLE "public"."feedback" TO "anon";
GRANT ALL ON TABLE "public"."feedback" TO "authenticated";
GRANT ALL ON TABLE "public"."feedback" TO "service_role";



GRANT ALL ON TABLE "public"."feedback_prompts" TO "anon";
GRANT ALL ON TABLE "public"."feedback_prompts" TO "authenticated";
GRANT ALL ON TABLE "public"."feedback_prompts" TO "service_role";



GRANT ALL ON TABLE "public"."financial_summaries" TO "anon";
GRANT ALL ON TABLE "public"."financial_summaries" TO "authenticated";
GRANT ALL ON TABLE "public"."financial_summaries" TO "service_role";



GRANT ALL ON TABLE "public"."projects" TO "anon";
GRANT ALL ON TABLE "public"."projects" TO "authenticated";
GRANT ALL ON TABLE "public"."projects" TO "service_role";



GRANT ALL ON TABLE "public"."financial_summary" TO "anon";
GRANT ALL ON TABLE "public"."financial_summary" TO "authenticated";
GRANT ALL ON TABLE "public"."financial_summary" TO "service_role";



GRANT ALL ON TABLE "public"."forecasting_data" TO "anon";
GRANT ALL ON TABLE "public"."forecasting_data" TO "authenticated";
GRANT ALL ON TABLE "public"."forecasting_data" TO "service_role";



GRANT ALL ON TABLE "public"."invoices" TO "anon";
GRANT ALL ON TABLE "public"."invoices" TO "authenticated";
GRANT ALL ON TABLE "public"."invoices" TO "service_role";



GRANT ALL ON TABLE "public"."next_actions" TO "anon";
GRANT ALL ON TABLE "public"."next_actions" TO "authenticated";
GRANT ALL ON TABLE "public"."next_actions" TO "service_role";



GRANT ALL ON TABLE "public"."payments" TO "anon";
GRANT ALL ON TABLE "public"."payments" TO "authenticated";
GRANT ALL ON TABLE "public"."payments" TO "service_role";



GRANT ALL ON TABLE "public"."problem_types" TO "anon";
GRANT ALL ON TABLE "public"."problem_types" TO "authenticated";
GRANT ALL ON TABLE "public"."problem_types" TO "service_role";



GRANT ALL ON TABLE "public"."problems" TO "anon";
GRANT ALL ON TABLE "public"."problems" TO "authenticated";
GRANT ALL ON TABLE "public"."problems" TO "service_role";



GRANT ALL ON TABLE "public"."project_cost_breakdowns" TO "anon";
GRANT ALL ON TABLE "public"."project_cost_breakdowns" TO "authenticated";
GRANT ALL ON TABLE "public"."project_cost_breakdowns" TO "service_role";



GRANT ALL ON TABLE "public"."project_financial_health" TO "anon";
GRANT ALL ON TABLE "public"."project_financial_health" TO "authenticated";
GRANT ALL ON TABLE "public"."project_financial_health" TO "service_role";



GRANT ALL ON TABLE "public"."project_financial_overview" TO "anon";
GRANT ALL ON TABLE "public"."project_financial_overview" TO "authenticated";
GRANT ALL ON TABLE "public"."project_financial_overview" TO "service_role";



GRANT ALL ON TABLE "public"."project_health_metrics" TO "anon";
GRANT ALL ON TABLE "public"."project_health_metrics" TO "authenticated";
GRANT ALL ON TABLE "public"."project_health_metrics" TO "service_role";



GRANT ALL ON TABLE "public"."project_milestones" TO "anon";
GRANT ALL ON TABLE "public"."project_milestones" TO "authenticated";
GRANT ALL ON TABLE "public"."project_milestones" TO "service_role";



GRANT ALL ON TABLE "public"."project_releases" TO "anon";
GRANT ALL ON TABLE "public"."project_releases" TO "authenticated";
GRANT ALL ON TABLE "public"."project_releases" TO "service_role";



GRANT ALL ON TABLE "public"."tasks" TO "anon";
GRANT ALL ON TABLE "public"."tasks" TO "authenticated";
GRANT ALL ON TABLE "public"."tasks" TO "service_role";



GRANT ALL ON TABLE "public"."project_portfolio_overview" TO "anon";
GRANT ALL ON TABLE "public"."project_portfolio_overview" TO "authenticated";
GRANT ALL ON TABLE "public"."project_portfolio_overview" TO "service_role";



GRANT ALL ON TABLE "public"."project_reports" TO "anon";
GRANT ALL ON TABLE "public"."project_reports" TO "authenticated";
GRANT ALL ON TABLE "public"."project_reports" TO "service_role";



GRANT ALL ON TABLE "public"."project_risks" TO "anon";
GRANT ALL ON TABLE "public"."project_risks" TO "authenticated";
GRANT ALL ON TABLE "public"."project_risks" TO "service_role";



GRANT ALL ON TABLE "public"."project_sprints" TO "anon";
GRANT ALL ON TABLE "public"."project_sprints" TO "authenticated";
GRANT ALL ON TABLE "public"."project_sprints" TO "service_role";



GRANT ALL ON TABLE "public"."resource_allocations" TO "anon";
GRANT ALL ON TABLE "public"."resource_allocations" TO "authenticated";
GRANT ALL ON TABLE "public"."resource_allocations" TO "service_role";



GRANT ALL ON TABLE "public"."time_entries" TO "anon";
GRANT ALL ON TABLE "public"."time_entries" TO "authenticated";
GRANT ALL ON TABLE "public"."time_entries" TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";



GRANT ALL ON TABLE "public"."resource_utilization" TO "anon";
GRANT ALL ON TABLE "public"."resource_utilization" TO "authenticated";
GRANT ALL ON TABLE "public"."resource_utilization" TO "service_role";



GRANT ALL ON TABLE "public"."risk_factors" TO "anon";
GRANT ALL ON TABLE "public"."risk_factors" TO "authenticated";
GRANT ALL ON TABLE "public"."risk_factors" TO "service_role";



GRANT ALL ON TABLE "public"."suggestions" TO "anon";
GRANT ALL ON TABLE "public"."suggestions" TO "authenticated";
GRANT ALL ON TABLE "public"."suggestions" TO "service_role";



GRANT ALL ON TABLE "public"."talent_assignments" TO "anon";
GRANT ALL ON TABLE "public"."talent_assignments" TO "authenticated";
GRANT ALL ON TABLE "public"."talent_assignments" TO "service_role";



GRANT ALL ON TABLE "public"."talent_utilization_overview" TO "anon";
GRANT ALL ON TABLE "public"."talent_utilization_overview" TO "authenticated";
GRANT ALL ON TABLE "public"."talent_utilization_overview" TO "service_role";



GRANT ALL ON TABLE "public"."talent_utilization_tracking" TO "anon";
GRANT ALL ON TABLE "public"."talent_utilization_tracking" TO "authenticated";
GRANT ALL ON TABLE "public"."talent_utilization_tracking" TO "service_role";



GRANT ALL ON TABLE "public"."timer_sessions" TO "anon";
GRANT ALL ON TABLE "public"."timer_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."timer_sessions" TO "service_role";



GRANT ALL ON TABLE "public"."timesheet_approvals" TO "anon";
GRANT ALL ON TABLE "public"."timesheet_approvals" TO "authenticated";
GRANT ALL ON TABLE "public"."timesheet_approvals" TO "service_role";



GRANT ALL ON TABLE "public"."training_examples" TO "anon";
GRANT ALL ON TABLE "public"."training_examples" TO "authenticated";
GRANT ALL ON TABLE "public"."training_examples" TO "service_role";



GRANT ALL ON TABLE "public"."work_orders" TO "anon";
GRANT ALL ON TABLE "public"."work_orders" TO "authenticated";
GRANT ALL ON TABLE "public"."work_orders" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";




























