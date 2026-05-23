vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "mono"

local function set_hl(groups, opts)
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

local c = {
  black  = "#010101",
  white  = "#FFFFFF",
  grey   = "#505050",
  border = "#E0E0E0",
}

-- Syntax: 7-step B&W scale
-- #505050 (keywords) → #6d6d6d → #8a8a8a → #a7a7a7 → #c4c4c4 → #cecece → #FFFFFF (functions/vars)

set_hl({
  "Keyword", "Statement", "Conditional", "Repeat", "Include",
  "Structure", "Define", "PreProc", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
}, { fg = "#505050", italic = false })

set_hl({ "@module", "@namespace", "@lsp.type.namespace" }, { fg = "#8a8a8a" })

set_hl({
  "Constant", "@constant.builtin", "@variable.builtin", "@constant",
  "@lsp.typemod.variable.readonly", "@lsp.typemod.variable.defaultLibrary",
}, { fg = "#505050" })

set_hl({ "String", "Character" }, { fg = "#6d6d6d" })

set_hl({
  "Type", "@type.builtin", "@lsp.type.builtinType",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = "#cecece", italic = true })

set_hl({
  "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
}, { fg = "#cecece" })

set_hl({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = "#c4c4c4" })
set_hl({ "@function.builtin" }, { fg = "#c4c4c4" })

-- SQL/go.mod conditional/operator/modifier tokens sit between @keyword and @type.builtin
set_hl({
  "Special", "SpecialChar",
  "@keyword.conditional", "@keyword.repeat",
  "@keyword.operator", "@keyword.modifier", "@keyword.directive",
  "@attribute", "@boolean",
  "@string.special", "@string.special.url",
}, { fg = "#a7a7a7" })

set_hl({
  "Function", "@function", "@function.call", "@method", "@constructor",
  "Title", "@lsp.typemod.namespace.declaration",
}, { fg = "#FFFFFF", bold = false })

set_hl({
  "Identifier", "@variable", "@variable.parameter",
  "@field", "@property", "@variable.member",
  "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter",
  "@lsp.typemod.variable.definition", "TSVariable", "TSVariableBuiltin",
}, { fg = "#FFFFFF" })

set_hl({ "@punctuation.bracket" }, { fg = "#FFFFFF" })

-- UI: transparent backgrounds throughout
set_hl({
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
  "TelescopeNormal",
  "Floaterm", "NormalFloat",
  "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
}, { bg = "NONE" })

set_hl({
  "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator",
}, { fg = "NONE", bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = c.border })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = c.black })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = c.black, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = c.black, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",  { fg = c.black, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",   { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon",         { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

vim.api.nvim_set_hl(0, "MsgArea",           { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdline",      { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.white, bg = "NONE" })

-- Confirm dialog ("Save? Yes No?")
vim.api.nvim_set_hl(0, "NoiceConfirm",              { fg = c.white,   bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder",        { fg = "#505050", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm",        { bg = "#2a2a2a", fg = c.white })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = "#c4c4c4", fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#c94f4f" })
vim.api.nvim_set_hl(0, "LineNr",            { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrAbove",       { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrBelow",       { fg = c.grey })
vim.api.nvim_set_hl(0, "CursorLineNr",      { fg = "#e8e8e8", bold = true })
vim.api.nvim_set_hl(0, "CursorLine",        { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",           { fg = "#383838" })
vim.api.nvim_set_hl(0, "MatchParen",        { fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",   { fg = "#8b3a3a" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",    { fg = "#c4a35a" })
vim.api.nvim_set_hl(0, "DiagnosticHint",    { fg = "#6b8e6b" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",    { fg = "#6a5454" })

for _, level in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { fg = c.white, bg = "NONE" })
  end
  local up = level:upper()
  for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
    vim.api.nvim_set_hl(0, "Notify" .. up .. part, { fg = c.white, bg = "NONE" })
  end
  vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. level, { fg = c.white, bg = "NONE" })
end

-- Warn: kuning; Error: merah — sesuai request user
for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
  vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = "#c4a35a", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = "#8b3a3a", bg = "NONE" })
end
for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
  vim.api.nvim_set_hl(0, "NotifyWARN"  .. part, { fg = "#c4a35a", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NotifyERROR" .. part, { fg = "#8b3a3a", bg = "NONE" })
end
vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",  { fg = "#c4a35a", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatLevelError",  { fg = "#8b3a3a", bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceMini",              { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary",  { fg = "#6a5454" })
vim.api.nvim_set_hl(0, "Directory",              { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "SnacksPickerFile",        { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "MiniIconsAzure",          { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "FloatTitle",              { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksTitle",             { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerToggle",      { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt",      { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerRule",        { fg = "#010101" })
vim.api.nvim_set_hl(0, "SnacksPickerMatch",       { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerTotals",      { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerDir",         { fg = "#383838" })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",  { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksIndent",            { fg = "#3d3d3d" })
vim.api.nvim_set_hl(0, "SnacksIndentScope",       { fg = "#e8e8e8" })
vim.api.nvim_set_hl(0, "WinBar",                  { fg = "#8a8a8a", bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",                { fg = "#8a8a8a", bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                    { fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",                { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyDesc",            { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyGroup",           { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeySeparator",       { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyValue",           { fg = c.white })

-- Dashboard
set_hl({
  "DashboardHeader", "DashboardCenter", "DashboardFooter",
  "DashboardShortCut", "DashboardIcon", "DashboardKey", "DashboardDesc",
  "SnacksDashboardHeader", "SnacksDashboardIcon", "SnacksDashboardKey",
  "SnacksDashboardDesc", "SnacksDashboardDir", "SnacksDashboardFile",
  "SnacksDashboardFooter", "SnacksDashboardSpecial",
}, { fg = c.white })

-- Diff & git signs
vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1c1c1c", fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1c1c1c", fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#1c1c1c", fg = "#505050" })
vim.api.nvim_set_hl(0, "DiffText",   { bg = "#2a2a2a", fg = "#FFFFFF" })

local gs = {
  Add = "#c4c4c4", Change = "#8a8a8a", Delete = "#505050",
  Untracked = "#3a3a3a", Topdelete = "#505050", Changedelete = "#6d6d6d",
}
for kind, color in pairs(gs) do
  for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
    vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
  end
end

-- Phantom / whitespace chars
vim.api.nvim_set_hl(0, "NonText",    { fg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#010101" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1a1a1a", fg = "NONE" })

-- Diagnostics: virtual text, floating window, sign column
local diag = {
  Error = "#8b3a3a", Warn = "#c4a35a", Hint = "#6b8e6b",
  Info = "#6a5454", Unnecessary = "#6a5454",
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- Completion menu
vim.api.nvim_set_hl(0, "PmenuKind",     { fg = "#a7a7a7", bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = "#FFFFFF", bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = "#6d6d6d", bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = "#a7a7a7", bg = "NONE" })

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = "#6d6d6d" })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = c.white })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = c.white })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = c.white })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.white })

-- Flash.nvim
vim.api.nvim_set_hl(0, "FlashMatch",    { bg = "#2a2a2a", fg = c.white })
vim.api.nvim_set_hl(0, "FlashCurrent",  { bg = "#c4c4c4", fg = c.black })
vim.api.nvim_set_hl(0, "FlashLabel",    { bg = "#FFFFFF", fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#383838" })

-- Lazy.nvim
vim.api.nvim_set_hl(0, "LazyNormal",       { bg = "NONE", fg = c.white })
vim.api.nvim_set_hl(0, "LazyButton",       { bg = "#1c1c1c", fg = "#a7a7a7" })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = "#2a2a2a", fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LazyH1",           { fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LazyH2",           { fg = "#a7a7a7", bold = true })
vim.api.nvim_set_hl(0, "LazySpecial",      { fg = "#8a8a8a" })
vim.api.nvim_set_hl(0, "LazyCommit",       { fg = "#6d6d6d" })
vim.api.nvim_set_hl(0, "LazyCommitType",   { fg = "#8a8a8a" })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = "#8a8a8a" })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.white })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = "#505050" })
vim.api.nvim_set_hl(0, "LazyLocal",        { fg = "#6d6d6d" })

-- Visual selection & search
vim.api.nvim_set_hl(0, "Visual",    { bg = "#303030", fg = c.white })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#202020", fg = "#aaaaaa" })
vim.api.nvim_set_hl(0, "Search",    { bg = "#2a2a2a", fg = c.white })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#c4c4c4", fg = c.black })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#FFFFFF",  fg = c.black })

vim.api.nvim_set_hl(0, "Substitute",                   { bg = "#303030", fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                     { bg = "#303030", fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                 { bg = "#252525", fg = c.white })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter",  { bg = "#303030", fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "Folded",                       { fg = "#6d6d6d", bg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceText",             { bg = "#2a2a2a", fg = c.white })
vim.api.nvim_set_hl(0, "LspReferenceRead",             { bg = "#2a2a2a", fg = c.white })
vim.api.nvim_set_hl(0, "LspReferenceWrite",            { bg = "#2a2a2a", fg = c.white })

-- Markdown: same 7-step B&W scale
set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
  "@markup.heading.1.markdown", "@markup.heading.2.markdown",
  "@markup.heading.3.markdown", "@markup.heading.4.markdown",
  "@markup.heading.5.markdown", "@markup.heading.6.markdown",
  "markdownH1", "markdownH2", "markdownH3",
  "markdownH4", "markdownH5", "markdownH6",
}, { fg = "#FFFFFF", bold = true, bg = "NONE" })

set_hl({
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
  "@punctuation.special.markdown",
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
}, { fg = "#a7a7a7", bold = false, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = "#6d6d6d", bg = "NONE" })

set_hl({
  "@markup.strong", "@markup.strong.markdown_inline", "markdownBold",
}, { fg = "#FFFFFF", bold = true })

set_hl({
  "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic",
}, { fg = "#FFFFFF", italic = true })

set_hl({
  "@markup.link", "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = "#c4c4c4", bg = "NONE", underline = false })

set_hl({
  "@markup.link.url", "@markup.link.url.markdown_inline", "markdownUrl",
}, { fg = "#8a8a8a", bg = "NONE", underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = "#a7a7a7" })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = "#8a8a8a" })

set_hl({
  "@markup.quote", "@markup.quote.markdown", "markdownBlockquote",
}, { fg = "#6d6d6d", italic = true })

set_hl({ "markdownRule" }, { fg = "#8a8a8a" })
