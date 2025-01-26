-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<Cr>", "A<Cr><Esc>", { noremap = true })

-- Insert mode key mappings
vim.keymap.set("i", "<C-a>", "<C-o>^", { noremap = true })
vim.keymap.set("i", "<C-b>", "<C-g>u<Left>", { noremap = true })
vim.keymap.set("i", "<C-f>", "<C-g>u<Right>", { noremap = true })
vim.keymap.set("i", "<C-e>", "<C-g>u<End>", { noremap = true })
vim.keymap.set("i", "<C-y>", '<C-r>"', { noremap = true })
vim.keymap.set("i", "<C-p>", "<C-o>gk", { noremap = true })
vim.keymap.set("i", "<C-n>", "<C-o>gj", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Esc>ld$a", { noremap = true })
vim.keymap.set("i", "<C-d>", "<Del>", { noremap = true })
vim.keymap.set("i", "<C-h>", "<Bs>", { noremap = true })

-- Command-line mode key mappings
vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true })
vim.keymap.set("c", "<C-h>", "<Bs>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<Right>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true })
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true })