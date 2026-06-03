vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "kanagawy"

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

-- Syntax + dashboard: vibrant kanagawa wave. UI/chrome unchanged from mono.
local kw = {
  bg_dark = "#16161D",  -- sumiInk0, section-a fg on mode-color bg
  fg      = "#DCD7BA",  -- fujiWhite
  comment = "#727169",  -- fujiGray
  keyword = "#957FB8",  -- oniViolet   — keywords, statement, visual mode
  preproc = "#E46876",  -- waveRed     — preproc, string.escape, variable.builtin
  type    = "#7AA89F",  -- waveAqua2   — types, namespace, constructor
  fun     = "#7E9CD8",  -- crystalBlue — functions, title, normal mode
  const   = "#FFA066",  -- surimiOrange — constants, boolean, replace mode
  ident   = "#E6C384",  -- carpYellow  — identifier, field, property
  param   = "#b8b4d0",  -- oniViolet2  — parameters
  string  = "#98BB6C",  -- springGreen — strings, insert mode
  number  = "#D27E99",  -- sakuraPink  — numbers
  oper    = "#C0A36E",  -- boatYellow2 — operators, command mode
  punct   = "#9CABCA",  -- springViolet2 — punctuation
  special = "#7FB4CA",  -- springBlue  — specials, attribute
  error   = "#E82424",  -- samuraiRed
  warn    = "#FF9E3B",  -- roninYellow
  info    = "#658594",  -- dragonBlue
  hint    = "#6A9589",  -- waveAqua1
  git_add = "#76946A",  -- autumnGreen
  git_chg = "#DCA561",  -- autumnYellow
  git_del = "#C34043",  -- autumnRed
}

-- ── Syntax (kanagawa wave roles, no italic) ───────────────────────────────────

set_hl({
  "Keyword", "Conditional", "Repeat", "Include", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
  "@keyword.return", "@keyword.return.go",
  "@keyword.repeat", "@keyword.conditional", "@keyword.conditional.ternary",
  "@keyword.exception", "@keyword.storage",
}, { fg = kw.keyword })

set_hl({ "Statement" }, { fg = kw.keyword })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "Define", "PreProc", "Macro", "@keyword.directive", "@keyword.modifier" }, { fg = kw.preproc })
set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = kw.type })
set_hl({ "@lsp.typemod.namespace.declaration" }, { fg = kw.fun })

set_hl({
  "Constant", "@constant", "@constant.builtin",
  "@lsp.typemod.variable.readonly",
}, { fg = kw.const })
set_hl({ "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" }, { fg = kw.preproc })

set_hl({ "String", "Character", "@string", "@character", "@string.special" }, { fg = kw.string })
set_hl({ "@string.escape" }, { fg = kw.preproc })
set_hl({ "@string.special.url" }, { fg = kw.special })

set_hl({
  "Type", "Structure", "StorageClass", "Tag",
  "@type", "@type.builtin", "@type.definition",
  "@lsp.type.builtinType", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = kw.type })

set_hl({
  "Operator", "@operator",
  "@keyword.operator",
}, { fg = kw.oper })

set_hl({
  "Delimiter", "@punctuation.delimiter", "@punctuation.bracket",
  "@punctuation.special", "@string.delimiter",
}, { fg = kw.punct })

set_hl({ "Special", "SpecialChar" }, { fg = kw.special })
set_hl({ "@attribute" }, { fg = kw.preproc })

set_hl({ "@boolean", "Boolean" }, { fg = kw.const })
set_hl({ "@number", "@number.float", "@float", "Number", "Float" }, { fg = kw.number })

set_hl({
  "Function", "@function", "@function.call", "@method",
  "@function.builtin",
}, { fg = kw.fun })
set_hl({ "@constructor" }, { fg = kw.type })
set_hl({ "Title" }, { fg = kw.fun })

set_hl({
  "Identifier", "@variable",
  "@lsp.type.variable", "@lsp.typemod.variable.definition",
  "TSVariable",
}, { fg = kw.fg })
set_hl({ "TSVariableBuiltin" }, { fg = kw.preproc })

set_hl({
  "@variable.parameter", "@lsp.type.parameter",
}, { fg = kw.param })

set_hl({
  "@field", "@property", "@variable.member",
  "@lsp.type.property",
}, { fg = kw.ident })

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = kw.comment, bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = kw.comment })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = kw.comment })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = kw.comment, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = kw.comment, bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = kw.comment })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = kw.comment })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = kw.comment })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = kw.fg, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = kw.comment })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = kw.special, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = kw.error })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = kw.warn })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = kw.hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = kw.info })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary",     { fg = kw.comment })
vim.api.nvim_set_hl(0, "Directory",                 { fg = kw.fun })
vim.api.nvim_set_hl(0, "FloatTitle",                { fg = kw.fun, bold = true })
vim.api.nvim_set_hl(0, "SnacksTitle",               { fg = kw.fun, bold = true })
vim.api.nvim_set_hl(0, "MiniIconsAzure",            { fg = kw.fun })
vim.api.nvim_set_hl(0, "WinBar",                    { fg = kw.comment, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",                  { fg = kw.comment, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                      { fg = kw.fg, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",                  { fg = kw.keyword })
vim.api.nvim_set_hl(0, "WhichKeyDesc",              { fg = kw.fun })
vim.api.nvim_set_hl(0, "WhichKeyGroup",             { fg = kw.ident })
vim.api.nvim_set_hl(0, "WhichKeySeparator",         { fg = kw.comment })
vim.api.nvim_set_hl(0, "WhichKeyValue",             { fg = kw.oper })
vim.api.nvim_set_hl(0, "WhichKeyBorder",            { fg = kw.comment, bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded",                    { fg = kw.comment, bg = "NONE" })

-- snacks + noice (re-applied on ColorScheme — see apply_snacks_noice())
local function apply_snacks_noice()
  vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = kw.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = kw.comment })
  vim.api.nvim_set_hl(0, "SnacksPickerTree",              { fg = kw.comment })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",            { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",       { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",             { fg = kw.fun, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt",            { fg = kw.fg })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",            { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",            { fg = kw.comment })
  vim.api.nvim_set_hl(0, "SnacksPickerRule",              { fg = c.bg4 })
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",       { fg = kw.comment })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = kw.comment })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",  { fg = kw.comment })
  vim.api.nvim_set_hl(0, "SnacksPickerSpecial",           { fg = kw.keyword })
  vim.api.nvim_set_hl(0, "SnacksInputNormal",             { fg = kw.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputBorder",             { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputTitle",              { fg = kw.fun, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputIcon",               { fg = kw.keyword, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksIndent",                  { fg = c.bg6 })
  vim.api.nvim_set_hl(0, "SnacksIndentScope",             { fg = kw.type })
  vim.api.nvim_set_hl(0, "SnacksWinSeparator",            { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",            { fg = kw.fun })

  vim.api.nvim_set_hl(0, "NoiceCmdline",                  { fg = kw.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",             { fg = kw.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",       { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",        { fg = kw.fun, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirm",                  { fg = kw.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirmBorder",            { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder",       { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",                { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",          { fg = kw.comment, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",        { fg = kw.fg, bg = kw.bg_dark, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",           { fg = kw.fun, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceMini",                     { bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = kw.keyword, bg = "NONE" })
  end

  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    local fg = lvl == "Info" and kw.fun or (lvl == "Hint" and kw.type or kw.fg)
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lvl, { fg = fg, bg = nb })
      if part == "Border" then
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = kw.comment, bg = nb })
      end
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lvl, { fg = fg, bg = nb })
  end
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = kw.warn, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = kw.error, bg = nb })
    if part == "Border" then
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn",  { fg = kw.comment, bg = nb })
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = kw.comment, bg = nb })
    end
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = kw.fun, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = kw.warn, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = kw.error, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = kw.fun, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = kw.warn, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = kw.error, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",     { fg = kw.warn, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelError",    { fg = kw.error, bg = nb })
end
apply_snacks_noice()

-- ── Dashboard (kanagawa) ──────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = kw.fun })
set_hl({ "DashboardCenter" }, { fg = kw.keyword })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = kw.type })
set_hl({ "DashboardShortCut" }, { fg = kw.string })
set_hl({ "DashboardKey", "SnacksDashboardKey" }, { fg = kw.const })
set_hl({ "DashboardDesc", "SnacksDashboardDesc" }, { fg = kw.comment })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = kw.type })
set_hl({ "SnacksDashboardDir" }, { fg = kw.keyword })
set_hl({ "SnacksDashboardFile" }, { fg = kw.fg })
set_hl({ "SnacksDashboardSpecial" }, { fg = kw.preproc })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.bg6, fg = c.white })

local gs = {
  Add = kw.git_add, Change = kw.git_chg, Delete = kw.git_del,
  Untracked = kw.comment, Topdelete = kw.git_del, Changedelete = kw.const,
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
  Error = kw.error, Warn = kw.warn, Hint = kw.hint,
  Info = kw.info, Unnecessary = kw.comment,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = kw.type, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = kw.fg, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = kw.comment, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = kw.comment, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = kw.fun, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = kw.comment })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = kw.fun })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = kw.fun })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = kw.fun })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret",{ fg = kw.keyword })

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

vim.api.nvim_set_hl(0, "Visual",    { bg = c.bg9, fg = kw.fg })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = kw.comment })
vim.api.nvim_set_hl(0, "Search",    { bg = c.bg6, fg = kw.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = kw.oper, fg = kw.bg_dark })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.bg5, fg = kw.fun })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.bg6, fg = kw.fg })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.bg6, fg = kw.fg })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.bg6, fg = kw.fg })

-- ── Markdown (kanagawa heading scale) ────────────────────────────────────────

set_hl({ "markdownH1", "@markup.heading.1.markdown" }, { fg = kw.keyword, bg = "NONE" })
set_hl({ "markdownH2", "@markup.heading.2.markdown" }, { fg = kw.fun, bg = "NONE" })
set_hl({ "markdownH3", "@markup.heading.3.markdown" }, { fg = kw.type, bg = "NONE" })
set_hl({ "markdownH4", "@markup.heading.4.markdown" }, { fg = kw.string, bg = "NONE" })
set_hl({ "markdownH5", "@markup.heading.5.markdown" }, { fg = kw.ident, bg = "NONE" })
set_hl({ "markdownH6", "@markup.heading.6.markdown" }, { fg = kw.oper, bg = "NONE" })

set_hl({
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
}, { fg = kw.comment, bg = "NONE" })

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
}, { fg = kw.fun, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = kw.string, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = kw.fg })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = kw.fg })

set_hl({
  "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = kw.fun, bg = "NONE" })

set_hl({
  "@markup.link", "@markup.link.url", "@markup.link.url.markdown_inline",
  "markdownUrl", "markdownLinkDelimiter", "markdownLinkTextDelimiter",
}, { fg = kw.keyword, bg = "NONE" })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = kw.preproc })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = kw.comment })

set_hl({ "markdownRule", "markdownDelimiter" }, { fg = kw.comment })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
  apply_snacks_noice()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(mode_bg, mode_fg)
  return {
    a = { bg = mode_bg, fg = kw.bg_dark, gui = "bold" },
    b = { bg = b_bg, fg = mode_fg },
    c = { bg = c_bg, fg = kw.fg },
  }
end

require("config.theme_registry").register("kanagawy", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section(kw.fun, kw.fun),
      insert   = mode_section(kw.string, kw.string),
      visual   = mode_section(kw.keyword, kw.keyword),
      replace  = mode_section(kw.const, kw.const),
      command  = mode_section(kw.oper, kw.oper),
      inactive = {
        a = { bg = c_bg, fg = kw.comment, gui = "bold" },
        b = { bg = c_bg, fg = kw.comment },
        c = { bg = c_bg, fg = kw.comment },
      },
    },
    c_bg         = c_bg,
    filename     = kw.fg,
    directory    = kw.comment,
    lazy_updates = kw.oper,
    diff = { added = kw.git_add, modified = kw.git_chg, removed = kw.git_del },
  },
})
