-- kanagawa.nvim (wave) — plugin's own colors, our transparency. See
-- lua/util/transparent.lua for the shared transparency logic.
return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = false,
  priority = 1000,
  config = function()
    local t = require("util.transparent")
    local function setup()
      require("kanagawa").setup({
        theme = "wave",
        transparent = t.enabled(),
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        overrides = t.overrides,
      })
    end
    setup()
    require("config.theme_registry").register("kanagawa", {
      reapply = t.reapply,
      lualine = t.lualine("kanagawa"),
      reload = function()
        setup()
        vim.cmd.colorscheme("kanagawa")
      end,
    })
  end,
}
