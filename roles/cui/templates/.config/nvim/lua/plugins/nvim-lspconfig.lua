return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local utils = require("config.utils")
    local constants = require("config.constants")

    local mason_lspconfig = utils.safe_require("mason-lspconfig")
    if not mason_lspconfig then return end

    local lspconfig = utils.safe_require("lspconfig")
    if not lspconfig then return end

    local on_attach = function(client, bufnr)
      -- Disable semantic tokens to prevent double highlighting
      if not constants.lsp.enable_semantic_tokens then
        client.server_capabilities.semanticTokensProvider = nil
      end

      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    end

    -- Set up mason-lspconfig with handlers
    utils.safe_execute(function()
      mason_lspconfig.setup({
        ensure_installed = constants.lsp.ensure_installed_servers,
        automatic_installation = true,
        handlers = {
          -- Default handler - will be called for each installed server
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
            })
          end,
        },
      })
    end, "mason-lspconfig.setup")
  end
}
