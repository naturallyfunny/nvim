vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "moonly"

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

-- Syntax + dashboard: vibrant moonfly. UI/chrome unchanged from mono.
local mf = {
  text      = "#c6c6c6",  -- base foreground
  sky       = "#74b2ff",  -- functions, titles
  blue      = "#80a0ff",  -- structure, normal mode
  violet    = "#cf87e8",  -- keywords, statement
  purple    = "#ae81ff",  -- visual mode, macro constants
  turquoise = "#79dac8",  -- identifier, module, constants
  emerald   = "#36c692",  -- types, insert mode
  green     = "#8cc85f",  -- variable builtin
  lime      = "#85dc85",  -- misc accents
  khaki     = "#c6c684",  -- strings
  yellow    = "#e3c78a",  -- numbers, command mode
  orange    = "#de935f",  -- constants
  coral     = "#f09479",  -- changedelete, cursearch
  crimson   = "#ff5189",  -- replace mode
  cranberry = "#e65e72",  -- operators, booleans
  red       = "#ff5d5d",  -- errors
  orchid    = "#e196a2",  -- parameters
  lavender  = "#adadf3",  -- property, fields
  haze      = "#88a2b7",  -- folded fg
  grey89    = "#e4e4e4",  -- bright text
  grey70    = "#b2b2b2",  -- secondary text
  grey58    = "#949494",  -- comment, dimmed
  grey39    = "#626262",  -- non-text, untracked
  grey0     = "#323437",  -- visual selection bg
  grey1     = "#373c4d",  -- search bg
  bay       = "#4d5d8d",  -- diff text bg
  mineral   = "#314940",  -- diff add bg
  black     = "#080808",  -- true black
}

-- ── Syntax (moonfly roles, no italic) ─────────────────────────────────────────

set_hl({
  "Keyword", "Conditional", "Repeat", "Include", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
  "@keyword.return", "@keyword.return.go",
  "@keyword.repeat", "@keyword.conditional", "@keyword.conditional.ternary",
  "@keyword.exception", "@keyword.storage",
}, { fg = mf.violet })

set_hl({ "Statement" }, { fg = mf.violet })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "Define", "PreProc", "Macro", "@keyword.directive", "@keyword.modifier" }, { fg = mf.cranberry })
set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = mf.turquoise })
set_hl({ "@lsp.typemod.namespace.declaration" }, { fg = mf.emerald })

set_hl({
  "Constant", "@constant", "@constant.builtin",
  "@lsp.typemod.variable.readonly",
}, { fg = mf.orange })
set_hl({ "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" }, { fg = mf.green })

set_hl({ "String", "Character", "@string", "@character", "@string.special" }, { fg = mf.khaki })
set_hl({ "@string.escape" }, { fg = mf.cranberry })
set_hl({ "@string.special.url" }, { fg = mf.purple })

set_hl({
  "Type", "Structure", "StorageClass", "Tag",
  "@type", "@type.builtin", "@type.definition",
  "@lsp.type.builtinType", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = mf.emerald })

set_hl({
  "Operator", "@operator", "Delimiter",
  "@punctuation.delimiter", "@punctuation.bracket", "@punctuation.special",
  "@keyword.operator", "@string.delimiter",
}, { fg = mf.cranberry })

set_hl({ "Special", "SpecialChar" }, { fg = mf.cranberry })
set_hl({ "@attribute" }, { fg = mf.sky })

set_hl({ "@boolean", "Boolean" }, { fg = mf.cranberry })
set_hl({ "@number", "@number.float", "@float", "Number", "Float" }, { fg = mf.orange })

set_hl({
  "Function", "@function", "@function.call", "@method",
  "@function.builtin",
}, { fg = mf.sky })
set_hl({ "@constructor" }, { fg = mf.emerald })
set_hl({ "Title" }, { fg = mf.sky })

set_hl({
  "Identifier", "@variable",
  "@lsp.type.variable", "@lsp.typemod.variable.definition",
  "TSVariable",
}, { fg = mf.text })
set_hl({ "TSVariableBuiltin" }, { fg = mf.green })

set_hl({
  "@variable.parameter", "@lsp.type.parameter",
}, { fg = mf.orchid })

set_hl({
  "@field", "@property", "@variable.member",
  "@lsp.type.property",
}, { fg = mf.lavender })

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = mf.grey58, bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = mf.grey58 })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = mf.grey58 })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = mf.grey58, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = mf.grey58, bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = mf.grey39 })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = mf.grey39 })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = mf.grey39 })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = mf.text, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = mf.grey58 })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = mf.violet, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = mf.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = mf.yellow })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = mf.turquoise })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = mf.sky })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary",     { fg = mf.grey39 })
vim.api.nvim_set_hl(0, "Directory",                 { fg = mf.sky })
vim.api.nvim_set_hl(0, "FloatTitle",                { fg = mf.sky, bold = true })
vim.api.nvim_set_hl(0, "SnacksTitle",               { fg = mf.sky, bold = true })
vim.api.nvim_set_hl(0, "MiniIconsAzure",            { fg = mf.sky })
vim.api.nvim_set_hl(0, "WinBar",                    { fg = mf.grey58, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",                  { fg = mf.grey39, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                      { fg = mf.text, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",                  { fg = mf.text })
vim.api.nvim_set_hl(0, "WhichKeyDesc",              { fg = mf.grey58 })
vim.api.nvim_set_hl(0, "WhichKeyGroup",             { fg = mf.violet })
vim.api.nvim_set_hl(0, "WhichKeySeparator",         { fg = mf.grey39 })
vim.api.nvim_set_hl(0, "WhichKeyValue",             { fg = mf.yellow })
vim.api.nvim_set_hl(0, "WhichKeyBorder",            { fg = mf.grey58, bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded",                    { fg = mf.haze, bg = "NONE" })

-- snacks + noice (re-applied on ColorScheme — see apply_snacks_noice())
local function apply_snacks_noice()
  vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = mf.text })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = mf.grey58 })
  vim.api.nvim_set_hl(0, "SnacksPickerTree",              { fg = mf.grey39 })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",            { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",       { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",             { fg = mf.sky, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt",            { fg = mf.text })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",            { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",            { fg = mf.grey39 })
  vim.api.nvim_set_hl(0, "SnacksPickerRule",              { fg = c.bg4 })
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",       { fg = mf.grey39 })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = mf.grey39 })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",  { fg = mf.grey39 })
  vim.api.nvim_set_hl(0, "SnacksPickerSpecial",           { fg = mf.violet })
  vim.api.nvim_set_hl(0, "SnacksInputNormal",             { fg = mf.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputBorder",             { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputTitle",              { fg = mf.sky, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputIcon",               { fg = mf.violet, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksIndent",                  { fg = c.bg6 })
  vim.api.nvim_set_hl(0, "SnacksIndentScope",             { fg = mf.turquoise })
  vim.api.nvim_set_hl(0, "SnacksWinSeparator",            { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",            { fg = mf.sky })

  vim.api.nvim_set_hl(0, "NoiceCmdline",                  { fg = mf.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",             { fg = mf.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",       { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",        { fg = mf.sky, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirm",                  { fg = mf.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirmBorder",            { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder",       { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",                { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",          { fg = mf.grey58, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",        { fg = mf.text, bg = mf.grey0, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",           { fg = mf.sky, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceMini",                     { bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = mf.violet, bg = "NONE" })
  end

  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    local fg = lvl == "Info" and mf.sky or (lvl == "Hint" and mf.turquoise or mf.text)
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lvl, { fg = fg, bg = nb })
      if part == "Border" then
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = mf.grey58, bg = nb })
      end
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lvl, { fg = fg, bg = nb })
  end
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = mf.yellow, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = mf.red, bg = nb })
    if part == "Border" then
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn",  { fg = mf.grey58, bg = nb })
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = mf.grey58, bg = nb })
    end
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = mf.sky, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = mf.yellow, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = mf.red, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = mf.sky, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = mf.yellow, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = mf.red, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",     { fg = mf.yellow, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelError",    { fg = mf.red, bg = nb })
end
apply_snacks_noice()

-- ── Dashboard (moonfly) ───────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = mf.blue })
set_hl({ "DashboardCenter" }, { fg = mf.violet })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = mf.coral })
set_hl({ "DashboardShortCut" }, { fg = mf.turquoise })
set_hl({ "DashboardKey", "SnacksDashboardKey" }, { fg = mf.yellow })
set_hl({ "DashboardDesc", "SnacksDashboardDesc" }, { fg = mf.grey58 })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = mf.turquoise })
set_hl({ "SnacksDashboardDir" }, { fg = mf.violet })
set_hl({ "SnacksDashboardFile" }, { fg = mf.text })
set_hl({ "SnacksDashboardSpecial" }, { fg = mf.crimson })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.bg6, fg = c.white })

local gs = {
  Add = mf.emerald, Change = mf.sky, Delete = mf.red,
  Untracked = mf.grey58, Topdelete = mf.red, Changedelete = mf.coral,
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
  Error = mf.red, Warn = mf.yellow, Hint = mf.turquoise,
  Info = mf.sky, Unnecessary = mf.grey39,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = mf.turquoise, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = mf.text, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = mf.grey39, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = mf.grey58, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = mf.sky, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = mf.grey39 })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = mf.sky })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = mf.sky })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = mf.sky })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret",{ fg = mf.violet })

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

vim.api.nvim_set_hl(0, "Visual",    { bg = c.bg9, fg = mf.text })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = mf.grey58 })
vim.api.nvim_set_hl(0, "Search",    { bg = c.bg6, fg = mf.text })
vim.api.nvim_set_hl(0, "CurSearch", { bg = mf.coral, fg = mf.black })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.bg5, fg = mf.sky })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.bg6, fg = mf.text })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.bg6, fg = mf.text })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.bg6, fg = mf.text })

-- ── Markdown (moonfly heading scale) ──────────────────────────────────────────

set_hl({ "markdownH1", "@markup.heading.1.markdown" }, { fg = mf.lavender, bg = "NONE" })
set_hl({ "markdownH2", "@markup.heading.2.markdown" }, { fg = mf.lavender, bg = "NONE" })
set_hl({ "markdownH3", "@markup.heading.3.markdown" }, { fg = mf.turquoise, bg = "NONE" })
set_hl({ "markdownH4", "@markup.heading.4.markdown" }, { fg = mf.orange, bg = "NONE" })
set_hl({ "markdownH5", "@markup.heading.5.markdown" }, { fg = mf.sky, bg = "NONE" })
set_hl({ "markdownH6", "@markup.heading.6.markdown" }, { fg = mf.violet, bg = "NONE" })

set_hl({
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
}, { fg = mf.grey58, bg = "NONE" })

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
}, { fg = mf.sky, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = mf.khaki, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = mf.text })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = mf.text })

set_hl({
  "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = mf.green, bg = "NONE" })

set_hl({
  "@markup.link", "@markup.link.url", "@markup.link.url.markdown_inline",
  "markdownUrl", "markdownLinkDelimiter", "markdownLinkTextDelimiter",
}, { fg = mf.purple, bg = "NONE" })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = mf.cranberry })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = mf.grey58 })

set_hl({ "markdownRule", "markdownDelimiter" }, { fg = mf.grey58 })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
  apply_snacks_noice()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(mode_bg, mode_fg)
  return {
    a = { bg = mode_bg, fg = mf.black, gui = "bold" },
    b = { bg = b_bg, fg = mode_fg },
    c = { bg = c_bg, fg = mf.text },
  }
end

require("config.theme_registry").register("moonly", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section(mf.blue, mf.blue),
      insert   = mode_section(mf.emerald, mf.emerald),
      visual   = mode_section(mf.purple, mf.purple),
      replace  = mode_section(mf.crimson, mf.crimson),
      command  = mode_section(mf.yellow, mf.yellow),
      inactive = {
        a = { bg = c_bg, fg = mf.grey58, gui = "bold" },
        b = { bg = c_bg, fg = mf.grey58 },
        c = { bg = c_bg, fg = mf.grey58 },
      },
    },
    c_bg         = c_bg,
    filename     = mf.text,
    directory    = mf.grey58,
    lazy_updates = mf.yellow,
    diff = { added = mf.emerald, modified = mf.sky, removed = mf.red },
  },
})
