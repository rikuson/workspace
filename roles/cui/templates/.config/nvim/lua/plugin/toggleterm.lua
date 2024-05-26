require("toggleterm").setup()
local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true
})
function _lazygit_toggle()
  lazygit:toggle()
end

local lazydocker = Terminal:new({
  cmd = "lazydocker",
  direction = "float",
  hidden = true
})
function _lazydocker_toggle()
  lazydocker:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua _lazydocker_toggle()<CR>", { noremap = true, silent = true })
