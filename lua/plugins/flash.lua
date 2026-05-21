return {
  "folke/flash.nvim",
  config = function(_, opts)
    require("flash").setup(opts)

    -- flash's char.lua hardcodes groups.current = groups.label (f) or groups.match (t),
    -- which makes the jump target indistinguishable from other matches for `t`/`T`,
    -- and uses FlashLabel (bright white) instead of FlashCurrent for `f`/`F`.
    -- Wrap char.new to always force FlashCurrent on the jump target.
    local char = require("flash.plugins.char")
    local orig_new = char.new
    char.new = function()
      local state = orig_new()
      state.opts.highlight.groups.current = "FlashCurrent"
      return state
    end
  end,
}
