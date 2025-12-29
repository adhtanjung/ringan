/**
 * Simple CSV parser utility
 * Handles quoted fields, escaped characters, and newlines
 */

export interface ParsedCSV {
	headers: string[];
	data: Array<Record<string, any>>;
}

/**
 * Parse CSV text into an array of objects
 * @param csvText The CSV file content as string
 * @returns Object containing headers array and data array
 */
export function parseCSV(csvText: string): ParsedCSV {
	if (!csvText || csvText.trim().length === 0) {
		return { headers: [], data: [] };
	}

	const lines: string[] = [];
	let currentLine = "";
	let inQuotes = false;

	// Split by lines while respecting quoted fields
	for (let i = 0; i < csvText.length; i++) {
		const char = csvText[i];
		const nextChar = csvText[i + 1];

		if (char === '"') {
			if (inQuotes && nextChar === '"') {
				// Escaped quote
				currentLine += '"';
				i++; // Skip next quote
			} else {
				// Toggle quote state
				inQuotes = !inQuotes;
			}
		} else if (char === "\n" && !inQuotes) {
			// End of line
			if (currentLine.trim()) {
				lines.push(currentLine);
			}
			currentLine = "";
		} else if (char === "\r") {
			// Skip carriage return
			continue;
		} else {
			currentLine += char;
		}
	}

	// Add the last line if not empty
	if (currentLine.trim()) {
		lines.push(currentLine);
	}

	if (lines.length === 0) {
		return { headers: [], data: [] };
	}

	// Parse first line as headers
	const headers = parseCSVLine(lines[0]!); // Safe: we checked lines.length > 0

	// Parse remaining lines as data
	const data: Array<Record<string, any>> = [];

	for (let i = 1; i < lines.length; i++) {
		const values = parseCSVLine(lines[i]!); // Safe: within array bounds

		// Skip empty lines
		if (values.length === 0 || (values.length === 1 && values[0] === "")) {
			continue;
		}

		// Create object mapping headers to values
		const row: Record<string, any> = {};
		headers.forEach((header, index) => {
			const value = values[index] ?? "";
			// Convert string values to appropriate types
			row[header] = convertValue(value);
		});

		data.push(row);
	}

	return { headers, data };
}

/**
 * Parse a single CSV line into an array of values
 * @param line The CSV line to parse
 * @returns Array of values (never undefined)
 */
function parseCSVLine(line: string): string[] {
	const values: string[] = [];
	let currentValue = "";
	let inQuotes = false;

	for (let i = 0; i < line.length; i++) {
		const char = line[i];
		const nextChar = line[i + 1];

		if (char === '"') {
			if (inQuotes && nextChar === '"') {
				// Escaped quote
				currentValue += '"';
				i++; // Skip next quote
			} else {
				// Toggle quote state
				inQuotes = !inQuotes;
			}
		} else if (char === "," && !inQuotes) {
			// End of value
			values.push(currentValue);
			currentValue = "";
		} else {
			currentValue += char;
		}
	}

	// Add the last value
	values.push(currentValue);

	// Ensure all values are strings (no undefined)
	return values.map((v) => v ?? "");
}

/**
 * Convert string values to appropriate types (boolean, number, null)
 * @param value The string value to convert
 * @returns Converted value
 */
function convertValue(value: string): any {
	if (value === "") return "";
	if (value === "null" || value === "NULL") return null;
	if (value === "true" || value === "TRUE") return true;
	if (value === "false" || value === "FALSE") return false;

	// Try to convert to number
	const num = Number(value);
	if (!isNaN(num) && value.trim() !== "") {
		return num;
	}

	return value;
}

/**
 * Convert array of objects to CSV text
 * @param data Array of objects to convert
 * @returns CSV text
 */
export function toCSV(data: Array<Record<string, any>>): string {
	if (!data || data.length === 0) {
		return "";
	}

	// Get headers from first object
	const firstItem = data[0];
	if (!firstItem) {
		return "";
	}

	const headers = Object.keys(firstItem);

	// Create header line
	const headerLine = headers.map((h) => escapeCSVValue(h)).join(",");

	// Create data lines
	const dataLines = data.map((row) => {
		return headers
			.map((header) => {
				const value = row[header];
				return escapeCSVValue(value);
			})
			.join(",");
	});

	return [headerLine, ...dataLines].join("\n");
}

/**
 * Escape a value for CSV format
 * @param value The value to escape
 * @returns Escaped value
 */
function escapeCSVValue(value: any): string {
	if (value === null || value === undefined) {
		return "";
	}

	const str = String(value);

	// If value contains comma, quote, or newline, wrap in quotes and escape quotes
	if (str.includes(",") || str.includes('"') || str.includes("\n")) {
		return `"${str.replace(/"/g, '""')}"`;
	}

	return str;
}
