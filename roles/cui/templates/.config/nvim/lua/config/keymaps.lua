local map = vim.keymap.set

-- Leader (also set in config/lazy.lua for lazy.nvim compatibility)
map("", "<space>", "<Nop>")

-- General
map({ "n", "v", "o" }, "Y", "y$")
map("v", "$", "$h")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("o", "W", [[:execute 'normal! '.v:count1.'W'<CR>]])
map({ "n", "v", "o" }, "<C-l>", "<Cmd>nohlsearch<CR>", { silent = true })
map("n", "<CR>", "A<CR><Esc>")
map("i", "<Right>", "<C-t>")
map("i", "<Left>", "<C-d>")

-- Escape
-- FIXME: ft_sqlの関数がマッピングされててSQLファイルで<C-c>の実行が遅い
map("i", "<C-l>", "<Esc>")
map("v", "<C-l>", "<Esc>")

-- Insert mode (Emacs-like)
map("i", "<C-a>", "<C-o>^")
map("i", "<C-b>", "<C-g>u<Left>")
map("i", "<C-f>", "<C-g>u<Right>")
map("i", "<C-e>", "<C-g>u<End>")
map("i", "<C-y>", '<C-r>"')
map("i", "<C-p>", "<C-o>gk")
map("i", "<C-n>", "<C-o>gj")
map("i", "<C-k>", "<Esc>ld$a")
map("i", "<C-d>", "<Del>")
map("i", "<C-h>", "<BS>")

-- Command mode (Emacs-like)
map("c", "<C-d>", "<Del>")
map("c", "<C-h>", "<BS>")
map("c", "<C-a>", "<Home>")
map("c", "<C-f>", "<Right>")
map("c", "<C-b>", "<Left>")
map("c", "<C-p>", "<Up>")
map("c", "<C-n>", "<Down>")

-- Prevent default
map("n", "s", "<Nop>")
map("x", "s", "<Nop>")
map("n", "Q", "gq")

-- Pane / Window / Tab
map("n", "<C-w>e", "<Cmd>edit<CR>")
map("n", "<C-w>v", "<Cmd>vsplit<CR>")
map("n", "<C-w>s", "<Cmd>split<CR>")
map("n", "<C-w>t", "<Cmd>tabnew %<CR>")
map("n", "<C-w>w", "<Cmd>w<CR>")
map("n", "<C-w>n", "gt")
map("n", "<C-w>p", "gT")
for n = 1, 9 do
  map("n", "<C-w>" .. n, "<Cmd>tabnext " .. n .. "<CR>", { silent = true })
end
