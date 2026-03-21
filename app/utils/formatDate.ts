export const formatDate = (value: string | number | Date | null | undefined): string => {
	if (!value) return "-";

	const date = value instanceof Date ? value : new Date(value);
	if (Number.isNaN(date.getTime())) return "-";

	return new Intl.DateTimeFormat(undefined, {
		dateStyle: "medium",
		timeStyle: "short",
	}).format(date);
};
