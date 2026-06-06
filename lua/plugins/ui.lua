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
        enabled = true,
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

      -- Other specs (e.g. LazyVim's catppuccin integration) may set
      -- opts.highlights to a function that lazily builds the table. Resolve
      -- it to a table before merging so tbl_deep_extend doesn't choke, then
      -- force our mono groups on top.
      local base = opts.highlights
      if type(base) == "function" then
        local ok, resolved = pcall(base)
        base = ok and resolved or {}
      end
      opts.highlights = vim.tbl_deep_extend("force", base or {}, groups)
      return opts
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)

      -- Re-apply key bufferline highlights after any ColorScheme load so
      -- plugins can't reintroduce the default blue indicator / diagnostic tints.
      local bg = "NONE"
      local fg_selected = "#FFFFFF"
      local apply = function()
        -- A plugin colorscheme's bufferline integration re-sets BufferLine*
        -- groups with solid backgrounds on ColorScheme; strip every bg so the
        -- tabline stays transparent (foregrounds are kept).
        for group in pairs(vim.api.nvim_get_hl(0, {})) do
          if group:find("^BufferLine") then
            local h = vim.api.nvim_get_hl(0, { name = group, link = false })
            h.bg, h.ctermbg = nil, nil
            vim.api.nvim_set_hl(0, group, h)
          end
        end
        -- re-assert the indicator/fill that integrations like to recolor
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
