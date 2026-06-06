-- rose-pine — plugin's own colors, our transparency. See
-- lua/util/transparent.lua for the shared transparency logic.
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    local t = require("util.transparent")
    require("rose-pine").setup({
      styles = { transparency = true, italic = false },
      highlight_groups = t.overrides(),
    })
    require("config.theme_registry").register("rose-pine", {
      reapply = t.reapply,
      lualine = t.lualine("rose-pine"),
    })
  end,
}
