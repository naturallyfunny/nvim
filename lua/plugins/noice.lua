return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      view = "cmdline", -- render at bottom, not as floating popup
      -- lang = false disables per-format syntax highlighting so typed text uses
      -- Normal (white) instead of e.g. vim's Statement (#505050 grey) for `:qa`.
      format = {
        cmdline     = { icon = ":", lang = false },
        search_down = { icon = "/", lang = false },
        search_up   = { icon = "?", lang = false },
        filter      = { icon = "!", lang = false },
        lua         = { icon = ":", lang = false },
        help        = { icon = "?", lang = false },
        input       = { icon = ">" },
      },
    },
  },
}
