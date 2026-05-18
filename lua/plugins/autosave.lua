-- VS Code-style "afterDelay" autosave.
-- Saves ~1s after you stop typing, plus immediately on FocusLost / BufLeave.
-- Suppresses LazyVim's format-on-save during autosave so undo stays clean —
-- formatting still runs on a manual :w.
return {
  "okuuva/auto-save.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    debounce_delay = 1000,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },
    condition = function(buf)
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end
      if vim.bo[buf].buftype ~= "" then
        return false
      end
      local skip_ft = { "TelescopePrompt", "NvimTree", "gitcommit", "gitrebase", "svn", "hgcommit" }
      if vim.tbl_contains(skip_ft, vim.bo[buf].filetype) then
        return false
      end
      return true
    end,
    write_all_buffers = false,
    noautocmd = false,
  },
  config = function(_, opts)
    require("auto-save").setup(opts)

    -- Suppress LazyVim's BufWritePre formatter for the autosave write only.
    -- okuuva fires User AutoSaveWritePre right before `:silent! write`, and
    -- User AutoSaveWritePost after — we toggle vim.g.autoformat across that
    -- window. Using vim.g (not vim.b) because the pre event runs before the
    -- buf_call switches into the target buffer.
    local group = vim.api.nvim_create_augroup("AutoSaveNoFormat", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "AutoSaveWritePre",
      callback = function()
        vim.g.__autosave_prev_autoformat = vim.g.autoformat
        vim.g.autoformat = false
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "AutoSaveWritePost",
      callback = function()
        vim.g.autoformat = vim.g.__autosave_prev_autoformat
        vim.g.__autosave_prev_autoformat = nil
      end,
    })
  end,
}
