vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "rosy-piny"

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
  s2 = "#6d6d6d",   -- keywords, builtin types, folded, LineNr, SnacksIndent, SnacksPickerTree, all borders
  s3 = "#8a8a8a",   -- constants, strings, numbers
  s4 = "#aaaaaa",   -- operators, punctuation, markdown markers
  s5 = "#c4c4c4",   -- user-defined types (@type, struct, interface)

  -- Surfaces (near-black backgrounds, ordered light → dark within each band)
  bg0 = "#101010",  -- [c_bg] lualine c
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
  dim   = "#3a3a3a",  -- git Untracked
  grey  = "#505050",  -- picker borders, git delete, darkest syntax
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
-- lualine section c bg.
local c_bg = c.bg0

-- Syntax + dashboard: vibrant rose-pine main. UI/chrome unchanged from mono.
local rp = {
  text   = "#e0def4",
  love   = "#eb6f92",
  gold   = "#f6c177",
  rose   = "#ebbcba",
  pine   = "#31748f",
  foam   = "#9ccfd8",
  iris   = "#c4a7e7",
  leaf   = "#95b1ac",
  subtle = "#908caa",
  muted  = "#6e6a86",
  overlay = "#26233a",
  base   = "#191724",
}

-- ── Syntax (rose-pine roles, no italic) ───────────────────────────────────────

set_hl({
  "Keyword", "Conditional", "Repeat", "Include", "Exception",
  "@keyword", "@keyword.function", "@keyword.import", "@include",
  "@keyword.return", "@keyword.return.go",
  "@keyword.repeat", "@keyword.conditional", "@keyword.conditional.ternary",
  "@keyword.exception", "@keyword.storage",
}, { fg = rp.pine })

set_hl({ "Statement" }, { fg = rp.pine })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl({ "Define", "PreProc", "Macro", "@keyword.directive", "@keyword.modifier" }, { fg = rp.iris })
set_hl({ "@module", "@module.builtin", "@namespace", "@lsp.type.namespace" }, { fg = rp.text })
set_hl({ "@lsp.typemod.namespace.declaration" }, { fg = rp.foam })

set_hl({
  "Constant", "@constant", "@constant.builtin",
  "@lsp.typemod.variable.readonly",
}, { fg = rp.gold })
set_hl({ "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" }, { fg = rp.love })

set_hl({ "String", "Character", "@string", "@character", "@string.special" }, { fg = rp.gold })
set_hl({ "@string.escape" }, { fg = rp.pine })
set_hl({ "@string.special.url" }, { fg = rp.iris })

set_hl({
  "Type", "Structure", "StorageClass", "Tag",
  "@type", "@type.builtin", "@type.definition",
  "@lsp.type.builtinType", "@lsp.type.struct", "@lsp.type.interface",
  "@lsp.type.enum", "@lsp.type.type",
  "@lsp.typemod.type.defaultLibrary", "@lsp.typemod.builtin.defaultLibrary",
}, { fg = rp.foam })

set_hl({
  "Operator", "@operator", "Delimiter",
  "@punctuation.delimiter", "@punctuation.bracket", "@punctuation.special",
  "@keyword.operator", "@string.delimiter",
}, { fg = rp.subtle })

set_hl({ "Special", "SpecialChar" }, { fg = rp.foam })
set_hl({ "@attribute" }, { fg = rp.iris })

set_hl({ "@boolean", "Boolean" }, { fg = rp.rose })
set_hl({ "@number", "@number.float", "@float", "Number", "Float" }, { fg = rp.gold })

set_hl({
  "Function", "@function", "@function.call", "@method",
  "@function.builtin",
}, { fg = rp.rose })
set_hl({ "@constructor" }, { fg = rp.foam })
set_hl({ "Title" }, { fg = rp.foam })

set_hl({
  "Identifier", "@variable",
  "@lsp.type.variable", "@lsp.typemod.variable.definition",
  "TSVariable",
}, { fg = rp.text })
set_hl({ "TSVariableBuiltin" }, { fg = rp.love })

set_hl({
  "@variable.parameter", "@lsp.type.parameter",
}, { fg = rp.iris })

set_hl({
  "@field", "@property", "@variable.member",
  "@lsp.type.property",
}, { fg = rp.foam })

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

set_hl({ "WinSeparator", "VertSplit", "NeoTreeWinSeparator", "SnacksWinSeparator" }, { fg = rp.muted, bg = "NONE" })

vim.api.nvim_set_hl(0, "FloatermBorder",          { bg = "NONE", fg = rp.muted })
vim.api.nvim_set_hl(0, "TelescopeBorder",          { fg = rp.muted })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder",       { fg = rp.muted, bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder",              { fg = rp.muted, bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr",                    { fg = rp.muted })
vim.api.nvim_set_hl(0, "LineNrAbove",               { fg = rp.muted })
vim.api.nvim_set_hl(0, "LineNrBelow",               { fg = rp.muted })
vim.api.nvim_set_hl(0, "CursorLineNr",              { fg = rp.text, bold = true })
vim.api.nvim_set_hl(0, "CursorLine",                { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment",                   { fg = rp.subtle })
vim.api.nvim_set_hl(0, "MatchParen",                { fg = rp.pine, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError",           { fg = rp.love })
vim.api.nvim_set_hl(0, "DiagnosticWarn",            { fg = rp.gold })
vim.api.nvim_set_hl(0, "DiagnosticHint",            { fg = rp.iris })
vim.api.nvim_set_hl(0, "DiagnosticInfo",            { fg = rp.foam })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary",     { fg = rp.muted })
vim.api.nvim_set_hl(0, "Directory",                 { fg = rp.foam })
vim.api.nvim_set_hl(0, "FloatTitle",                { fg = rp.foam, bold = true })
vim.api.nvim_set_hl(0, "SnacksTitle",               { fg = rp.foam, bold = true })
vim.api.nvim_set_hl(0, "MiniIconsAzure",            { fg = rp.foam })
vim.api.nvim_set_hl(0, "WinBar",                    { fg = rp.subtle, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC",                  { fg = rp.muted, bg = "NONE" })
vim.api.nvim_set_hl(0, "Bold",                      { fg = rp.text, bold = true })
vim.api.nvim_set_hl(0, "WhichKey",                  { fg = rp.text })
vim.api.nvim_set_hl(0, "WhichKeyDesc",              { fg = rp.subtle })
vim.api.nvim_set_hl(0, "WhichKeyGroup",             { fg = rp.iris })
vim.api.nvim_set_hl(0, "WhichKeySeparator",         { fg = rp.muted })
vim.api.nvim_set_hl(0, "WhichKeyValue",             { fg = rp.gold })
vim.api.nvim_set_hl(0, "WhichKeyBorder",            { fg = rp.muted, bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded",                    { fg = rp.muted, bg = "NONE" })

-- snacks + noice (re-applied on ColorScheme — see apply_snacks_noice())
local function apply_snacks_noice()
  vim.api.nvim_set_hl(0, "SnacksPickerFile",              { fg = rp.text })
  vim.api.nvim_set_hl(0, "SnacksPickerDir",               { fg = rp.subtle })
  vim.api.nvim_set_hl(0, "SnacksPickerTree",              { fg = rp.muted })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",            { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder",       { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch",             { fg = rp.rose, bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt",            { fg = rp.text })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle",            { fg = rp.subtle, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals",            { fg = rp.muted })
  vim.api.nvim_set_hl(0, "SnacksPickerRule",              { fg = rp.overlay })
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored",       { fg = rp.muted })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden",        { fg = rp.muted })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored",  { fg = rp.muted })
  vim.api.nvim_set_hl(0, "SnacksPickerSpecial",           { fg = rp.iris })
  vim.api.nvim_set_hl(0, "SnacksInputNormal",             { fg = rp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputBorder",             { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputTitle",              { fg = rp.foam, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksInputIcon",               { fg = rp.iris, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksIndent",                  { fg = rp.overlay })
  vim.api.nvim_set_hl(0, "SnacksIndentScope",             { fg = rp.foam })
  vim.api.nvim_set_hl(0, "SnacksWinSeparator",            { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",            { fg = rp.rose })

  vim.api.nvim_set_hl(0, "NoiceCmdline",                  { fg = rp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",             { fg = rp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",       { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle",        { fg = rp.foam, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirm",                  { fg = rp.text, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceConfirmBorder",            { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceNotificationBorder",       { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenu",                { fg = rp.subtle, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuBorder",          { fg = rp.muted, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",        { fg = rp.text, bg = rp.overlay, bold = true })
  vim.api.nvim_set_hl(0, "NoicePopupmenuMatch",           { fg = rp.rose, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NoiceMini",                     { bg = "NONE" })
  for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = rp.iris, bg = "NONE" })
  end

  local nb = "NONE"
  for _, lvl in ipairs({ "Info", "Hint", "Trace", "Debug" }) do
    local fg = lvl == "Info" and rp.foam or (lvl == "Hint" and rp.iris or rp.text)
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lvl, { fg = fg, bg = nb })
      if part == "Border" then
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = rp.muted, bg = nb })
      end
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lvl, { fg = fg, bg = nb })
  end
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Warn",  { fg = rp.gold, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. "Error", { fg = rp.love, bg = nb })
    if part == "Border" then
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderWarn",  { fg = rp.muted, bg = nb })
      vim.api.nvim_set_hl(0, "SnacksNotifierBorderError", { fg = rp.muted, bg = nb })
    end
  end
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo",  { fg = rp.foam, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn",  { fg = rp.gold, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = rp.love, bg = nb, bold = true })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo",   { fg = rp.foam, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn",   { fg = rp.gold, bg = nb })
  vim.api.nvim_set_hl(0, "SnacksNotifierIconError",  { fg = rp.love, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelWarn",     { fg = rp.gold, bg = nb })
  vim.api.nvim_set_hl(0, "NoiceFormatLevelError",    { fg = rp.love, bg = nb })
end
apply_snacks_noice()

-- ── Dashboard (rose-pine) ─────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = rp.pine })
set_hl({ "DashboardCenter" }, { fg = rp.gold })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = rp.iris })
set_hl({ "DashboardShortCut" }, { fg = rp.love })
set_hl({ "DashboardKey", "SnacksDashboardKey" }, { fg = rp.gold })
set_hl({ "DashboardDesc", "SnacksDashboardDesc" }, { fg = rp.subtle })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = rp.foam })
set_hl({ "SnacksDashboardDir" }, { fg = rp.iris })
set_hl({ "SnacksDashboardFile" }, { fg = rp.text })
set_hl({ "SnacksDashboardSpecial" }, { fg = rp.love })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd",    { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText",   { bg = c.bg6, fg = c.white })

local gs = {
  Add = rp.foam, Change = rp.rose, Delete = rp.love,
  Untracked = rp.subtle, Topdelete = rp.love, Changedelete = rp.rose,
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
  Error = rp.love, Warn = rp.gold, Hint = rp.iris,
  Info = rp.foam, Unnecessary = rp.muted,
}
for sev, color in pairs(diag) do
  vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticFloating"    .. sev, { fg = color, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSign"        .. sev, { fg = color, bg = "NONE" })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind",     { fg = rp.foam, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuKindSel",  { fg = rp.text, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtra",    { fg = rp.muted, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = rp.subtle, bg = "NONE" })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching",      { fg = rp.rose, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = rp.muted })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",  { fg = rp.foam })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",  { fg = rp.foam })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",   { fg = rp.foam })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret",{ fg = rp.iris })

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

vim.api.nvim_set_hl(0, "Visual",    { bg = c.bg9, fg = rp.text })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = rp.subtle })
vim.api.nvim_set_hl(0, "Search",    { bg = c.bg6, fg = rp.text })
vim.api.nvim_set_hl(0, "CurSearch", { bg = rp.gold, fg = rp.base })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

vim.api.nvim_set_hl(0, "Substitute",                  { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "WildMenu",                    { bg = c.bg7, fg = c.white })
vim.api.nvim_set_hl(0, "QuickFixLine",                { bg = c.bg5, fg = rp.foam })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.white, bold = true })
vim.api.nvim_set_hl(0, "LspReferenceText",            { bg = c.bg6, fg = rp.text })
vim.api.nvim_set_hl(0, "LspReferenceRead",            { bg = c.bg6, fg = rp.text })
vim.api.nvim_set_hl(0, "LspReferenceWrite",           { bg = c.bg6, fg = rp.text })

-- ── Markdown (soft rose-pine heading scale) ───────────────────────────────────

set_hl({ "markdownH1", "@markup.heading.1.markdown" }, { fg = rp.iris, bg = "NONE" })
set_hl({ "markdownH2", "@markup.heading.2.markdown" }, { fg = rp.foam, bg = "NONE" })
set_hl({ "markdownH3", "@markup.heading.3.markdown" }, { fg = rp.rose, bg = "NONE" })
set_hl({ "markdownH4", "@markup.heading.4.markdown" }, { fg = rp.gold, bg = "NONE" })
set_hl({ "markdownH5", "@markup.heading.5.markdown" }, { fg = rp.pine, bg = "NONE" })
set_hl({ "markdownH6", "@markup.heading.6.markdown" }, { fg = rp.leaf, bg = "NONE" })

set_hl({
  "markdownH1Delimiter", "markdownH2Delimiter", "markdownH3Delimiter",
  "markdownH4Delimiter", "markdownH5Delimiter", "markdownH6Delimiter",
  "markdownHeadingDelimiter",
  "@markup.heading.1.marker.markdown", "@markup.heading.2.marker.markdown",
  "@markup.heading.3.marker.markdown", "@markup.heading.4.marker.markdown",
  "@markup.heading.5.marker.markdown", "@markup.heading.6.marker.markdown",
}, { fg = rp.subtle, bg = "NONE" })

set_hl({
  "@markup.heading", "@markup.heading.markdown",
  "@markup.heading.1", "@markup.heading.2", "@markup.heading.3",
  "@markup.heading.4", "@markup.heading.5", "@markup.heading.6",
}, { fg = rp.foam, bg = "NONE" })

set_hl({
  "@markup.raw", "@markup.raw.markdown", "@markup.raw.markdown_inline",
  "markdownCode", "markdownCodeDelimiter",
  "@markup.raw.block.markdown", "markdownCodeBlock",
}, { fg = rp.foam, bg = "NONE" })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" },
  { fg = rp.text })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" },
  { fg = rp.text })

set_hl({
  "@markup.link.label", "@markup.link.label.markdown_inline",
  "markdownLinkText", "markdownLink",
}, { fg = rp.foam, bg = "NONE" })

set_hl({
  "@markup.link", "@markup.link.url", "@markup.link.url.markdown_inline",
  "markdownUrl", "markdownLinkDelimiter", "markdownLinkTextDelimiter",
}, { fg = rp.iris, bg = "NONE" })

set_hl({
  "@markup.list", "@markup.list.markdown",
  "markdownListMarker", "markdownOrderedListMarker",
}, { fg = rp.pine })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" },
  { fg = rp.text })

set_hl({ "markdownRule", "markdownDelimiter" }, { fg = rp.subtle })

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
  apply_snacks_noice()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(mode_bg, mode_fg)
  return {
    a = { bg = mode_bg, fg = rp.base, gui = "bold" },
    b = { bg = b_bg, fg = mode_fg },
    c = { bg = c_bg, fg = rp.text },
  }
end

require("config.theme_registry").register("rosy-piny", {
  reapply = reapply,
  lualine = {
    theme = {
      normal   = mode_section(rp.rose, rp.rose),
      insert   = mode_section(rp.foam, rp.foam),
      visual   = mode_section(rp.iris, rp.iris),
      replace  = mode_section(rp.pine, rp.pine),
      command  = mode_section(rp.love, rp.love),
      inactive = {
        a = { bg = c_bg, fg = rp.muted, gui = "bold" },
        b = { bg = c_bg, fg = rp.muted },
        c = { bg = c_bg, fg = rp.muted },
      },
    },
    c_bg         = c_bg,
    filename     = rp.text,
    directory    = rp.muted,
    lazy_updates = rp.gold,
    diff = { added = rp.foam, modified = rp.rose, removed = rp.love },
  },
})
