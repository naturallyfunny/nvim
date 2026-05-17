-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- == CUSTOM CURSOR CONFIGURATION ==
-- n-v-c-sm:block  -> Normal, Visual, Command, Showmatch mode = BLOCK (Steady/Diam)
-- i-ci-ve:block   -> Insert, Command-insert, Visual-exclude = BLOCK
-- blinkwait700... -> Mengatur kecepatan kedip (Blinking)
-- r               -> Replace mode = Horizontal Bar (Optional, tapi user minta Block di semua mode, jadi kita set block)

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr-o:block"

-- Disable relative line numbers (use absolute only)
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.signcolumn = "no"
vim.opt.foldcolumn = "0"
vim.opt.cursorline = true
vim.opt.list = false
vim.opt.fillchars:append({ vert = " " })

-- Set Neovim indentation to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.winblend = 0
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0

