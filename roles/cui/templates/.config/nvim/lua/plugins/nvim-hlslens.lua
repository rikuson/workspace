return {
  "kevinhwang91/nvim-hlslens",
  keys = {
    { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Next search result", mode = "n", noremap = true, silent = true },
    { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Previous search result", mode = "n", noremap = true, silent = true },
    { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor", mode = "n", noremap = true, silent = true },
    { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor (backward)", mode = "n", noremap = true, silent = true },
    { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor (partial)", mode = "n", noremap = true, silent = true },
    { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor (partial, backward)", mode = "n", noremap = true, silent = true },
  },
  config = function()
    require('hlslens').setup()
  end
}
