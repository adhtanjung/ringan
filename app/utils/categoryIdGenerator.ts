import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Generate a human-readable prefix from a type name
 * Examples:
 * - "Work Stress" -> "WS"
 * - "Social Anxiety" -> "SA"
 * - "Depression" -> "DEP"
 */
export function generatePrefix(typeName: string): string {
	if (!typeName) return "";

	// Remove special characters and extra spaces
	const cleaned = typeName.trim().replace(/[^a-zA-Z\s]/g, "");

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
 * Get the next sequence number for a given prefix
 * @param supabase Supabase client instance
 * @param prefix The prefix to search for (e.g., "WS")
 * @returns The next sequence number as a zero-padded string (e.g., "001")
 */
export async function getNextSequence(
	supabase: SupabaseClient,
	prefix: string
): Promise<string> {
	try {
		// Query all category_ids that start with this prefix
		const { data, error } = await supabase
			.from("problem_types")
			.select("category_id")
			.like("category_id", `${prefix}_%`);

		if (error) {
			console.error("Error fetching existing category IDs:", error);
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
				const match = item.category_id.match(new RegExp(`^${prefix}_(\\d+)$`));
				return match ? parseInt(match[1], 10) : 0;
			})
			.filter((num) => !isNaN(num) && num > 0);

		// Find the maximum sequence number
		const maxSequence = sequences.length > 0 ? Math.max(...sequences) : 0;

		// Return next sequence, zero-padded to 3 digits
		return String(maxSequence + 1).padStart(3, "0");
	} catch (error) {
		console.error("Unexpected error in getNextSequence:", error);
		return "001";
	}
}

/**
 * Generate a complete category ID from a type name
 * @param supabase Supabase client instance
 * @param typeName The type name to generate ID from
 * @returns A human-readable category ID (e.g., "WS_001")
 */
export async function generateCategoryId(
	supabase: SupabaseClient,
	typeName: string
): Promise<string> {
	const prefix = generatePrefix(typeName);
	if (!prefix) {
		throw new Error("Cannot generate category ID: invalid type name");
	}

	const sequence = await getNextSequence(supabase, prefix);
	return `${prefix}_${sequence}`;
}
