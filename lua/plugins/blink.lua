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
        -- 1. Copilot ghost text showing -> Tab accepts the inline suggestion
        -- 2. Menu open                  -> Tab accepts the selection (snippet-aware)
        -- 3. Otherwise                  -> normal indent (fallback)
        -- Native Copilot (ai.copilot-native) renders suggestions via Neovim's
        -- built-in LSP inline completion; get() applies the shown suggestion and
        -- returns true. We must wire it here because preset="none" drops LazyVim's
        -- default ai_accept binding. pcall-guarded so a tab still indents when the
        -- inline-completion feature isn't active for the buffer.
        ["<Tab>"] = {
          function(cmp)
            local ok, applied = pcall(vim.lsp.inline_completion.get)
            if ok and applied then
              return true
            end
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
