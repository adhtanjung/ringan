import type { SupabaseClient } from "@supabase/supabase-js";

interface SequenceIdConfig {
	table: string;
	column: string;
	prefix: string;
	width?: number;
	legacyPatterns?: RegExp[];
}

const SUGGESTION_LEGACY_PATTERNS = [
	/^SUG_(\d+)$/i,
	/^S_[A-Z]{2,4}_(\d{3,4})$/i,
];

const ACTION_LEGACY_PATTERNS = [/^NA_(\d+)$/i];

const escapeRegex = (value: string) =>
	value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

const extractSequence = (
	value: string,
	prefix: string,
	legacyPatterns: RegExp[] = [],
) => {
	const canonicalMatch = value.match(
		new RegExp(`^${escapeRegex(prefix)}_(\\d+)$`, "i"),
	);
	if (canonicalMatch?.[1]) {
		return Number.parseInt(canonicalMatch[1], 10) || 0;
	}

	for (const pattern of legacyPatterns) {
		const match = value.match(pattern);
		if (match?.[1]) {
			return Number.parseInt(match[1], 10) || 0;
		}
	}

	return 0;
};

const getMaxSequence = async (
	supabase: SupabaseClient,
	config: SequenceIdConfig,
) => {
	try {
		const { data, error } = await supabase
			.from(config.table)
			.select(config.column);

		if (error) {
			console.error(
				`Error fetching existing IDs from ${config.table}.${config.column}:`,
				error,
			);
			return 0;
		}

		let maxSequence = 0;
		for (const row of data || []) {
			const idValue = String(row?.[config.column] || "");
			if (!idValue) continue;

			const sequence = extractSequence(
				idValue,
				config.prefix,
				config.legacyPatterns || [],
			);
			if (sequence > maxSequence) {
				maxSequence = sequence;
			}
		}

		return maxSequence;
	} catch (error) {
		console.error(
			`Unexpected error while computing max sequence for ${config.table}.${config.column}:`,
			error,
		);
		return 0;
	}
};

export async function createSequenceIdAllocator(
	supabase: SupabaseClient,
	config: SequenceIdConfig,
) {
	const width = config.width ?? 4;
	let current = await getMaxSequence(supabase, config);

	return () => `${config.prefix}_${String(++current).padStart(width, "0")}`;
}

export async function createSuggestionIdAllocator(supabase: SupabaseClient) {
	return createSequenceIdAllocator(supabase, {
		table: "suggestions",
		column: "suggestion_id",
		prefix: "S",
		width: 4,
		legacyPatterns: SUGGESTION_LEGACY_PATTERNS,
	});
}

export async function createActionIdAllocator(supabase: SupabaseClient) {
	return createSequenceIdAllocator(supabase, {
		table: "next_actions",
		column: "action_id",
		prefix: "A",
		width: 4,
		legacyPatterns: ACTION_LEGACY_PATTERNS,
	});
}

export async function generateSuggestionId(supabase: SupabaseClient) {
	const nextId = await createSuggestionIdAllocator(supabase);
	return nextId();
}

export async function generateActionId(supabase: SupabaseClient) {
	const nextId = await createActionIdAllocator(supabase);
	return nextId();
}

export function isValidSuggestionId(value: string) {
	return /^(S_\d{4,}|SUG_\d{3,4}|S_[A-Z]{2,4}_\d{3,4})$/i.test(value || "");
}

export function isValidActionId(value: string) {
	return /^(A_\d{3,}|NA_\d{3,4})$/i.test(value || "");
}
