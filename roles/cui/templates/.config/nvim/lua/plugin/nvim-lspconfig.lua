require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- Disable syntax highlighting
  client.server_capabilities.semanticTokensProvider = nil

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

-- Rust
nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach,
}

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
}
