return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup()

    -- Register key groups
    wk.add({
      { "<leader>f", group = "File" },
      { "<leader>g", group = "Git" },
      { "<leader>d", group = "Docker" },
      { "<leader>s", group = "Search" },
    })
  end,
}
