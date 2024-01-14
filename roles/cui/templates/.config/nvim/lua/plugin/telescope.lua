require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-s>"] = "select_horizontal"
      }
    }
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    }
  }
}
vim.keymap.set('n', '<leader>f', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<Leader>s', '<cmd>Telescope git_status<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>z', '<cmd>LazyGit<cr>')
vim.keymap.set('n', '<leader>.', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>')

require("telescope").load_extension "file_browser"
