return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    -- <leader>u is LazyVim's reserved UI/toggle which-key group; use <leader>U instead.
    { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undotree toggle" },
  },
  init = function()
    -- Move focus into the undotree panel when it opens.
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
