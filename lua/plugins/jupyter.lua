return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
        end,
        config = function()
            local function init_and_import(file)
                vim.schedule(function()
                    local ok, kernel = pcall(function()
                        return vim.json.decode(io.open(file, "r"):read("a")).metadata.kernelspec.name
                    end)
                    if not ok or not vim.tbl_contains(vim.fn.MoltenAvailableKernels(), kernel) then
                        return
                    end
                    vim.cmd("MoltenInit " .. kernel)
                    vim.cmd("MoltenImportOutput")
                end)
            end

            vim.api.nvim_create_autocmd("BufAdd", {
                pattern = "*.ipynb",
                callback = function(e)
                    init_and_import(e.file)
                end,
            })

            -- BufAdd does not fire for the file nvim was launched with; BufEnter
            -- covers only that case, hence the vim_did_enter guard.
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*.ipynb",
                callback = function(e)
                    if vim.v.vim_did_enter ~= 1 then
                        init_and_import(e.file)
                    end
                end,
            })

            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "*.ipynb",
                callback = function()
                    if require("molten.status").initialized() == "Molten" then
                        vim.cmd("MoltenExportOutput!")
                    end
                end,
            })

            -- jupytext turns .ipynb into a markdown buffer; otter/quarto only
            -- belong on those, not on every markdown note.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "markdown", "quarto" },
                callback = function()
                    if vim.fn.expand("%:e") == "ipynb" then
                        require("quarto").activate()
                    end
                end,
            })
        end,
    },

    {
        "3rd/image.nvim",
        build = false,
        opts = {
            backend = "kitty",
            processor = "magick_cli",
            max_width_window_percentage = 80,
            max_height_window_percentage = 50,
            integrations = { markdown = { enabled = false } },
        },
    },

    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
        },
    },

    {
        "quarto-dev/quarto-nvim",
        dependencies = { "jmbuhr/otter.nvim" },
        ft = { "quarto", "markdown" },
        opts = {
            lspFeatures = {
                languages = { "python" },
                chunks = "all",
                diagnostics = { enabled = true, triggers = { "BufWritePost" } },
                completion = { enabled = true },
            },
            codeRunner = { enabled = true, default_method = "molten" },
        },
        keys = function()
            local runner = require("quarto.runner")
            return {
                { "<localleader>rc", runner.run_cell, desc = "Run cell" },
                { "<localleader>ra", runner.run_above, desc = "Run cell and above" },
                { "<localleader>rA", runner.run_all, desc = "Run all cells" },
                { "<localleader>rl", runner.run_line, desc = "Run line" },
                { "<localleader>r", runner.run_range, mode = "v", desc = "Run selection" },
                { "<localleader>rr", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-run cell" },
                { "<localleader>oo", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Enter output" },
                { "<localleader>oh", "<cmd>MoltenHideOutput<cr>", desc = "Hide output" },
                { "<localleader>ok", "<cmd>MoltenDelete<cr>", desc = "Delete Molten cell" },
                { "<localleader>oi", "<cmd>MoltenInit<cr>", desc = "Init kernel" },
            }
        end,
    },
}
