return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
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

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "auto"
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
