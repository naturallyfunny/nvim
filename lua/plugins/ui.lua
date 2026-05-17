local dashboard = require("custom.dashboard")

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {},
      },
      picker = {
        backdrop = false,
        win = {
          wo = {
            -- winblend = 0, -- Let the theme handle transparency
          },
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                position = "right",
                width = 40,
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
        enabled = true,
      },
      dim = {
        enabled = false,
      },
    },
  },

  -- Disable Bufferline (Tab Bar di atas)
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  -- Disable mini.indentscope
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },

  -- Change default folder icon from azure (overridden to green) to white
  {
    "echasnovski/mini.icons",
    opts = {
      default = {
        directory = { hl = "MiniIconsWhite" },
      },
    },
  },
}
