return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            servers = {
                -- sourcekit-lsp ships with Xcode (`xcrun sourcekit-lsp`) and is
                -- NOT available in Mason, so register it manually and skip the
                -- Mason install step with `mason = false`.
                sourcekit = {
                    mason = false,
                    cmd = { "sourcekit-lsp" },
                    -- Neovim's filetype names for Objective-C / Objective-C++
                    -- are "objc" / "objcpp" (there is no "objective-c" filetype).
                    filetypes = { "swift", "objc", "objcpp" },
                    root_dir = function(fname)
                        local util = require("lspconfig.util")
                        -- Prefer the build-server manifest, then an Xcode
                        -- project/workspace, then a SwiftPM package, then git.
                        return util.root_pattern("buildServer.json")(fname)
                            or util.root_pattern("*.xcodeproj", "*.xcworkspace")(fname)
                            or util.root_pattern("Package.swift")(fname)
                            or util.root_pattern(".git")(fname)
                    end,
                },
            },
        },
    },
}
