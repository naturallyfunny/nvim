vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "earth-light"

local hl = require("util.highlights")
local g = hl.groups

local function set_hl(groups, opts)
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

-- ── Palette ──────────────────────────────────────────────────────────────────

-- The light twin of `earth`: same roles, darkened so they read on parchment.
local c = {
    -- Anchors
    bg = "#E2DDD4", -- solid fallback when transparency is off
    fg = "#1a1610",
    on_accent = "#1a1610", -- same as `fg`; nothing here needs a lighter pair yet

    -- Syntax
    keyword = "#236030",
    module = "#386428", -- deliberately the same green as `special`
    special = "#386428",
    header = "#1a8020",
    string = "#6b5234",
    const = "#186480",
    ptype = "#5e5a50",
    utype = "#426028",
    var = "#2a2218",
    comment = "#5a7870",

    -- UI chrome
    grey = "#888076",
    subtle = "#7a7868",
    nontext = "#b0ac9c",
    border = "#9a9488",
    sel = "#bad4b6",
    visual = "#8ab880",
    match = "#2a9e40",

    -- Tinted surfaces, one hue per job.
    surf_green = "#d2e8cc",
    surf_blue = "#d0d8ea",
    surf_red = "#e8d0d0",
    surf_earth = "#e4d8b8",
    surf_ghost = "#d4d8cc",
    surf_col = "#dce0e4",
    surf_navy = "#d0d4e0",
    surf_teal = "#c4dcd4",
    surf_lift = "#b4cab0",
    surf_mid = "#c0d4bc",

    -- Neutral surfaces, each step further from `bg`.
    cursorline = "#cac5b8",
    panel = "#b5b0a0",
    backdrop = "#a29e90",

    -- Statusline
    bar_bg = "#dedad0",
    bar_fg = "#6a6858",
    bar_file = "#3d3020",
    bar_updates = "#8a6820",

    -- Diagnostics
    d_error = "#8b3030",
    d_warn = "#8a6010",
    d_hint = "#4a7a40",
    d_info = "#3a6870",

    -- Notification severity accents
    n_warn = "#a07820",
    n_error = "#c04040",
    n_info = "#5a5a5a",
}

local surface = require("util.transparent").bg(c.bg)

-- lualine section b bg.
local b_bg = c.panel
-- lualine section c bg.
local c_bg = c.bar_bg

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
}, { fg = c.keyword })

set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})

set_hl(g.module, { fg = c.module })

set_hl({
    "Constant",
    "@constant.builtin",
    "@variable.builtin",
    "@constant",
    "@lsp.typemod.variable.readonly",
    "@lsp.typemod.variable.defaultLibrary",
}, { fg = c.const })

set_hl(g.string, { fg = c.string })

set_hl(g.ptype, { fg = c.ptype, italic = true })

set_hl(g.utype, { fg = c.utype })

set_hl(g.operator, { fg = c.fg })
set_hl({ "@function.builtin" }, { fg = c.fg })

set_hl({ "@keyword.conditional", "@keyword.repeat" }, { fg = c.keyword })

set_hl(g.special, { fg = c.special })

set_hl(g.number, { fg = c.const })

set_hl({
    "Function",
    "@function",
    "@function.call",
    "@method",
    "@constructor",
    "Title",
    "@lsp.typemod.namespace.declaration",
}, { fg = c.fg })

set_hl(g.variable, { fg = c.var })

set_hl({ "@punctuation.bracket" }, { fg = c.fg })
set_hl({ "@string.delimiter" }, { fg = c.fg })

-- ── UI: transparent / bg-matched backgrounds ──────────────────────────────────

set_hl(g.surfaces, { bg = surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = c.fg, bg = c.sel })

set_hl({ "Normal", "NormalNC" }, { fg = c.fg, bg = surface })

set_hl(g.separators, { fg = c.comment, bg = surface })

vim.api.nvim_set_hl(0, "FloatermBorder", { bg = surface, fg = c.ptype })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = c.ptype })
set_hl({ "NeoTreeFloatBorder", "FloatBorder", "NoiceCmdlinePopupBorder" }, { fg = c.ptype, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = c.utype, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

set_hl({ "MsgArea", "NoiceCmdline", "NoiceCmdlinePopup" }, { fg = c.string, bg = surface })

vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = c.var, bg = surface })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = c.ptype, bg = surface })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm", { bg = c.surf_navy, fg = c.var })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.const, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.match, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchFuzzy", { fg = c.match, bold = true })
vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = c.utype, bold = true })
set_hl({ "LineNr", "LineNrAbove", "LineNrBelow" }, { fg = c.comment })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.var, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = c.cursorline })
vim.api.nvim_set_hl(0, "Comment", { fg = c.comment })
vim.api.nvim_set_hl(0, "MatchParen", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.d_error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.d_warn })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.d_hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.d_info })

-- Notification severity → color. Unlike the mono/venom schemes this one tints
-- a notification with three roles, so each severity carries all three.
for _, lv in ipairs({
    { level = "Info", border = c.ptype, accent = c.utype, body = c.string },
    { level = "Hint", border = c.ptype, accent = c.utype, body = c.string },
    { level = "Trace", border = c.ptype, accent = c.utype, body = c.string },
    { level = "Debug", border = c.ptype, accent = c.utype, body = c.string },
    { level = "Warn", border = c.d_warn, accent = c.d_warn, body = c.d_warn },
    { level = "Error", border = c.d_error, accent = c.d_error, body = c.d_error },
}) do
    local up = lv.level:upper()
    for _, part in ipairs({ "Border", "Title", "Icon" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lv.level, { fg = lv.accent, bg = surface })
    end
    for _, part in ipairs({ "", "Footer", "History" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lv.level, { fg = lv.body, bg = surface })
    end
    -- nvim-notify's border is the one part that does not follow snacks'.
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Border", { fg = lv.border, bg = surface })
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Title", { fg = lv.accent, bg = surface })
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Icon", { fg = lv.accent, bg = surface })
    vim.api.nvim_set_hl(0, "Notify" .. up .. "Body", { fg = lv.body, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lv.level, { fg = lv.accent, bg = surface })
end
vim.api.nvim_set_hl(0, "NoiceMini", { bg = surface })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.comment })
vim.api.nvim_set_hl(0, "Directory", { fg = c.var })
vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = c.fg })
vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = c.special })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = c.utype })
vim.api.nvim_set_hl(0, "SnacksTitle", { fg = c.utype })
vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.bg })
vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
set_hl({ "SnacksPickerDir", "SnacksPickerTree", "SnacksPickerPathIgnored" }, { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = c.subtle })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.grey })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = c.subtle })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.ptype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.ptype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputNormal", { fg = c.var, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.ptype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputTitle", { fg = c.utype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputIcon", { fg = c.utype, bg = surface })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = c.nontext })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.var })
vim.api.nvim_set_hl(0, "WinBar", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "Bold", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "WhichKey", { fg = c.var })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = c.keyword })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = c.grey })
vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = c.ptype })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = c.header })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = c.const })
set_hl({ "DashboardKey", "SnacksDashboardKey", "DashboardShortCut" }, { fg = c.var })
set_hl({ "DashboardDesc", "SnacksDashboardDesc", "DashboardCenter" }, { fg = c.fg })
set_hl({ "SnacksDashboardFile", "SnacksDashboardDir" }, { fg = c.ptype })
set_hl({ "SnacksDashboardSpecial" }, { fg = c.fg })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = c.const })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.surf_green, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.surf_blue, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.surf_red, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffText", { bg = c.sel, fg = c.fg })

local gs = {
    Add = c.var,
    Change = c.const,
    Delete = c.d_error,
    Untracked = c.grey,
    Topdelete = c.d_error,
    Changedelete = c.string,
}
for kind, color in pairs(gs) do
    for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
        vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
    end
end

-- ── Phantom / whitespace ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText", { fg = c.nontext })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.nontext })
vim.api.nvim_set_hl(0, "Whitespace", { fg = c.surf_ghost })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.comment })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = c.surf_col, fg = "NONE" })

-- ── Diagnostics: virtual text, float, sign column ─────────────────────────────

local diag = {
    Error = c.d_error,
    Warn = c.d_warn,
    Hint = c.d_hint,
    Info = c.d_info,
    Unnecessary = c.comment,
}
for sev, color in pairs(diag) do
    vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticFloating" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticSign" .. sev, { fg = color, bg = surface })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind", { fg = c.ptype, bg = surface })
vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtra", { fg = c.grey, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.ptype, bg = surface })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.utype, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = c.grey })
set_hl({ "TelescopeResultsTitle", "TelescopePreviewTitle", "TelescopePromptTitle" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = c.var })

-- ── Flash.nvim ────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch", { bg = c.surf_green, fg = c.fg })
vim.api.nvim_set_hl(0, "FlashCurrent", { bg = c.keyword, fg = c.bg })
vim.api.nvim_set_hl(0, "FlashLabel", { bg = c.var, fg = c.bg, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.backdrop })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal", { bg = surface, fg = c.fg })
vim.api.nvim_set_hl(0, "LazyButton", { bg = c.surf_navy, fg = c.ptype })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.surf_lift, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH1", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH2", { fg = c.ptype, bold = true })
vim.api.nvim_set_hl(0, "LazySpecial", { fg = c.var })
vim.api.nvim_set_hl(0, "LazyCommit", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType", { fg = c.special })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.var })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal", { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual", { bg = c.visual, fg = c.on_accent })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.surf_mid, fg = c.ptype })
vim.api.nvim_set_hl(0, "Search", { bg = c.surf_earth, fg = c.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.keyword, fg = c.bg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.var, fg = c.bg })

vim.api.nvim_set_hl(0, "Substitute", { bg = c.sel, fg = c.fg })
vim.api.nvim_set_hl(0, "WildMenu", { bg = c.sel, fg = c.fg })
vim.api.nvim_set_hl(0, "QuickFixLine", { bg = c.surf_navy, fg = c.fg })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.sel, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "Folded", { fg = c.grey, bg = surface })
set_hl({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }, { bg = c.surf_teal, fg = c.fg })

-- ── Markdown ──────────────────────────────────────────────────────────────────

set_hl({
    "@markup.heading.1",
    "@markup.heading.1.markdown",
    "markdownH1",
}, { fg = c.utype, bold = true, bg = surface })

set_hl({
    "@markup.heading.2",
    "@markup.heading.2.markdown",
    "markdownH2",
}, { fg = c.module, bold = true, bg = surface })

set_hl({
    "@markup.heading.3",
    "@markup.heading.3.markdown",
    "markdownH3",
}, { fg = c.special, bold = true, bg = surface })

set_hl({
    "@markup.heading.4",
    "@markup.heading.4.markdown",
    "markdownH4",
}, { fg = c.var, bold = true, bg = surface })

set_hl({
    "@markup.heading",
    "@markup.heading.markdown",
    "@markup.heading.5",
    "@markup.heading.5.markdown",
    "markdownH5",
    "@markup.heading.6",
    "@markup.heading.6.markdown",
    "markdownH6",
}, { fg = c.ptype, bold = true, bg = surface })

set_hl(g.md_heading_marker, { fg = c.grey, bold = false, bg = surface })

set_hl(g.md_raw, { fg = c.const, bg = surface })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" }, { fg = c.string, bold = true })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" }, { fg = c.var, italic = true })

set_hl(g.md_link, { fg = c.const, bg = surface, underline = false })

set_hl({
    "@markup.link.url",
    "@markup.link.url.markdown_inline",
    "markdownUrl",
}, { fg = c.string, bg = surface, underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.grey })

set_hl(g.md_list, { fg = c.module })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" }, { fg = c.string, italic = true })

set_hl({ "markdownRule" }, { fg = c.border })

-- ── Bufferline ────────────────────────────────────────────────────────────────
local function apply_bufferline()
    hl.bufferline(c.grey, c.subtle, c.fg) -- inactive, visible, selected
end
apply_bufferline()

-- ── Plugin re-application ─────────────────────────────────────────────────────
local accent = c.ptype

local function reapply()
    vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.bg })
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.utype, bold = true })
    vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.grey })
    vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = accent, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = accent, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = accent, bg = surface })
    for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.fg, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = accent, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = c.comment, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { fg = c.fg, bg = c.surf_navy, bold = true })
    vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = accent, bg = surface, bold = true })
    vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.fg, bg = surface })
    local nb = surface
    for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = accent, bg = nb })
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. lvl, { fg = c.fg, bg = nb })
    end
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = accent, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { fg = c.n_warn, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = c.n_error, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = c.n_info, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn", { fg = c.n_warn, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconError", { fg = c.n_error, bg = nb })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.match, bold = true })
    vim.api.nvim_set_hl(0, "SnacksWinSeparator", { fg = c.comment, bg = surface })
    apply_bufferline()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(a_bg, a_fg)
    return {
        a = { bg = a_bg, fg = a_fg, gui = "bold" },
        b = { bg = b_bg, fg = c.fg },
        c = { bg = c_bg, fg = c.bar_fg },
    }
end

require("config.theme_registry").register("earth-light", {
    reapply = reapply,
    lualine = {
        theme = {
            normal = mode_section(c.ptype, c.bg),
            insert = mode_section(c.keyword, c.bg),
            visual = mode_section(c.visual, c.on_accent),
            replace = mode_section(c.const, c.bg),
            command = mode_section(c.utype, c.bg),
            inactive = {
                a = { bg = c_bg, fg = c.border, gui = "bold" },
                b = { bg = c_bg, fg = c.border },
                c = { bg = c_bg, fg = c.border },
            },
        },
        c_bg = c_bg,
        filename = c.bar_file,
        directory = c.bar_fg,
        lazy_updates = c.bar_updates,
        diff = { added = c.fg, modified = c.module, removed = c.d_error },
    },
})
