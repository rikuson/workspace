return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    init = function()
      vim.g.loaded_nvim_treesitter = 1
    end,
  },
  {
    "lewis6991/ts-install.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("ts-install").setup({
        ensure_install = { "c", "lua", "vim", "vimdoc", "query" },
        auto_install = true,
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
