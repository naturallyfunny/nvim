local function set_highlights(hl, groups, opts)
  for _, group in ipairs(groups) do
    hl[group] = opts
  end
end

local c = {
  base = "#010101",
  black = "#010101",
  text = "#d4d6c6",
  white = "#FFFFFF",

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
  cyan_blue = "#f7768e",

  package_color = "#FFFFFF",
  string_color = "#7db84e",
  darker_silver = "#B0B0B0",
}

local function setup_syntax_highlights(hl)
  -- B&W scale: 7 even steps from #505050 (keywords) to #FFFFFF (functions/vars)
  set_highlights(hl, {
    "Keyword", "Statement", "Conditional", "Repeat", "Include",
    "Structure", "Define", "PreProc", "Exception",
    "@keyword", "@keyword.function", "@keyword.import", "@include",
  }, { fg = "#505050", italic = false })

  set_highlights(hl, { "@module", "@namespace", "@lsp.type.namespace" }, { fg = "#8a8a8a" })

  set_highlights(hl, {
    "Constant", "@constant.builtin", "@variable.builtin", "@constant",
    "@lsp.typemod.variable.readonly", "@lsp.typemod.variable.defaultLibrary",
  }, { fg = "#505050" })

  set_highlights(hl, { "String", "Character" }, { fg = "#6d6d6d" })

  set_highlights(hl, {
    "Type", "@type.builtin", "@lsp.type.builtinType",
    "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
  }, { fg = "#cecece", italic = true })

  set_highlights(hl, {
    "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
    "@lsp.type.enum", "@lsp.type.type",
  }, { fg = "#cecece" })

  set_highlights(hl, { "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = "#c4c4c4" })
  set_highlights(hl, { "@function.builtin" }, { fg = "#c4c4c4" })

  set_highlights(hl, {
    "Function", "@function", "@function.call", "@method", "@constructor",
    "Title", "@lsp.typemod.namespace.declaration",
  }, { fg = "#FFFFFF", bold = false })

  set_highlights(hl, {
    "Identifier", "@variable", "@variable.parameter",
    "@field", "@property", "@variable.member",
    "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter",
    "@lsp.typemod.variable.definition", "TSVariable", "TSVariableBuiltin",
  }, { fg = "#FFFFFF" })

  set_highlights(hl, { "@punctuation.bracket" }, { fg = "#FFFFFF" })
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
    "StatusLine", "StatusLineNC",
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
  -- Link the default cmdline icon group to the search icon group so all
  -- prompt icons (`:` `/` `?` `!` `>`) share the same yellow as `/`.
  hl.NoiceCmdlineIcon = { link = "NoiceCmdlineIconSearch" }
  hl.MsgArea = { fg = c.white, bg = "NONE" }
  hl.NoiceCmdline = { fg = c.white, bg = "NONE" }
  hl.NoiceCmdlinePopup = { fg = c.white, bg = "NONE" }
  hl.BlinkCmpLabelMatch = { fg = "#c94f4f" }
  hl.LineNr = { fg = c.grey }
  hl.LineNrAbove = { fg = c.grey }
  hl.LineNrBelow = { fg = c.grey }
  hl.CursorLineNr = { fg = "#e8e8e8", bold = true }
  hl.CursorLine = { bg = "NONE" }
  hl.Cursor = { bg = c.cursor, fg = c.black }
  hl.Comment = { fg = "#383838" }
  hl.MatchParen = { fg = "#c94f4f" }
  hl.DiagnosticError = { fg = "#8b3a3a" }
  hl.DiagnosticWarn = { fg = "#c4a35a" }
  hl.DiagnosticHint = { fg = "#6b8e6b" }
  hl.Directory = { fg = "#FFFFFF" }
  hl.SnacksPickerFile = { fg = "#FFFFFF" }
  hl.MiniIconsAzure = { fg = "#FFFFFF" }
  -- Explorer title bar: FloatTitle and SnacksTitle are cyan (#27a1b9) in tokyonight;
  -- SnacksPickerToggle links to SnacksProfilerBadgeInfo which is also cyan (#2ac3de).
  hl.FloatTitle = { fg = c.white }
  hl.SnacksTitle = { fg = c.white }
  hl.SnacksPickerToggle = { fg = c.white, bg = "NONE" }
  hl.SnacksPickerPrompt = { fg = c.white }
  hl.SnacksPickerRule = { fg = "#010101" }
  hl.SnacksPickerMatch = { fg = c.white }
  hl.SnacksPickerTotals = { fg = c.white }
  hl.SnacksPickerDir = { fg = "#383838" }
  -- Git-ignored and hidden (dot-prefixed) entries in the explorer. Snacks links
  -- these to NonText, which tokyonight tints navy — match LineNr's neutral grey.
  hl.SnacksPickerPathIgnored = { fg = c.grey }
  hl.SnacksPickerPathHidden = { fg = c.grey }
  hl.SnacksPickerGitStatusIgnored = { fg = c.grey }
  hl.SnacksIndent = { fg = "#3d3d3d" }
  hl.SnacksIndentScope = { fg = "#e8e8e8" }
  -- Winbar/breadcrumb: tokyonight defaults to a navy-tinted comment color.
  -- Use a neutral mid-grey so the directory path reads as plain grey, not blue.
  hl.WinBar = { fg = "#8a8a8a", bg = "NONE" }
  hl.WinBarNC = { fg = "#8a8a8a", bg = "NONE" }
  -- pretty_path uses filename_hl="Bold" — give Bold an explicit white fg so the
  -- filename stays white instead of inheriting lualine_c's grey.
  hl.Bold = { fg = c.white, bold = true }
  hl.WhichKey = { fg = c.white }
  hl.WhichKeyDesc = { fg = c.white }
  hl.WhichKeyGroup = { fg = c.white }
  hl.WhichKeySeparator = { fg = c.white }
  hl.WhichKeyValue = { fg = c.white }
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
  hl.Visual = { bg = "#535c7e", fg = c.white }
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
        colors.fg = "#FFFFFF"
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
      -- Solid monochrome B&W statusline with powerline chevrons.
      -- Mode-pill brightness gradient: INSERT brightest (active editing focus),
      -- NORMAL slightly off-white, COMMAND/VISUAL mid, REPLACE darkest.
      -- Section c blends into the editor bg (#010101) so empty stretches don't
      -- show as a grey rectangle. Section b uses a subtle accent bg so the
      -- a→b and b→c chevrons remain visible.
      local b_bg, b_fg = "#1a1a1a", "#b8b8b8"
      local c_bg, c_fg = "#010101", "#6a6a6a"
      local function mode_section(a_bg, a_fg)
        return {
          a = { bg = a_bg, fg = a_fg, gui = "bold" },
          b = { bg = b_bg, fg = b_fg },
          c = { bg = c_bg, fg = c_fg },
        }
      end
      local theme = {
        normal   = mode_section("#e8e8e8", "#010101"),
        insert   = mode_section("#FFFFFF", "#c94f4f"),
        visual   = mode_section("#FFFFFF", "#7aa2f7"),
        replace  = mode_section("#3a3a3a", "#FFFFFF"),
        command  = mode_section("#b0b0b0", "#010101"),
        inactive = {
          a = { bg = c_bg, fg = "#4a4a4a", gui = "bold" },
          b = { bg = c_bg, fg = "#4a4a4a" },
          c = { bg = c_bg, fg = "#4a4a4a" },
        },
      }

      -- root_dir component (folder icon + project name) renders inside section c.
      for _, component in ipairs((opts.sections or {}).lualine_c or {}) do
        if type(component) == "table" and type(component[1]) == "function" and component.color then
          component.color = function() return { fg = "#FFFFFF", bg = c_bg, gui = "bold" } end
        end
      end

      -- lazy.nvim updates component (cube icon + count) renders inside section x.
      local lazy_status = require("lazy.status")
      for _, component in ipairs((opts.sections or {}).lualine_x or {}) do
        if type(component) == "table" and component[1] == lazy_status.updates then
          component.color = function() return { fg = "#FFFFFF", bg = c_bg } end
        end
      end

      opts.options = opts.options or {}
      -- Powerline chevrons: U+E0B0 (solid right), U+E0B2 (solid left) for sections;
      -- U+E0B1 (thin right), U+E0B3 (thin left) for components.
      opts.options.section_separators = { left = "\xee\x82\xb0", right = "\xee\x82\xb2" }
      opts.options.component_separators = { left = "\xee\x82\xb1", right = "\xee\x82\xb3" }
      opts.options.theme = theme
    end,
  },
}
