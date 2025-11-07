return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
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

    -- Keymap to open oil.nvim with <C-w>.
    vim.keymap.set("n", "<C-w>.", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
