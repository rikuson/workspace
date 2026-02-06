return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
    },
  },
  keys = {
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    { "<c-s>j", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
        label = { after = { 0, 0 } },
        pattern = [[^\s*\zs\S]],
      })
    end, desc = "Flash Line Down" },
    { "<c-s>k", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
        label = { after = { 0, 0 } },
        pattern = [[^\s*\zs\S]],
      })
    end, desc = "Flash Line Up" },
    { "<c-s>w", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
        pattern = [[\<\w]],
      })
    end, desc = "Flash Word Forward" },
    { "<c-s>W", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
        pattern = [[\S\+]],
      })
    end, desc = "Flash WORD Forward" },
    { "<c-s>b", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
        pattern = [[\<\w]],
      })
    end, desc = "Flash Word Backward" },
    { "<c-s>B", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
        pattern = [[\S\+]],
      })
    end, desc = "Flash WORD Backward" },
  },
}
