# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal **LazyVim-based Neovim config**. `init.lua` → `lua/config/lazy.lua` bootstraps lazy.nvim, imports `lazyvim.plugins`, then layers `lua/plugins/*` and the extras listed in `lazyvim.json` on top. There is no application to run or test — "running" it is opening `nvim`.

## Companion docs (read these too)

- **`AGENTS.md`** (git-tracked) — the maintained quick-reference: architecture summary, custom keymaps table, edit gotchas for the theme files. Keep it in sync when you change those things.
- **`NOTE.md`** (gitignored, written in Indonesian) — the "why" behind code that looks like dead code or an anomaly: commented-out autocmds, intentional duplication, monkey-patches, deliberate non-B&W exceptions. **Check it before "cleaning up" anything that looks redundant.**

## Commands

- **Format:** `stylua lua/ colors/` — config in `stylua.toml` (4-space indent, 120 col). This is the only tooling; there is no test runner and no linter (stylua is formatter-only).
- **Reload a colorscheme after editing it:** `:colorscheme <name>` (re-sources the `colors/*.lua` file).
- **Inspect highlights when debugging theme work:** `:lua print(vim.inspect(vim.api.nvim_get_hl(0, { name = "Group" })))` and `:lua print(vim.eval_statusline(...))` style calls.

## Architecture — the theme system (the non-obvious core)

Everything unusual in this config orbits a single design goal: **zero hardcoded colors outside `colors/*.lua`**, so `:colorscheme` swaps the *entire* UI (statusline, picker, cmdline) at runtime. The mechanism has four moving parts:

1. **`lua/config/theme_registry.lua`** — a tiny registry. Each hand-built scheme calls `register(name, { reapply, lualine, reload })` at the bottom of its `colors/*.lua` file. `current()` returns the spec for the active `vim.g.colors_name`.

2. **`colors/*.lua`** — the hand-built schemes: **mono** (B&W, the canonical one), **earth**, **venom**, **venom-light**. Each defines a palette table `c`, sets highlights via a local `set_hl` helper, defines a `reapply()` closure, and registers itself. (Note: AGENTS.md's scheme list is stale — trust the actual files in `colors/`.)

3. **`lua/config/autocmds.lua`** — on `ColorScheme` (wrapped in `vim.schedule`) calls the active spec's `reapply()`. This exists because **noice and snacks re-run their own `highlights.setup()` on every `ColorScheme` event without `default=true`, clobbering the scheme's highlights.** `reapply()` re-sets exactly those groups *after* the plugins finish. If you add a snacks/noice highlight to a colorscheme, you must also add it to that scheme's `reapply()` block.

4. **`lua/plugins/theme.lua`** — reads the active spec's `lualine` palette and rebuilds the statusline on `ColorScheme`. Contains two fragile patches over LazyVim's default lualine sections: a per-component recolor loop, and a rewrite of trouble.nvim's `%*` reset to `%#lualine_c_normal#` (so inter-segment gaps don't render transparent). Both silently no-op if LazyVim restructures its default sections.

**Transparency** is an orthogonal switch on top of all this: `vim.util.transparent` (`lua/util/transparent.lua`) exposes `vim.g.transparent` (ON by default). Hand-built schemes call `t.bg(solid)` instead of writing `"NONE"`; plugin schemes pass `t.enabled()` to their native flag. `:Transparency on|off|toggle` flips it and re-applies via each spec's `reload`. Don't reintroduce literal `"NONE"` backgrounds — route them through `t.bg()`.

**Default scheme persistence:** every `ColorScheme` event writes `vim.g.colors_name` to `stdpath("state")/colorscheme`; `theme.lua` reads it back on startup so the last-used scheme restores.

**External plugin schemes** (rose-pine) load `lazy = false, priority = 1000` and do *not* register with the theme_registry — they use `util.transparent`'s helpers (`overrides()`, `lualine(name)`) for the transparency hook only.

## Config layout

- `lua/config/` — LazyVim's standard entrypoints: `options.lua`, `keymaps.lua`, `autocmds.lua`, `lazy.lua`, plus the custom `theme_registry.lua`.
- `lua/plugins/*.lua` — one file per plugin (or concern); each returns a lazy.nvim spec that overrides/extends LazyVim. `languages.lua` just imports `lazyvim.plugins.extras.lang.*`.
- `lua/util/` — shared helpers (currently `transparent.lua`).
- `lua/custom/` — non-plugin custom code (e.g. `dashboard.lua` ASCII art).
- `colors/` — the colorschemes (see above).
- `lazyvim.json` — which LazyVim extras are enabled (langs: go, python, typescript, svelte, tailwind, json, yaml, sql, docker, markdown; tooling: prettier, eslint, copilot-native, dap, harpoon2).

## Gotchas that bite

These are the high-frequency ones; the full list is in `AGENTS.md` and `NOTE.md`:

- **Never `replace_all` hex values in `colors/mono.lua`** — the same hex appears in both palette definitions and syntax groups. Match with surrounding context.
- `b_bg` / `c_bg` and other lualine constants are **hoisted to the top of each colors file**; change them there, not inside the lualine block.
- Custom code in many plugin files exists to *override a LazyVim default* (e.g. `mini.indentscope` `enabled = false`, the lualine patch loop). Deleting it re-enables the default behavior. When in doubt, NOTE.md explains it.
