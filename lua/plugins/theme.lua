return {
  {
    "LazyVim/LazyVim",
    opts = function()
      local f = vim.fn.stdpath("state") .. "/colorscheme"
      local saved = vim.fn.filereadable(f) == 1 and vim.fn.readfile(f)[1] or "earth"
      return { colorscheme = saved }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Statusline palette comes from whichever colorscheme is active.
      -- Each colors/*.lua registers a `lualine` spec with theme_registry; we read
      -- it here and rebuild on ColorScheme so :colorscheme swaps the statusline too.
      local registry = require("config.theme_registry")
      local function spec()
        local s = registry.current() or registry.schemes.mono
        return s and s.lualine
      end

      local function apply(o)
        local l = spec()
        if not l then
          return
        end
        o.options = o.options or {}
        o.options.theme = l.theme
        o.options.section_separators   = { left = "\xee\x82\xb0", right = "\xee\x82\xb2" }
        o.options.component_separators = { left = "\xee\x82\xb1", right = "\xee\x82\xb3" }

        for _, component in ipairs((o.sections or {}).lualine_c or {}) do
          if type(component) == "table" and type(component[1]) == "function" and component.color then
            component.color = function()
              local ll = spec()
              return { fg = ll.filename, bg = ll.c_bg, gui = "bold" }
            end
          end
        end

        local lazy_status = require("lazy.status")
        for _, component in ipairs((o.sections or {}).lualine_x or {}) do
          if type(component) == "table" and component[1] == lazy_status.updates then
            component.color = function()
              local ll = spec()
              return { fg = ll.lazy_updates, bg = ll.c_bg }
            end
          end
          if type(component) == "table" and component[1] == "diff" then
            component.diff_color = {
              added    = { fg = l.diff.added },
              modified = { fg = l.diff.modified },
              removed  = { fg = l.diff.removed },
            }
          end
        end
      end

      apply(opts)

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          apply(opts)
          pcall(function()
            require("lualine").setup(opts)
          end)
        end,
        desc = "Rebuild lualine statusline for the active colorscheme",
      })
    end,
  },
}
