return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- Enable ghost text (inline preview)
        ghost_text = {
          enabled = true,
        },
        list = {
          selection = {
            preselect = false, -- Don't auto-select first item so ghost text stays visible
            auto_insert = true, -- Insert text while navigating
          },
        },
      },
      keymap = {
        preset = "none", -- Fully manual keymaps

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        -- Tab logic (VS Code / Copilot style):
        -- 1. Menu open  -> Tab accepts (select_and_accept)
        -- 2. Otherwise  -> normal indent (fallback)
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
    },
  },
}
