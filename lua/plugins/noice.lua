return {
  "folke/noice.nvim",
  opts = {
    -- Force every vim.notify call (info/warn/error) into the bottom-right mini view
    notify = {
      enabled = true,
      view = "mini",
    },
    -- Same for :messages-style output (echo/echomsg/lua print)
    messages = {
      enabled = true,
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
      view_history = "messages",
      view_search = false,
    },
    lsp = {
      progress = { enabled = true, view = "mini" },
      message = { enabled = true, view = "mini" },
    },
    routes = {
      -- Catch-all so nothing escapes to the popup view
      { filter = { event = "notify" }, view = "mini" },
      { filter = { event = "msg_show" }, view = "mini" },
    },
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
