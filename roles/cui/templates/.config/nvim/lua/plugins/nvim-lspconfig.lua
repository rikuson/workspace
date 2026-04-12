return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Ensure Mason is set up first (if not already done by another plugin)
    require("mason").setup()

    -- Use LspAttach autocommand to reliably set keymaps when any LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
          -- Disable syntax highlighting
          client.server_capabilities.semanticTokensProvider = nil
        end

        local bufopts = { noremap=true, silent=true, buffer=ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      end,
    })

    -- Filter ts_ls diagnostics that overlap with eslint
    local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, ...)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client and client.name == "ts_ls" and result and result.diagnostics then
        result.diagnostics = vim.tbl_filter(function(d)
          return not vim.tbl_contains({ 6133, 6196 }, d.code)
        end, result.diagnostics)
      end
      return original_handler(err, result, ctx, ...)
    end

    -- Set up mason-lspconfig with handlers
    require("mason-lspconfig").setup({
      ensure_installed = { "rust_analyzer", "ts_ls", "eslint" },
      automatic_installation = true,
      handlers = {
        -- Default handler - will be called for each installed server
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        -- Disable vtsls (duplicates ts_ls diagnostics)
        ["vtsls"] = function() end,
      },
    })
  end
}
