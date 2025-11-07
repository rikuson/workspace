return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-w>.", "<CMD>Oil<CR>", desc = "Open parent directory", mode = "n" },
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
      },
    })
  end,
}
