# nvim config — OpenCode guidance

LazyVim-based Neovim config. `init.lua` bootstraps lazy.nvim → imports `lua/config/lazy.lua` → loads `lua/plugins/*` and LazyVim extras.

## Architecture

- **Colorscheme system**: Each `colors/*.lua` (mono, earth, kanagawy, rosy-piny, tokyodarky, moonly) registers a spec via `lua/config/theme_registry.lua:register(name, {reapply, lualine})`. `theme.lua` reads the active spec via `registry.current()` and applies it. This is the central pattern — understand it before editing colors.
- **Snacks/noice highlight re-application**: Both plugins clobber highlights on `ColorScheme` events. Each colorscheme exposes a `reapply()` function called from `lua/config/autocmds.lua`. If you add a snacks/noice highlight, update both the top-level `set_hl` and the `reapply()` block.
- **External theme plugins** (rose-pine, kanagawa, tokyodark, moonfly) are loaded with `lazy = false, priority = 1000` so `:colorscheme` works without explicit require. They do NOT register with theme_registry.
- **Default colorscheme** is persisted to `vim.fn.stdpath("state") .. "/colorscheme"` on every `ColorScheme` event; defaults to "earth" if not found (see `lua/plugins/theme.lua`).

## Keymaps (not LazyVim defaults)

| Keys | Action |
|------|--------|
| `kj` (insert) | `<Esc>` |
| `<S-CR>` (all modes) | `<Esc>` |
| `<leader>a` | Harpoon add |
| `<leader>H` | Harpoon menu |
| `<leader>1`–`4` | Harpoon select 1–4 |
| `<leader>U` | Undotree toggle |
| `w`/`e`/`b`/`ge` (n/o/x) | nvim-spider (subword motion) |
| `<Tab>` (insert) | Blink accept / fallback |
| `<C-space>` | Blink show |

## Developer commands

- Format: `stylua lua/ colors/` (4-space indent, 120 col width)
- No test runner (Neovim config — no tests)
- No linter configured (stylua is formatter only)

## Edit gotchas

- **Never `replace_all` hex values** in `colors/mono.lua` — they appear in both palette assignments and syntax highlights. Use context-specific matching.
- `b_bg` / `c_bg` are hoisted constants at the top of each colorscheme. Change them in one place, not in the lualine block. Headers list all consumers.
- mono.lua uses **capability-based** lualine mode colors: insert & replace share the same swatch (dark bg = "writing to file"). Don't give them distinct colors.
- `StatusLine` / `StatusLineNC` must stay `bg = "NONE"` — setting them to a solid color breaks trouble.nvim's inter-segment gaps.
- The trouble `%*` rewrite lives in `lua/plugins/theme.lua` — don't "fix" the transparent gap by changing `StatusLine.bg` or clearing trouble cache.
- `disabled_filetypes` from LazyVim must not be overridden (hides lualine on dashboard).
- `CursorLineNr` is intentionally bright (`#e8e8e8 bold`) — don't fold it into `b_bg`.

## Source of truth

**`CLAUDE.md`** (in repo root, gitignored via `.gitignore`) contains exhaustive detail on lualine architecture, the trouble fix, snacks re-application pattern, verification commands (`nvim_eval_statusline`, `nvim_get_hl`), and all non-obvious design decisions. Read it before making theme/UI changes.
