-- Configuration constants for Neovim setup
-- Centralized place for all magic numbers and tunable values

return {
  -- Timing values (milliseconds)
  timers = {
    easymotion_poll_interval = 500,      -- How often to check easymotion state
    highlight_yank_duration = 500,        -- How long to highlight yanked text
  },

  -- Performance tuning
  performance = {
    treesitter_max_filesize = 100 * 1024, -- 100KB - disable TS for larger files
  },

  -- Plugin priorities
  priorities = {
    tiny_inline_diagnostic = 1000,        -- Must load before other diagnostics
  },

  -- LSP Configuration
  lsp = {
    ensure_installed_servers = { "rust_analyzer", "ts_ls" },
    enable_semantic_tokens = false,       -- Disabled to prevent double highlighting
  },
}
