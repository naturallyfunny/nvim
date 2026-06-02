return {
  "rose-pine/neovim",
  name = "rose-pine",
  -- Not the default scheme (mono/earth own that via theme_registry); load eagerly
  -- so `:colorscheme rose-pine` is always available without an explicit require.
  lazy = false,
  priority = 1000,
}
