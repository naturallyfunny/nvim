-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- == CUSTOM CURSOR CONFIGURATION ==
-- n-v-c-sm:block  -> Normal, Visual, Command, Showmatch mode = BLOCK (steady)
-- i-ci-ve:block   -> Insert, Command-insert, Visual-exclude = BLOCK
-- blinkwait700... -> Controls blink speed
-- r               -> Replace mode = Horizontal Bar (block in all modes)

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr-o:block"

-- Disable relative line numbers (use absolute only)
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.signcolumn = "no"
vim.opt.foldcolumn = "0"
vim.opt.cursorline = true
vim.opt.list = false
vim.opt.fillchars:append({ vert = "│", eob = " " })

-- Set Neovim indentation to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.winblend = 0
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0

-- Reserve a dedicated bottom line for the command-line (: / ? ! etc.)
-- so it no longer overwrites the lualine statusline (which sits above it).
-- Fixed at 1 (not auto-growing): lualine never shifts; messages longer than
-- one line trigger a brief "Press ENTER" prompt, then the cmdline clears.
vim.opt.cmdheight = 1

-- Quieter command-line: suppress routine messages so the bottom line stays
-- empty most of the time. W = no "written" on save (autosave noise),
-- I = no intro, c = no ins-completion messages.
vim.opt.shortmess:append("WIc")

-- == ROOT DETECTION ORDER ==
-- LazyVim default is { "lsp", { ".git", "lua" }, "cwd" } — the "lsp" detector
-- is checked FIRST, so it trusts whatever the active language server reports as
-- the project root. That breaks for Go workspaces: when a `go.work` file exists,
-- gopls correctly reports the *workspace* root (the parent folder holding
-- go.work) instead of the individual module. So opening Snacks explorer
-- (<leader>E) from a .go file rooted at the parent instead of the module.
--
-- Fix: check pattern-based detectors FIRST so the closest folder containing
-- .git / go.mod / lua wins (i.e. the actual module you're editing). "lsp" stays
-- as a fallback for projects with no such marker; "cwd" is the final fallback.
-- "lua" is kept so editing this Neovim config still roots correctly.
vim.g.root_spec = { { ".git", "go.mod", "lua" }, "lsp", "cwd" }

-- == SUPPRESS A SINGLE BENIGN LSP WATCHER NOTICE ==
-- gopls registers a `workspace/didChangeWatchedFiles` watcher on the go.work
-- root's `vendor/` dir so it can detect a future `go work vendor`. In an
-- unvendored go.work dev setup that dir legitimately never exists, so Neovim's
-- file-watcher (vim/_watch.lua) fails to start it and emits a once-per-session
-- INFO notice: "watch.watch: ENOENT: no such file or directory". It's cosmetic
-- — file-watching for the real module dirs works fine.
--
-- NOTE: _watch.lua emits this via `vim.notify_once`, NOT `vim.notify`. Wrapping
-- `vim.notify` here does nothing because LazyVim's lazy_notify + Snacks.nvim
-- replace `vim.notify` AFTER options.lua runs, discarding any wrapper. Nothing
-- ever replaces `vim.notify_once`, and notify_once delegates to vim.notify
-- internally — so wrapping notify_once and short-circuiting catches the message
-- reliably before it reaches Snacks. Filter ONLY this exact message.
do
    local orig_notify_once = vim.notify_once
    vim.notify_once = function(msg, level, opts)
        if type(msg) == "string" and msg:match("^watch%.watch: ENOENT") then
            return false
        end
        return orig_notify_once(msg, level, opts)
    end
end

