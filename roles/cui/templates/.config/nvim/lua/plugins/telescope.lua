return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
    { '<leader>fg', function() require('telescope.builtin').git_files() end, desc = 'Git Files' },
    { '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = 'Recent' },
    { '<leader>gs', function() require('telescope.builtin').git_status() end, desc = 'Git Status' },
    { '<leader>sg', function() require('telescope.builtin').live_grep() end, desc = 'Grep' },
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
