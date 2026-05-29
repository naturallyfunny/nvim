-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Ensure Snacks Explorer is closed on startup (prevents session restore from keeping it open)
-- vim.api.nvim_create_autocmd("VimEnter", {
--   desc = "Close Snacks Explorer on Startup",
--   callback = function()
--     vim.schedule(function()
--       local wins = vim.api.nvim_tabpage_list_wins(0)
--       for _, win in ipairs(wins) do
--         local buf = vim.api.nvim_win_get_buf(win)
--         local ft = vim.bo[buf].filetype
--         if ft and string.match(ft, "^snacks_picker_") then
--           vim.api.nvim_win_close(win, true)
--         end
--       end
--     end)
--   end,
-- })

-- Highlight overrides that must outlast plugin re-application.
-- Both noice and snacks re-apply their defaults on ColorScheme events (without default=true).
-- We use vim.schedule to run after all VeryLazy callbacks finish (including plugin setups),
-- and vim.schedule_wrap on ColorScheme to run after all sync ColorScheme callbacks.
-- The actual colors live in each colorscheme (colors/*.lua), which registers a
-- reapply() with lua/config/theme_registry.lua. This keeps zero hardcoded colors here,
-- so switching :colorscheme swaps every UI accent without touching this file.
local function apply_hl_overrides()
  local spec = require("config.theme_registry").current()
  if spec and spec.reapply then
    spec.reapply()
  end
end

-- vim.schedule defers to the next event loop tick, after ALL VeryLazy callbacks
-- (including noice.setup() → highlights.setup()) have finished.
vim.schedule(apply_hl_overrides)

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = vim.schedule_wrap(apply_hl_overrides),
  desc = "Override snacks picker highlights after Snacks re-application",
})


-- Persist active colorscheme so the next startup restores it
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local f = vim.fn.stdpath("state") .. "/colorscheme"
    vim.fn.writefile({ vim.g.colors_name }, f)
  end,
  desc = "Save active colorscheme to state file",
})

-- Show markdown as raw text (LazyVim defaults conceallevel=2, which hides
-- code fences, link syntax, emphasis markers, etc.) and turn off the spell
-- checker so non-English words don't get red squiggles.
-- Show ~ for end-of-buffer only in real file windows; all other buffers (dashboard,
-- lazy, terminal, etc.) inherit the global eob=" " and stay clean.
-- FileType fires before the first paint so there is no visible flash.
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then return end -- skip floats
    if vim.bo.buftype == "" and vim.bo.filetype ~= "netrw" then
      vim.wo.fillchars = "vert:│,eob:~"
    else
      vim.wo.fillchars = "vert:│,eob: "
    end
  end,
  desc = "eob tilde only in file buffers",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.spell = false
  end,
  desc = "Raw markdown rendering, no spell-check",
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
