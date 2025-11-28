return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>gz", "<cmd>lua _lazygit_toggle()<CR>", desc = "Lazygit", mode = "n" },
    { "<leader>dz", "<cmd>lua _lazydocker_toggle()<CR>", desc = "Lazydocker", mode = "n" },
    { "<leader>t", "<cmd>lua _floatterm_toggle()<CR>", desc = "Terminal", mode = "n" },
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

    local floatterm = Terminal:new({
      direction = "float",
      hidden = true,
      float_opts = {
        width = 100,
        height = 30,
      }
    })
    function _floatterm_toggle()
      floatterm:toggle()
    end
  end
}
