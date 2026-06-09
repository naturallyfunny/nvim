return {
    {
        "wojciech-kulik/xcodebuild.nvim",
        dependencies = {
            -- All three are already installed by LazyVim; listed to match the
            -- upstream docs and to guarantee load order for the dap integration.
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            -- nvim-dap comes from the lazyvim.plugins.extras.dap.core extra.
            -- Declaring it as a dependency makes Lazy load (and let LazyVim
            -- configure) nvim-dap *before* this spec's config runs, so the
            -- codelldb adapter below registers against a ready dap instance.
            "mfussenegger/nvim-dap",
        },
        cmd = {
            "XcodebuildSetup",
            "XcodebuildPicker",
            "XcodebuildBuild",
            "XcodebuildBuildForTesting",
            "XcodebuildBuildRun",
            "XcodebuildRun",
            "XcodebuildTest",
            "XcodebuildTestClass",
            "XcodebuildSelectScheme",
            "XcodebuildSelectDevice",
            "XcodebuildSelectTestPlan",
            "XcodebuildToggleLogs",
            "XcodebuildToggleCodeCoverage",
        },
        keys = {
            { "<leader>X", "", desc = "+Xcode" },
            { "<leader>X.", "<cmd>XcodebuildSetup<cr>", desc = "Project Settings Wizard" },
            { "<leader>Xf", "<cmd>XcodebuildPicker<cr>", desc = "Show All Xcode Actions" },
            { "<leader>Xb", "<cmd>XcodebuildBuild<cr>", desc = "Build Project" },
            { "<leader>XB", "<cmd>XcodebuildBuildForTesting<cr>", desc = "Build For Testing" },
            { "<leader>Xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & Run Project" },
            { "<leader>Xt", "<cmd>XcodebuildTest<cr>", desc = "Run Tests" },
            { "<leader>XT", "<cmd>XcodebuildTestClass<cr>", desc = "Run This Test Class" },
            { "<leader>Xs", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select Scheme" },
            { "<leader>Xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select Device" },
            { "<leader>Xp", "<cmd>XcodebuildSelectTestPlan<cr>", desc = "Select Test Plan" },
            { "<leader>Xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Xcode Logs" },
            { "<leader>Xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", desc = "Toggle Code Coverage" },

            -- Debugging entry points. These start an xcodebuild-driven dap
            -- session; once running, LazyVim's standard <leader>d* keymaps
            -- (step/continue/breakpoints/terminate) work as usual. We use dd/dD
            -- so we don't collide with LazyVim's defaults (dr = REPL, dt = Terminate).
            {
                "<leader>dd",
                function()
                    require("xcodebuild.integrations.dap").build_and_debug()
                end,
                desc = "Build & Debug (Xcode)",
            },
            {
                "<leader>dD",
                function()
                    require("xcodebuild.integrations.dap").debug_without_build()
                end,
                desc = "Debug Without Building (Xcode)",
            },
        },
        config = function()
            require("xcodebuild").setup({})

            -- nvim-dap integration with the codelldb adapter, following
            -- wojciech-kulik/ios-dev-starter-nvim. dap is already loaded and
            -- configured by LazyVim at this point (declared as a dependency above).
            local dap = require("xcodebuild.integrations.dap")

            -- TODO: point this at your codelldb adapter binary. With LazyVim +
            -- Mason you can install it via `:MasonInstall codelldb`, in which case
            -- the path is usually:
            --   vim.fn.expand("$MASON/packages/codelldb/extension/adapter/codelldb")
            -- Otherwise download codelldb from the vadimcn/codelldb releases and
            -- point at extension/adapter/codelldb inside the extracted VSIX.
            local codelldb_path = vim.fn.expand("~/tools/codelldb/extension/adapter/codelldb")

            dap.setup(codelldb_path)
        end,
    },

    -- Low-effort lualine integration: show the selected simulator/device (and
    -- OS) while editing Swift files. lualine is provided by LazyVim, so we only
    -- extend its existing opts. Guarded with pcall so it is inert until a
    -- project has been configured via the xcodebuild wizard.
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            local function xcode_device()
                local ok, project = pcall(require, "xcodebuild.project.config")
                if not ok or not project.settings or not project.settings.deviceName then
                    return ""
                end
                local s = project.settings
                local os_suffix = s.os and (" (" .. s.os .. ")") or ""
                return " " .. s.deviceName .. os_suffix
            end

            opts.sections = opts.sections or {}
            opts.sections.lualine_x = opts.sections.lualine_x or {}
            table.insert(opts.sections.lualine_x, 1, {
                xcode_device,
                cond = function()
                    return vim.bo.filetype == "swift"
                end,
            })
        end,
    },
}
