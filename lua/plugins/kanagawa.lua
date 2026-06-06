-- kanagawa.nvim (wave) with only our adjustments on top, so `:colorscheme
-- kanagawa` gives the transparent/no-italic look directly — no separate scheme.
--
-- We keep ALL of the plugin's own colors. The only differences from upstream:
--   1. no italics (commentStyle/keywordStyle)
--   2. transparency for the groups the plugin's `transparent` flag misses
--      (it really only clears Normal — floats, statusline, gutter, pmenu, etc.
--      stay solid), restored to `bg = none` (fg is preserved: kanagawa merges
--      overrides per-group with `tbl_extend`).
-- Every foreground/color is the plugin's own — we never recolor anything.
return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = false,
  priority = 1000,
  config = function()
    local p = require("kanagawa.colors").setup({ theme = "wave" }).palette
    local gray = p.fujiGray

    require("kanagawa").setup({
      theme = "wave",
      transparent = true,
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      overrides = function()
        local o = {}
        -- strip the backgrounds `transparent = true` leaves solid (fg kept)
        for _, g in ipairs({
          "NormalFloat", "FloatBorder", "FloatTitle",
          "StatusLine", "StatusLineNC", "WinBar", "WinBarNC",
          "SignColumn", "Folded",
          "LineNr", "LineNrAbove", "LineNrBelow", "CursorLine", "CursorLineNr",
          "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
          "PmenuKind", "PmenuKindSel", "PmenuExtra", "PmenuExtraSel",
          "GitSignsAdd", "GitSignsChange", "GitSignsDelete",
          "DiagnosticSignError", "DiagnosticSignWarn",
          "DiagnosticSignHint", "DiagnosticSignInfo",
        }) do
          o[g] = { bg = "none" }
        end
        return o
      end,
    })

    -- snacks/noice re-apply solid backgrounds on every ColorScheme event,
    -- clobbering the transparency above. reapply() (called from
    -- lua/config/autocmds.lua) just clears those backgrounds again — the
    -- foreground colors are left exactly as the plugins set them.
    local function reapply()
      local function strip(g) -- clear bg, keep whatever fg the plugin set
        local h = vim.api.nvim_get_hl(0, { name = g, link = false })
        h.bg, h.ctermbg = nil, nil
        vim.api.nvim_set_hl(0, g, h)
      end
      for _, g in ipairs({
        "SnacksNormal", "SnacksNormalNC", "SnacksLayoutNormal", "SnacksDashboardNormal",
        "SnacksPickerNormal", "SnacksPickerList", "SnacksPickerPreview", "SnacksInputNormal",
        "SnacksPickerBorder", "SnacksPickerInputBorder", "SnacksInputBorder", "SnacksWinSeparator",
        "NoiceCmdline", "NoiceCmdlinePopup", "NoiceConfirm", "NoicePopupmenu", "NoiceMini",
        "NoiceCmdlinePopupBorder", "NoiceConfirmBorder", "NoicePopupmenuBorder", "NoiceNotificationBorder",
      }) do
        strip(g)
      end
    end

    -- Statusline palette (lualine isn't part of the colorscheme, so we feed it
    -- from the wave palette via theme_registry — same mechanism as our schemes).
    local c_bg, b_bg = p.sumiInk1, p.sumiInk3
    local function mode(bg)
      return {
        a = { bg = bg, fg = p.sumiInk0, gui = "bold" },
        b = { bg = b_bg, fg = bg },
        c = { bg = c_bg, fg = p.fujiWhite },
      }
    end

    require("config.theme_registry").register("kanagawa", {
      reapply = reapply,
      lualine = {
        theme = {
          normal   = mode(p.crystalBlue),
          insert   = mode(p.springGreen),
          visual   = mode(p.oniViolet),
          replace  = mode(p.surimiOrange),
          command  = mode(p.boatYellow2),
          inactive = {
            a = { bg = c_bg, fg = gray, gui = "bold" },
            b = { bg = c_bg, fg = gray },
            c = { bg = c_bg, fg = gray },
          },
        },
        c_bg         = c_bg,
        filename     = p.fujiWhite,
        directory    = gray,
        lazy_updates = p.boatYellow2,
        diff = { added = p.autumnGreen, modified = p.autumnYellow, removed = p.autumnRed },
      },
    })
  end,
}
