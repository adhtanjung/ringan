-- Incremental patch: dashboard RPC only
-- Safe to run on existing databases

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



GRANT ALL ON FUNCTION "public"."get_admin_dashboard_active_stats"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_admin_dashboard_active_stats"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_admin_dashboard_active_stats"() TO "service_role";
