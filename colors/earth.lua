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

-- ── Palette ──────────────────────────────────────────────────────────────────

local c = {
  -- Editor base
  bg      = "#0c0c13",  -- near-black navy
  fg      = "#FFFFFF",  -- default text, operators

  -- Syntax: semantic roles
  keyword = "#2e553a",  -- keywords (dark forest green)
  module  = "#328c45",  -- namespaces, structural green
  special = "#5a7f52",  -- special keywords, attributes (mid green)
  string  = "#785e3b",  -- string literals (warm brown)
  const   = "#69bdd6",  -- constants, numbers (sky cyan)
  type    = "#afaba0",  -- builtin types (warm grey)
  utype   = "#99b77b",  -- user-defined types: struct, interface, enum (sage)
  var     = "#e9e0cf",  -- variables, parameters (warm cream)

  -- UI chrome
  comment = "#3c3f55",  -- comments (dark ink, barely above bg)
  grey    = "#585860",  -- line numbers, muted chrome
  dim     = "#2d3048",  -- indent guides, non-text
  border  = "#404558",  -- borders, inactive lualine fg
  sel     = "#35484e",  -- selections, lualine command fg
  indent  = "#1e3828",  -- SnacksIndent (dark forest, just above bg)

  -- Tinted dark surfaces (backgrounds for diff, search, UI panels)
  surf_green = "#1a2820",  -- DiffAdd, FlashMatch bg (dark forest tint)
  surf_blue  = "#1e2030",  -- DiffChange bg (dark navy tint)
  surf_red   = "#281820",  -- DiffDelete bg (dark wine tint)
  surf_earth = "#241c0e",  -- Search bg (dark sepia)
  surf_ghost = "#272a3a",  -- Whitespace (very dark blue-grey)
  surf_col   = "#282b40",  -- ColorColumn bg
  surf_navy  = "#2a2d40",  -- [b_bg] lualine b, LazyButton (dark navy panel)
  surf_teal  = "#2a3840",  -- LspReference bg (dark teal)
  surf_mid   = "#2d3d44",  -- VisualNOS bg (dark teal-grey)
  surf_lift  = "#333650",  -- LazyButtonActive bg (lifted navy)

  -- Lualine palette
  bar    = "#181826",  -- [c_bg] lualine section c bg (dark step above editor bg)
  deep   = "#222335",  -- lualine a fg for normal/visual (dark navy text)
  sage   = "#8aad8a",  -- lualine visual a_bg, Visual selection (soft sage)
  cyan_l = "#5bc8e8",  -- lualine replace a_bg (bright cyan)
  cream  = "#f3d6b8",  -- lualine filename, replace a_fg (warm parchment)
  gold   = "#b89868",  -- lualine lazy_updates (golden brown)
  muted  = "#7a8078",  -- lualine b fg (sage-grey)
  mid    = "#505060",  -- lualine c fg, inactive fg, directory (muted blue-grey)

  -- Diagnostics
  d_error = "#8b4040",
  d_warn  = "#9a7040",
  d_hint  = "#5a8a58",
  d_info  = "#4a7888",

  -- Notification severity accents
  n_warn  = "#e5c07b",
  n_error = "#e06c75",
  n_info  = "#6a6a6a",

  -- Brights
  bright_green = "#5abf5a",  -- BlinkCmpLabelMatch
}

-- lualine section b bg.
local b_bg = c.surf_navy
-- lualine section c bg, also reused for inactive mode sections.
local c_bg = c.bar

-- ── Syntax ───────────────────────────────────────────────────────────────────

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

set_hl({ "Operator", "@operator", "Delimiter", "@punctuation.delimiter" }, { fg = c.fg })
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
set_hl({ "@string.delimiter" }, { fg = c.fg })

-- ── UI: transparent / bg-matched backgrounds ──────────────────────────────────

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
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",  { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",   { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon",         { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

vim.api.nvim_set_hl(0, "MsgArea",           { fg = c.string, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdline",      { fg = c.string, bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.string, bg = "NONE" })

vim.api.nvim_set_hl(0, "NoiceConfirm",              { fg = c.var,     bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder",        { fg = c.utype,   bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm",        { bg = c.surf_navy, fg = c.var })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.const,   fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",        { fg = c.bright_green, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchFuzzy",   { fg = c.bright_green, bold = true })
vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",       { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = c.grey })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = c.grey })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = c.var, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = c.comment })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = c.d_error })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = c.d_warn })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = c.d_hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = c.d_info })

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
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",      { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",       { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksInputNormal", { fg = c.var,   bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputTitle",  { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksInputIcon",   { fg = c.utype, bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksIndent",      { fg = c.indent })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.utype })
vim.api.nvim_set_hl(0, "WinBar",            { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",          { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",              { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",          { fg = c.var })
vim.api.nvim_set_hl(0, "WhichKeyDesc",      { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyGroup",     { fg = c.keyword })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = c.grey })
vim.api.nvim_set_hl(0, "WhichKeyValue",     { fg = c.type })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" },                  { fg = c.module })
set_hl({ "DashboardIcon",   "SnacksDashboardIcon" },                    { fg = c.const })
set_hl({ "DashboardKey",    "SnacksDashboardKey", "DashboardShortCut" },{ fg = c.var })
set_hl({ "DashboardDesc",   "SnacksDashboardDesc", "DashboardCenter" }, { fg = c.fg })
set_hl({ "SnacksDashboardFile", "SnacksDashboardDir" },                 { fg = c.type })
set_hl({ "SnacksDashboardSpecial" },                                    { fg = c.keyword })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" },                  { fg = c.string })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.surf_green, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.surf_blue,  fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.surf_red,   fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.sel,        fg = c.fg })

local gs = {
  Add = c.var, Change = c.const, Delete = c.d_error,
  Untracked = c.grey, Topdelete = c.d_error, Changedelete = c.string,
}
for kind, color in pairs(gs) do
  for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
    vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
  end
end

-- ── Phantom / whitespace ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText",    { fg = c.dim })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.dim })
vim.api.nvim_set_hl(0, "Whitespace", { fg = c.surf_ghost })
vim.api.nvim_set_hl(0, "EndOfBuffer",{ fg = c.grey })
vim.api.nvim_set_hl(0, "ColorColumn",{ bg = c.surf_col, fg = "NONE" })

-- ── Diagnostics: virtual text, float, sign column ─────────────────────────────

local diag = {
  Error = c.d_error, Warn = c.d_warn, Hint = c.d_hint,
  Info = c.d_info, Unnecessary = c.comment,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = c.type, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = c.fg,   bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.type, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",       { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter",  { fg = c.grey })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",   { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",   { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",    { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.var })

-- ── Flash.nvim ────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch",    { bg = c.surf_green, fg = c.fg })
vim.api.nvim_set_hl(0, "FlashCurrent",  { bg = c.keyword,    fg = c.fg })
vim.api.nvim_set_hl(0, "FlashLabel",    { bg = c.var,        fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.comment })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal",       { bg = "NONE",       fg = c.fg })
vim.api.nvim_set_hl(0, "LazyButton",       { bg = c.surf_navy,  fg = c.type })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.surf_lift,  fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH1",           { fg = c.fg,   bold = true })
vim.api.nvim_set_hl(0, "LazyH2",           { fg = c.type, bold = true })
vim.api.nvim_set_hl(0, "LazySpecial",      { fg = c.var })
vim.api.nvim_set_hl(0, "LazyCommit",       { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType",   { fg = c.special })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.var })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal",        { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual",    { bg = c.sage,       fg = c.deep })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.surf_mid,   fg = c.type })
vim.api.nvim_set_hl(0, "Search",    { bg = c.surf_earth, fg = c.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.keyword,    fg = c.fg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.var,        fg = c.bg })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.sel,       fg = c.fg })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.sel,       fg = c.fg })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.surf_navy, fg = c.fg })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.sel,       fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "Folded",                      { fg = c.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.surf_teal, fg = c.fg })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.surf_teal, fg = c.fg })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.surf_teal, fg = c.fg })

-- ── Markdown ──────────────────────────────────────────────────────────────────

set_hl({
  "@markup.heading.1", "@markup.heading.1.markdown", "markdownH1",
}, { fg = c.utype, bold = true, bg = "NONE" })

set_hl({
  "@markup.heading.2", "@markup.heading.2.markdown", "markdownH2",
}, { fg = c.module, bold = true, bg = "NONE" })

set_hl({
  "@markup.heading.3", "@markup.heading.3.markdown", "markdownH3",
}, { fg = c.special, bold = true, bg = "NONE" })

set_hl({
  "@markup.heading.4", "@markup.heading.4.markdown", "markdownH4",
}, { fg = c.var, bold = true, bg = "NONE" })

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.5", "@markup.heading.5.markdown", "markdownH5",
  "@markup.heading.6", "@markup.heading.6.markdown", "markdownH6",
}, { fg = c.type, bold = true, bg = "NONE" })

set_hl({
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
  "@punctuation.special.markdown",
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
}, { fg = c.grey, bold = false, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = c.const, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = c.string, bold = true })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = c.var, italic = true })

set_hl({
  "@markup.link", "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = c.const, bg = "NONE", underline = false })

set_hl({
  "@markup.link.url", "@markup.link.url.markdown_inline", "markdownUrl",
}, { fg = c.string, bg = "NONE", underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.grey })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = c.module })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = c.string, italic = true })

set_hl({ "markdownRule" }, { fg = c.border })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local accent = c.utype

local function reapply()
  vim.api.nvim_set_hl(0, "SnacksPickerRule",        { fg = c.bg })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",       { fg = c.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",      { fg = c.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",         { fg = c.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",      { fg = c.fg,   bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = accent, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",      { fg = accent, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",       { fg = c.fg,   bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = accent, bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.fg, bg = "NONE" })
  end
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = accent,   bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",          { fg = c.fg,     bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",    { fg = c.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",  { fg = c.fg,     bg = c.surf_navy, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",     { fg = accent,   bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceCmdline",            { fg = c.fg,     bg = "NONE" })
  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = accent, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier"       .. lvl, { fg = c.fg,   bg = nb })
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = accent,    bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = c.n_warn,  bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = c.n_error, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = c.n_info,  bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = c.n_warn,  bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = c.n_error, bg = nb })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",       { fg = accent, bold = true })
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local b_fg = c.muted
local c_fg = c.mid
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
      normal   = mode_section(c.type,  c.deep),
      insert   = mode_section(c.module, c.fg),
      visual   = mode_section(c.sage,  c.deep),
      replace  = mode_section(c.cyan_l, c.cream),
      command  = mode_section(c.fg,    c.sel),
      inactive = {
        a = { bg = c_bg, fg = c.border, gui = "bold" },
        b = { bg = c_bg, fg = c.border },
        c = { bg = c_bg, fg = c.border },
      },
    },
    c_bg         = c_bg,
    filename     = c.cream,
    directory    = c.mid,
    lazy_updates = c.gold,
    diff = { added = c.cream, modified = c.module, removed = c.d_error },
  },
})
