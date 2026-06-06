-- Shared transparency helper for the plugin-based colorschemes
-- (kanagawa / catppuccin / rose-pine).
--
-- Each of those plugins has its own `transparent` flag, but they all only clear
-- a handful of base groups — floats, statusline, gutter, pmenu, signs, etc. stay
-- solid. This module holds the ONE list of leftover groups and clears just their
-- backgrounds (foregrounds are kept: every plugin merges overrides per-group, so
-- `{ bg = "none" }` only touches the background). No colors are invented here —
-- the look stays 100% the plugin's own.
--
-- Usage from a plugin spec's config:
--   local t = require("util.transparent")
--   require("<plugin>").setup({ <native transparent flag>, <override opt> = t.overrides })
--   require("config.theme_registry").register("<colors_name>", {
--     reapply = t.reapply, lualine = t.lualine("<bundled lualine theme>"),
--   })

local M = {}

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
  for _, g in ipairs(M.editor) do
    o[g] = { bg = "none" }
  end
  return o
end

-- reapply for theme_registry: clear bg on snacks/noice surfaces, keep their fg.
function M.reapply()
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
