return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Ensure Mason is set up first (if not already done by another plugin)
    require("mason").setup()

    local on_attach = function(client, bufnr)
      -- Disable syntax highlighting
      client.server_capabilities.semanticTokensProvider = nil

      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    end

    -- Set up mason-lspconfig with handlers
    require("mason-lspconfig").setup({
      ensure_installed = { "rust_analyzer", "ts_ls" },
      automatic_installation = true,
      handlers = {
        -- Default handler - will be called for each installed server
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
          })
        end,
      },
    })
  end
}
