return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Git Files' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Git Status' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Grep' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
  },
  config = function()
    local actions = require "telescope.actions"
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
          mappings = {
            i = {
              ["<C-t>"] = actions.select_tab,
            }
          }
        }
      }
    }
  end
}
