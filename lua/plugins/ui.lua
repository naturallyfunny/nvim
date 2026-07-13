local dashboard = require("custom.dashboard")

return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Override the notification window style: single border, same as cmdline popup.
      -- Border hl groups are set in autocmds.lua so all levels use the same grey box.
      styles = {
        notification = {
          border = "rounded",
          wo = { winhighlight = "" },
        },
        input = {
          border = "rounded",
        },
      },
      notifier = {
        style = "compact",
        margin = { top = 0, right = 1, bottom = 2 },
      },
      dashboard = {
        preset = {
          header = dashboard.header,
        },
      },
      picker = {
        backdrop = false,
        win = {
          input = {
            keys = {
              ["<S-CR>"]    = { function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false) end, mode = { "i", "n" }, desc = "Escape" },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            auto_close = true,
            layout = {
              layout = {
                width = 0,
                height = 0,
                border = "none",
                box = "vertical",
                { win = "list" },
              },
            },
            win = {
              list = {
                window = { border = "none" },
              },
            },
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
      indent = {
        enabled = false,
      },
      dim = {
        enabled = false,
      },
      statuscolumn = {
        enabled = false,
      },
      image = {
        enabled = true,
      },
    },
  },

  -- Bufferline (tab bar)
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.indicator = { style = "icon" }
      return opts
    end,
  },

  -- Disable mini.indentscope
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
}
