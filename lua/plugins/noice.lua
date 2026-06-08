return {
  "folke/noice.nvim",
  -- Disabled to keep the true old-school NATIVE command-line.
  -- Noice externalizes messages (ext_messages), which forces cmdheight=0 and
  -- removes the dedicated command-line row, causing : / ? to overlap the
  -- lualine statusline. With Noice off, cmdheight=1 (see config/options.lua)
  -- gives the native cmdline its own line below lualine. The opts below are
  -- kept dormant so Noice can be re-enabled later by removing this line.
  enabled = false,
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
      long_message_to_split = true,
    },
    -- Hand the command-line back to Neovim's native bottom line.
    -- Noice's bottom "cmdline" view is actually a floating popup anchored at
    -- the editor's bottom edge, which overlaps the lualine statusline while you
    -- type. Disabling it gives the true old-school native cmdline, which lives
    -- on its own reserved line (cmdheight=1) below lualine and never covers it.
    cmdline = {
      enabled = false,
    },
    views = {
      cmdline_popup = {
        position = {
          row = "90%",
          col = "50%",
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        size = { width = 64, height = "auto" },
        win_options = {
          winhighlight = "Normal:NoiceCmdlinePopup,FloatBorder:NoiceCmdlinePopupBorder,FloatTitle:NoiceCmdlinePopupTitle",
        },
      },
      popupmenu = {
        border = {
          style = "single",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = "Normal:NoicePopupmenu,FloatBorder:NoicePopupmenuBorder,PmenuMatch:NoicePopupmenuMatch",
        },
      },
      notify = {
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = "Normal:NoiceNotification,FloatBorder:NoiceNotificationBorder,FloatTitle:NoiceNotificationTitle",
        },
      },
      mini = {
        position = {
          row = -2,
          col = 0,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = "Normal:NoiceNotification,FloatBorder:NoiceNotificationBorder,FloatTitle:NoiceNotificationTitle",
        },
      },
    },
  },
}
