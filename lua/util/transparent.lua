-- Shared transparency helper for every colorscheme — the plugin-based ones
-- (kanagawa / catppuccin / rose-pine) AND the hand-built ones (mono / earth).
--
-- Transparency is a single toggle (`vim.g.transparent`, ON by default) that all
-- schemes read, so the see-through look isn't baked into any one colorscheme:
-- flip it off and every scheme renders solid backgrounds instead.
--
--   * Plugin schemes pass their native flag = enabled() and overrides()/reapply()
--     as their override option — these no-op when transparency is off, leaving
--     the plugin's own solid background.
--   * Hand-built schemes define solid backgrounds and use bg() in place of a
--     literal "NONE" so each surface follows the toggle.
--
-- Foregrounds are never touched here; only backgrounds switch between the
-- scheme's solid color and "none".
--
-- Usage from a plugin spec's config:
--   local t = require("util.transparent")
--   require("<plugin>").setup({ <native flag> = t.enabled(), <override opt> = t.overrides })
--   require("config.theme_registry").register("<colors_name>", {
--     reapply = t.reapply, lualine = t.lualine("<bundled lualine theme>"),
--   })

local M = {}

-- The one switch. Transparent by default; set `vim.g.transparent = false` in
-- your config for solid backgrounds across all schemes.
function M.enabled()
  return vim.g.transparent ~= false
end

-- Background value for a surface: "none" when transparent, else the scheme's own
-- solid `bg`. Hand-built schemes use this wherever they'd otherwise write "NONE".
function M.bg(solid)
  return M.enabled() and "none" or solid
end

-- Flip transparency at runtime and re-apply the active scheme. Hand-built schemes
-- (colors/*.lua) recompute their surfaces when re-sourced; plugin schemes read
-- their flag only at setup(), so each registers a `reload` in the theme_registry
-- that re-runs setup with the new value.
function M.set(on)
  vim.g.transparent = on and true or false
  local name = vim.g.colors_name
  if not name then
    return
  end
  local spec = require("config.theme_registry").schemes[name]
  if spec and spec.reload then
    spec.reload()
  else
    vim.cmd.colorscheme(name)
  end
end

function M.toggle()
  M.set(not M.enabled())
end

-- Backgrounds the plugins' own `transparent` flag leaves solid. Cleared once at
-- colorscheme load via each plugin's override option.
M.editor = {
  "NormalFloat", "FloatBorder", "FloatTitle",
  "StatusLine", "StatusLineNC", "WinBar", "WinBarNC",
  "TabLine", "TabLineFill", "TabLineSel", -- bufferline draws on the tabline base
  "SignColumn", "Folded",
  "LineNr", "LineNrAbove", "LineNrBelow", "CursorLine", "CursorLineNr",
  "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
  "PmenuKind", "PmenuKindSel", "PmenuExtra", "PmenuExtraSel",
  "GitSignsAdd", "GitSignsChange", "GitSignsDelete",
  "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignHint", "DiagnosticSignInfo",
}

-- snacks/noice re-apply their own (solid) backgrounds on every ColorScheme
-- event, so these have to be cleared again afterwards (via theme_registry.reapply).
M.plugins = {
  "SnacksNormal", "SnacksNormalNC", "SnacksLayoutNormal", "SnacksDashboardNormal",
  "SnacksPickerNormal", "SnacksPickerList", "SnacksPickerPreview", "SnacksInputNormal",
  "SnacksPickerBorder", "SnacksPickerInputBorder", "SnacksInputBorder", "SnacksWinSeparator",
  "NoiceCmdline", "NoiceCmdlinePopup", "NoiceConfirm", "NoicePopupmenu", "NoiceMini",
  "NoiceCmdlinePopupBorder", "NoiceConfirmBorder", "NoicePopupmenuBorder", "NoiceNotificationBorder",
}

-- Override table (bg = none per group) for a plugin's override option.
-- It's a function so it can be passed straight to plugins that expect one
-- (kanagawa `overrides`, catppuccin `custom_highlights`); call it for plugins
-- that want a table (rose-pine `highlight_groups`).
function M.overrides()
  local o = {}
  if M.enabled() then
    for _, g in ipairs(M.editor) do
      o[g] = { bg = "none" }
    end
  end
  return o
end

-- reapply for theme_registry: clear bg on snacks/noice surfaces, keep their fg.
-- No-op when transparency is off, so the plugin's own solid surfaces survive.
function M.reapply()
  if not M.enabled() then
    return
  end
  for _, g in ipairs(M.plugins) do
    local h = vim.api.nvim_get_hl(0, { name = g, link = false })
    h.bg, h.ctermbg = nil, nil
    vim.api.nvim_set_hl(0, g, h)
  end
end

-- lualine spec for theme_registry. We return the bundled lualine theme by NAME
-- (a string, e.g. "kanagawa", "catppuccin-mocha", "rose-pine"); lualine resolves
-- it at its own setup — after the colorscheme has loaded — which avoids the
-- require-loop you hit if you pull the theme table during the plugin's config.
-- No palette fields, so the statusline stays exactly the plugin's own (the
-- per-component recoloring in theme.lua only applies to the hand-built schemes).
function M.lualine(name)
  return { theme = name }
end

return M
