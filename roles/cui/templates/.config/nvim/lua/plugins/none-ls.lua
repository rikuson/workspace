return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    -- Ensure Mason is set up first
    require("mason").setup()

    -- Set up mason-null-ls BEFORE null-ls
    require('mason-null-ls').setup({
      ensure_installed = { "eslint_d" },
      automatic_installation = true,
    })

    local null_ls = require('null-ls')

    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      })
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- Default: formatting enabled
    vim.g.disable_autoformat = false

    -- Toggle command
    vim.api.nvim_create_user_command('ToggleAutoFormat', function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      print('Format on save: ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
    end, {})

    -- Fix on save
    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            if not vim.g.disable_autoformat then
              lsp_formatting(bufnr)
            end
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
      table.insert(sources, require("none-ls.diagnostics.eslint_d"))
    end

    null_ls.setup({
      sources = sources,
      on_attach = on_attach,
    })
  end
}
