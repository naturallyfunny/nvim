vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "catppucciny"

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
  s2 = "#6d6d6d",
  s3 = "#8a8a8a",
  s4 = "#aaaaaa",
  s5 = "#c4c4c4",

  -- Surfaces (near-black backgrounds, ordered light → dark within each band)
  bg0 = "#101010",  -- [c_bg] lualine c
  bg1 = "#1a1a1a",  -- color column
  bg2 = "#1c1c1c",  -- diff hunk bg, lazy button bg
  bg3 = "#1e1e1e",  -- comment fg, noice popupmenu selected bg
  bg4 = "#202020",  -- VisualNOS bg
  bg5 = "#252525",  -- quickfix line bg
  bg6 = "#2a2a2a",  -- [b_bg] lualine b, search, diff text, LspReference
  bg7 = "#303030",  -- substitute, wildmenu, LspSignatureActiveParameter
  bg8 = "#383838",  -- flash backdrop
  bg9 = "#404040",  -- visual selection, lualine visual mode a_bg

  -- UI greys
  dim   = "#3a3a3a",
  grey  = "#505050",
  muted = "#4a4a4a",
  mid   = "#6a6a6a",

  -- Bright accents
  scope  = "#e8e8e8",
  border = "#E0E0E0",
}

-- lualine section b bg.
local b_bg = c.bg6
-- lualine section c bg.
local c_bg = c.bg0

-- Syntax + dashboard: vibrant Catppuccin Mocha. UI/chrome unchanged from mono.
local cp = {
  base     = "#1E1E2E",  -- mocha base bg, used as section-a fg
  text     = "#CDD6F4",  -- base foreground, variables
  red      = "#F38BA8",  -- builtin variables, errors
  maroon   = "#EBA0AC",  -- parameters
  peach    = "#FAB387",  -- constants, numbers, booleans, builtin functions
  yellow   = "#F9E2AF",  -- types, attributes
  green    = "#A6E3A1",  -- strings, add
  teal     = "#94E2D5",  -- properties, fields, accent
  sky      = "#89DCEB",  -- operators, specials
  sapphire = "#74C7EC",  -- constructors
  blue     = "#89B4FA",  -- functions, info
  lavender = "#B4BEFE",  -- modules, namespaces
  mauve    = "#CBA6F7",  -- keywords, macros, hint
  pink     = "#F5C2E7",  -- preproc, directives, escapes
  rosewater= "#F5E0DC",  -- link urls
  overlay  = "#6C7086",  -- comments, line numbers, borders
}

-- ── Syntax (Catppuccin Mocha roles, no italic) ───────────────────────────────

set_hl({
  "Keyword", "Conditional", "Repeat", "Include", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
  "@keyword.return", "@keyword.return.go",
  "@keyword.repeat", "@keyword.conditional", "@keyword.conditional.ternary",
  "@keyword.exception", "@keyword.storage", "@keyword.modifier",
}, { fg = cp.mauve })

set_hl({ "Statement" }, { fg = cp.mauve })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "Define", "PreProc", "Macro", "@keyword.directive" }, { fg = cp.pink })
set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = cp.lavender })
set_hl({ "@lsp.typemod.namespace.declaration" }, { fg = cp.lavender })

set_hl({
  "Constant", "@constant", "@constant.builtin",
  "@lsp.typemod.variable.readonly",
}, { fg = cp.peach })
set_hl({ "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" }, { fg = cp.red })

set_hl({ "String", "Character", "@string", "@character", "@string.special" }, { fg = cp.green })
set_hl({ "@string.escape" }, { fg = cp.pink })
set_hl({ "@string.special.url" }, { fg = cp.rosewater })

set_hl({
  "Type", "Structure", "StorageClass", "Tag",
  "@type", "@type.builtin", "@type.definition",
  "@lsp.type.builtinType", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = cp.yellow })

set_hl({
  "Operator", "@operator", "Delimiter",
  "@punctuation.delimiter", "@punctuation.bracket", "@punctuation.special",
  "@keyword.operator", "@string.delimiter",
}, { fg = cp.sky })

set_hl({ "Special", "SpecialChar" }, { fg = cp.sky })
set_hl({ "@attribute" }, { fg = cp.yellow })

set_hl({ "@boolean", "Boolean" }, { fg = cp.peach })
set_hl({ "@number", "@number.float", "@float", "Number", "Float" }, { fg = cp.peach })

set_hl({
  "Function", "@function", "@function.call", "@method",
}, { fg = cp.blue })
set_hl({ "@function.builtin" }, { fg = cp.peach })
set_hl({ "@constructor" }, { fg = cp.sapphire })
set_hl({ "Title" }, { fg = cp.blue })

set_hl({
  "Identifier", "@variable",
  "@lsp.type.variable", "@lsp.typemod.variable.definition",
  "TSVariable",
}, { fg = cp.text })
set_hl({ "TSVariableBuiltin" }, { fg = cp.red })

set_hl({
  "@variable.parameter", "@lsp.type.parameter",
}, { fg = cp.maroon })

set_hl({
  "@field", "@property", "@variable.member",
  "@lsp.type.property",
}, { fg = cp.teal })

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = cp.overlay, bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = cp.overlay })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = cp.overlay })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = cp.overlay, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = cp.overlay, bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = cp.overlay })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = cp.overlay })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = cp.overlay })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = cp.text, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = cp.overlay })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = cp.teal, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = cp.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = cp.yellow })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = cp.mauve })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = cp.blue })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary",     { fg = cp.overlay })
vim.api.nvim_set_hl(0, "Directory",                 { fg = cp.blue })
vim.api.nvim_set_hl(0, "FloatTitle",                { fg = cp.blue, bold = true })
vim.api.nvim_set_hl(0, "SnacksTitle",               { fg = cp.blue, bold = true })
vim.api.nvim_set_hl(0, "MiniIconsAzure",            { fg = cp.blue })
vim.api.nvim_set_hl(0, "WinBar",                    { fg = cp.overlay, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",                  { fg = cp.overlay, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                      { fg = cp.text, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",                  { fg = cp.red })
vim.api.nvim_set_hl(0, "WhichKeyDesc",              { fg = cp.blue })
vim.api.nvim_set_hl(0, "WhichKeyGroup",             { fg = cp.peach })
vim.api.nvim_set_hl(0, "WhichKeySeparator",         { fg = cp.overlay })
vim.api.nvim_set_hl(0, "WhichKeyValue",             { fg = cp.yellow })
vim.api.nvim_set_hl(0, "WhichKeyBorder",            { fg = cp.overlay, bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded",                    { fg = cp.overlay, bg = "NONE" })

-- snacks + noice (re-applied on ColorScheme — see apply_snacks_noice())
local function apply_snacks_noice()
  vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = cp.text })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = cp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerTree",              { fg = cp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",            { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",       { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",             { fg = cp.blue, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt",            { fg = cp.text })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",            { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",            { fg = cp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerRule",              { fg = c.bg4 })
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",       { fg = cp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = cp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",  { fg = cp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerSpecial",           { fg = cp.mauve })
  vim.api.nvim_set_hl(0, "SnacksInputNormal",             { fg = cp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputBorder",             { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputTitle",              { fg = cp.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputIcon",               { fg = cp.mauve, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksIndent",                  { fg = c.bg6 })
  vim.api.nvim_set_hl(0, "SnacksIndentScope",             { fg = cp.teal })
  vim.api.nvim_set_hl(0, "SnacksWinSeparator",            { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",            { fg = cp.blue })

  vim.api.nvim_set_hl(0, "NoiceCmdline",                  { fg = cp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",             { fg = cp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",       { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",        { fg = cp.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirm",                  { fg = cp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirmBorder",            { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder",       { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",                { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",          { fg = cp.overlay, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",        { fg = cp.text, bg = cp.base, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",           { fg = cp.blue, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceMini",                     { bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = cp.mauve, bg = "NONE" })
  end

  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    local fg = lvl == "Info" and cp.blue or (lvl == "Hint" and cp.mauve or cp.text)
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lvl, { fg = fg, bg = nb })
      if part == "Border" then
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = cp.overlay, bg = nb })
      end
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lvl, { fg = fg, bg = nb })
  end
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = cp.yellow, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = cp.red, bg = nb })
    if part == "Border" then
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn",  { fg = cp.overlay, bg = nb })
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = cp.overlay, bg = nb })
    end
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = cp.blue, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = cp.yellow, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = cp.red, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = cp.blue, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = cp.yellow, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = cp.red, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",     { fg = cp.yellow, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelError",    { fg = cp.red, bg = nb })
end
apply_snacks_noice()

-- ── Dashboard (Catppuccin Mocha) ──────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = cp.blue })
set_hl({ "DashboardCenter" }, { fg = cp.mauve })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = cp.teal })
set_hl({ "DashboardShortCut" }, { fg = cp.green })
set_hl({ "DashboardKey", "SnacksDashboardKey" }, { fg = cp.yellow })
set_hl({ "DashboardDesc", "SnacksDashboardDesc" }, { fg = cp.overlay })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = cp.teal })
set_hl({ "SnacksDashboardDir" }, { fg = cp.mauve })
set_hl({ "SnacksDashboardFile" }, { fg = cp.text })
set_hl({ "SnacksDashboardSpecial" }, { fg = cp.red })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.bg6, fg = c.white })

local gs = {
  Add = cp.green, Change = cp.blue, Delete = cp.red,
  Untracked = cp.overlay, Topdelete = cp.red, Changedelete = cp.peach,
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

-- ── Diagnostics: virtual text, float, sign column ────────────────────────────

local diag = {
  Error = cp.red, Warn = cp.yellow, Hint = cp.mauve,
  Info = cp.blue, Unnecessary = cp.overlay,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = cp.teal, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = cp.text, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = cp.overlay, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = cp.overlay, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = cp.blue, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = cp.overlay })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret",{ fg = cp.mauve })

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

vim.api.nvim_set_hl(0, "Visual",    { bg = c.bg9, fg = cp.text })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = cp.overlay })
vim.api.nvim_set_hl(0, "Search",    { bg = c.bg6, fg = cp.text })
vim.api.nvim_set_hl(0, "CurSearch", { bg = cp.peach, fg = cp.base })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.bg5, fg = cp.blue })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.bg6, fg = cp.text })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.bg6, fg = cp.text })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.bg6, fg = cp.text })

-- ── Markdown (Catppuccin Mocha heading scale) ────────────────────────────────

set_hl({ "markdownH1", "@markup.heading.1.markdown" }, { fg = cp.mauve, bg = "NONE" })
set_hl({ "markdownH2", "@markup.heading.2.markdown" }, { fg = cp.blue, bg = "NONE" })
set_hl({ "markdownH3", "@markup.heading.3.markdown" }, { fg = cp.sky, bg = "NONE" })
set_hl({ "markdownH4", "@markup.heading.4.markdown" }, { fg = cp.green, bg = "NONE" })
set_hl({ "markdownH5", "@markup.heading.5.markdown" }, { fg = cp.yellow, bg = "NONE" })
set_hl({ "markdownH6", "@markup.heading.6.markdown" }, { fg = cp.peach, bg = "NONE" })

set_hl({
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
}, { fg = cp.overlay, bg = "NONE" })

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
}, { fg = cp.yellow, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = cp.green, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = cp.text })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = cp.text })

set_hl({
  "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = cp.mauve, bg = "NONE" })

set_hl({
  "@markup.link", "@markup.link.url", "@markup.link.url.markdown_inline",
  "markdownUrl", "markdownLinkDelimiter", "markdownLinkTextDelimiter",
}, { fg = cp.blue, bg = "NONE" })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = cp.mauve })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = cp.overlay })

set_hl({ "markdownRule", "markdownDelimiter" }, { fg = cp.overlay })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
  apply_snacks_noice()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(mode_bg, mode_fg)
  return {
    a = { bg = mode_bg, fg = cp.base, gui = "bold" },
    b = { bg = b_bg, fg = mode_fg },
    c = { bg = c_bg, fg = cp.text },
  }
end

require("config.theme_registry").register("catppucciny", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section(cp.blue, cp.blue),
      insert   = mode_section(cp.green, cp.green),
      visual   = mode_section(cp.mauve, cp.mauve),
      replace  = mode_section(cp.red, cp.red),
      command  = mode_section(cp.peach, cp.peach),
      inactive = {
        a = { bg = c_bg, fg = cp.overlay, gui = "bold" },
        b = { bg = c_bg, fg = cp.overlay },
        c = { bg = c_bg, fg = cp.overlay },
      },
    },
    c_bg         = c_bg,
    filename     = cp.text,
    directory    = cp.overlay,
    lazy_updates = cp.yellow,
    diff = { added = cp.green, modified = cp.blue, removed = cp.red },
  },
})
