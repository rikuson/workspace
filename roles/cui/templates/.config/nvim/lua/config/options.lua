local opt = vim.opt

-- Display
opt.conceallevel = 0
opt.wrap = true
opt.number = true
opt.list = true
opt.listchars = { tab = "¦ ", trail = "-", eol = "¬" }
opt.virtualedit = "block"
opt.mouse = "n"

-- Charcode
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8", "euc-jp", "sjis" }
opt.fileformats = { "unix", "dos", "mac" }
vim.cmd("lang en_US.UTF-8")

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = false
opt.ignorecase = false

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- History
opt.swapfile = false
opt.hidden = true
opt.undodir = vim.fn.expand("~/.vim/undo/")
opt.undofile = true

-- Cursor shape (terminal)
if vim.fn.has("unix") == 1 then
  vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
end
