return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        mini = { enabled = true },
        snacks = { enabled = true },
        noice = true,
        which_key = true,
        blink_cmp = true,
        mason = true,
        markdown = true,
      },
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
