return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local utils = require("config.utils")

    -- Set up mason-null-ls (Mason is already initialized by mason.lua)
    local mason_null_ls = utils.safe_require("mason-null-ls")
    if not mason_null_ls then return end

    local null_ls = utils.safe_require("null-ls")
    if not null_ls then return end

    utils.safe_execute(function()
      mason_null_ls.setup({
        ensure_installed = { "eslint_d" },
        automatic_installation = true,
      })
    end, "mason-null-ls.setup")

    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      })
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- Fix on save
    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end
    end

    -- Build sources list, only including eslint_d if available
    local sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.rubocop,
      null_ls.builtins.formatting.rubocop,
    }

    -- Add eslint_d only if command exists
    if vim.fn.executable("eslint_d") == 1 then
      local eslint_d = utils.safe_require("none-ls.diagnostics.eslint_d")
      if eslint_d then
        table.insert(sources, eslint_d)
      end
    end

    utils.safe_execute(function()
      null_ls.setup({
        sources = sources,
        on_attach = on_attach,
      })
    end, "null-ls.setup")
  end
}
