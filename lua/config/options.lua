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

