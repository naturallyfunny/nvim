return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      -- Let noice render LSP hover/signature markdown properly
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      -- Route common file-write / jump-position messages to mini (LazyVim default)
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,        -- search count appears at the bottom cmdline area
      command_palette = true,      -- position cmdline and popupmenu together
      long_message_to_split = true, -- long messages go to a split instead of popup
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
