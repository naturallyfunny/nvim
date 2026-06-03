vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "tokyodarky"

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

-- Syntax + dashboard: vibrant tokyodark. UI/chrome unchanged from mono.
local td = {
  bg_dark = "#11121D",  -- tokyodark main bg, used as section-a fg
  fg      = "#A0A8CD",  -- base foreground
  red     = "#EE6D85",  -- keywords, operators, errors
  orange  = "#F6955B",  -- identifiers, constants, tags
  yellow  = "#D7A65F",  -- strings, numbers, title, command mode
  green   = "#95C561",  -- functions, directory, normal mode
  blue    = "#7199EE",  -- types, structure, insert mode
  cyan    = "#38A89D",  -- indent scope accent
  purple  = "#A485DD",  -- macros, booleans, specials, visual mode
  grey    = "#4A5057",  -- comments, line numbers, borders
}

-- ── Syntax (tokyodark roles, no italic) ──────────────────────────────────────

set_hl({
  "Keyword", "Conditional", "Repeat", "Include", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
  "@keyword.return", "@keyword.return.go",
  "@keyword.repeat", "@keyword.conditional", "@keyword.conditional.ternary",
  "@keyword.exception", "@keyword.storage",
}, { fg = td.red })

set_hl({ "Statement" }, { fg = td.red })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "Define", "PreProc", "Macro", "@keyword.directive", "@keyword.modifier" }, { fg = td.purple })
set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = td.blue })
set_hl({ "@lsp.typemod.namespace.declaration" }, { fg = td.cyan })

set_hl({
  "Constant", "@constant", "@constant.builtin",
  "@lsp.typemod.variable.readonly",
}, { fg = td.orange })
set_hl({ "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" }, { fg = td.purple })

set_hl({ "String", "Character", "@string", "@character", "@string.special" }, { fg = td.yellow })
set_hl({ "@string.escape" }, { fg = td.red })
set_hl({ "@string.special.url" }, { fg = td.blue })

set_hl({
  "Type", "Structure", "StorageClass", "Tag",
  "@type", "@type.builtin", "@type.definition",
  "@lsp.type.builtinType", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = td.blue })

set_hl({
  "Operator", "@operator", "Delimiter",
  "@punctuation.delimiter", "@punctuation.bracket", "@punctuation.special",
  "@keyword.operator", "@string.delimiter",
}, { fg = td.red })

set_hl({ "Special", "SpecialChar" }, { fg = td.purple })
set_hl({ "@attribute" }, { fg = td.purple })

set_hl({ "@boolean", "Boolean" }, { fg = td.purple })
set_hl({ "@number", "@number.float", "@float", "Number", "Float" }, { fg = td.purple })

set_hl({
  "Function", "@function", "@function.call", "@method",
  "@function.builtin",
}, { fg = td.green })
set_hl({ "@constructor" }, { fg = td.blue })
set_hl({ "Title" }, { fg = td.yellow })

set_hl({
  "Identifier", "@variable",
  "@lsp.type.variable", "@lsp.typemod.variable.definition",
  "TSVariable",
}, { fg = td.fg })
set_hl({ "TSVariableBuiltin" }, { fg = td.purple })

set_hl({
  "@variable.parameter", "@lsp.type.parameter",
}, { fg = td.orange })

set_hl({
  "@field", "@property", "@variable.member",
  "@lsp.type.property",
}, { fg = td.orange })

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = td.grey, bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = td.grey })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = td.grey })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = td.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = td.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = td.grey })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = td.grey })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = td.grey })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = td.fg, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = td.grey })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = td.cyan, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = td.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = td.yellow })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = td.purple })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = td.blue })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary",     { fg = td.grey })
vim.api.nvim_set_hl(0, "Directory",                 { fg = td.green })
vim.api.nvim_set_hl(0, "FloatTitle",                { fg = td.blue, bold = true })
vim.api.nvim_set_hl(0, "SnacksTitle",               { fg = td.blue, bold = true })
vim.api.nvim_set_hl(0, "MiniIconsAzure",            { fg = td.blue })
vim.api.nvim_set_hl(0, "WinBar",                    { fg = td.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",                  { fg = td.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                      { fg = td.fg, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",                  { fg = td.red })
vim.api.nvim_set_hl(0, "WhichKeyDesc",              { fg = td.blue })
vim.api.nvim_set_hl(0, "WhichKeyGroup",             { fg = td.orange })
vim.api.nvim_set_hl(0, "WhichKeySeparator",         { fg = td.grey })
vim.api.nvim_set_hl(0, "WhichKeyValue",             { fg = td.yellow })
vim.api.nvim_set_hl(0, "WhichKeyBorder",            { fg = td.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded",                    { fg = td.grey, bg = "NONE" })

-- snacks + noice (re-applied on ColorScheme — see apply_snacks_noice())
local function apply_snacks_noice()
  vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = td.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = td.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerTree",              { fg = td.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",            { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",       { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",             { fg = td.blue, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt",            { fg = td.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",            { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",            { fg = td.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerRule",              { fg = c.bg4 })
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",       { fg = td.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = td.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",  { fg = td.grey })
  vim.api.nvim_set_hl(0, "SnacksPickerSpecial",           { fg = td.purple })
  vim.api.nvim_set_hl(0, "SnacksInputNormal",             { fg = td.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputBorder",             { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputTitle",              { fg = td.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputIcon",               { fg = td.purple, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksIndent",                  { fg = c.bg6 })
  vim.api.nvim_set_hl(0, "SnacksIndentScope",             { fg = td.cyan })
  vim.api.nvim_set_hl(0, "SnacksWinSeparator",            { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",            { fg = td.blue })

  vim.api.nvim_set_hl(0, "NoiceCmdline",                  { fg = td.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",             { fg = td.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",       { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",        { fg = td.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirm",                  { fg = td.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirmBorder",            { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder",       { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",                { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",          { fg = td.grey, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",        { fg = td.fg, bg = td.bg_dark, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",           { fg = td.blue, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceMini",                     { bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = td.purple, bg = "NONE" })
  end

  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    local fg = lvl == "Info" and td.blue or (lvl == "Hint" and td.purple or td.fg)
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lvl, { fg = fg, bg = nb })
      if part == "Border" then
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = td.grey, bg = nb })
      end
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lvl, { fg = fg, bg = nb })
  end
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = td.yellow, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = td.red, bg = nb })
    if part == "Border" then
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn",  { fg = td.grey, bg = nb })
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = td.grey, bg = nb })
    end
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = td.blue, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = td.yellow, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = td.red, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = td.blue, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = td.yellow, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = td.red, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",     { fg = td.yellow, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelError",    { fg = td.red, bg = nb })
end
apply_snacks_noice()

-- ── Dashboard (tokyodark) ─────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = td.blue })
set_hl({ "DashboardCenter" }, { fg = td.purple })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = td.cyan })
set_hl({ "DashboardShortCut" }, { fg = td.green })
set_hl({ "DashboardKey", "SnacksDashboardKey" }, { fg = td.yellow })
set_hl({ "DashboardDesc", "SnacksDashboardDesc" }, { fg = td.grey })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = td.cyan })
set_hl({ "SnacksDashboardDir" }, { fg = td.purple })
set_hl({ "SnacksDashboardFile" }, { fg = td.fg })
set_hl({ "SnacksDashboardSpecial" }, { fg = td.red })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.bg6, fg = c.white })

local gs = {
  Add = td.green, Change = td.blue, Delete = td.red,
  Untracked = td.grey, Topdelete = td.red, Changedelete = td.orange,
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
  Error = td.red, Warn = td.yellow, Hint = td.purple,
  Info = td.blue, Unnecessary = td.grey,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = td.cyan, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = td.fg, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = td.grey, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = td.grey, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = td.blue, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = td.grey })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = td.blue })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = td.blue })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = td.blue })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret",{ fg = td.purple })

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

vim.api.nvim_set_hl(0, "Visual",    { bg = c.bg9, fg = td.fg })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = td.grey })
vim.api.nvim_set_hl(0, "Search",    { bg = c.bg6, fg = td.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = td.orange, fg = td.bg_dark })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.bg5, fg = td.blue })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.bg6, fg = td.fg })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.bg6, fg = td.fg })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.bg6, fg = td.fg })

-- ── Markdown (tokyodark heading scale) ───────────────────────────────────────

set_hl({ "markdownH1", "@markup.heading.1.markdown" }, { fg = td.purple, bg = "NONE" })
set_hl({ "markdownH2", "@markup.heading.2.markdown" }, { fg = td.blue, bg = "NONE" })
set_hl({ "markdownH3", "@markup.heading.3.markdown" }, { fg = td.cyan, bg = "NONE" })
set_hl({ "markdownH4", "@markup.heading.4.markdown" }, { fg = td.green, bg = "NONE" })
set_hl({ "markdownH5", "@markup.heading.5.markdown" }, { fg = td.yellow, bg = "NONE" })
set_hl({ "markdownH6", "@markup.heading.6.markdown" }, { fg = td.orange, bg = "NONE" })

set_hl({
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
}, { fg = td.grey, bg = "NONE" })

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
}, { fg = td.yellow, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = td.yellow, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = td.fg })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = td.fg })

set_hl({
  "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = td.purple, bg = "NONE" })

set_hl({
  "@markup.link", "@markup.link.url", "@markup.link.url.markdown_inline",
  "markdownUrl", "markdownLinkDelimiter", "markdownLinkTextDelimiter",
}, { fg = td.blue, bg = "NONE" })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = td.purple })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = td.grey })

set_hl({ "markdownRule", "markdownDelimiter" }, { fg = td.grey })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
  apply_snacks_noice()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(mode_bg, mode_fg)
  return {
    a = { bg = mode_bg, fg = td.bg_dark, gui = "bold" },
    b = { bg = b_bg, fg = mode_fg },
    c = { bg = c_bg, fg = td.fg },
  }
end

require("config.theme_registry").register("tokyodarky", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section(td.green, td.green),
      insert   = mode_section(td.blue, td.blue),
      visual   = mode_section(td.purple, td.purple),
      replace  = mode_section(td.red, td.red),
      command  = mode_section(td.yellow, td.yellow),
      inactive = {
        a = { bg = c_bg, fg = td.grey, gui = "bold" },
        b = { bg = c_bg, fg = td.grey },
        c = { bg = c_bg, fg = td.grey },
      },
    },
    c_bg         = c_bg,
    filename     = td.fg,
    directory    = td.grey,
    lazy_updates = td.yellow,
    diff = { added = td.green, modified = td.blue, removed = td.red },
  },
})
