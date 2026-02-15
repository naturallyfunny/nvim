-- A more stable auto-save plugin: LudoPinelli/auto-save.nvim
return {
  "LudoPinelli/auto-save.nvim",
  -- Load on non-intrusive events
  event = { "InsertLeave", "FocusLost", "BufLeave" },
  opts = {
    enabled = true,
    execution_message = {
      message = "✓ auto-saved",
      dim = 0,
      cleaning_interval = 1250,
    },
    -- Use triggers that are guaranteed not to interfere with editing.
    -- This configuration will NOT save while you are typing.
    trigger_events = { "InsertLeave", "FocusLost", "BufLeave" },
    condition = function(buf)
      -- Use early returns to make the conditions clearer
      if not vim.api.nvim_buf_is_valid(buf) then
        return false
      end

      -- Exclude special buffers
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      if buftype ~= "" then
        return false
      end

      -- Exclude specific filetypes
      local fts = { "TelescopePrompt", "NvimTree", "gitcommit", "gitrebase", "svn", "hgcommit" }
      if vim.tbl_contains(fts, vim.bo[buf].filetype) then
        return false
      end

      -- If all checks pass, allow auto-saving
      return true
    end,
    write_all_buffers = false,
    -- No debounce needed for these events
  },
}
