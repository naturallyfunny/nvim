return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
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
      command_palette = true,
      long_message_to_split = true,
    },
    cmdline = {
      view = "cmdline_popup",
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
    views = {
      cmdline_popup = {
        border = {
          style = "single",
          padding = { 0, 1 },
        },
        size = { width = 64, height = "auto" },
        win_options = {
          winhighlight = "Normal:NoiceCmdlinePopup,FloatBorder:NoiceCmdlinePopupBorder",
        },
      },
      popupmenu = {
        border = {
          style = "single",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = "Normal:NoicePopupmenu,FloatBorder:NoicePopupmenuBorder",
        },
      },
    },
  },
}
