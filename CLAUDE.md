# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal **LazyVim-based Neovim config**. `init.lua` → `lua/config/lazy.lua` bootstraps lazy.nvim, imports `lazyvim.plugins`, then layers `lua/plugins/*` and the extras listed in `lazyvim.json` on top. There is no application to run or test — "running" it is opening `nvim`.

## Commands

- **Format:** `stylua lua/ colors/` — config in `stylua.toml` (4-space indent, 120 col). This is the only tooling; there is no test runner and no linter (stylua is formatter-only).
- **Reload a colorscheme after editing it:** `:colorscheme <name>` (re-sources the `colors/*.lua` file).
- **Inspect highlights when debugging theme work:** `:lua print(vim.inspect(vim.api.nvim_get_hl(0, { name = "Group" })))` and `:lua print(vim.eval_statusline(...))` style calls.

## Architecture — the theme system (the non-obvious core)

Everything unusual in this config orbits a single design goal: **zero hardcoded colors outside `colors/*.lua`**, so `:colorscheme` swaps the *entire* UI (statusline, picker, cmdline) at runtime. The mechanism has four moving parts:

1. **`lua/config/theme_registry.lua`** — a tiny registry. Each hand-built scheme calls `register(name, { reapply, lualine, reload })` at the bottom of its `colors/*.lua` file. `current()` returns the spec for the active `vim.g.colors_name`.

2. **`colors/*.lua`** — the hand-built schemes: **mono** (B&W, the canonical one), **earth**, **earth-light**, **venom**, **venom-light**. Each defines a palette table `c`, sets highlights via a local `set_hl` helper, defines a `reapply()` closure, and registers itself.

   **`lua/util/highlights.lua`** carries the parts that were identical in all five: `groups` (which highlight groups make up a role — pure taxonomy, **zero colors**) and `bufferline()` (bufferline.nvim's ~54 groups across three states). A scheme file is therefore only "role → color" decisions:

   ```lua
   local hl = require("util.highlights")
   local g = hl.groups
   set_hl(g.string, { fg = c.string })   -- key names mirror the palette vocabulary
   hl.bufferline(c.subtle, c.clear, c.fg) -- inactive, visible, selected
   ```

   A scheme that needs to deviate can still pass a literal list. **Three things stay duplicated on purpose** — don't "tidy" them: the `set_hl` helper (5 lines, never changes, and seeing it makes every call below obvious), the `hi clear` / `syntax reset` preamble (the standard colorscheme convention), and `reapply()` (too divergent between schemes — sharing it would need more options than it saves).

3. **`lua/config/autocmds.lua`** — on `ColorScheme` (wrapped in `vim.schedule`) calls the active spec's `reapply()`. This exists because **noice and snacks re-run their own `highlights.setup()` on every `ColorScheme` event without `default=true`, clobbering the scheme's highlights.** `reapply()` re-sets exactly those groups *after* the plugins finish. If you add a snacks/noice highlight to a colorscheme, you must also add it to that scheme's `reapply()` block.

4. **`lua/plugins/theme.lua`** — reads the active spec's `lualine` palette and rebuilds the statusline on `ColorScheme`. Contains two fragile patches over LazyVim's default lualine sections: a per-component recolor loop, and a rewrite of trouble.nvim's `%*` reset to `%#lualine_c_normal#` (so inter-segment gaps don't render transparent). Both silently no-op if LazyVim restructures its default sections.

**Palette vocabulary.** All five schemes name palette keys by *role*, using one shared vocabulary, so the same key means the same thing in every file and no key needs a "used by" comment (grep `c.<name>` for that). Each scheme uses the subset it needs.

- Anchors: `bg` (solid fallback when transparency is off), `fg` (main text), `on_accent` (text on a bright fill), `emph`, `scope`.
- Syntax: `keyword`, `ret`, `module`, `string`, `const`, `bconst`, `ptype`, `utype`, `var`, `comment`, `special`, `header`.
- Chrome: `gutter`, `shade`, `inactive`, `grey`, `subtle`, `border`, `sel`, `visual`, `nontext`, `match`.
- Statusline: `bar_bg`, `bar_fg`, `bar_file`, `bar_updates`.
- Severity: `d_error|warn|hint|info`, `n_warn|error|info`.
- `mono`/`venom`/`venom-light` add a prominence ladder `faint → soft → clear → bright → vivid` (quiet → loud; `vivid` currently only in `venom`) plus a `bg0..bg9` background ramp. The ladder is ordered by *prominence*, not lightness, which is why the light scheme keeps the same order while its hexes run the other way. `bg*` numbering is shared across those three, so **gaps are intentional** — don't renumber.

`fg`/`on_accent` invert between dark and light schemes; that is the point of naming them by role rather than by color.

**Transparency** is an orthogonal switch on top of all this: `vim.util.transparent` (`lua/util/transparent.lua`) exposes `vim.g.transparent` (ON by default). Hand-built schemes call `t.bg(solid)` instead of writing `"NONE"`; plugin schemes pass `t.enabled()` to their native flag. `:Transparency on|off|toggle` flips it and re-applies via each spec's `reload`. Don't reintroduce literal `"NONE"` backgrounds — route them through `t.bg()`.

**Default scheme persistence:** every `ColorScheme` event writes `vim.g.colors_name` to `stdpath("state")/colorscheme`; `theme.lua` reads it back on startup so the last-used scheme restores.

**External plugin schemes** (rose-pine) load `lazy = false, priority = 1000` and do *not* register with the theme_registry — they use `util.transparent`'s helpers (`overrides()`, `lualine(name)`) for the transparency hook only.

## Config layout

- `lua/config/` — LazyVim's standard entrypoints: `options.lua`, `keymaps.lua`, `autocmds.lua`, `lazy.lua`, plus the custom `theme_registry.lua`.
- `lua/plugins/*.lua` — one file per plugin (or concern); each returns a lazy.nvim spec that overrides/extends LazyVim. `languages.lua` just imports `lazyvim.plugins.extras.lang.*`.
- `lua/util/` — shared helpers: `transparent.lua` (the transparency switch) and `highlights.lua` (highlight-group taxonomy + the bufferline loop; no colors).
- `lua/custom/` — non-plugin custom code (e.g. `dashboard.lua` ASCII art).
- `colors/` — the colorschemes (see above).
- `lazyvim.json` — which LazyVim extras are enabled (langs: go, python, typescript, svelte, tailwind, json, yaml, sql, docker, markdown; tooling: prettier, eslint, copilot-native, dap, harpoon2).

## Gotchas that bite

- **Never `replace_all` hex values in `colors/*.lua`** — the same hex appears in both palette definitions and highlight groups, and several palette keys deliberately share a hex (`mono`'s `gutter`/`inactive`, `earth`'s `module`/`special`). Renaming a *key* is safe via `c.<name>` because the `c.` prefix is always present.
- `b_bg` / `c_bg` and other lualine constants are **hoisted to the top of each colors file**; change them there, not inside the lualine block.
- The `lualine` table each scheme registers has field names read by `lua/plugins/theme.lua` (`theme`, `c_bg`, `filename`, `directory`, `lazy_updates`, `diff.*`). Those are a public contract — they are not palette keys and must not be renamed.
- Custom code in many plugin files exists to *override a LazyVim default* (e.g. `mini.indentscope` `enabled = false`, the lualine patch loop). Deleting it re-enables the default behavior.
- `nvim_set_hl` **replaces** a group's definition, it does not merge. Listing a group in a batch and then setting it again on the next line makes the first write dead — that is why `PmenuSel` is absent from `g.surfaces`.
- `hl.bufferline()` writes literal `"NONE"` backgrounds rather than `t.bg()`, on purpose: bufferline draws over the tabline, and `TabLine`/`TabLineFill`/`TabLineSel` (in `util.transparent.editor`) are what the transparency switch actually controls.

## Verifying a colors/ refactor

Any change that is meant to be cosmetic (renames, regrouping, formatting) can be *proved* not to shift a single color. Dump every highlight group for every scheme, in both transparency states and after `reapply()`, before and after the change, then diff:

```sh
DUMP=before.txt nvim --headless -u NONE --cmd 'set rtp+=~/.config/nvim' \
  -c 'luafile scripts/dump_hl.lua' -c 'qa!'
```

`-u NONE` plus `set rtp+=` loads `colors/` and `lua/` without lazy.nvim, so the run is deterministic and does not rewrite `stdpath("state")/colorscheme`. The dump script iterates the five schemes × `vim.g.transparent` true/false, calls each spec's `reapply()`, and writes sorted `vim.api.nvim_get_hl(0, {})` output plus the registered `lualine` table. A non-empty diff means a color moved.
