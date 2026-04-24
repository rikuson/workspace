return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo", "ToggleAutoFormat" },
  config = function()
    vim.g.disable_autoformat = false

    vim.api.nvim_create_user_command("ToggleAutoFormat", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      print("Format on save: " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
    end, {})

    require("conform").setup({
      formatters_by_ft = {
        javascript = { "oxfmt", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        ruby = { "rubocop" },
      },
      format_on_save = function()
        if vim.g.disable_autoformat then
          return
        end
        return { timeout_ms = 3000, lsp_format = "fallback" }
      end,
    })
  end,
}
