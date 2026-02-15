-- pocco81/auto-save.nvim: A plugin for auto-saving buffers
return {
  "pocco81/auto-save.nvim",
  enabled = false, -- NOTE: Temporarily disabled for debugging the undo/delete issue.
  -- Load on these events to enable IDE-like auto-saving
  event = { "TextChanged", "InsertLeave", "FocusLost", "BufLeave" },
  opts = {
    enabled = true,
    execution_message = {
      message = "✓ auto-saved",
      dim = 0,
      cleaning_interval = 1250,
    },
    -- Triggers for saving, including on text change for IDE-like behavior
    trigger_events = { "TextChanged", "InsertLeave", "FocusLost", "BufLeave" },
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
    -- Debounce saving to avoid issues. 1500ms is a good default.
    debounce_delay = 1500,
  },
}
