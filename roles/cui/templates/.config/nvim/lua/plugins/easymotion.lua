return {
  "easymotion/vim-easymotion",
  keys = {
    { "<C-s>f", "<Plug>(easymotion-f)", desc = "EasyMotion Find Forward", mode = "n" },
    { "<C-s>F", "<Plug>(easymotion-F)", desc = "EasyMotion Find Backward", mode = "n" },
    { "<C-s>t", "<Plug>(easymotion-t)", desc = "EasyMotion Till Forward", mode = "n" },
    { "<C-s>T", "<Plug>(easymotion-T)", desc = "EasyMotion Till Backward", mode = "n" },
    { "<C-s>w", "<Plug>(easymotion-w)", desc = "EasyMotion Word Forward", mode = "n" },
    { "<C-s>W", "<Plug>(easymotion-W)", desc = "EasyMotion Word Forward", mode = "n" },
    { "<C-s>b", "<Plug>(easymotion-b)", desc = "EasyMotion Word Backward", mode = "n" },
    { "<C-s>B", "<Plug>(easymotion-B)", desc = "EasyMotion Word Backward", mode = "n" },
    { "<C-s>e", "<Plug>(easymotion-e)", desc = "EasyMotion End of Word Forward", mode = "n" },
    { "<C-s>E", "<Plug>(easymotion-E)", desc = "EasyMotion End of Word Forward", mode = "n" },
    { "<C-s>ge", "<Plug>(easymotion-ge)", desc = "EasyMotion End of Word Backward", mode = "n" },
    { "<C-s>gE", "<Plug>(easymotion-gE)", desc = "EasyMotion End of Word Backward", mode = "n" },
    { "<C-s>j", "<Plug>(easymotion-j)", desc = "EasyMotion Line Down", mode = "n" },
    { "<C-s>k", "<Plug>(easymotion-k)", desc = "EasyMotion Line Up", mode = "n" },
    { "<C-s>n", "<Plug>(easymotion-n)", desc = "EasyMotion Search Next", mode = "n" },
    { "<C-s>N", "<Plug>(easymotion-N)", desc = "EasyMotion Search Previous", mode = "n" },
    { "<C-s>s", "<Plug>(easymotion-s)", desc = "EasyMotion Search Char", mode = "n" },
  },
  init = function()
    vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings
  end,
  config = function()
    local constants = require("config.constants")
    local easymotion_timer = nil

    local function stop_easymotion_poll()
      if easymotion_timer then
        easymotion_timer:stop()
        easymotion_timer:close()
        easymotion_timer = nil
      end
    end

    local function start_easymotion_poll()
      -- Only start one poll at a time
      stop_easymotion_poll()

      easymotion_timer = vim.uv.new_timer()
      easymotion_timer:start(
        constants.timers.easymotion_poll_interval,
        constants.timers.easymotion_poll_interval,
        vim.schedule_wrap(function()
          if vim.fn["EasyMotion#is_active"]() == 0 then
            vim.diagnostic.enable()
            stop_easymotion_poll()
          end
        end)
      )
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = {"EasyMotionPromptBegin"},
      callback = function()
        vim.diagnostic.disable()
      end
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "EasyMotionPromptEnd",
      callback = function()
        start_easymotion_poll()
      end
    })

    -- Cleanup on VimLeave
    vim.api.nvim_create_autocmd("VimLeave", {
      callback = function()
        stop_easymotion_poll()
      end
    })
  end
}
