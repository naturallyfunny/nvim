vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "venom-light"

local function set_hl(groups, opts)
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

-- ── Palette ──────────────────────────────────────────────────────────────────

local c = {
    -- Anchors
    black = "#010101",
    ink   = "#000000", -- pure black
    white = "#FFFFFF",
    bg    = "#D0D0D0", -- editor background (matches ghostty bg)

    -- Syntax scale: darker = more prominent on #D0D0D0 bg
    s2 = "#aaaaaa", -- borders
    s3 = "#888888", -- mid (winbar, misc)
    s4 = "#666666", -- operators, brackets, specials, return
    s5 = "#2a2a2a", -- user-defined types

    string  = "#2e7d78", -- venom-light strings (dark teal)
    const   = "#3a6ea8", -- venom-light user-defined constants (dark blue)
    bconst  = "#7d4f80", -- venom-light language built-in constants (dark pinky)
    ret     = "#666666", -- venom-light operators (same zone as s4)
    module  = "#777777", -- venom-light modules/namespaces
    ptype   = "#4a4d5c", -- venom-light primitive/built-in types (italic)
    utype   = "#3d4a7a", -- venom-light custom/user-defined types
    comment = "#7a7d5e", -- venom-light comments (dark olive)

    -- Surfaces (darker than #D0D0D0 so highlights are visible)
    bg0 = "#c8c8c8", -- [c_bg] lualine c
    bg1 = "#c4c4c4", -- color column
    bg2 = "#c0c0c0", -- diff hunk bg, lazy button bg
    bg3 = "#bbbbbb", -- cursor line, noice popupmenu selected bg
    bg4 = "#b8b8b8", -- VisualNOS bg
    bg5 = "#b0b0b0", -- quickfix line bg
    bg6 = "#a8a8a8", -- [b_bg] lualine b, search, diff text, LspReference
    bg7 = "#a0a0a0", -- substitute, wildmenu, LspSignatureActiveParameter
    bg8 = "#989898", -- flash backdrop, snacks picker dir label
    bg9 = "#909090", -- visual selection, lualine visual mode a_bg

    -- UI greys
    dim    = "#aaaaaa", -- git Untracked
    gutter = "#888888", -- LineNr (non-scope gutter)
    grey   = "#555555", -- keywords
    muted  = "#888888", -- lualine inactive fg
    mid    = "#777777", -- lualine c fg, snacks notifier info titles

    -- Dark accents
    scope  = "#111111", -- CursorLineNr, SnacksIndentScope
    border = "#1a1a1a", -- FloatermBorder

    -- Diagnostics
    d_error = "#8b2020",
    d_warn  = "#8a6010",
    d_hint  = "#3a6a3a",
    d_info  = "#5a4444",

    -- Notification severity accents
    n_warn  = "#8a6010",
    n_error = "#c04040",
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
}, { fg = c.grey, italic = false })

set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.s4 })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = c.module })

set_hl({ "Constant", "@constant.builtin", "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" }, { fg = c.bconst })
set_hl({ "@constant", "@lsp.typemod.variable.readonly" }, { fg = c.const })

set_hl({ "String", "Character", "@string", "@string.escape", "@character" }, { fg = c.string })

set_hl({
    "Type",
    "@type.builtin",
    "@lsp.type.builtinType",
    "@lsp.typemod.type.defaultLibrary",
    "@lsp.typemod.builtin.defaultLibrary",
}, { fg = c.ptype, italic = true })

set_hl({
    "@type",
    "@type.definition",
    "@lsp.type.struct",
    "@lsp.type.interface",
    "@lsp.type.enum",
    "@lsp.type.type",
}, { fg = c.utype })

set_hl({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.ret })
set_hl({
    "@function.builtin",
    "@lsp.typemod.function.defaultLibrary",
    "@lsp.typemod.method.defaultLibrary",
}, { fg = c.black, italic = true })

set_hl({
    "Special",
    "SpecialChar",
    "@keyword.operator",
    "@keyword.modifier",
    "@keyword.directive",
    "@attribute",
    "@string.special",
    "@string.special.url",
}, { fg = c.s4 })

set_hl({ "@boolean", "Boolean", "@number", "@number.float", "@float", "Number", "Float" }, { fg = c.const })

set_hl({
    "Function",
    "@function",
    "@function.call",
    "@method.call",
    "@constructor",
    "Title",
    "@lsp.typemod.namespace.declaration",
}, { fg = c.black, bold = false })

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
}, { fg = c.black })

set_hl({ "@punctuation.bracket", "@string.delimiter" }, { fg = c.s4 })

-- ── UI: backgrounds ───────────────────────────────────────────────────────────

set_hl({ "Normal", "NormalNC" }, { fg = c.black, bg = surface })

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = c.s2, bg = surface })

vim.api.nvim_set_hl(0, "FloatermBorder", { bg = surface, fg = c.border })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = c.s2 })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = c.s2, bg = surface })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = c.s2, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

vim.api.nvim_set_hl(0, "MsgArea", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.black, bg = surface })

vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = c.s2, bg = surface })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm", { bg = c.bg6, fg = c.black })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.s5, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.s3 })
vim.api.nvim_set_hl(0, "LineNr", { fg = c.gutter })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = c.gutter })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = c.gutter })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.scope, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = c.bg3 })
vim.api.nvim_set_hl(0, "Comment", { fg = c.comment })
vim.api.nvim_set_hl(0, "MatchParen", { fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.d_error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.d_warn })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.d_hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.d_info })

for _, level in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = c.black, bg = surface })
    end
    local up = level:upper()
    for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
        vim.api.nvim_set_hl(0, "Notify" .. up .. part, { fg = c.black, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. level, { fg = c.black, bg = surface })
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
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.d_info })
vim.api.nvim_set_hl(0, "Directory", { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = c.black })
vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = c.black })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksTitle", { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.bg8 })
vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksInputNormal", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.s2, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputTitle", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputIcon", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = c.bg7 })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.ink })
vim.api.nvim_set_hl(0, "WinBar", { fg = c.s3, bg = surface })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = c.s3, bg = surface })
vim.api.nvim_set_hl(0, "Bold", { fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "WhichKey", { fg = c.black })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = c.black })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = c.black })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = c.black })
vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = c.black })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = c.s2, bg = surface })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({
    "DashboardHeader",
    "DashboardCenter",
    "DashboardFooter",
    "DashboardShortCut",
    "DashboardIcon",
    "DashboardKey",
    "DashboardDesc",
    "SnacksDashboardHeader",
    "SnacksDashboardIcon",
    "SnacksDashboardKey",
    "SnacksDashboardDesc",
    "SnacksDashboardDir",
    "SnacksDashboardFile",
    "SnacksDashboardFooter",
    "SnacksDashboardSpecial",
}, { fg = c.black })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText", { bg = c.bg6, fg = c.black })

local gs = {
    Add          = c.s5,
    Change       = c.s3,
    Delete       = c.grey,
    Untracked    = c.dim,
    Topdelete    = c.grey,
    Changedelete = c.s2,
}
for kind, color in pairs(gs) do
    for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
        vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
    end
end

-- ── Phantom / whitespace ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText", { fg = c.bg6 })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.bg6 })
vim.api.nvim_set_hl(0, "Whitespace", { fg = c.bg2 })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.grey })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = c.bg1, fg = "NONE" })

-- ── Diagnostics: virtual text, float, sign column ─────────────────────────────

local diag = {
    Error       = c.d_error,
    Warn        = c.d_warn,
    Hint        = c.d_hint,
    Info        = c.d_info,
    Unnecessary = c.d_info,
}
for sev, color in pairs(diag) do
    vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticFloating" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticSign" .. sev, { fg = color, bg = surface })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind", { fg = c.s4, bg = surface })
vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = c.black, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtra", { fg = c.s2, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.s4, bg = surface })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = c.grey })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = c.black })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = c.black })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = c.black })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.black })

-- ── Flash.nvim ────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch", { bg = c.bg6, fg = c.black })
vim.api.nvim_set_hl(0, "FlashCurrent", { bg = c.s5, fg = c.white })
vim.api.nvim_set_hl(0, "FlashLabel", { bg = c.black, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.bg8 })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal", { bg = surface, fg = c.black })
vim.api.nvim_set_hl(0, "LazyButton", { bg = c.bg2, fg = c.s4 })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.bg6, fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "LazyH1", { fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "LazyH2", { fg = c.s4, bold = true })
vim.api.nvim_set_hl(0, "LazySpecial", { fg = c.s3 })
vim.api.nvim_set_hl(0, "LazyCommit", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType", { fg = c.s3 })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.s3 })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.black })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal", { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual", { bg = c.bg9, fg = c.black })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = c.s4 })
vim.api.nvim_set_hl(0, "Search", { bg = c.bg6, fg = c.black })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.s5, fg = c.white })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.black, fg = c.white })

vim.api.nvim_set_hl(0, "Substitute", { bg = c.bg7, fg = c.black })
vim.api.nvim_set_hl(0, "WildMenu", { bg = c.bg7, fg = c.black })
vim.api.nvim_set_hl(0, "QuickFixLine", { bg = c.bg5, fg = c.black })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "Folded", { fg = c.s2, bg = surface })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = c.bg6, fg = c.black })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = c.bg6, fg = c.black })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = c.bg6, fg = c.black })

-- ── Markdown ──────────────────────────────────────────────────────────────────

set_hl({
    "@markup.heading",
    "@markup.heading.markdown",
    "@markup.heading.1",
    "@markup.heading.2",
    "@markup.heading.3",
    "@markup.heading.4",
    "@markup.heading.5",
    "@markup.heading.6",
    "@markup.heading.1.markdown",
    "@markup.heading.2.markdown",
    "@markup.heading.3.markdown",
    "@markup.heading.4.markdown",
    "@markup.heading.5.markdown",
    "@markup.heading.6.markdown",
    "markdownH1",
    "markdownH2",
    "markdownH3",
    "markdownH4",
    "markdownH5",
    "markdownH6",
}, { fg = c.black, bold = true, bg = surface })

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
}, { fg = c.s4, bold = false, bg = surface })

set_hl({
    "@markup.raw",
    "@markup.raw.markdown",
    "@markup.raw.markdown_inline",
    "markdownCode",
    "markdownCodeDelimiter",
    "@markup.raw.block.markdown",
    "markdownCodeBlock",
}, { fg = c.s2, bg = surface })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" }, { fg = c.black, bold = true })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" }, { fg = c.black, italic = true })

set_hl({
    "@markup.link",
    "@markup.link.label",
    "@markup.link.label.markdown_inline",
    "markdownLinkText",
    "markdownLink",
}, { fg = c.s5, bg = surface, underline = false })

set_hl({
    "@markup.link.url",
    "@markup.link.url.markdown_inline",
    "markdownUrl",
}, { fg = c.s3, bg = surface, underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.s4 })

set_hl({
    "@markup.list",
    "@markup.list.markdown",
    "markdownListMarker",
    "markdownOrderedListMarker",
}, { fg = c.s3 })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" }, { fg = c.s2, italic = true })

set_hl({ "markdownRule" }, { fg = c.s3 })

-- ── Bufferline ────────────────────────────────────────────────────────────────
local function apply_bufferline()
    local dim, vis, sel = c.mid, c.s4, c.black
    for _, name in ipairs({ "Background", "CloseButton", "Modified", "Numbers", "Diagnostic",
        "ErrorDiagnostic", "WarningDiagnostic", "InfoDiagnostic", "HintDiagnostic" }) do
        vim.api.nvim_set_hl(0, "BufferLine" .. name,              { bg = "NONE", fg = dim })
        vim.api.nvim_set_hl(0, "BufferLine" .. name .. "Visible",  { bg = "NONE", fg = vis })
        vim.api.nvim_set_hl(0, "BufferLine" .. name .. "Selected", { bg = "NONE", fg = sel })
    end
    for _, sev in ipairs({ "Error", "Warning", "Info", "Hint" }) do
        vim.api.nvim_set_hl(0, "BufferLine" .. sev,               { bg = "NONE", fg = dim })
        vim.api.nvim_set_hl(0, "BufferLine" .. sev .. "Visible",  { bg = "NONE", fg = vis })
        vim.api.nvim_set_hl(0, "BufferLine" .. sev .. "Selected", { bg = "NONE", fg = sel, bold = true })
    end
    vim.api.nvim_set_hl(0, "BufferLineDuplicate",         { bg = "NONE", fg = dim, italic = true })
    vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible",  { bg = "NONE", fg = vis, italic = true })
    vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { bg = "NONE", fg = sel, italic = true })
    vim.api.nvim_set_hl(0, "BufferLinePick",              { bg = "NONE", fg = dim, bold = true })
    vim.api.nvim_set_hl(0, "BufferLinePickVisible",       { bg = "NONE", fg = vis, bold = true })
    vim.api.nvim_set_hl(0, "BufferLinePickSelected",      { bg = "NONE", fg = sel, bold = true })
    vim.api.nvim_set_hl(0, "BufferLineBufferVisible",     { bg = "NONE", fg = vis })
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected",    { bg = "NONE", fg = sel, bold = true })
    for _, g in ipairs({ "Separator", "SeparatorVisible", "SeparatorSelected", "OffsetSeparator" }) do
        vim.api.nvim_set_hl(0, "BufferLine" .. g, { bg = "NONE", fg = "NONE" })
    end
    vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible",  { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = "NONE", fg = sel })
    vim.api.nvim_set_hl(0, "BufferLineFill",              { bg = "NONE" })
end
apply_bufferline()

-- ── Plugin re-application ─────────────────────────────────────────────────────

local function reapply()
    vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.white })
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.black })
    vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.black })
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.bg8 })
    vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.black, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.grey, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.grey, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksWinSeparator", { fg = c.grey, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.black, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = c.s2, bg = surface })
    for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.black, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = c.grey, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { fg = c.black, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = c.grey, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { fg = c.black, bg = c.bg3, bold = true })
    vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = c.black, bg = surface, bold = true })
    vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.black, bg = surface })
    local nb = surface
    for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = c.gutter, bg = nb })
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. lvl, { fg = c.black, bg = nb })
    end
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = c.mid, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { fg = c.n_warn, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = c.n_error, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = c.mid, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn", { fg = c.n_warn, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconError", { fg = c.n_error, bg = nb })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.s3 })
    apply_bufferline()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local b_fg = c.black
local c_fg = c.mid
local function mode_section(a_bg, a_fg)
    return {
        a = { bg = a_bg, fg = a_fg, gui = "bold" },
        b = { bg = b_bg, fg = b_fg },
        c = { bg = c_bg, fg = c_fg },
    }
end

require("config.theme_registry").register("venom-light", {
    reapply = reapply,
    lualine = {
        theme = {
            normal  = mode_section(c.black, c.white),
            insert  = mode_section(c_bg, c.black),
            visual  = mode_section(c.bg9, c.black),
            replace = mode_section(c_bg, c.black),
            command = mode_section(c.black, c.white),
            inactive = {
                a = { bg = c_bg, fg = c.muted, gui = "bold" },
                b = { bg = c_bg, fg = c.muted },
                c = { bg = c_bg, fg = c.muted },
            },
        },
        c_bg       = c_bg,
        filename   = c.black,
        directory  = c.mid,
        lazy_updates = c.black,
        diff = { added = c.black, modified = c.black, removed = c.black },
    },
})
