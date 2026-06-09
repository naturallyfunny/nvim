return {
    -- Treesitter parser for Swift.
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "swift" })
            end
        end,
    },

    -- Formatting: SwiftFormat (formatter ships with conform.nvim).
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                swift = { "swiftformat" },
            },
        },
    },

    -- Linting: SwiftLint (linter ships with nvim-lint).
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                swift = { "swiftlint" },
            },
        },
    },
}
