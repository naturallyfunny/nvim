return {
  { "LazyVim/LazyVim", opts = { colorscheme = "mono" } },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Monochrome B&W statusline with powerline chevrons.
      -- Mode-pill brightness: NORMAL off-white, INSERT inverted (dark pill),
      -- COMMAND mid-grey, VISUAL dark, REPLACE darkest.
      local b_bg, b_fg = "#1a1a1a", "#b8b8b8"
      local c_bg, c_fg = "NONE", "#6a6a6a"
      local function mode_section(a_bg, a_fg)
        return {
          a = { bg = a_bg, fg = a_fg, gui = "bold" },
          b = { bg = b_bg, fg = b_fg },
          c = { bg = c_bg, fg = c_fg },
        }
      end
      local theme = {
        normal   = mode_section("#e8e8e8", "#010101"),
        insert   = mode_section("#010101", "#e8e8e8"),
        visual   = mode_section("#303030", "#FFFFFF"),
        replace  = mode_section("#3a3a3a", "#FFFFFF"),
        command  = mode_section("#b0b0b0", "#010101"),
        inactive = {
          a = { bg = c_bg, fg = "#4a4a4a", gui = "bold" },
          b = { bg = c_bg, fg = "#4a4a4a" },
          c = { bg = c_bg, fg = "#4a4a4a" },
        },
      }

      for _, component in ipairs((opts.sections or {}).lualine_c or {}) do
        if type(component) == "table" and type(component[1]) == "function" and component.color then
          component.color = function() return { fg = "#FFFFFF", bg = c_bg, gui = "bold" } end
        end
      end

      local lazy_status = require("lazy.status")
      for _, component in ipairs((opts.sections or {}).lualine_x or {}) do
        if type(component) == "table" and component[1] == lazy_status.updates then
          component.color = function() return { fg = "#FFFFFF", bg = c_bg } end
        end
        if type(component) == "table" and component[1] == "diff" then
          component.diff_color = {
            added    = { fg = "#FFFFFF" },
            modified = { fg = "#FFFFFF" },
            removed  = { fg = "#FFFFFF" },
          }
        end
      end

      opts.options = opts.options or {}
      opts.options.section_separators   = { left = "\xee\x82\xb0", right = "\xee\x82\xb2" }
      opts.options.component_separators = { left = "\xee\x82\xb1", right = "\xee\x82\xb3" }
      opts.options.theme = theme
    end,
  },
}
