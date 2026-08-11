vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "mono"

local hl = require("util.highlights")
local g = hl.groups

local function set_hl(groups, opts)
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

-- ── Palette ──────────────────────────────────────────────────────────────────

local c = {
    -- Anchors
    fg = "#FFFFFF",
    emph = "#FAFAFA",
    on_accent = "#010101", -- text drawn on top of a bright fill
    bg = "#000000", -- solid fallback when transparency is off

    -- Foreground ladder, quiet → loud. Being monochrome, each step serves both
    -- syntax and chrome; grep `c.<name>` for who uses one.
    shade = "#3a3a3a",
    gutter = "#4a4a4a",
    inactive = "#4a4a4a",
    grey = "#505050",
    subtle = "#6a6a6a",
    faint = "#6d6d6d",
    soft = "#8a8a8a",
    clear = "#aaaaaa",
    bright = "#c4c4c4",
    border = "#E0E0E0",
    scope = "#e8e8e8",

    -- Background ramp, each step further from `bg`.
    bg0 = "#101010",
    bg1 = "#1a1a1a",
    bg2 = "#1c1c1c",
    bg3 = "#1e1e1e",
    bg4 = "#202020",
    bg5 = "#252525",
    bg6 = "#2a2a2a",
    bg7 = "#303030",
    bg8 = "#383838",
    bg9 = "#404040",

    -- Diagnostics
    d_error = "#8b3a3a",
    d_warn = "#c4a35a",
    d_hint = "#6b8e6b",
    d_info = "#6a5454",

    -- Notification severity accents (warmer than the diagnostic pair on purpose)
    n_warn = "#e5c07b",
    n_error = "#e06c75",
}

-- Surface background: "none" when transparency is on (the default), else the
-- solid editor bg. Used everywhere a UI surface would otherwise be hardcoded
-- transparent, so `vim.g.transparent = false` makes the whole scheme opaque.
local surface = require("util.transparent").bg(c.bg)

-- lualine section b bg.
local b_bg = c.bg5
-- lualine section c bg.
local c_bg = c.bg0

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
}, { fg = c.faint, italic = false })

set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {}) -- let treesitter handle keywords so @keyword.return.go can fire
-- Let treesitter @constant win for user-declared consts; nil/true/false still
-- fall to @lsp.typemod.variable.defaultLibrary. Clearing readonly.go alone is
-- not enough: @lsp.type.variable.go sits one priority *below* the typemods but
-- still above treesitter, so it would repaint every const with the variable
-- color. Both have to be silent for treesitter to show through.
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.go", {})
vim.api.nvim_set_hl(0, "@lsp.type.variable.go", {})

set_hl(g.module, { fg = c.grey })

set_hl({
    "Constant",
    "@constant.builtin",
    "@variable.builtin",
    "@constant",
    "@lsp.typemod.variable.readonly",
    "@lsp.typemod.variable.defaultLibrary",
}, { fg = c.soft })

set_hl(g.string, { fg = c.soft })

set_hl(g.ptype, { fg = c.faint, italic = true })

set_hl(g.utype, { fg = c.bright })

set_hl(g.operator, { fg = c.clear })
set_hl({ "@function.builtin" }, { fg = c.fg })

set_hl({ "@keyword.repeat" }, { fg = c.faint })
set_hl({ "@keyword.conditional" }, { fg = c.clear })

set_hl(g.special, { fg = c.clear })

set_hl(g.number, { fg = c.soft })

set_hl({
    "Function",
    "@function",
    "@function.call",
    "@method",
    "@constructor",
    "Title",
    "@lsp.typemod.namespace.declaration",
}, { fg = c.fg, bold = false })

set_hl(g.variable, { fg = c.fg })

set_hl({ "@punctuation.bracket", "@string.delimiter" }, { fg = c.fg })

-- ── UI: backgrounds ───────────────────────────────────────────────────────────

set_hl({ "Normal", "NormalNC" }, { fg = c.fg, bg = surface })

set_hl(g.surfaces, { bg = surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = c.fg, bg = c.bg3 })

set_hl(g.separators, { fg = c.faint, bg = surface })

vim.api.nvim_set_hl(0, "FloatermBorder", { bg = surface, fg = c.border })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = c.faint })
set_hl({ "NeoTreeFloatBorder", "FloatBorder", "NoiceCmdlinePopupBorder" }, { fg = c.faint, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

set_hl({ "MsgArea", "NoiceCmdline", "NoiceCmdlinePopup" }, { fg = c.fg, bg = surface })

vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = c.faint, bg = surface })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm", { bg = c.bg6, fg = c.fg })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.bright, fg = c.on_accent, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.soft })
set_hl({ "LineNr", "LineNrAbove", "LineNrBelow" }, { fg = c.gutter })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.scope, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = surface })
vim.api.nvim_set_hl(0, "Comment", { fg = c.bg3 })
vim.api.nvim_set_hl(0, "MatchParen", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.d_error })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.d_warn })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.d_hint })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.d_info })

-- Notification severity → color. Snacks, nvim-notify and noice each split a
-- notification into differently-named parts; the severity mapping is the part
-- worth reading, so it sits in one table.
for _, lv in ipairs({
    { level = "Info", fg = c.fg },
    { level = "Hint", fg = c.fg },
    { level = "Trace", fg = c.fg },
    { level = "Debug", fg = c.fg },
    { level = "Warn", fg = c.d_warn },
    { level = "Error", fg = c.d_error },
}) do
    for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer", "History" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. lv.level, { fg = lv.fg, bg = surface })
    end
    for _, part in ipairs({ "Border", "Title", "Icon", "Body" }) do
        vim.api.nvim_set_hl(0, "Notify" .. lv.level:upper() .. part, { fg = lv.fg, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceFormatLevel" .. lv.level, { fg = lv.fg, bg = surface })
end
vim.api.nvim_set_hl(0, "NoiceMini", { bg = surface })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.d_info })
set_hl({ "Directory", "SnacksPickerFile", "MiniIconsAzure", "FloatTitle", "SnacksTitle" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.on_accent })
vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.bg8 })
vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = c.faint })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.faint, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.faint, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = c.shade })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = c.subtle })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = c.shade })
vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = c.subtle })
vim.api.nvim_set_hl(0, "SnacksInputNormal", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.faint, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputTitle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputIcon", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksIndent", { fg = c.faint })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.scope })
vim.api.nvim_set_hl(0, "WinBar", { fg = c.soft, bg = surface })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = c.soft, bg = surface })
vim.api.nvim_set_hl(0, "Bold", { fg = c.fg, bold = true })
set_hl({ "WhichKey", "WhichKeyDesc", "WhichKeyGroup", "WhichKeySeparator", "WhichKeyValue" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = c.faint, bg = surface })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({
    "DashboardHeader",
    "DashboardCenter",
    "DashboardFooter",
    "DashboardShortCut",
    "DashboardIcon",
    "DashboardKey",
    "DashboardDesc",
    "SnacksDashboardHeader",
    "SnacksDashboardIcon",
    "SnacksDashboardKey",
    "SnacksDashboardDesc",
    "SnacksDashboardDir",
    "SnacksDashboardFile",
    "SnacksDashboardFooter",
    "SnacksDashboardSpecial",
}, { fg = c.fg })

-- ── Diff & git signs ──────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = c.bg2, fg = "NONE" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = c.bg2, fg = c.grey })
vim.api.nvim_set_hl(0, "DiffText", { bg = c.bg6, fg = c.fg })

local gs = {
    Add = c.bright,
    Change = c.soft,
    Delete = c.grey,
    Untracked = c.shade,
    Topdelete = c.grey,
    Changedelete = c.faint,
}
for kind, color in pairs(gs) do
    for _, suffix in ipairs({ "", "Nr", "Ln", "Staged" }) do
        vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suffix, { fg = color })
    end
end

-- ── Phantom / whitespace ──────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "NonText", { fg = c.bg6 })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.bg6 })
vim.api.nvim_set_hl(0, "Whitespace", { fg = c.bg2 })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = c.gutter })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = c.bg1, fg = "NONE" })

-- ── Diagnostics: virtual text, float, sign column ─────────────────────────────

local diag = {
    Error = c.d_error,
    Warn = c.d_warn,
    Hint = c.d_hint,
    Info = c.d_info,
    Unnecessary = c.d_info,
}
for sev, color in pairs(diag) do
    vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticFloating" .. sev, { fg = color, bg = surface })
    vim.api.nvim_set_hl(0, "DiagnosticSign" .. sev, { fg = color, bg = surface })
end

-- ── Completion menu ───────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "PmenuKind", { fg = c.clear, bg = surface })
vim.api.nvim_set_hl(0, "PmenuKindSel", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtra", { fg = c.faint, bg = surface })
vim.api.nvim_set_hl(0, "PmenuExtraSel", { fg = c.clear, bg = surface })

-- ── Telescope ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = c.grey })
set_hl(
    { "TelescopeResultsTitle", "TelescopePreviewTitle", "TelescopePromptTitle", "TelescopeSelectionCaret" },
    { fg = c.fg }
)

-- ── Flash.nvim ────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "FlashMatch", { bg = c.bg6, fg = c.fg })
vim.api.nvim_set_hl(0, "FlashCurrent", { bg = c.bright, fg = c.on_accent })
vim.api.nvim_set_hl(0, "FlashLabel", { bg = c.fg, fg = c.on_accent, bold = true })
vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = c.bg8 })

-- ── Lazy.nvim ─────────────────────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "LazyNormal", { bg = surface, fg = c.fg })
vim.api.nvim_set_hl(0, "LazyButton", { bg = c.bg2, fg = c.clear })
vim.api.nvim_set_hl(0, "LazyButtonActive", { bg = c.bg6, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH1", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "LazyH2", { fg = c.clear, bold = true })
vim.api.nvim_set_hl(0, "LazySpecial", { fg = c.soft })
vim.api.nvim_set_hl(0, "LazyCommit", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyCommitType", { fg = c.soft })
vim.api.nvim_set_hl(0, "LazyReasonPlugin", { fg = c.soft })
vim.api.nvim_set_hl(0, "LazyProgressDone", { fg = c.fg })
vim.api.nvim_set_hl(0, "LazyProgressTodo", { fg = c.grey })
vim.api.nvim_set_hl(0, "LazyLocal", { fg = c.grey })

-- ── Visual selection & search ─────────────────────────────────────────────────

vim.api.nvim_set_hl(0, "Visual", { bg = c.bg9, fg = c.fg })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = c.bg4, fg = c.clear })
vim.api.nvim_set_hl(0, "Search", { bg = c.bg6, fg = c.fg })
vim.api.nvim_set_hl(0, "CurSearch", { bg = c.bright, fg = c.on_accent })
vim.api.nvim_set_hl(0, "IncSearch", { bg = c.fg, fg = c.on_accent })

vim.api.nvim_set_hl(0, "Substitute", { bg = c.bg7, fg = c.fg })
vim.api.nvim_set_hl(0, "WildMenu", { bg = c.bg7, fg = c.fg })
vim.api.nvim_set_hl(0, "QuickFixLine", { bg = c.bg5, fg = c.fg })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = c.bg7, fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "Folded", { fg = c.faint, bg = surface })
set_hl({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }, { bg = c.bg6, fg = c.fg })

-- ── Markdown ──────────────────────────────────────────────────────────────────

set_hl({
    "@markup.heading",
    "@markup.heading.markdown",
    "@markup.heading.1",
    "@markup.heading.2",
    "@markup.heading.3",
    "@markup.heading.4",
    "@markup.heading.5",
    "@markup.heading.6",
    "@markup.heading.1.markdown",
    "@markup.heading.2.markdown",
    "@markup.heading.3.markdown",
    "@markup.heading.4.markdown",
    "@markup.heading.5.markdown",
    "@markup.heading.6.markdown",
    "markdownH1",
    "markdownH2",
    "markdownH3",
    "markdownH4",
    "markdownH5",
    "markdownH6",
}, { fg = c.fg, bold = true, bg = surface })

set_hl(g.md_heading_marker, { fg = c.clear, bold = false, bg = surface })

set_hl(g.md_raw, { fg = c.faint, bg = surface })

set_hl({ "@markup.strong", "@markup.strong.markdown_inline", "markdownBold" }, { fg = c.fg, bold = true })

set_hl({ "@markup.italic", "@markup.italic.markdown_inline", "markdownItalic" }, { fg = c.fg, italic = true })

set_hl(g.md_link, { fg = c.bright, bg = surface, underline = false })

set_hl({
    "@markup.link.url",
    "@markup.link.url.markdown_inline",
    "markdownUrl",
}, { fg = c.soft, bg = surface, underline = false })

set_hl({ "markdownLinkDelimiter", "markdownLinkTextDelimiter" }, { fg = c.clear })

set_hl(g.md_list, { fg = c.soft })

set_hl({ "@markup.quote", "@markup.quote.markdown", "markdownBlockquote" }, { fg = c.faint, italic = true })

set_hl({ "markdownRule" }, { fg = c.soft })

-- ── Bufferline ────────────────────────────────────────────────────────────────
local function apply_bufferline()
    hl.bufferline(c.subtle, c.clear, c.fg) -- inactive, visible, selected
end
apply_bufferline()

-- ── Plugin re-application ─────────────────────────────────────────────────────
-- noice/snacks re-apply their own defaults on ColorScheme events, clobbering the
-- groups below. reapply() is invoked from lua/config/autocmds.lua after they run.
local function reapply()
    vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.on_accent })
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.fg })
    vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.bg8 })
    vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.faint, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.faint, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksWinSeparator", { fg = c.faint, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = c.faint, bg = surface })
    for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.fg, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = c.faint, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = c.faint, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { fg = c.fg, bg = c.bg3, bold = true })
    vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = c.fg, bg = surface, bold = true })
    vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.fg, bg = surface })
    local nb = surface
    for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = c.faint, bg = nb })
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. lvl, { fg = c.fg, bg = nb })
    end
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = c.subtle, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleWarn", { fg = c.n_warn, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleError", { fg = c.n_error, bg = nb, bold = true })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = c.subtle, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconWarn", { fg = c.n_warn, bg = nb })
    vim.api.nvim_set_hl(0, "SnacksNotifierIconError", { fg = c.n_error, bg = nb })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.soft })
    apply_bufferline()
end

-- ── Lualine registration ──────────────────────────────────────────────────────

local function mode_section(a_bg, a_fg)
    return {
        a = { bg = a_bg, fg = a_fg, gui = "bold" },
        b = { bg = b_bg, fg = c.fg },
        c = { bg = c_bg, fg = c.subtle },
    }
end

require("config.theme_registry").register("mono", {
    reapply = reapply,
    lualine = {
        theme = {
            normal = mode_section(c_bg, c.fg),
            insert = mode_section(c.emph, c_bg),
            visual = mode_section(c.shade, c.fg),
            replace = mode_section(c_bg, c.fg),
            command = mode_section(c_bg, c.fg),
            inactive = {
                a = { bg = c_bg, fg = c.inactive, gui = "bold" },
                b = { bg = c_bg, fg = c.inactive },
                c = { bg = c_bg, fg = c.inactive },
            },
        },
        c_bg = c_bg,
        filename = c.fg,
        directory = c.subtle,
        lazy_updates = c.fg,
        diff = { added = c.fg, modified = c.fg, removed = c.fg },
    },
})
