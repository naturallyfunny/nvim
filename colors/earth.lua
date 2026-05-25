vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "earth"

local function set_hl(groups, opts)
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

local c = {
  bg      = "#0e0e16",
  fg      = "#FFFFFF",
  keyword = "#2e553a",
  string  = "#785e3b",
  var     = "#e9e0cf",
  type    = "#afaba0",
  utype   = "#99b77b",  -- user-defined types (struct, interface, enum names)
  sel     = "#35484e",
  const   = "#69bdd6",  -- constants, numbers
  op      = "#FFFFFF",  -- operators, punctuation
  comment = "#3c3f55",  -- dark ink, barely above bg
  module  = "#328c45",  -- structural green: namespaces
  special = "#5a7f52",  -- mid-green: special keywords, attributes
  grey    = "#585860",  -- line numbers, muted chrome
  dim     = "#2d3048",  -- indent guides, non-text
  border  = "#404558",
}

-- ── Syntax ────────────────────────────────────────────────────────────────

set_hl({
  "Keyword", "Statement", "Conditional", "Repeat", "Include",
  "Structure", "Define", "PreProc", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
}, { fg = c.keyword })

set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})  -- let treesitter handle keywords so @keyword.return.go can fire

set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = c.module })

set_hl({
  "Constant", "@constant.builtin", "@variable.builtin", "@constant",
  "@lsp.typemod.variable.readonly", "@lsp.typemod.variable.defaultLibrary",
}, { fg = c.const })

set_hl({ "String", "Character", "@string", "@string.escape", "@character" }, { fg = c.string })

set_hl({
  "Type", "@type.builtin", "@lsp.type.builtinType",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = c.type, italic = true })

set_hl({
  "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
}, { fg = c.utype })

set_hl({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.op })
set_hl({ "@function.builtin" }, { fg = c.fg })

set_hl({ "@keyword.conditional", "@keyword.repeat" }, { fg = c.keyword })

set_hl({
  "Special", "SpecialChar",
  "@keyword.operator", "@keyword.modifier", "@keyword.directive",
  "@attribute",
  "@string.special", "@string.special.url",
}, { fg = c.special })

set_hl({ "@boolean", "Boolean", "@number", "@number.float", "@float", "Number", "Float" }, { fg = c.const })

set_hl({
  "Function", "@function", "@function.call", "@method", "@constructor",
  "Title", "@lsp.typemod.namespace.declaration",
}, { fg = c.fg })

set_hl({
  "Identifier", "@variable", "@variable.parameter",
  "@field", "@property", "@variable.member",
  "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter",
  "@lsp.typemod.variable.definition", "TSVariable", "TSVariableBuiltin",
}, { fg = c.var })

set_hl({ "@punctuation.bracket" }, { fg = c.fg })
set_hl({ "@string.delimiter" }, { fg = c.op })

-- ── UI: transparent / bg-matched backgrounds ──────────────────────────────

set_hl({
  "NormalNC", "Terminal", "TermNormal",
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
  "TelescopeNormal",
  "Floaterm", "NormalFloat",
  "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
}, { bg = "NONE" })

vim.api.nvim_set_hl(0, "Normal", { fg = c.fg, bg = "NONE" })

set_hl({
  "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator",
}, { fg = "NONE", bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = c.keyword })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = c.keyword })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = c.keyword, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = c.keyword, bg = "NONE" })
-- NOTE: NoiceCmdlinePopupBorder is re-applied via the registered reapply() below
-- because Noice resets highlights after ColorScheme events. The value here and there must match.
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",  { fg = "#99b77b", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",   { fg = "#99b77b", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon",         { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

vim.api.nvim_set_hl(0, "MsgArea",           { fg = c.string, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdline",      { fg = c.string, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.string, bg = "NONE" })

vim.api.nvim_set_hl(0, "NoiceConfirm",              { fg = c.var,    bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder",        { fg = c.utype,  bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm",        { bg = "#2a2d40", fg = c.var })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.const,  fg = c.fg,  bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",      { fg = "#5abf5a", bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchFuzzy", { fg = "#5abf5a", bold = true })
vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",     { fg = "#99b77b", bold = true })
vim.api.nvim_set_hl(0, "LineNr",            { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrAbove",       { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrBelow",       { fg = c.grey })
vim.api.nvim_set_hl(0, "CursorLineNr",      { fg = c.var, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",        { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",           { fg = c.comment })
vim.api.nvim_set_hl(0, "MatchParen",        { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",   { fg = "#8b4040" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",    { fg = "#9a7040" })
vim.api.nvim_set_hl(0, "DiagnosticHint",    { fg = "#5a8a58" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",    { fg = "#4a7888" })

for _, level in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
  for _, part in ipairs({ "Border", "Title", "Icon" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = c.utype, bg = "NONE" })
  end
  for _, part in ipairs({ "", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = c.string, bg = "NONE" })
  end
  local up = level:upper()
  vim.api.nvim_set_hl(0, "Notify" .. up .. "Border", { fg = c.utype,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "Notify" .. up .. "Title",  { fg = c.utype,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "Notify" .. up .. "Icon",   { fg = c.utype,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "Notify" .. up .. "Body",   { fg = c.string, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. level, { fg = c.utype, bg = "NONE" })
end

for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
  vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = "#9a7040", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = "#8b4040", bg = "NONE" })
end
for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
  vim.api.nvim_set_hl(0, "NotifyWARN"  .. part, { fg = "#9a7040", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NotifyERROR" .. part, { fg = "#8b4040", bg = "NONE" })
end
vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",  { fg = "#9a7040", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatLevelError", { fg = "#8b4040", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceMini",             { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.comment })
vim.api.nvim_set_hl(0, "Directory",             { fg = c.var })
vim.api.nvim_set_hl(0, "SnacksPickerFile",       { fg = c.fg })
vim.api.nvim_set_hl(0, "MiniIconsAzure",         { fg = c.special })
vim.api.nvim_set_hl(0, "FloatTitle",             { fg = c.utype })
vim.api.nvim_set_hl(0, "SnacksTitle",            { fg = c.utype })
vim.api.nvim_set_hl(0, "SnacksPickerToggle",     { fg = c.fg, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt",     { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerRule",       { fg = c.bg })
vim.api.nvim_set_hl(0, "SnacksPickerMatch",      { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "SnacksPickerTotals",     { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerDir",        { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",     { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",      { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksInputNormal", { fg = c.var,   bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputTitle",  { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputIcon",   { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksIndent",      { fg = c.dim })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.var })
vim.api.nvim_set_hl(0, "WinBar",            { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",          { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",              { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",          { fg = c.var })
vim.api.nvim_set_hl(0, "WhichKeyDesc",      { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyGroup",     { fg = c.keyword })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = c.grey })
vim.api.nvim_set_hl(0, "WhichKeyValue",     { fg = c.type })

-- ── Dashboard ─────────────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" },               { fg = c.utype })
set_hl({ "DashboardIcon",   "SnacksDashboardIcon" },                 { fg = c.const })
set_hl({ "DashboardKey",    "SnacksDashboardKey", "DashboardShortCut" }, { fg = c.var })
set_hl({ "DashboardDesc",   "SnacksDashboardDesc", "DashboardCenter" }, { fg = c.fg })
set_hl({ "SnacksDashboardFile", "SnacksDashboardDir" },              { fg = c.type })
set_hl({ "SnacksDashboardSpecial" },                                 { fg = c.keyword })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" },               { fg = c.string })

-- ── Diff & git signs ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1a2820", fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1e2030", fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#281820", fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.sel,    fg = c.fg })

local gs = {
  Add = c.var, Change = c.const, Delete = "#8b4040",
  Untracked = c.grey, Topdelete = "#8b4040", Changedelete = c.string,
}
for kind, color in pairs(gs) do
  for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
    vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
  end
end

-- ── Phantom / whitespace chars ────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText",    { fg = c.dim })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.dim })
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#272a3a" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.grey })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#282b40", fg = "NONE" })

-- ── Diagnostics ───────────────────────────────────────────────────────────

local diag = {
  Error = "#8b4040", Warn = "#9a7040", Hint = "#5a8a58",
  Info = "#4a7888", Unnecessary = c.comment,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = c.type, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = c.fg,   bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.type, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",       { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter",  { fg = c.grey })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",   { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",   { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",    { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.var })

-- ── Flash.nvim ────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch",    { bg = "#2a3040", fg = c.fg })
vim.api.nvim_set_hl(0, "FlashCurrent",  { bg = c.keyword, fg = c.fg })
vim.api.nvim_set_hl(0, "FlashLabel",    { bg = c.var, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.grey })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal",       { bg = "NONE", fg = c.fg })
vim.api.nvim_set_hl(0, "LazyButton",       { bg = "#2a2d40", fg = c.type })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = "#333650", fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH1",           { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH2",           { fg = c.type, bold = true })
vim.api.nvim_set_hl(0, "LazySpecial",      { fg = c.var })
vim.api.nvim_set_hl(0, "LazyCommit",       { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType",   { fg = c.special })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.var })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal",        { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual",    { bg = "#8aad8a",  fg = "#222335" })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#2d3d44",  fg = c.type })
vim.api.nvim_set_hl(0, "Search",    { bg = "#2a3840",  fg = c.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.keyword,  fg = c.fg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.var,      fg = c.bg })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.sel,     fg = c.fg })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.sel,     fg = c.fg })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = "#2a2d40", fg = c.fg })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.sel,     fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "Folded",                      { fg = c.grey,    bg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = "#2a3840", fg = c.fg })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = "#2a3840", fg = c.fg })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = "#2a3840", fg = c.fg })

-- ── Markdown ──────────────────────────────────────────────────────────────

-- H1 — sage green, paling menonjol
set_hl({
  "@markup.heading.1", "@markup.heading.1.markdown", "markdownH1",
}, { fg = c.utype, bold = true, bg = "NONE" })

-- H2 — forest green
set_hl({
  "@markup.heading.2", "@markup.heading.2.markdown", "markdownH2",
}, { fg = c.module, bold = true, bg = "NONE" })

-- H3 — mid sage
set_hl({
  "@markup.heading.3", "@markup.heading.3.markdown", "markdownH3",
}, { fg = c.special, bold = true, bg = "NONE" })

-- H4 — warm cream
set_hl({
  "@markup.heading.4", "@markup.heading.4.markdown", "markdownH4",
}, { fg = c.var, bold = true, bg = "NONE" })

-- H5/H6 + fallback — warm grey muted
set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.5", "@markup.heading.5.markdown", "markdownH5",
  "@markup.heading.6", "@markup.heading.6.markdown", "markdownH6",
}, { fg = c.type, bold = true, bg = "NONE" })

-- Heading markers — hampir tak terlihat, tidak mengalihkan perhatian
set_hl({
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
  "@punctuation.special.markdown",
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
}, { fg = c.grey, bold = false, bg = "NONE" })

-- Inline code & code block — cyan biru
set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = c.const, bg = "NONE" })

-- Bold — coklat tanah
set_hl({
  "@markup.strong", "@markup.strong.markdown_inline", "markdownBold",
}, { fg = c.string, bold = true })

-- Italic — warm cream
set_hl({
  "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic",
}, { fg = c.var, italic = true })

-- Link text — cyan, kontras jelas
set_hl({
  "@markup.link", "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = c.const, bg = "NONE", underline = false })

-- URL — coklat tanah
set_hl({
  "@markup.link.url", "@markup.link.url.markdown_inline", "markdownUrl",
}, { fg = c.string, bg = "NONE", underline = false })

-- Link delimiters — subtle
set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.grey })

-- List markers — forest green, jelas terbaca
set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = c.module })

-- Blockquote — coklat hangat italic, terasa organik
set_hl({
  "@markup.quote", "@markup.quote.markdown", "markdownBlockquote",
}, { fg = c.string, italic = true })

-- Horizontal rule — subtle border
set_hl({ "markdownRule" }, { fg = c.border })

-- ── Plugin re-application + statusline registration ────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local accent = c.utype  -- #99b77b

local function reapply()
  vim.api.nvim_set_hl(0, "SnacksPickerRule",        { fg = "#010101" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",       { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",      { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",         { fg = "#383838" })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",      { fg = "#FFFFFF", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = "#010101", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",      { fg = "#010101", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",       { fg = "#FFFFFF", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = accent,    bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = "#FFFFFF", bg = "NONE" })
  end
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = accent,    bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",          { fg = "#FFFFFF", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",    { fg = "#3a3a3a", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",  { fg = "#FFFFFF", bg = "#1e1e1e", bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",     { fg = accent,    bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceCmdline",            { fg = "#FFFFFF", bg = "NONE" })
  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = accent,   bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier"       .. lvl, { fg = "#FFFFFF", bg = nb })
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = accent,   bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = "#e5c07b", bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = "#e06c75", bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = "#6a6a6a", bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = "#e5c07b", bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = "#e06c75", bg = nb })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",       { fg = accent, bold = true })
end

local b_bg, b_fg = "#2a2d40", "#7a8078"
local c_bg, c_fg = "NONE", "#505060"
local function mode_section(a_bg, a_fg)
  return {
    a = { bg = a_bg, fg = a_fg, gui = "bold" },
    b = { bg = b_bg, fg = b_fg },
    c = { bg = c_bg, fg = c_fg },
  }
end

require("config.theme_registry").register("earth", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section("#afaba0", "#222335"),
      insert   = mode_section("#328c45", "#FFFFFF"),
      visual   = mode_section("#8aad8a", "#222335"),
      replace  = mode_section("#5bc8e8", "#f3d6b8"),
      command  = mode_section("#FFFFFF", "#35484e"),
      inactive = {
        a = { bg = c_bg, fg = "#404558", gui = "bold" },
        b = { bg = c_bg, fg = "#404558" },
        c = { bg = c_bg, fg = "#404558" },
      },
    },
    c_bg         = c_bg,
    filename     = "#f3d6b8",
    lazy_updates = "#b89868",
    diff = { added = "#f3d6b8", modified = "#328c45", removed = "#8b4040" },
  },
})
