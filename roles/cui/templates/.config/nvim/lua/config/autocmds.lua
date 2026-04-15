local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight cursorline number only in active window
augroup("CursorLine", { clear = true })
autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = "CursorLine",
  callback = function() vim.wo.cursorline = true end,
})
autocmd("WinLeave", {
  group = "CursorLine",
  callback = function() vim.wo.cursorline = false end,
})

-- Remember cursor position
augroup("RestoreCursor", { clear = true })
autocmd("BufRead", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function() vim.hl.on_yank({ timeout = 500 }) end,
})
