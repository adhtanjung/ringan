import { driver } from "driver.js";
import "driver.js/dist/driver.css";

export const useOnboarding = () => {
	const commonSteps = [
		{
			element: "#tour-search",
			popover: {
				title: "Search Data",
				description: "Quickly find items by typing keywords here.",
			},
		},
		{
			element: "#tour-filter-toggle",
			popover: {
				title: "Filter Options",
				description:
					"Click here to toggle the filter bar and refine your view.",
			},
		},
		{
			element: "#tour-filter-bar",
			popover: {
				title: "Active Filters",
				description: "Use these dropdowns to filter by specific criteria.",
			},
		},
		{
			element: "#tour-create-new",
			popover: {
				title: "Add New Data",
				description: "Click here to create a new entry manually.",
			},
		},
		{
			element: "#tour-import-export",
			popover: {
				title: "Import / Export",
				description:
					"Bulk actions! Import data from CSV or export current view to CSV.",
			},
		},
		{
			element: "#tour-refresh",
			popover: {
				title: "Refresh Data",
				description: "Reload the latest data from the server.",
			},
		},
		{
			element: "#tour-table-headers",
			popover: {
				title: "Sortable Columns",
				description:
					"Click column headers to sort data ascending or descending.",
			},
		},
	];

	const problemSteps = [
		{
			element: "#tour-page-title",
			popover: {
				title: "Subcategories (Problems)",
				description:
					"Manage all subcategories here. This is the main data view.",
			},
		},
		...commonSteps,
	];

	const problemTypeSteps = [
		{
			element: "#tour-page-title",
			popover: {
				title: "Problem Categories",
				description:
					"Define the high-level categories that group your subcategories.",
			},
		},
		...commonSteps,
	];

	const assessmentSteps = [
		{
			element: "#tour-page-title",
			popover: {
				title: "Assessments",
				description: "Manage assessment questions for each subcategory.",
			},
		},
		{
			element: "#tour-bulk-edit",
			popover: {
				title: "Bulk Edit Mode",
				description:
					"Switch to Spreadsheet View for fast, bulk editing of questions.",
			},
		},
		...commonSteps,
	];

	const importSteps = [
		{
			element: "#tour-import-modal-title",
			popover: {
				title: "Import Data",
				description:
					"Upload your data files here. Supports CSV, Excel, and JSON.",
			},
		},
		{
			element: "#tour-import-file",
			popover: {
				title: "File Upload",
				description: "Drag & Drop your file or click to browse.",
			},
		},
		{
			element: "#tour-import-type",
			popover: {
				title: "Data Type",
				description: "Select which type of data you are importing.",
			},
		},
		{
			element: "#tour-import-templates",
			popover: {
				title: "Templates & Examples",
				description:
					"Download a template to ensure your data is formatted correctly.",
			},
		},
		{
			element: "#tour-import-btn",
			popover: {
				title: "Start Import",
				description: "Click here to begin the import process.",
			},
		},
	];

	const editSteps = [
		{
			element: "#tour-edit-modal-title",
			popover: {
				title: "Edit / Create Item",
				description: "Fill in the details for this item.",
			},
		},
		{
			element: "#dataset-edit-form",
			popover: {
				title: "Form Fields",
				description: "Complete all required fields marked with *.",
			},
		},
		{
			element: "#tour-edit-save-btn",
			popover: {
				title: "Save Changes",
				description: "Click to save your changes to the database.",
			},
		},
	];

	const problemTypeEditSteps = [
		{
			element: "#tour-pt-modal-title",
			popover: {
				title: "Category Details",
				description: "Define the main Category details here.",
			},
		},
		{
			element: "#tour-pt-check-btn",
			popover: {
				title: "Duplicate Check",
				description: "Click to verify if this Category Name already exists.",
			},
		},
		{
			element: "#tour-pt-save-btn",
			popover: {
				title: "Save Category",
				description: "Create or update the category.",
			},
		},
	];

	const startTour = (
		page:
			| "problems"
			| "problem_types"
			| "assessments"
			| "import"
			| "edit_general"
			| "edit_problem_type",
	) => {
		let steps: any[] = [];

		if (page === "problems") steps = problemSteps;
		else if (page === "problem_types") steps = problemTypeSteps;
		else if (page === "assessments") steps = assessmentSteps;
		else if (page === "import") steps = importSteps;
		else if (page === "edit_general") steps = editSteps;
		else if (page === "edit_problem_type") steps = problemTypeEditSteps;

		const driverObj = driver({
			showProgress: true,
			animate: true,
			popoverClass: "driverjs-theme",
			steps: steps,
		});

		driverObj.drive();
	};

	return {
		startTour,
	};
};
