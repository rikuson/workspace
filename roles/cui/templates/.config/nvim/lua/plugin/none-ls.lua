require('mason-null-ls').setup({
    ensure_installed = { 'eslint', 'prettier', 'prettier-eslint', 'rubocop' },
    handlers = {},
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.rubocop,
  },
})
