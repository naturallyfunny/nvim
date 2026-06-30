return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          -- Push snippets (snippets/*.json: `ief`, `lsenv`, ...) to the top of the
          -- menu so they sit at items[1]; the <Tab> handler below relies on this to
          -- give snippets priority over Supermaven's ghost text.
          snippets = { score_offset = 100 },
        },
      },
      completion = {
        menu = {
          direction_priority = { "n", "s" },
        },
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

        -- Tab logic (VS Code / Copilot style), in priority order:
        -- 1. Snippet candidate (e.g. `ief`, `lsenv`) -> always accept the snippet
        -- 2. Supermaven suggestion showing            -> accept the inline ghost text
        -- 3. Menu open / snippet active               -> accept the selection
        -- 4. Otherwise                                -> normal indent (fallback)
        --
        -- Snippets win first because Supermaven's ghost text would otherwise steal
        -- Tab while a snippet is sitting at the top of the menu. A snippet item
        -- carries source_id == "snippets"; we check the selected item, or the top
        -- candidate when nothing is selected (preselect = false), and accept by
        -- index so it fires even without an explicit selection. The high
        -- score_offset on the snippets provider keeps it as items[1].
        --
        -- Supermaven renders AI suggestions as inline ghost text but exposes no
        -- public accept API, so we reach into its `completion_preview` module.
        -- pcall-guarded so Tab still indents if the module is missing or the
        -- plugin renames it on update. on_accept_suggestion() mutates the buffer
        -- and must run outside the keymap callback (textlock), hence vim.schedule;
        -- we return true immediately so blink treats the key as handled and skips
        -- the indent fallback. Wired here because preset="none" drops LazyVim's
        -- default ai_accept binding.
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              local idx = cmp.get_selected_item_idx() or 1
              local item = cmp.get_selected_item() or cmp.get_items()[1]
              if item and item.source_id == "snippets" then
                return cmp.accept({ index = idx })
              end
            end
            local ok, sm = pcall(require, "supermaven-nvim.completion_preview")
            if ok and sm and sm.has_suggestion() then
              vim.schedule(function()
                sm.on_accept_suggestion()
              end)
              return true
            end
            if cmp.snippet_active() then
              cmp.select_and_accept()
              return true
            end
            return cmp.select_and_accept()
          end,
          "fallback",
        },
        ["<C-l>"] = { "snippet_forward", "fallback" },
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
