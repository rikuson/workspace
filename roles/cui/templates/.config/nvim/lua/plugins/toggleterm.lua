return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>gz", "<cmd>lua _lazygit_toggle()<CR>", desc = "Lazygit", mode = "n" },
    { "<leader>dz", "<cmd>lua _lazydocker_toggle()<CR>", desc = "Lazydocker", mode = "n" },
    { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Terminal", mode = "n" },
  },
  config = function()
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
  end
}
