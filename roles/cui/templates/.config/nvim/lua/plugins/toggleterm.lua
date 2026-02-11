return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>gz", "<cmd>lua _lazygit_toggle()<CR>", desc = "Lazygit", mode = "n" },
    { "<leader>dz", "<cmd>lua _lazydocker_toggle()<CR>", desc = "Lazydocker", mode = "n" },
    { "<leader>t", "<cmd>lua _floatterm_toggle()<CR>", desc = "Terminal", mode = "n" },
    { "<leader>cc", "<cmd>lua _claude_code_toggle()<CR>", desc = "Claude Code", mode = "n" },
    { "<leader>cC", "<cmd>lua _claude_code_yolo_toggle()<CR>", desc = "Claude Code (skip permissions)", mode = "n" },
  },
  config = function()
    require("toggleterm").setup()

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = function()
        vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { buffer = 0, noremap = true, silent = true })
      end,
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      on_open = function(term)
        vim.keymap.del("t", "<C-[>", { buffer = term.bufnr })
      end,
    })
    function _lazygit_toggle()
      lazygit:toggle()
    end

    local lazydocker = Terminal:new({
      cmd = "lazydocker",
      direction = "float",
      hidden = true,
      on_open = function(term)
        vim.keymap.del("t", "<C-[>", { buffer = term.bufnr })
      end,
    })
    function _lazydocker_toggle()
      lazydocker:toggle()
    end

    local floatterm = Terminal:new({
      direction = "float",
      hidden = true,
    })
    function _floatterm_toggle()
      floatterm:toggle()
    end

    local claude_code = Terminal:new({
      cmd = "claude",
      direction = "vertical",
      hidden = true,
      count = 10,
      on_open = function(term)
        vim.cmd("vertical resize 60")
      end,
    })
    function _claude_code_toggle()
      claude_code:toggle()
    end

    local claude_code_yolo = Terminal:new({
      cmd = "claude --dangerously-skip-permissions",
      direction = "vertical",
      hidden = true,
      count = 11,
      on_open = function(term)
        vim.cmd("vertical resize 60")
      end,
    })
    function _claude_code_yolo_toggle()
      claude_code_yolo:toggle()
    end
  end
}
