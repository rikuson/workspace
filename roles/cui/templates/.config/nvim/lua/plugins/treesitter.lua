return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()
    vim.treesitter.language.register("bash", "zsh")
  end,
}
