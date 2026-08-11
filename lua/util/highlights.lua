-- Shared highlight taxonomy for the hand-built colorschemes in `colors/`.
--
-- This module holds **no colors**. It answers only "which highlight groups make
-- up this role" — the part every scheme had spelled out identically, and the
-- part that silently drifts when one scheme is edited and the others are not.
-- Each `colors/*.lua` still decides the color:
--
--   local g = require("util.highlights").groups
--   set_hl(g.string, { fg = c.string })
--
-- A scheme that ever needs to deviate can still pass a literal list instead.
-- The key names mirror the shared palette vocabulary, so call sites read
-- straight across: `g.<role>` gets `c.<role>`.

local M = {}

M.groups = {
    -- ── Syntax ────────────────────────────────────────────────────────────
    string = {
        "String",
        "Character",
        "@string",
        "@string.escape",
        "@character",
    },

    number = {
        "@boolean",
        "Boolean",
        "@number",
        "@number.float",
        "@float",
        "Number",
        "Float",
    },

    variable = {
        "Identifier",
        "@variable",
        "@variable.parameter",
        "@field",
        "@property",
        "@variable.member",
        "@lsp.type.property",
        "@lsp.type.variable",
        "@lsp.type.parameter",
        -- @lsp.typemod.variable.definition is deliberately absent. A `const`
        -- declaration is one token carrying *both* `readonly` and `definition`,
        -- and nvim paints every typemod at the same priority (see
        -- semantic_tokens.lua: `set_mark0(..., 2)`) iterating `pairs`, so
        -- coloring `definition` makes const declarations flip between the
        -- variable color and the constant color at random. Left undefined it
        -- paints nothing, `@lsp.typemod.variable.readonly` wins for constants,
        -- and plain variable definitions still get the variable color from
        -- @lsp.type.variable one priority below.
        "TSVariable",
        "TSVariableBuiltin",
    },

    -- Primitive / built-in types.
    ptype = {
        "Type",
        "@type.builtin",
        "@lsp.type.builtinType",
        "@lsp.typemod.type.defaultLibrary",
        "@lsp.typemod.builtin.defaultLibrary",
    },

    -- User-defined types: struct, interface, enum.
    utype = {
        "@type",
        "@type.definition",
        "@lsp.type.struct",
        "@lsp.type.interface",
        "@lsp.type.enum",
        "@lsp.type.type",
    },

    module = {
        "@module",
        "@module.builtin",
        "@namespace",
        "@lsp.type.namespace",
    },

    operator = {
        "Operator",
        "@operator",
        "Delimiter",
        "@punctuation.delimiter",
    },

    special = {
        "Special",
        "SpecialChar",
        "@keyword.operator",
        "@keyword.modifier",
        "@keyword.directive",
        "@attribute",
        "@string.special",
        "@string.special.url",
    },

    -- ── UI ────────────────────────────────────────────────────────────────

    -- Every window/float/panel body that should sit on the editor background.
    -- Note PmenuSel is deliberately absent: every scheme sets it explicitly
    -- right after, and nvim_set_hl replaces a definition rather than merging,
    -- so listing it here would be dead work.
    surfaces = {
        "Terminal",
        "TermNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "SideBar",
        "SideBarNC",
        "SnacksNormal",
        "SnacksNormalNC",
        "SnacksPickerNormal",
        "SnacksPickerNormalNC",
        "SnacksPickerList",
        "SnacksPickerPreview",
        "SnacksLayoutNormal",
        "SnacksDashboardNormal",
        "SnacksTerminal",
        "SnacksTerminalNormal",
        "SnacksExplorer",
        "SnacksExplorerNormal",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NetrwNormal",
        "NetrwNormalNC",
        "NormalSB",
        "SignColumnSB",
        "StatusLine",
        "StatusLineNC",
        "WhichKeyNormal",
        "WhichKeyFloat",
        "TelescopeNormal",
        "Floaterm",
        "NormalFloat",
        "Pmenu",
        "PmenuSbar",
        "PmenuThumb",
    },

    separators = {
        "WinSeparator",
        "VertSplit",
        "NeoTreeWinSeparator",
        "SnacksWinSeparator",
    },

    -- ── Markdown ──────────────────────────────────────────────────────────

    md_heading_marker = {
        "@markup.heading.1.marker.markdown",
        "@markup.heading.2.marker.markdown",
        "@markup.heading.3.marker.markdown",
        "@markup.heading.4.marker.markdown",
        "@markup.heading.5.marker.markdown",
        "@markup.heading.6.marker.markdown",
        "@punctuation.special.markdown",
        "markdownH1Delimiter",
        "markdownH2Delimiter",
        "markdownH3Delimiter",
        "markdownH4Delimiter",
        "markdownH5Delimiter",
        "markdownH6Delimiter",
        "markdownHeadingDelimiter",
    },

    md_raw = {
        "@markup.raw",
        "@markup.raw.markdown",
        "@markup.raw.markdown_inline",
        "markdownCode",
        "markdownCodeDelimiter",
        "@markup.raw.block.markdown",
        "markdownCodeBlock",
    },

    md_link = {
        "@markup.link",
        "@markup.link.label",
        "@markup.link.label.markdown_inline",
        "markdownLinkText",
        "markdownLink",
    },

    md_list = {
        "@markup.list",
        "@markup.list.markdown",
        "markdownListMarker",
        "markdownOrderedListMarker",
    },
}

-- bufferline.nvim spreads one tab across ~30 highlight groups, each in three
-- states. Spelling that out per scheme is what let `earth` and `earth-light`
-- lose their tab-bar styling entirely without anyone noticing, so the loop
-- lives here and the three colors come from the caller.
--
-- Backgrounds are a literal "NONE" on purpose, not `util.transparent.bg()`:
-- bufferline draws over the tabline, and TabLine/TabLineFill/TabLineSel are
-- what the transparency switch controls (see `util.transparent.editor`).
function M.bufferline(inactive, visible, selected)
    for _, name in ipairs({
        "Background",
        "CloseButton",
        "Modified",
        "Numbers",
        "Diagnostic",
        "ErrorDiagnostic",
        "WarningDiagnostic",
        "InfoDiagnostic",
        "HintDiagnostic",
    }) do
        vim.api.nvim_set_hl(0, "BufferLine" .. name, { bg = "NONE", fg = inactive })
        vim.api.nvim_set_hl(0, "BufferLine" .. name .. "Visible", { bg = "NONE", fg = visible })
        vim.api.nvim_set_hl(0, "BufferLine" .. name .. "Selected", { bg = "NONE", fg = selected })
    end

    for _, sev in ipairs({ "Error", "Warning", "Info", "Hint" }) do
        vim.api.nvim_set_hl(0, "BufferLine" .. sev, { bg = "NONE", fg = inactive })
        vim.api.nvim_set_hl(0, "BufferLine" .. sev .. "Visible", { bg = "NONE", fg = visible })
        vim.api.nvim_set_hl(0, "BufferLine" .. sev .. "Selected", { bg = "NONE", fg = selected, bold = true })
    end

    vim.api.nvim_set_hl(0, "BufferLineDuplicate", { bg = "NONE", fg = inactive, italic = true })
    vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { bg = "NONE", fg = visible, italic = true })
    vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { bg = "NONE", fg = selected, italic = true })
    vim.api.nvim_set_hl(0, "BufferLinePick", { bg = "NONE", fg = inactive, bold = true })
    vim.api.nvim_set_hl(0, "BufferLinePickVisible", { bg = "NONE", fg = visible, bold = true })
    vim.api.nvim_set_hl(0, "BufferLinePickSelected", { bg = "NONE", fg = selected, bold = true })
    vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = "NONE", fg = visible })
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "NONE", fg = selected, bold = true })

    for _, part in ipairs({ "Separator", "SeparatorVisible", "SeparatorSelected", "OffsetSeparator" }) do
        vim.api.nvim_set_hl(0, "BufferLine" .. part, { bg = "NONE", fg = "NONE" })
    end

    vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = "NONE", fg = selected })
    vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
end

return M
