-- github-nvim-theme — plugin's own colors, our transparency. See
-- lua/util/transparent.lua for the shared transparency logic.
return {
  "projekt0n/github-nvim-theme",
  name = "github-theme",
  lazy = false,
  priority = 1000,
  config = function()
    local t = require("util.transparent")
    local function setup()
      require("github-theme").setup({
        options = { transparent = t.enabled() },
        groups = { all = t.overrides() },
      })
    end
    setup()

    local registry = require("config.theme_registry")
    for _, name in ipairs({
      "github_dark",
      "github_dark_default",
      "github_dark_dimmed",
      "github_dark_high_contrast",
      "github_dark_colorblind",
      "github_dark_tritanopia",
      "github_light",
      "github_light_default",
      "github_light_high_contrast",
      "github_light_colorblind",
      "github_light_tritanopia",
    }) do
      registry.register(name, {
        reapply = t.reapply,
        lualine = t.lualine(name),
        reload = function()
          setup()
          vim.cmd.colorscheme(name)
        end,
      })
    end
  end,
}
