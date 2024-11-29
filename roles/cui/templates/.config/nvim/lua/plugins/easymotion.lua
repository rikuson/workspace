return {
  "easymotion/vim-easymotion",
  config = function()
    vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>(easymotion-prefix)", {})
    vim.api.nvim_create_autocmd("User", {pattern = {"EasyMotionPromptBegin"}, callback = function() vim.diagnostic.disable() end})
    function check_easymotion()
      local timer = vim.loop.new_timer()
      timer:start(500, 0, vim.schedule_wrap(function()
        -- vim.notify("check_easymotion")
        if vim.fn["EasyMotion#is_active"]() == 0 then
          vim.diagnostic.enable()
          vim.g.waiting_for_easy_motion = false
        else
          check_easymotion()
        end
      end))
    end
    vim.api.nvim_create_autocmd("User", {
      pattern = "EasyMotionPromptEnd",
      callback = function()
        if vim.g.waiting_for_easy_motion then return end
        vim.g.waiting_for_easy_motion = true
        check_easymotion()
      end
    })
  end
}
