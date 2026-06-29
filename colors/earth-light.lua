vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "earth-light"

local function set_hl(groups, opts)
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

-- ── Palette ──────────────────────────────────────────────────────────────────

local c = {
    -- Editor base
    bg = "#E2DDD4", -- warm parchment background
    fg = "#1a1610", -- default text (very dark warm brown)

    -- Syntax: semantic roles (darkened from earth dark for light bg readability)
    keyword = "#236030", -- keywords (dark forest green)
    module = "#386428", -- namespaces (deep forest green)
    vivid = "#1a8020", -- dashboard header accent (saturated dark green)
    special = "#386428", -- special keywords, attributes
    string = "#6b5234", -- string literals (warm dark brown)
    const = "#186480", -- constants, numbers (dark teal)
    type = "#5e5a50", -- builtin types (dark warm grey, italic)
    utype = "#426028", -- user-defined types: struct, interface, enum (dark sage)
    var = "#2a2218", -- variables, parameters (very dark warm brown)

    -- UI chrome
    comment = "#5a7870", -- comments (muted dark teal-grey)
    grey = "#888076", -- line numbers, muted chrome
    dim = "#b0ac9c", -- indent guides, non-text
    border = "#9a9488", -- borders
    sel = "#bad4b6", -- selections, lualine command fg
    indent = "#d4e8cc", -- SnacksIndent (very pale green)

    -- Tinted light surfaces (lighter tints over parchment for diff, search, panels)
    surf_green = "#d2e8cc", -- DiffAdd (pale green)
    surf_blue = "#d0d8ea", -- DiffChange (pale blue)
    surf_red = "#e8d0d0", -- DiffDelete (pale pink)
    surf_earth = "#e4d8b8", -- Search bg (pale sepia)
    surf_ghost = "#d4d8cc", -- Whitespace
    surf_col = "#dce0e4", -- ColorColumn
    surf_navy = "#d0d4e0", -- LazyButton panel
    surf_teal = "#c4dcd4", -- LspReference bg
    surf_mid = "#c0d4bc", -- VisualNOS bg
    surf_lift = "#b4cab0", -- [b_bg] lualine b (warm sage panel)

    -- bg scale: progressively darker for highlights (all shadowing below bg)
    bg0 = "#dedad0", -- [c_bg] lualine c
    bg1 = "#d8d4c8",
    bg2 = "#d2cec0",
    bg3 = "#cac5b8", -- cursor line, noice popupmenu selected bg
    bg4 = "#c4bfb0",
    bg5 = "#bdb8a8",
    bg6 = "#b5b0a0", -- [b_bg] lualine b, search, LspReference
    bg7 = "#aaa498",
    bg8 = "#a29e90", -- flash backdrop
    bg9 = "#989280", -- visual selection

    -- Lualine palette
    bar = "#dedad0", -- [c_bg] lualine section c bg
    deep = "#1a1610", -- lualine a fg (matches fg)
    sage = "#8ab880", -- lualine visual a_bg, Visual selection (sage green)
    cyan_l = "#4ab0d0", -- lualine replace a_bg
    cream = "#3d3020", -- lualine filename (dark warm brown)
    gold = "#8a6820", -- lualine lazy_updates (golden brown)
    muted = "#7a7868", -- lualine inactive fg
    mid = "#6a6858", -- lualine c fg, directory

    -- Diagnostics
    d_error = "#8b3030",
    d_warn = "#8a6010",
    d_hint = "#4a7a40",
    d_info = "#3a6870",

    -- Notification severity accents
    n_warn = "#a07820",
    n_error = "#c04040",
    n_info = "#5a5a5a",

    -- Brights
    bright_green = "#2a9e40", -- BlinkCmpLabelMatch
}

local surface = require("util.transparent").bg(c.bg)

-- lualine section b bg.
local b_bg = c.bg6
-- lualine section c bg.
local c_bg = c.bg0

-- ── Syntax ───────────────────────────────────────────────────────────────────

set_hl({
    "Keyword",
    "Statement",
    "Conditional",
    "Repeat",
    "Include",
    "Structure",
    "Define",
    "PreProc",
    "Exception",
    "@keyword",
    "@keyword.function",
    "@keyword.import",
    "@include",
}, { fg = c.keyword })

set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = c.module })

set_hl({
    "Constant",
    "@constant.builtin",
    "@variable.builtin",
    "@constant",
    "@lsp.typemod.variable.readonly",
    "@lsp.typemod.variable.defaultLibrary",
}, { fg = c.const })

set_hl({ "String", "Character", "@string", "@string.escape", "@character" }, { fg = c.string })

set_hl({
    "Type",
    "@type.builtin",
    "@lsp.type.builtinType",
    "@lsp.typemod.type.defaultLibrary",
    "@lsp.typemod.builtin.defaultLibrary",
}, { fg = c.type, italic = true })

set_hl({
    "@type",
    "@type.definition",
    "@lsp.type.struct",
    "@lsp.type.interface",
    "@lsp.type.enum",
    "@lsp.type.type",
}, { fg = c.utype })

set_hl({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.fg })
set_hl({ "@function.builtin" }, { fg = c.fg })

set_hl({ "@keyword.conditional", "@keyword.repeat" }, { fg = c.keyword })

set_hl({
    "Special",
    "SpecialChar",
    "@keyword.operator",
    "@keyword.modifier",
    "@keyword.directive",
    "@attribute",
    "@string.special",
    "@string.special.url",
}, { fg = c.special })

set_hl({ "@boolean", "Boolean", "@number", "@number.float", "@float", "Number", "Float" }, { fg = c.const })

set_hl({
    "Function",
    "@function",
    "@function.call",
    "@method",
    "@constructor",
    "Title",
    "@lsp.typemod.namespace.declaration",
}, { fg = c.fg })

set_hl({
    "Identifier",
    "@variable",
    "@variable.parameter",
    "@field",
    "@property",
    "@variable.member",
    "@lsp.type.property",
    "@lsp.type.variable",
    "@lsp.type.parameter",
    "@lsp.typemod.variable.definition",
    "TSVariable",
    "TSVariableBuiltin",
}, { fg = c.var })

set_hl({ "@punctuation.bracket" }, { fg = c.fg })
set_hl({ "@string.delimiter" }, { fg = c.fg })

-- ── UI: transparent / bg-matched backgrounds ──────────────────────────────────

set_hl({
    "Terminal",
    "TermNormal",
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "SideBar",
    "SideBarNC",
    "SnacksNormal",
    "SnacksNormalNC",
    "SnacksPickerNormal",
    "SnacksPickerNormalNC",
    "SnacksPickerList",
    "SnacksPickerPreview",
    "SnacksLayoutNormal",
    "SnacksDashboardNormal",
    "SnacksTerminal",
    "SnacksTerminalNormal",
    "SnacksExplorer",
    "SnacksExplorerNormal",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "NetrwNormal",
    "NetrwNormalNC",
    "NormalSB",
    "SignColumnSB",
    "StatusLine",
    "StatusLineNC",
    "WhichKeyNormal",
    "WhichKeyFloat",
    "TelescopeNormal",
    "Floaterm",
    "NormalFloat",
    "Pmenu",
    "PmenuSel",
    "PmenuSbar",
    "PmenuThumb",
}, { bg = surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = c.fg, bg = c.sel })

set_hl({ "Normal", "NormalNC" }, { fg = c.fg, bg = surface })

set_hl({
    "WinSeparator",
    "VertSplit",
    "NeoTreeWinSeparator",
    "SnacksWinSeparator",
}, { fg = c.comment, bg = surface })

vim.api.nvim_set_hl(0, "FloatermBorder", { bg = surface, fg = c.type })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = c.type })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = c.utype, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

vim.api.nvim_set_hl(0, "MsgArea", { fg = c.string, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.string, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.string, bg = surface })

vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = c.var, bg = surface })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm", { bg = c.surf_navy, fg = c.var })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.const, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.bright_green, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchFuzzy", { fg = c.bright_green, bold = true })
vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = c.comment })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = c.comment })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = c.comment })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.var, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = c.bg3 })
vim.api.nvim_set_hl(0, "Comment", { fg = c.comment })
vim.api.nvim_set_hl(0, "MatchParen", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.d_error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.d_warn })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.d_hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.d_info })

for _, level in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    for _, part in ipairs({ "Border", "Title", "Icon" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = c.utype, bg = surface })
    end
    for _, part in ipairs({ "", "Footer", "History" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = c.string, bg = surface })
    end
    local up = level:upper()
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Border", { fg = c.type, bg = surface })
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Title", { fg = c.utype, bg = surface })
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Icon", { fg = c.utype, bg = surface })
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Body", { fg = c.string, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. level, { fg = c.utype, bg = surface })
end

for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn", { fg = c.d_warn, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = c.d_error, bg = surface })
end
for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
    vim.api.nvim_set_hl(0, "NotifyWARN" .. part, { fg = c.d_warn, bg = surface })
    vim.api.nvim_set_hl(0, "NotifyERROR" .. part, { fg = c.d_error, bg = surface })
end
vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn", { fg = c.d_warn, bg = surface })
vim.api.nvim_set_hl(0, "NoiceFormatLevelError", { fg = c.d_error, bg = surface })
vim.api.nvim_set_hl(0, "NoiceMini", { bg = surface })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.comment })
vim.api.nvim_set_hl(0, "Directory", { fg = c.var })
vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = c.fg })
vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = c.special })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = c.utype })
vim.api.nvim_set_hl(0, "SnacksTitle", { fg = c.utype })
vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.bg })
vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = c.muted })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = c.muted })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputNormal", { fg = c.var, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputTitle", { fg = c.utype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputIcon", { fg = c.utype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = c.dim })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.var })
vim.api.nvim_set_hl(0, "WinBar", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "Bold", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "WhichKey", { fg = c.var })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = c.keyword })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = c.grey })
vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = c.type })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = c.vivid })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = c.const })
set_hl({ "DashboardKey", "SnacksDashboardKey", "DashboardShortCut" }, { fg = c.var })
set_hl({ "DashboardDesc", "SnacksDashboardDesc", "DashboardCenter" }, { fg = c.fg })
set_hl({ "SnacksDashboardFile", "SnacksDashboardDir" }, { fg = c.type })
set_hl({ "SnacksDashboardSpecial" }, { fg = c.fg })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = c.const })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.surf_green, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.surf_blue, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.surf_red, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffText", { bg = c.sel, fg = c.fg })

local gs = {
    Add = c.var,
    Change = c.const,
    Delete = c.d_error,
    Untracked = c.grey,
    Topdelete = c.d_error,
    Changedelete = c.string,
}
for kind, color in pairs(gs) do
    for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
        vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
    end
end

-- ── Phantom / whitespace ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText", { fg = c.dim })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.dim })
vim.api.nvim_set_hl(0, "Whitespace", { fg = c.surf_ghost })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.comment })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = c.surf_col, fg = "NONE" })

-- ── Diagnostics: virtual text, float, sign column ─────────────────────────────

local diag = {
    Error = c.d_error,
    Warn = c.d_warn,
    Hint = c.d_hint,
    Info = c.d_info,
    Unnecessary = c.comment,
}
for sev, color in pairs(diag) do
    vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticFloating" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticSign" .. sev, { fg = color, bg = surface })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind", { fg = c.type, bg = surface })
vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtra", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.type, bg = surface })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = c.grey })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.var })

-- ── Flash.nvim ────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch", { bg = c.surf_green, fg = c.fg })
vim.api.nvim_set_hl(0, "FlashCurrent", { bg = c.keyword, fg = c.bg })
vim.api.nvim_set_hl(0, "FlashLabel", { bg = c.var, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.bg8 })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal", { bg = surface, fg = c.fg })
vim.api.nvim_set_hl(0, "LazyButton", { bg = c.surf_navy, fg = c.type })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.surf_lift, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH1", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH2", { fg = c.type, bold = true })
vim.api.nvim_set_hl(0, "LazySpecial", { fg = c.var })
vim.api.nvim_set_hl(0, "LazyCommit", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType", { fg = c.special })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.var })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal", { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual", { bg = c.sage, fg = c.deep })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.surf_mid, fg = c.type })
vim.api.nvim_set_hl(0, "Search", { bg = c.surf_earth, fg = c.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.keyword, fg = c.bg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.var, fg = c.bg })

vim.api.nvim_set_hl(0, "Substitute", { bg = c.sel, fg = c.fg })
vim.api.nvim_set_hl(0, "WildMenu", { bg = c.sel, fg = c.fg })
vim.api.nvim_set_hl(0, "QuickFixLine", { bg = c.surf_navy, fg = c.fg })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.sel, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "Folded", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = c.surf_teal, fg = c.fg })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = c.surf_teal, fg = c.fg })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = c.surf_teal, fg = c.fg })

-- ── Markdown ──────────────────────────────────────────────────────────────────

set_hl({
    "@markup.heading.1",
    "@markup.heading.1.markdown",
    "markdownH1",
}, { fg = c.utype, bold = true, bg = surface })

set_hl({
    "@markup.heading.2",
    "@markup.heading.2.markdown",
    "markdownH2",
}, { fg = c.module, bold = true, bg = surface })

set_hl({
    "@markup.heading.3",
    "@markup.heading.3.markdown",
    "markdownH3",
}, { fg = c.special, bold = true, bg = surface })

set_hl({
    "@markup.heading.4",
    "@markup.heading.4.markdown",
    "markdownH4",
}, { fg = c.var, bold = true, bg = surface })

set_hl({
    "@markup.heading",
    "@markup.heading.markdown",
    "@markup.heading.5",
    "@markup.heading.5.markdown",
    "markdownH5",
    "@markup.heading.6",
    "@markup.heading.6.markdown",
    "markdownH6",
}, { fg = c.type, bold = true, bg = surface })

set_hl({
    "@markup.heading.1.marker.markdown",
    "@markup.heading.2.marker.markdown",
    "@markup.heading.3.marker.markdown",
    "@markup.heading.4.marker.markdown",
    "@markup.heading.5.marker.markdown",
    "@markup.heading.6.marker.markdown",
    "@punctuation.special.markdown",
    "markdownH1Delimiter",
    "markdownH2Delimiter",
    "markdownH3Delimiter",
    "markdownH4Delimiter",
    "markdownH5Delimiter",
    "markdownH6Delimiter",
    "markdownHeadingDelimiter",
}, { fg = c.grey, bold = false, bg = surface })

set_hl({
    "@markup.raw",
    "@markup.raw.markdown",
    "@markup.raw.markdown_inline",
    "markdownCode",
    "markdownCodeDelimiter",
    "@markup.raw.block.markdown",
    "markdownCodeBlock",
}, { fg = c.const, bg = surface })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" }, { fg = c.string, bold = true })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" }, { fg = c.var, italic = true })

set_hl({
    "@markup.link",
    "@markup.link.label",
    "@markup.link.label.markdown_inline",
    "markdownLinkText",
    "markdownLink",
}, { fg = c.const, bg = surface, underline = false })

set_hl({
    "@markup.link.url",
    "@markup.link.url.markdown_inline",
    "markdownUrl",
}, { fg = c.string, bg = surface, underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.grey })

set_hl({
    "@markup.list",
    "@markup.list.markdown",
    "markdownListMarker",
    "markdownOrderedListMarker",
}, { fg = c.module })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" }, { fg = c.string, italic = true })

set_hl({ "markdownRule" }, { fg = c.border })

-- ── Plugin re-application ─────────────────────────────────────────────────────
local accent = c.type

local function reapply()
    vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.bg })
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.utype, bold = true })
    vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.grey })
    vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = accent, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = accent, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = accent, bg = surface })
    for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.fg, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = accent, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = c.comment, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { fg = c.fg, bg = c.surf_navy, bold = true })
    vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = accent, bg = surface, bold = true })
    vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.fg, bg = surface })
    local nb = surface
    for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = accent, bg = nb })
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. lvl, { fg = c.fg, bg = nb })
    end
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = accent, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { fg = c.n_warn, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = c.n_error, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = c.n_info, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn", { fg = c.n_warn, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconError", { fg = c.n_error, bg = nb })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = accent, bold = true })
    vim.api.nvim_set_hl(0, "SnacksWinSeparator", { fg = c.comment, bg = surface })
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local b_fg = c.fg
local c_fg = c.mid
local function mode_section(a_bg, a_fg)
    return {
        a = { bg = a_bg, fg = a_fg, gui = "bold" },
        b = { bg = b_bg, fg = b_fg },
        c = { bg = c_bg, fg = c_fg },
    }
end

require("config.theme_registry").register("earth-light", {
    reapply = reapply,
    lualine = {
        theme = {
            normal = mode_section(c.type, c.bg),
            insert = mode_section(c.keyword, c.bg),
            visual = mode_section(c.sage, c.deep),
            replace = mode_section(c.const, c.bg),
            command = mode_section(c.utype, c.bg),
            inactive = {
                a = { bg = c_bg, fg = c.border, gui = "bold" },
                b = { bg = c_bg, fg = c.border },
                c = { bg = c_bg, fg = c.border },
            },
        },
        c_bg = c_bg,
        filename = c.cream,
        directory = c.mid,
        lazy_updates = c.gold,
        diff = { added = c.fg, modified = c.module, removed = c.d_error },
    },
})
