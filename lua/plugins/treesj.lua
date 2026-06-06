return {
  "Wansmer/treesj",
  -- nvim-treesitter is already provided by LazyVim; listed to match upstream docs.
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  keys = {
    -- treesj's defaults are <space>m/j/s, which collide with the leader key.
    -- Disable them below and bind a single explicit toggle instead.
    { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Split/join code block" },
  },
  opts = {
    use_default_keymaps = false,
  },
}
