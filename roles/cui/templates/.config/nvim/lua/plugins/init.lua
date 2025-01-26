return {
  { "mbbill/undotree" },
  { "mg979/vim-visual-multi" },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("tiny-inline-diagnostic").setup({
        options = {
          multilines = true,
        },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd([[colorscheme kanagawa-dragon]])
    end,
  },
  {
    "thinca/vim-quickrun",
    config = function()
      if vim.version().major > 8 or (vim.version().major == 8 and vim.version().minor >= 2) then
        vim.g.quickrun_config = {
          _ = {
            outputter = "popup",
          },
        }
      end
      vim.g.quickrun_no_default_key_mappings = 1
    end,
  },
  { "tpope/vim-fugitive" },
}
