-- catppuccin (mocha) — plugin's own colors, our transparency. See
-- lua/util/transparent.lua for the shared transparency logic.
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    local t = require("util.transparent")
    local function setup()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = t.enabled(),
        no_italic = true,
        custom_highlights = t.overrides,
      })
    end
    setup()
    -- `:colorscheme catppuccin` resolves colors_name to the flavour ("catppuccin-mocha"),
    -- so the registry must be keyed by that — not "catppuccin".
    require("config.theme_registry").register("catppuccin-mocha", {
      reapply = t.reapply,
      lualine = t.lualine("catppuccin-mocha"),
      reload = function()
        setup()
        vim.cmd.colorscheme("catppuccin")
      end,
    })
  end,
}
