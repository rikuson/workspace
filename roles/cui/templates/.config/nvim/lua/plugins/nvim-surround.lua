return {
  "kylechui/nvim-surround",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<Nop>",
        insert_line = "<Nop>",
        normal = "s",
        normal_cur = "ss",
        normal_line = "<Nop>",
        normal_cur_line = "<Nop>",
        visual = "s",
        visual_line = "<Nop>",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      }
    })
  end
}
