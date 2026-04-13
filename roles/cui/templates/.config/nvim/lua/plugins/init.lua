return {
	{ "L3MON4D3/LuaSnip" },
	{ "RRethy/vim-illuminate", event = "BufReadPost" },
	{ "andymass/vim-matchup", event = "BufReadPost" },
	{ "editorconfig/editorconfig-vim" },
	{
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
    },
  },
	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "itchyny/lightline.vim" },
	{ "jay-babu/mason-null-ls.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = true,
  },
	{
	  "lukas-reineke/indent-blankline.nvim",
	  main = "ibl",
	  event = "BufReadPre",
	  ---@module "ibl"
	  ---@type ibl.config
	  opts = {
	    indent = { char = '¦' }
	  },
	},
	{
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 500
    end,
  },
	{
    "mbbill/undotree",
    keys = {
      { "<leader>su", "<cmd>UndotreeToggle<cr>", desc = "Undotree Toggle" },
    },
  },
	{ "mg979/vim-visual-multi", event = "BufReadPost" },
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
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "onsails/lspkind-nvim" },
	{ "psliwka/vim-smoothie" },
	{
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd [[colorscheme kanagawa-dragon]]
    end,
  },
	{ "statianzo/vim-jade" },
	{
    "thinca/vim-quickrun",
    cmd = "QuickRun",
    config = function()
      if vim.version().major > 8 or (vim.version().major == 8 and vim.version().minor >= 2) then
        vim.g.quickrun_config = {
          _ = {
            outputter = "popup"
          }
        }
      end
      vim.g.quickrun_no_default_key_mappings = 1
    end
  },
	{ "tpope/vim-abolish", event = "BufReadPost" },
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
	{ "windwp/nvim-ts-autotag", event = "InsertEnter" },
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
		},
		config = function()
			require("copilot").setup({})
		end,
	},
}
