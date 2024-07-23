require('CopilotChat').setup()

function ShowCopilotChatActionPrompt()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua ShowCopilotChatActionPrompt()<cr>", { noremap = true, silent = true })
