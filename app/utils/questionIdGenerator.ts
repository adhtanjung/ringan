import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Get the next question ID in the format Q{number}
 * @param supabase Supabase client instance
 * @returns The next question ID (e.g., "Q1", "Q2", "Q3", etc.)
 */
export async function generateQuestionId(
	supabase: SupabaseClient,
	_questionText?: string
): Promise<string> {
	try {
		// Query all question_ids that start with "Q"
		const { data, error } = await supabase
			.from("assessments")
			.select("question_id")
			.like("question_id", "Q%");

		if (error) {
			console.error("Error fetching existing question IDs:", error);
			// If error, start from Q1
			return "Q1";
		}

		if (!data || data.length === 0) {
			// No existing records
			return "Q1";
		}

		// Extract sequence numbers from existing IDs (e.g., "Q1" => 1, "Q23" => 23)
		const sequences = data
			.map((item) => {
				const match = item.question_id.match(/^Q(\d+)$/);
				return match ? parseInt(match[1], 10) : 0;
			})
			.filter((num) => !isNaN(num) && num > 0);

		// Find the maximum sequence number
		const maxSequence = sequences.length > 0 ? Math.max(...sequences) : 0;

		// Return next sequence in format Q{padded_number}
		return `Q${String(maxSequence + 1).padStart(8, "0")}`;
	} catch (error) {
		console.error("Unexpected error in generateQuestionId:", error);
		return "Q1";
	}
}
