-- Consolidated Mason setup
-- This plugin is loaded as a dependency by nvim-lspconfig and none-ls
return {
  "williamboman/mason.nvim",
  config = function()
    local utils = require("config.utils")
    local mason = utils.safe_require("mason")
    if not mason then return end

    utils.safe_execute(function()
      mason.setup()
    end, "mason.setup")
  end,
}
