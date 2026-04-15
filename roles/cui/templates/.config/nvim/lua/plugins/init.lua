return {
	{ "RRethy/vim-illuminate" },
	{ "andymass/vim-matchup" },
	{ "hashivim/vim-terraform" },
	{
    "lewis6991/gitsigns.nvim",
    config = true,
  },
	{
	  "folke/snacks.nvim",
	  ---@type snacks.Config
	  opts = {
	    indent = { enabled = true },
	    scope = { enabled = true },
	  },
	},
	{
    "mbbill/undotree",
    keys = {
      { "<leader>su", "<cmd>UndotreeToggle<cr>", desc = "Undotree Toggle" },
    },
  },
	{ "mg979/vim-visual-multi" },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require('tiny-inline-diagnostic').setup({
        options = {
          multilines = true,
        },
      })
    end
  },
	{ "psliwka/vim-smoothie" },
	{
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd [[colorscheme kanagawa-dragon]]
    end,
  },
	{ "tpope/vim-abolish" },
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
		keys = {
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
			{ "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff" },
		},
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "williamboman/mason.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<Tab>",
					},
				},
			})
		end,
	},
}
