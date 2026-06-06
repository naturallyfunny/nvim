-- rose-pine — plugin's own colors, our transparency. See
-- lua/util/transparent.lua for the shared transparency logic.
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    local t = require("util.transparent")
    local function setup()
      require("rose-pine").setup({
        styles = { transparency = t.enabled(), italic = false },
        highlight_groups = t.overrides(),
      })
    end
    setup()
    require("config.theme_registry").register("rose-pine", {
      reapply = t.reapply,
      lualine = t.lualine("rose-pine"),
      reload = function()
        setup()
        vim.cmd.colorscheme("rose-pine")
      end,
    })
  end,
}
