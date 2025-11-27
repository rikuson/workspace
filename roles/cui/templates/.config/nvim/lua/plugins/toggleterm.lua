-- Local module to avoid global namespace pollution
local M = {}
local lazygit_terminal
local lazydocker_terminal

function M.lazygit_toggle()
  if not lazygit_terminal then
    local Terminal = require("toggleterm.terminal").Terminal
    lazygit_terminal = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true
    })
  end
  lazygit_terminal:toggle()
end

function M.lazydocker_toggle()
  if not lazydocker_terminal then
    local Terminal = require("toggleterm.terminal").Terminal
    lazydocker_terminal = Terminal:new({
      cmd = "lazydocker",
      direction = "float",
      hidden = true
    })
  end
  lazydocker_terminal:toggle()
end

return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>gz", function() M.lazygit_toggle() end, desc = "Lazygit", mode = "n" },
    { "<leader>dz", function() M.lazydocker_toggle() end, desc = "Lazydocker", mode = "n" },
    { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Terminal", mode = "n" },
  },
  config = function()
    require("toggleterm").setup()
  end
}
