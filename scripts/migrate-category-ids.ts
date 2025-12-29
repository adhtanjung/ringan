#!/usr/bin/env tsx
/**
 * Migration script to update existing problem_types records with human-readable category IDs
 *
 * Usage: npx tsx scripts/migrate-category-ids.ts
 */

import { createClient } from "@supabase/supabase-js";
import { generateCategoryId } from "../app/utils/categoryIdGenerator";

// Load environment variables
const SUPABASE_URL =
	process.env.SUPABASE_URL || "https://rnmfpyjfmgwwqgdgwcgz.supabase.co";
const SUPABASE_KEY =
	process.env.SUPABASE_PUBLISHABLE_KEY ||
	"sb_publishable_yxLgCF4Pj6O4Nr1TxGPdxA_CZ-kTLnE";

interface ProblemType {
	id: string;
	type_name: string;
	category_id: string;
}

async function migrateCategories() {
	console.log("🚀 Starting category ID migration...\n");

	// Create Supabase client
	const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

	try {
		// Fetch all problem types
		console.log("📥 Fetching existing problem types...");
		const { data: problemTypes, error: fetchError } = await supabase
			.from("problem_types")
			.select("id, type_name, category_id")
			.order("created_at", { ascending: true });

		if (fetchError) {
			throw new Error(`Failed to fetch problem types: ${fetchError.message}`);
		}

		if (!problemTypes || problemTypes.length === 0) {
			console.log("✅ No problem types found to migrate.");
			return;
		}

		console.log(`Found ${problemTypes.length} problem type(s)\n`);

		// Track generated IDs to ensure uniqueness in this batch
		const generatedIds = new Set<string>();
		let successCount = 0;
		let skipCount = 0;
		let errorCount = 0;

		// Process each problem type
		for (let i = 0; i < problemTypes.length; i++) {
			const item = problemTypes[i];
			console.log(
				`[${i + 1}/${problemTypes.length}] Processing: "${item.type_name}"`
			);
			console.log(`  Current category_id: ${item.category_id}`);

			// Check if it already has a human-readable format (PREFIX_NNN)
			const isHumanReadable = /^[A-Z]{1,4}_\d{3}$/.test(item.category_id);

			if (isHumanReadable) {
				console.log(`  ⏭️  Skipping (already human-readable)\n`);
				skipCount++;
				continue;
			}

			try {
				// Generate new category ID
				let newCategoryId = await generateCategoryId(supabase, item.type_name);

				// Handle potential duplicates within this batch
				let attempt = 1;
				while (generatedIds.has(newCategoryId) && attempt < 100) {
					console.log(`  ⚠️  Collision detected, regenerating...`);
					// Modify the type name slightly to get a different ID
					newCategoryId = await generateCategoryId(
						supabase,
						`${item.type_name} ${attempt}`
					);
					attempt++;
				}

				generatedIds.add(newCategoryId);
				console.log(`  New category_id: ${newCategoryId}`);

				// Update the record
				const { error: updateError } = await supabase
					.from("problem_types")
					.update({ category_id: newCategoryId })
					.eq("id", item.id);

				if (updateError) {
					throw new Error(`Update failed: ${updateError.message}`);
				}

				console.log(`  ✅ Updated successfully\n`);
				successCount++;
			} catch (error) {
				console.error(
					`  ❌ Error: ${
						error instanceof Error ? error.message : String(error)
					}\n`
				);
				errorCount++;
			}
		}

		// Summary
		console.log("=" + "=".repeat(50));
		console.log("\n📊 Migration Summary:");
		console.log(`   Total records: ${problemTypes.length}`);
		console.log(`   ✅ Successfully updated: ${successCount}`);
		console.log(`   ⏭️  Skipped (already migrated): ${skipCount}`);
		console.log(`   ❌ Errors: ${errorCount}`);
		console.log("\n✨ Migration complete!\n");
	} catch (error) {
		console.error("\n❌ Migration failed:");
		console.error(error instanceof Error ? error.message : String(error));
		process.exit(1);
	}
}

// Run the migration
migrateCategories();
