return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      multi_window = true,
      forward = true,
      wrap = true,
      mode = "exact",
    },
    jump = {
      jumplist = true,
      pos = "start",
      history = false,
      register = false,
      nohlsearch = false,
      autojump = false,
    },
    label = {
      uppercase = true,
      rainbow = {
        enabled = false,
        shade = 5,
      },
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = true,
        jump_labels = true,
        multi_line = true,
        highlight = { backdrop = true },
      },
    },
  },
  keys = {
    -- Main search (replaces easymotion-s)
    { "<C-s>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },

    -- Character motions (f, F, t, T)
    { "<C-s>f", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        search = { mode = "search", max_length = 1, forward = true },
        label = { after = { 0, 0 } },
        pattern = ".",
      })
    end, desc = "Flash Find Forward" },
    { "<C-s>F", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        search = { mode = "search", max_length = 1, forward = false },
        label = { after = { 0, 0 } },
        pattern = ".",
      })
    end, desc = "Flash Find Backward" },
    { "<C-s>t", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        search = { mode = "search", max_length = 1, forward = true },
        label = { before = true, after = false },
        pattern = ".",
      })
    end, desc = "Flash Till Forward" },
    { "<C-s>T", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        search = { mode = "search", max_length = 1, forward = false },
        label = { before = true, after = false },
        pattern = ".",
      })
    end, desc = "Flash Till Backward" },

    -- Word motions (w, b, e)
    { "<C-s>w", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        pattern = "\\<\\w",
        search = { forward = true, wrap = true },
      })
    end, desc = "Flash Word Forward" },
    { "<C-s>W", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        pattern = "\\S\\+",
        search = { forward = true, wrap = true },
      })
    end, desc = "Flash WORD Forward" },
    { "<C-s>b", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        pattern = "\\<\\w",
        search = { forward = false, wrap = true },
      })
    end, desc = "Flash Word Backward" },
    { "<C-s>B", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        pattern = "\\S\\+",
        search = { forward = false, wrap = true },
      })
    end, desc = "Flash WORD Backward" },
    { "<C-s>e", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        pattern = "\\w\\>",
        search = { forward = true, wrap = true },
      })
    end, desc = "Flash End of Word Forward" },
    { "<C-s>E", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        pattern = "\\S\\+\\>",
        search = { forward = true, wrap = true },
      })
    end, desc = "Flash End of WORD Forward" },

    -- Line motions (j, k)
    { "<C-s>j", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        search = { mode = "search", max_length = 0 },
        label = { after = { 0, 0 } },
        pattern = "^",
      })
    end, desc = "Flash Line Down" },
    { "<C-s>k", mode = { "n", "x", "o" }, function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false },
        label = { after = { 0, 0 } },
        pattern = "^",
      })
    end, desc = "Flash Line Up" },

    -- Treesitter (bonus feature not in easymotion)
    { "<C-s>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },

    -- Remote (bonus feature for operations)
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },

    -- Treesitter search (bonus feature)
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
  config = function(_, opts)
    require("flash").setup(opts)

    -- Disable diagnostics during flash
    local flash_active = false
    vim.api.nvim_create_autocmd("User", {
      pattern = "FlashEnter",
      callback = function()
        if not flash_active then
          flash_active = true
          vim.diagnostic.disable()
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "FlashLeave",
      callback = function()
        if flash_active then
          flash_active = false
          vim.diagnostic.enable()
        end
      end,
    })
  end,
}
