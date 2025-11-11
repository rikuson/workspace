-- Utility functions for Neovim configuration

local M = {}

-- Safely require a module with error notification
function M.safe_require(module_name)
  local status, module = pcall(require, module_name)
  if not status then
    vim.notify(
      "Failed to load module: " .. module_name .. "\n" .. tostring(module),
      vim.log.levels.ERROR
    )
    return nil
  end
  return module
end

-- Safely execute a function with error handling
function M.safe_execute(fn, context)
  local ok, err = pcall(fn)
  if not ok then
    local ctx_msg = context and (" [" .. context .. "]") or ""
    vim.notify(
      "Configuration error" .. ctx_msg .. ": " .. tostring(err),
      vim.log.levels.ERROR
    )
    return false
  end
  return true
end

return M
