-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Ensure Snacks Explorer is closed on startup (prevents session restore from keeping it open)
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Close Snacks Explorer on Startup",
  callback = function()
    vim.schedule(function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        if ft and string.match(ft, "^snacks_picker_") then
          vim.api.nvim_win_close(win, true)
        end
      end
    end)
  end,
})

-- Highlight overrides that must outlast plugin re-application.
-- Both noice and snacks re-apply their defaults on ColorScheme events (without default=true).
-- We use vim.schedule to run after all VeryLazy callbacks finish (including plugin setups),
-- and vim.schedule_wrap on ColorScheme to run after all sync ColorScheme callbacks.
local function apply_hl_overrides()
  vim.api.nvim_set_hl(0, "SnacksPickerRule", { fg = "#010101" })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "SnacksPickerTotals", { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#383838" })
  vim.api.nvim_set_hl(0, "SnacksPickerToggle", { fg = "#FFFFFF", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = "#010101", bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#010101", bg = "NONE" })
  -- Noice: noice.setup() calls highlights.setup() after colorscheme loads, overwriting on_highlights
  -- NoiceCmdline is the active group when cmdline.view = "cmdline" (native bottom);
  -- NoiceCmdlinePopup applies when cmdline.view = "cmdline_popup" (floating). Set both.
  vim.api.nvim_set_hl(0, "NoiceCmdline", { fg = "#FFFFFF", bg = "NONE" })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { fg = "#FFFFFF", bg = "NONE" })
  -- Blink: tokyonight sets BlinkCmpLabelMatch = blue1 #2ac3de directly in its blink groups file
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#c94f4f" })
end

-- vim.schedule defers to the next event loop tick, after ALL VeryLazy callbacks
-- (including noice.setup() → highlights.setup()) have finished.
vim.schedule(apply_hl_overrides)

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = vim.schedule_wrap(apply_hl_overrides),
  desc = "Override snacks picker highlights after Snacks re-application",
})

-- FIX KURSOR MERAH (Prioritas Utama)
-- Memaksa highlight cursor setiap kali colorscheme dimuat/diubah
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local red_cursor = { bg = "#FF0000", fg = "#000000" }
    vim.api.nvim_set_hl(0, "Cursor", red_cursor)
    vim.api.nvim_set_hl(0, "TermCursor", red_cursor)
    vim.api.nvim_set_hl(0, "CursorNC", red_cursor)
    -- Tambahan untuk mode Insert (seringkali di-handle terpisah oleh terminal emulator/GUI)
    vim.api.nvim_set_hl(0, "lCursor", red_cursor)
    vim.api.nvim_set_hl(0, "CursorIM", red_cursor)
  end,
})

-- Explicitly ensure Normal highlight group has no blend
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- These colors are based on the tokyonight.nvim configuration in lua/plugins/theme.lua
    local fg_color = "#FFFFFF" -- colors.fg (pure white so cmdline / unhighlighted text isn't grey)
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = fg_color, blend = 0 })
  end,
  desc = "Ensure Normal highlight group has no blend",
})

-- Force Lualine backgrounds to be transparent
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Explicitly set lualine sections to transparent
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*",
      callback = function()
        for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command" }) do
          -- Skip section 'a' (mode) and 'z' (location) so they retain their background color
          for _, section in ipairs({ "b", "c", "x", "y" }) do
            local hl_name = "lualine_" .. section .. "_" .. mode
            local success, hl = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
            if success and hl and hl.background then
              hl.background = nil
              hl.bg = "NONE"
              vim.api.nvim_set_hl(0, hl_name, hl)
            end
          end
        end
      end,
    })
  end,
})
vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("ForceOpaqueMainWindows", { clear = true }),
  callback = function()
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
      local buftype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winid), "buftype")
      local is_float = vim.api.nvim_win_get_config(winid).float

      -- Only set winblend for normal buffer windows, not floating windows
      if buftype == "" and not is_float then
        vim.api.nvim_win_set_option(winid, "winblend", 0)
      end
    end
  end,
  desc = "Ensure main editor windows remain opaque",
})
