return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = {
    -- See Configuration section for options
  },
  config = function()
    require('CopilotChat').setup()

    function ShowCopilotChatActionPrompt()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end

    vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua ShowCopilotChatActionPrompt()<cr>", { noremap = true, silent = true })

  end,
}
