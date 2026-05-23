local dashboard = require("custom.dashboard")

return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Override the notification window style: single border, same as cmdline popup.
      -- Border hl groups are set in autocmds.lua so all levels use the same grey box.
      styles = {
        notification = {
          border = "single",
          wo = { winhighlight = "" },
        },
        input = {
          border = "single",
        },
      },
      notifier = {
        style = "compact",
      },
      dashboard = {
        preset = {
          header = dashboard.header,
        },
      },
      picker = {
        backdrop = false,
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                position = "right",
                width = 40,
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
    },
  },

  -- Bufferline (tab bar)
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.indicator = { style = "icon" }

      local bg = "NONE"
      local fg_dim = "#6a6a6a"
      local fg_visible = "#b8b8b8"
      local fg_selected = "#FFFFFF"

      local function tri(fg_inactive, fg_vis, fg_sel)
        return {
          inactive = { bg = bg, fg = fg_inactive },
          visible  = { bg = bg, fg = fg_vis },
          selected = { bg = bg, fg = fg_sel },
        }
      end

      local text = tri(fg_dim, fg_visible, fg_selected)
      local diag = tri(fg_dim, fg_visible, fg_selected)

      local groups = {
        -- empty area to the right of the last tab
        fill = { bg = bg },

        -- buffer name
        background       = text.inactive,
        buffer_visible   = text.visible,
        buffer_selected  = { bg = bg, fg = fg_selected, bold = true, italic = false },

        -- close / modified icons
        close_button           = text.inactive,
        close_button_visible   = text.visible,
        close_button_selected  = text.selected,
        modified               = text.inactive,
        modified_visible       = text.visible,
        modified_selected      = text.selected,

        -- duplicate filename suffix
        duplicate          = { bg = bg, fg = fg_dim,     italic = true },
        duplicate_visible  = { bg = bg, fg = fg_visible, italic = true },
        duplicate_selected = { bg = bg, fg = fg_selected, italic = true },

        -- tab separators / offset separator
        separator          = { bg = bg, fg = bg },
        separator_visible  = { bg = bg, fg = bg },
        separator_selected = { bg = bg, fg = bg },
        offset_separator   = { bg = bg, fg = bg },

        -- left-edge indicator on the selected tab (was blue)
        indicator_visible  = { bg = bg, fg = bg },
        indicator_selected = { bg = bg, fg = fg_selected },

        -- buffer numbers / pick prompt
        numbers          = text.inactive,
        numbers_visible  = text.visible,
        numbers_selected = text.selected,
        pick             = { bg = bg, fg = fg_dim,      bold = true },
        pick_visible     = { bg = bg, fg = fg_visible,  bold = true },
        pick_selected    = { bg = bg, fg = fg_selected, bold = true },

        -- generic diagnostic count
        diagnostic          = diag.inactive,
        diagnostic_visible  = diag.visible,
        diagnostic_selected = diag.selected,

        -- per-severity diagnostic count + label coloring of the filename.
        -- Force all to the B&W scale so warnings don't tint the tab gold.
        error                       = diag.inactive,
        error_visible               = diag.visible,
        error_selected              = { bg = bg, fg = fg_selected, bold = true, italic = false },
        error_diagnostic            = diag.inactive,
        error_diagnostic_visible    = diag.visible,
        error_diagnostic_selected   = diag.selected,
        warning                     = diag.inactive,
        warning_visible             = diag.visible,
        warning_selected            = { bg = bg, fg = fg_selected, bold = true, italic = false },
        warning_diagnostic          = diag.inactive,
        warning_diagnostic_visible  = diag.visible,
        warning_diagnostic_selected = diag.selected,
        info                        = diag.inactive,
        info_visible                = diag.visible,
        info_selected               = { bg = bg, fg = fg_selected, bold = true, italic = false },
        info_diagnostic             = diag.inactive,
        info_diagnostic_visible     = diag.visible,
        info_diagnostic_selected    = diag.selected,
        hint                        = diag.inactive,
        hint_visible                = diag.visible,
        hint_selected               = { bg = bg, fg = fg_selected, bold = true, italic = false },
        hint_diagnostic             = diag.inactive,
        hint_diagnostic_visible     = diag.visible,
        hint_diagnostic_selected    = diag.selected,
      }

      opts.highlights = vim.tbl_deep_extend("force", opts.highlights or {}, groups)
      return opts
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)

      -- Re-apply key bufferline highlights after any ColorScheme load so
      -- plugins can't reintroduce the default blue indicator / diagnostic tints.
      local bg = "NONE"
      local fg_selected = "#FFFFFF"
      local apply = function()
        vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = bg, fg = fg_selected })
        vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible",  { bg = bg, fg = bg })
        vim.api.nvim_set_hl(0, "BufferLineFill",              { bg = bg })
      end
      apply()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("BufferLineMonoOverrides", { clear = true }),
        callback = apply,
      })
    end,
  },

  -- Disable mini.indentscope
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
}
