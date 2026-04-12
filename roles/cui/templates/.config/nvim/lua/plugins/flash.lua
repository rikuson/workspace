return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    labels = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;,.[]",
    label = {
      before = { 0, 0 },
      after = false,
    },
    modes = {
      search = {
        enabled = false,
      },
    },
    highlight = {
      groups = {
        label = "FlashLabel",
      },
    },
    highlight = {
      groups = {
        label = "FlashLabel",
      },
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ff0000", bg = "NONE", bold = true })
  end,
  keys = {
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    { "<c-s>j", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
        label = { before = { 0, 0 }, after = false },
        pattern = [[^\s*\zs\S]],
      })
    end, desc = "Flash Line Down" },
    { "<c-s>k", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
        label = { before = { 0, 0 }, after = false },
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
        pattern = [[\(\s\|^\)\zs\S]],
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
        pattern = [[\(\s\|^\)\zs\S]],
      })
    end, desc = "Flash WORD Backward" },
    { "<c-s>e", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
        pattern = [[\w\ze\(\W\|$\)\|\S\ze\(\s\|$\)]],
      })
    end, desc = "Flash Word End Forward" },
    { "<c-s>E", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
        pattern = [[\S\ze\(\s\|$\)]],
      })
    end, desc = "Flash WORD End Forward" },
    { "<c-s>ge", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
        pattern = [[\w\ze\(\W\|$\)\|\S\ze\(\s\|$\)]],
      })
    end, desc = "Flash Word End Backward" },
    { "<c-s>gE", mode = "n", function()
      require("flash").jump({
        search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
        pattern = [[\S\ze\(\s\|$\)]],
      })
    end, desc = "Flash WORD End Backward" },
  },
}
