return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-w>e", "<CMD>Oil<CR>", desc = "Open filer in current buffer", mode = "n" },
    { "<C-w>v", "<CMD>vsplit | Oil<CR>", desc = "Open filer in vertical split", mode = "n" },
    { "<C-w>s", "<CMD>split | Oil<CR>", desc = "Open filer in horizontal split", mode = "n" },
    { "<C-w>t", "<CMD>tabnew | Oil<CR>", desc = "Open filer in new tab", mode = "n" },
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
        ["<BS>"] = "actions.parent",
      },
    })
  end,
}
