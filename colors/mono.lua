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

-- ── Palette ──────────────────────────────────────────────────────────────────

local c = {
  -- Anchors
  black  = "#010101",
  white  = "#FFFFFF",

  -- Syntax scale: 5 named steps between black and white
  --   modules → keywords/types → constants/strings → operators → user-types → white
  s2 = "#6d6d6d",   -- keywords, builtin types, folded
  s3 = "#8a8a8a",   -- constants, strings, numbers
  s4 = "#aaaaaa",   -- operators, punctuation, markdown markers
  s5 = "#c4c4c4",   -- user-defined types (@type, struct, interface)

  -- Surfaces (near-black backgrounds, ordered light → dark within each band)
  bg0 = "#101010",  -- [c_bg] lualine c, win separators, picker borders
  bg1 = "#1a1a1a",  -- color column
  bg2 = "#1c1c1c",  -- diff hunk bg, lazy button bg
  bg3 = "#1e1e1e",  -- comment fg, noice popupmenu selected bg
  bg4 = "#202020",  -- VisualNOS bg
  bg5 = "#252525",  -- quickfix line bg
  bg6 = "#2a2a2a",  -- [b_bg] lualine b, search, diff text, LspReference
  bg7 = "#303030",  -- substitute, wildmenu, LspSignatureActiveParameter
  bg8 = "#383838",  -- flash backdrop, snacks picker dir label
  bg9 = "#404040",  -- visual selection, lualine visual mode a_bg

  -- UI greys
  dim   = "#3a3a3a",  -- subtle borders (WhichKey, noice popup)
  grey  = "#505050",  -- line numbers, picker borders, git delete, darkest syntax
  muted = "#4a4a4a",  -- lualine inactive fg
  mid   = "#6a6a6a",  -- lualine c fg, snacks notifier info titles

  -- Bright accents
  scope  = "#e8e8e8",  -- CursorLineNr, SnacksIndentScope
  border = "#E0E0E0",  -- FloatermBorder

  -- Diagnostics
  d_error = "#8b3a3a",
  d_warn  = "#c4a35a",
  d_hint  = "#6b8e6b",
  d_info  = "#6a5454",

  -- Notification severity accents (warm tones for warn/error titles)
  n_warn  = "#e5c07b",
  n_error = "#e06c75",
}

-- lualine section b bg.
local b_bg = c.bg6
-- lualine section c bg, also reused for win separators and snacks picker borders.
local c_bg = c.bg0

-- ── Syntax ───────────────────────────────────────────────────────────────────

set_hl({
  "Keyword", "Statement", "Conditional", "Repeat", "Include",
  "Structure", "Define", "PreProc", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
}, { fg = c.s2, italic = false })

set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.white })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})  -- let treesitter handle keywords so @keyword.return.go can fire

set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = c.grey })

set_hl({
  "Constant", "@constant.builtin", "@variable.builtin", "@constant",
  "@lsp.typemod.variable.readonly", "@lsp.typemod.variable.defaultLibrary",
}, { fg = c.s3 })

set_hl({ "String", "Character", "@string", "@string.escape", "@character" }, { fg = c.s3 })

set_hl({
  "Type", "@type.builtin", "@lsp.type.builtinType",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = c.s2, italic = true })

set_hl({
  "@type", "@type.definition", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
}, { fg = c.s5 })

set_hl({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.s4 })
set_hl({ "@function.builtin" }, { fg = c.white })

set_hl({ "@keyword.repeat" }, { fg = c.s2 })
set_hl({ "@keyword.conditional" }, { fg = c.s4 })

set_hl({
  "Special", "SpecialChar",
  "@keyword.operator", "@keyword.modifier", "@keyword.directive",
  "@attribute",
  "@string.special", "@string.special.url",
}, { fg = c.s4 })

set_hl({ "@boolean", "Boolean", "@number", "@number.float", "@float", "Number", "Float" }, { fg = c.s3 })

set_hl({
  "Function", "@function", "@function.call", "@method", "@constructor",
  "Title", "@lsp.typemod.namespace.declaration",
}, { fg = c.white, bold = false })

set_hl({
  "Identifier", "@variable", "@variable.parameter",
  "@field", "@property", "@variable.member",
  "@lsp.type.property", "@lsp.type.variable", "@lsp.type.parameter",
  "@lsp.typemod.variable.definition", "TSVariable", "TSVariableBuiltin",
}, { fg = c.white })

set_hl({ "@punctuation.bracket", "@string.delimiter" }, { fg = c.white })

-- ── UI: transparent backgrounds ──────────────────────────────────────────────

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = c_bg, bg = "NONE" })

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

vim.api.nvim_set_hl(0, "NoiceConfirm",              { fg = c.white,  bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder",        { fg = c.grey,   bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm",        { bg = c.bg6,    fg = c.white })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.s5,     fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",        { fg = c.s3 })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = c.grey })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = c.scope, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = c.bg3 })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = c.d_error })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = c.d_warn })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = c.d_hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = c.d_info })

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

for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
  vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = c.d_warn,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = c.d_error, bg = "NONE" })
end
for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
  vim.api.nvim_set_hl(0, "NotifyWARN"  .. part, { fg = c.d_warn,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "NotifyERROR" .. part, { fg = c.d_error, bg = "NONE" })
end
vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",  { fg = c.d_warn,  bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatLevelError", { fg = c.d_error, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceMini",             { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.d_info })
vim.api.nvim_set_hl(0, "Directory",             { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerFile",       { fg = c.white })
vim.api.nvim_set_hl(0, "MiniIconsAzure",         { fg = c.white })
vim.api.nvim_set_hl(0, "FloatTitle",             { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksTitle",            { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerToggle",     { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt",     { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerRule",       { fg = c.black })
vim.api.nvim_set_hl(0, "SnacksPickerMatch",      { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerTotals",     { fg = c.white })
vim.api.nvim_set_hl(0, "SnacksPickerDir",        { fg = c.bg8 })
vim.api.nvim_set_hl(0, "SnacksPickerTree",       { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerBorder",     { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",{ fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",{ fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksInputNormal",      { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputBorder",      { fg = c.grey,  bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputTitle",       { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputIcon",        { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksIndent",           { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksIndentScope",      { fg = c.scope })
vim.api.nvim_set_hl(0, "WinBar",                 { fg = c.s3, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",               { fg = c.s3, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                   { fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",               { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyDesc",           { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyGroup",          { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeySeparator",      { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyValue",          { fg = c.white })
vim.api.nvim_set_hl(0, "WhichKeyBorder",         { fg = c.dim, bg = "NONE" })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({
  "DashboardHeader", "DashboardCenter", "DashboardFooter",
  "DashboardShortCut", "DashboardIcon", "DashboardKey", "DashboardDesc",
  "SnacksDashboardHeader", "SnacksDashboardIcon", "SnacksDashboardKey",
  "SnacksDashboardDesc", "SnacksDashboardDir", "SnacksDashboardFile",
  "SnacksDashboardFooter", "SnacksDashboardSpecial",
}, { fg = c.white })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.bg6, fg = c.white })

local gs = {
  Add = c.s5, Change = c.s3, Delete = c.grey,
  Untracked = c.dim, Topdelete = c.grey, Changedelete = c.s2,
}
for kind, color in pairs(gs) do
  for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
    vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
  end
end

-- ── Phantom / whitespace ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText",    { fg = c.bg6 })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.bg6 })
vim.api.nvim_set_hl(0, "Whitespace", { fg = c.bg2 })
vim.api.nvim_set_hl(0, "EndOfBuffer",{ fg = c.grey })
vim.api.nvim_set_hl(0, "ColorColumn",{ bg = c.bg1, fg = "NONE" })

-- ── Diagnostics: virtual text, float, sign column ─────────────────────────────

local diag = {
  Error = c.d_error, Warn = c.d_warn, Hint = c.d_hint,
  Info = c.d_info, Unnecessary = c.d_info,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = c.s4, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = c.white, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = c.s2, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.s4, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = c.grey })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = c.white })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = c.white })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = c.white })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret",{ fg = c.white })

-- ── Flash.nvim ────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch",    { bg = c.bg6, fg = c.white })
vim.api.nvim_set_hl(0, "FlashCurrent",  { bg = c.s5,  fg = c.black })
vim.api.nvim_set_hl(0, "FlashLabel",    { bg = c.white, fg = c.black, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.bg8 })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal",       { bg = "NONE",  fg = c.white })
vim.api.nvim_set_hl(0, "LazyButton",       { bg = c.bg2,   fg = c.s4 })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.bg6,   fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LazyH1",           { fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LazyH2",           { fg = c.s4,    bold = true })
vim.api.nvim_set_hl(0, "LazySpecial",      { fg = c.s3 })
vim.api.nvim_set_hl(0, "LazyCommit",       { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType",   { fg = c.s3 })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.s3 })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.white })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal",        { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual",    { bg = c.bg9, fg = c.white })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = c.s4 })
vim.api.nvim_set_hl(0, "Search",    { bg = c.bg6, fg = c.white })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.s5,  fg = c.black })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.white, fg = c.black })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.bg5, fg = c.white })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "Folded",                      { fg = c.s2,  bg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.bg6, fg = c.white })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.bg6, fg = c.white })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.bg6, fg = c.white })

-- ── Markdown ──────────────────────────────────────────────────────────────────

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
  "@markup.heading.1.markdown", "@markup.heading.2.markdown",
  "@markup.heading.3.markdown", "@markup.heading.4.markdown",
  "@markup.heading.5.markdown", "@markup.heading.6.markdown",
  "markdownH1", "markdownH2", "markdownH3",
  "markdownH4", "markdownH5", "markdownH6",
}, { fg = c.white, bold = true, bg = "NONE" })

set_hl({
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
  "@punctuation.special.markdown",
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
}, { fg = c.s4, bold = false, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = c.s2, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = c.white, bold = true })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = c.white, italic = true })

set_hl({
  "@markup.link", "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = c.s5, bg = "NONE", underline = false })

set_hl({
  "@markup.link.url", "@markup.link.url.markdown_inline", "markdownUrl",
}, { fg = c.s3, bg = "NONE", underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.s4 })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = c.s3 })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = c.s2, italic = true })

set_hl({ "markdownRule" }, { fg = c.s3 })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
  vim.api.nvim_set_hl(0, "SnacksPickerRule",        { fg = c.black })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",       { fg = c.white })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",      { fg = c.white })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",         { fg = c.bg8 })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",      { fg = c.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.grey,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",      { fg = c.grey,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksWinSeparator",      { fg = c_bg,    bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",       { fg = c.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = c.dim,   bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.white, bg = "NONE" })
  end
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = c.dim,   bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",          { fg = c.white, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",    { fg = c.dim,   bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",  { fg = c.white, bg = c.bg3, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",     { fg = c.white, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceCmdline",            { fg = c.white, bg = "NONE" })
  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = c.dim,   bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier"       .. lvl, { fg = c.white, bg = nb })
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = c.mid,     bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = c.n_warn,  bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = c.n_error, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = c.mid,     bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = c.n_warn,  bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = c.n_error, bg = nb })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",       { fg = c.s3 })
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local b_fg = c.white
local c_fg = c.mid
local function mode_section(a_bg, a_fg)
  return {
    a = { bg = a_bg, fg = a_fg, gui = "bold" },
    b = { bg = b_bg, fg = b_fg },
    c = { bg = c_bg, fg = c_fg },
  }
end

require("config.theme_registry").register("mono", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section(c.white, c_bg),
      insert   = mode_section(c_bg, c.white),
      visual   = mode_section(c.bg9, c.white),
      replace  = mode_section(c_bg, c.white),
      command  = mode_section(c.white, c_bg),
      inactive = {
        a = { bg = c_bg, fg = c.muted, gui = "bold" },
        b = { bg = c_bg, fg = c.muted },
        c = { bg = c_bg, fg = c.muted },
      },
    },
    c_bg         = c_bg,
    filename     = c.white,
    directory    = c.mid,
    lazy_updates = c.white,
    diff = { added = c.white, modified = c.white, removed = c.white },
  },
})
