vim.cmd("hi clear")
if vim.fn.exists("syntax_on") ~= 0 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "venom-light"

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
    fg = "#010101",
    emph = "#303030",
    scope = "#000000",
    on_accent = "#FEFAFE", -- text drawn on top of a dark fill
    bg = "#D0D0D0", -- solid fallback when transparency is off; matches ghostty bg

    -- Syntax
    keyword = "#555555",
    ret = "#404040", -- return and conditional keywords
    module = "#777777",
    string = "#7b998c",
    bconst = "#3a6ea8", -- builtin constants: nil, true, self…
    const = "#7d4f80",
    ptype = "#4a4d5c", -- primitive/builtin types, rendered italic
    utype = "#3d4a7a",
    comment = "#7a7d5e",

    -- Neutral ladder, quiet → loud. Same order as the dark schemes, so the
    -- lightness runs the opposite way: on a light bg, louder means darker.
    shade = "#aaaaaa",
    faint = "#aaaaaa",
    soft = "#888888",
    inactive = "#888888",
    gutter = "#808080",
    subtle = "#777777",
    clear = "#555555",
    grey = "#555555",
    border = "#555555",
    bright = "#2a2a2a",

    -- Background ramp, each step further from `bg`. Numbering is shared with
    -- mono and venom, so gaps stay put rather than being renumbered.
    bg0 = "#cccccc",
    bg1 = "#c4c4c4",
    bg2 = "#c0c0c0",
    bg3 = "#bbbbbb",
    bg4 = "#b8b8b8",
    bg5 = "#b0b0b0",
    bg6 = "#a8a8a8",
    bg7 = "#a0a0a0",
    bg8 = "#989898",
    bg9 = "#909090",

    -- Diagnostics
    d_error = "#8b2020",
    d_warn = "#8a6010",
    d_hint = "#3a6a3a",
    d_info = "#5a4444",

    -- Notification severity accents
    n_warn = "#8a6010",
    n_error = "#c04040",
}

local surface = require("util.transparent").bg(c.bg)

-- lualine section b bg.
local b_bg = c.bg7
-- lualine section c bg.
local c_bg = c.bg0

-- ── Syntax ───────────────────────────────────────────────────────────────────

set_hl({
    "Keyword",
    "Statement",
    "Include",
    "Structure",
    "Define",
    "PreProc",
    "Exception",
    "@keyword",
    "@keyword.function",
    "@keyword.import",
    "@include",
}, { fg = c.keyword, italic = false })

set_hl({ "Conditional", "@keyword.conditional" }, { fg = c.clear })
set_hl({ "Repeat", "@keyword.repeat" }, { fg = c.keyword })
set_hl({ "@keyword.return", "@keyword.return.go" }, { fg = c.clear, italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.go", {}) -- let treesitter @constant win; nil/true/false fall to @lsp.typemod.variable.defaultLibrary

set_hl(g.module, { fg = c.module })

set_hl(
    { "Constant", "@constant.builtin", "@variable.builtin", "@lsp.typemod.variable.defaultLibrary" },
    { fg = c.bconst }
)
set_hl({ "@constant", "@lsp.typemod.variable.readonly" }, { fg = c.const })

set_hl(g.string, { fg = c.string })

set_hl(g.ptype, { fg = c.ptype })

set_hl(g.utype, { fg = c.utype })

set_hl(g.operator, { fg = c.ret })
set_hl({
    "@function.builtin",
    "@lsp.typemod.function.defaultLibrary",
    "@lsp.typemod.method.defaultLibrary",
}, { fg = c.fg, italic = true })

set_hl(g.special, { fg = c.clear })

set_hl(g.number, { fg = c.const })

set_hl({
    "Function",
    "@function",
    "@function.call",
    "@method.call",
    "Title",
    "@lsp.typemod.namespace.declaration",
}, { fg = c.fg, bold = false })

set_hl(g.variable, { fg = c.emph })

set_hl({ "@punctuation.bracket", "@string.delimiter", "@constructor" }, { fg = c.clear })

-- ── UI: backgrounds ───────────────────────────────────────────────────────────

set_hl({ "Normal", "NormalNC" }, { fg = c.fg, bg = surface })

set_hl(g.surfaces, { bg = surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = c.fg, bg = c.bg3 })

set_hl(g.separators, { fg = c.border, bg = surface })

set_hl({
    "FloatermBorder",
    "NeoTreeFloatBorder",
    "FloatBorder",
    "NoiceCmdlinePopupBorder",
}, { fg = c.border, bg = surface })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = c.border })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "NoiceCmdlineIconSearch" })

for _, name in ipairs({ "Cmdline", "Lua", "Help", "Input", "Filter", "Search_up", "Search_down" }) do
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. name, { link = "NoiceCmdlineIconSearch" })
end

vim.api.nvim_set_hl(0, "MsgArea", { fg = c.fg, bg = surface })
-- Native message-area groups (Noice off → these drive the bottom line).
set_hl({ "Question", "MoreMsg", "ModeMsg" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = c.n_error })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = c.n_warn })
vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.fg, bg = surface })

vim.api.nvim_set_hl(0, "NoiceConfirm", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = c.border, bg = surface })
vim.api.nvim_set_hl(0, "NoiceFormatConfirm", { bg = c.bg6, fg = c.fg })
vim.api.nvim_set_hl(0, "NoiceFormatConfirmDefault", { bg = c.bright, fg = c.on_accent, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = c.soft })
set_hl({ "LineNr", "LineNrAbove", "LineNrBelow" }, { fg = c.gutter })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.scope, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = c.bg3 })
vim.api.nvim_set_hl(0, "Comment", { fg = c.comment })
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
vim.api.nvim_set_hl(0, "NoiceMini", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = c.d_info })
set_hl({ "Directory", "SnacksPickerFile", "MiniIconsAzure", "FloatTitle", "SnacksTitle" }, { fg = c.fg })

set_hl({ "SnacksPickerPrompt", "SnacksPickerMatch", "SnacksPickerTotals" }, { fg = c.fg })
set_hl({ "SnacksPickerBorder", "SnacksPickerInputBorder" }, { fg = c.border, bg = surface })
set_hl({ "SnacksPickerPathIgnored", "SnacksPickerGitStatusIgnored" }, { fg = c.shade })
set_hl({ "SnacksPickerPathHidden", "SnacksPickerGitStatusUntracked" }, { fg = c.subtle })
vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.on_accent })
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.bg8 })
vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = c.grey })

set_hl({ "SnacksInputNormal", "SnacksInputTitle", "SnacksInputIcon" }, { fg = c.fg, bg = surface })
vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = c.border, bg = surface })

vim.api.nvim_set_hl(0, "SnacksIndent", { fg = c.shade })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = c.scope })
set_hl({ "WinBar", "WinBarNC" }, { fg = c.soft, bg = surface })
vim.api.nvim_set_hl(0, "Bold", { fg = c.fg, bold = true })

set_hl({ "WhichKey", "WhichKeyDesc", "WhichKeyGroup", "WhichKeySeparator", "WhichKeyValue" }, { fg = c.fg })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = c.border, bg = surface })

-- ── Dashboard ─────────────────────────────────────────────────────────────────

set_hl({ "DashboardHeader", "SnacksDashboardHeader" }, { fg = c.fg })
set_hl({ "DashboardIcon", "SnacksDashboardIcon" }, { fg = c.fg })
set_hl({ "DashboardKey", "DashboardShortCut", "SnacksDashboardKey" }, { fg = c.fg })
set_hl({ "DashboardDesc", "DashboardCenter", "SnacksDashboardDesc" }, { fg = c.clear })
set_hl({ "SnacksDashboardFile" }, { fg = c.clear })
set_hl({ "SnacksDashboardDir" }, { fg = c.soft })
set_hl({ "DashboardFooter", "SnacksDashboardFooter" }, { fg = c.soft })
set_hl({ "SnacksDashboardSpecial" }, { fg = c.fg })

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
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#808080" })
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

local function reapply()
    vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = c.on_accent })
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = c.fg })
    vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = c.fg })
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = c.bg8 })
    vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = c.border, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = c.border, bg = surface })
    vim.api.nvim_set_hl(0, "SnacksWinSeparator", { fg = c.border, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = c.border, bg = surface })
    for _, suffix in ipairs({ "", "Search", "Filter", "Lua", "Help", "Input", "Cmdline" }) do
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. suffix, { fg = c.fg, bg = surface })
    end
    vim.api.nvim_set_hl(0, "NoiceNotificationBorder", { fg = c.border, bg = surface })
    vim.api.nvim_set_hl(0, "NoiceNotificationTitle", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { fg = c.fg, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = c.border, bg = surface })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { fg = c.fg, bg = c.bg3, bold = true })
    vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = c.fg, bg = surface, bold = true })
    vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = c.fg, bg = surface })
    local nb = surface
    for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
        vim.api.nvim_set_hl(0, "SnacksNotifierBorder" .. lvl, { fg = c.border, bg = nb })
        vim.api.nvim_set_hl(0, "SnacksNotifier" .. lvl, { fg = c.fg, bg = nb })
    end
    vim.api.nvim_set_hl(0, "SnacksNotifierTitleInfo", { fg = c.fg, bg = nb })
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

require("config.theme_registry").register("venom-light", {
    reapply = reapply,
    lualine = {
        theme = {
            normal = mode_section(c_bg, c.fg),
            insert = mode_section(c.fg, c.on_accent),
            visual = mode_section(c.bg9, c.fg),
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
