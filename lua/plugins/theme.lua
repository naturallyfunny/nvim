local function set_highlights(hl, groups, opts)
  for _, group in ipairs(groups) do
    hl[group] = opts
  end
end

local c = {
  base = "#010101",
  black = "#010101",
  text = "#d4d6c6",
  white = "#E0E0E0",

  -- COLOR CONFIG:
  pink_bright = "#f30974",
  pink_dark = "#ab0652",

  -- [BARU] PINK SAGE / DUSTY PINK
  -- Kode ini jauh lebih desaturated (keabu-abuan) dan soft.
  -- Tidak lagi neon ("menyala").
  pink_sage = "#523646",

  green_lime = "#bae67e",
  yellow_gold = "#ffd602",
  blue = "#1ea8fc",
  purple = "#d699ff",
  cyan = "#80e5ff",
  pale = "#cebbfa",
  grey = "#505050",
  cursor = "#FF0000",
  silver = "#C0C0C0",
  cyan_blue = "#2cc3df",

  package_color = "#FFFFFF",
  string_color = "#7aa2f7",
  darker_silver = "#B0B0B0",
}

local function setup_syntax_highlights(hl)
  set_highlights(hl, {
    "Keyword", "Statement", "Conditional", "Repeat", "Include",
    "Structure", "Define", "PreProc", "Exception",
    "@keyword", "@keyword.function", "@keyword.import", "@include",
  }, { fg = c.grey, italic = false })

  set_highlights(hl, {
    "Function", "@function", "@function.call", "@method", "@constructor",
    "Title",
    "@lsp.typemod.namespace.declaration",
  }, { fg = "#FFFFFF", bold = false })

  set_highlights(hl, { "@module", "@namespace", "@lsp.type.namespace" }, { fg = c.package_color })

  set_highlights(hl, {
    "Type", "@type.builtin", "@lsp.type.builtinType",
    "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
  }, { fg = c.darker_silver, italic = true })

  set_highlights(hl, {
    "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
    "@lsp.type.enum", "@lsp.type.type", "Structure",
  }, { fg = c.white })

  set_highlights(hl, {
    "Identifier", "@variable", "@variable.parameter",
    "@field", "@property", "@variable.member",
    "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter",
  }, { fg = c.white })

  set_highlights(hl, { "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.white })
  set_highlights(hl, { "@punctuation.bracket" }, { fg = c.white })
  set_highlights(hl, { "String", "Character" }, { fg = c.string_color })
  set_highlights(hl, { "Constant", "@constant.builtin", "@variable.builtin" }, { fg = c.darker_silver })
end

local function setup_ui_highlights(hl, colors)
  set_highlights(hl, {
    "Normal", "NormalNC", "Terminal", "TermNormal",
    "NeoTreeNormal", "NeoTreeNormalNC", "SideBar", "SideBarNC",
    "SnacksNormal", "SnacksNormalNC",
    "SnacksPickerNormal", "SnacksPickerNormalNC",
    "SnacksPickerList", "SnacksPickerPreview", "SnacksLayoutNormal",
    "SnacksDashboardNormal", "SnacksTerminal", "SnacksTerminalNormal",
    "SnacksExplorer", "SnacksExplorerNormal",
    "NvimTreeNormal", "NvimTreeNormalNC", "NetrwNormal", "NetrwNormalNC",
    "NormalSB", "SignColumnSB",
    "StatusLine", "StatusLineNC", "MsgArea",
    "WhichKeyNormal", "WhichKeyFloat",
  }, { bg = "NONE" })
  set_highlights(hl, {
    "TelescopeNormal", "TelescopeBorder",
  }, { bg = "NONE" })

  set_highlights(hl, {
    "Floaterm", "NormalFloat",
    "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
  }, { bg = "NONE" })

  set_highlights(hl, {
    "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator",
  }, { fg = "NONE", bg = "NONE" })

  hl.FloatermBorder = { bg = "NONE", fg = colors.border }
  hl.TelescopeBorder = { fg = c.black }
  hl.NeoTreeFloatBorder = { fg = c.black, bg = "NONE" }
  hl.FloatBorder = { fg = c.black, bg = "NONE" }
  -- Noice.nvim floating command line styling
  hl.NoiceCmdlinePopupBorder = { fg = c.black, bg = "NONE" }
  hl.NoiceCmdlinePopupTitle = { fg = c.white, bg = "NONE" }
  hl.NoiceCmdlineIcon = { fg = c.white, bg = "NONE" }
  hl.NoiceCmdlinePopup = { bg = "NONE" }
  hl.LineNr = { fg = c.grey }
  hl.CursorLineNr = { fg = c.white, bold = true }
  hl.Cursor = { bg = c.cursor, fg = c.black }
  hl.Comment = { fg = "#3a4261" }
  hl.MatchParen = { fg = c.cyan_blue }
end

local function setup_dashboard_highlights(hl)
  set_highlights(hl, {
    "DashboardHeader", "DashboardCenter", "DashboardFooter",
    "DashboardShortCut", "DashboardIcon", "DashboardKey", "DashboardDesc",
    "SnacksDashboardHeader", "SnacksDashboardIcon", "SnacksDashboardKey",
    "SnacksDashboardDesc", "SnacksDashboardDir", "SnacksDashboardFile",
    "SnacksDashboardFooter", "SnacksDashboardSpecial",
  }, { fg = c.white })
end

local function setup_visual_selection_highlights(hl)
  -- Menggunakan warna #333333
  hl.Visual = { bg = "#2a1f3d", fg = c.pale }
  hl.VisualNOS = { bg = "#1e1530", fg = c.grey }
end

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      dim_inactive = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      on_colors = function(colors)
        local main_bg = "#010101"
        local pop_bg = "#010101"
        local main_border_color = "#E0E0E0" -- Define local literal for border

        colors.bg = main_bg
        colors.bg_sidebar = main_bg
        colors.bg_dark = pop_bg
        colors.bg_statusline = "NONE"

        colors.border = main_border_color -- Use local literal
        colors.fg = "#d4d6c6"
      end,

      on_highlights = function(hl, colors)
        setup_syntax_highlights(hl)
        setup_ui_highlights(hl, colors)
        setup_dashboard_highlights(hl)
        setup_visual_selection_highlights(hl)
      end,
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Load the default Tokyonight theme for lualine
      local tokyonight = require("lualine.themes.tokyonight")
      
      -- Strip backgrounds from the middle sections but leave section 'a' (mode), 'b' (branch), and 'z' alone
      for _, mode in pairs(tokyonight) do
        if mode.a then
          mode.a.fg = mode.a.bg
          mode.a.bg = "NONE"
        end
        if mode.b then mode.b.bg = "NONE" end
        if mode.c then mode.c.bg = "NONE" end
        if mode.x then mode.x.bg = "NONE" end
        if mode.y then mode.y.bg = "NONE" end
      end
      
      opts.options = opts.options or {}
      opts.options.section_separators = { left = "", right = "" }
      opts.options.theme = tokyonight
    end,
  },
}
