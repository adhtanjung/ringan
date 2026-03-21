import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Generate a human-readable prefix from a name
 * Examples:
 * - "Work Stress" => "WS"
 * - "Social Anxiety" => "SA"
 * - "Depression" => "DEP"
 */
export function generateSubCategoryPrefix(name: string): string {
	if (!name) return "";

	// Remove special characters and extra spaces
	const cleaned = name.trim().replace(/[^a-zA-Z\s]/g, "");

	// Split into words
	const words = cleaned.split(/\s+/).filter((word) => word.length > 0);

	if (words.length === 0) return "";

	// If single word, take first 3 characters
	if (words.length === 1) {
		return words[0]!.substring(0, 3).toUpperCase();
	}

	// If multiple words, take first letter of each word (max 4)
	return words
		.slice(0, 4)
		.filter((word) => word.length > 0) // Ensure non-empty words
		.map((word) => word[0])
		.join("")
		.toUpperCase();
}

/**
 * Get the next sequence number for a given prefix in the problems table
 * @param supabase Supabase client instance
 * @param prefix The prefix to search for (e.g., "WS")
 * @returns The next sequence number as a zero-padded string (e.g., "001")
 */
export async function getNextSubCategorySequence(
	supabase: SupabaseClient,
	prefix: string
): Promise<string> {
	try {
		// Query all sub_category_ids that start with this prefix
		const { data, error } = await supabase
			.from("problems")
			.select("sub_category_id")
			.like("sub_category_id", `${prefix}_%`);

		if (error) {
			console.error("Error fetching existing subcategory IDs:", error);
			// If error, start from 1
			return "001";
		}

		if (!data || data.length === 0) {
			// No existing records with this prefix
			return "001";
		}

		// Extract sequence numbers from existing IDs
		const sequences = data
			.map((item) => {
				const match = item.sub_category_id.match(
					new RegExp(`^${prefix}_(\\d+)$`)
				);
				return match ? parseInt(match[1], 10) : 0;
			})
			.filter((num) => !isNaN(num) && num > 0);

		// Find the maximum sequence number
		const maxSequence = sequences.length > 0 ? Math.max(...sequences) : 0;

		// Return next sequence, zero-padded to 3 digits
		return String(maxSequence + 1).padStart(3, "0");
	} catch (error) {
		console.error("Unexpected error in getNextSubCategorySequence:", error);
		return "001";
	}
}

/**
 * Generate a complete subcategory ID from a problem name
 * @param supabase Supabase client instance
 * @param problemName The problem name to generate ID from
 * @returns A human-readable subcategory ID (e.g., "WS_001")
 */
export async function generateSubCategoryId(
	supabase: SupabaseClient,
	problemName: string
): Promise<string> {
	const prefix = generateSubCategoryPrefix(problemName);
	if (!prefix) {
		throw new Error("Cannot generate subcategory ID: invalid problem name");
	}

	const sequence = await getNextSubCategorySequence(supabase, prefix);
	return `${prefix}_${sequence}`;
}
