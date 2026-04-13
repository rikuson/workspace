return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	event = "LspAttach",
	config = function()
		require("goto-preview").setup({
			references = {
				provider = "telescope",
				telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
			},
		})
	end,
	keys = {
		{ "gpd", function() require("goto-preview").goto_preview_definition() end, desc = "Preview Definition" },
		{ "gpt", function() require("goto-preview").goto_preview_type_definition() end, desc = "Preview Type Definition" },
		{ "gpi", function() require("goto-preview").goto_preview_implementation() end, desc = "Preview Implementation" },
		{ "gpD", function() require("goto-preview").goto_preview_declaration() end, desc = "Preview Declaration" },
		{ "gpr", function() require("goto-preview").goto_preview_references() end, desc = "Preview References" },
		{ "gP", function() require("goto-preview").close_all_win() end, desc = "Close All Preview Windows" },
	},
}
