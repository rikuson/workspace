return {
  "kylechui/nvim-surround",
  config = function()
    require("nvim-surround").setup({})

    -- Remove default keymaps we don't want
    pcall(vim.keymap.del, "i", "<C-g>s")
    pcall(vim.keymap.del, "i", "<C-g>S")
    pcall(vim.keymap.del, "n", "ys")
    pcall(vim.keymap.del, "n", "yss")
    pcall(vim.keymap.del, "n", "yS")
    pcall(vim.keymap.del, "n", "ySS")
    pcall(vim.keymap.del, "x", "S")
    pcall(vim.keymap.del, "x", "gS")

    -- Custom keymaps (noremap=false required for <Plug> mappings)
    local opts = { noremap = false, silent = true }
    vim.keymap.set("n", "s", "<Plug>(nvim-surround-normal)", opts)
    vim.keymap.set("n", "ss", "<Plug>(nvim-surround-normal-cur)", opts)
    vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", opts)
  end
}
