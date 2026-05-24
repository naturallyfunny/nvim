-- Central registry so the rest of the config never hardcodes colors.
-- Each colorscheme (colors/*.lua) registers its own spec:
--   reapply  : function that re-sets the highlight groups noice/snacks clobber
--              after ColorScheme events (called from lua/config/autocmds.lua).
--   lualine  : statusline palette consumed by lua/plugins/theme.lua.
-- autocmds.lua and theme.lua read whichever scheme is active via current().
local M = { schemes = {} }

function M.register(name, spec)
  M.schemes[name] = spec
end

function M.current()
  return M.schemes[vim.g.colors_name]
end

return M
