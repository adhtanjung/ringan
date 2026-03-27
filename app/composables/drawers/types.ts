export interface DrawerRecord {
	[key: string]: unknown;
}

export interface DrawerOpenState {
	[key: string]: boolean;
}

export interface RelationActionPayload {
	scopeKey: string;
	idField: string;
	idValue: string | number | null | undefined;
}

export interface LinkedListRequestPayload extends RelationActionPayload {
	title: string;
	description: string;
}

export interface CopyIdPayload {
	value: unknown;
	label: string;
}

export type RelationSummaryStatus =
	| "idle"
	| "loading"
	| "resolved"
	| "missing"
	| "not_found"
	| "error";

export interface RelationSummaryPayload {
	title: string;
	subtitle?: string;
	badges?: string[];
	idLabel: string;
	idValue: string;
}

export interface RelationSummaryState {
	status: RelationSummaryStatus;
	loading: boolean;
	error: string;
	data: RelationSummaryPayload | null;
}

export const createRelationSummaryState = (): RelationSummaryState => ({
	status: "idle",
	loading: false,
	error: "",
	data: null,
});
