-- Dump every highlight group of every hand-built scheme, in both transparency
-- states and after reapply(), so a cosmetic refactor of colors/ can be proved
-- not to shift a single color. Run before and after the change, then diff:
--
--   DUMP=before.txt nvim --headless -u NONE --cmd 'set rtp+=~/.config/nvim' \
--     -c 'luafile scripts/dump_hl.lua' -c 'qa!'
--
-- `-u NONE` keeps the run deterministic (no lazy.nvim, no plugins) and avoids
-- rewriting stdpath("state")/colorscheme, which the real config does on every
-- ColorScheme event.
local schemes = { "mono", "venom", "venom-light", "earth", "earth-light" }
local out = {}

for _, transparent in ipairs({ true, false }) do
    for _, name in ipairs(schemes) do
        vim.g.transparent = transparent
        vim.cmd.colorscheme(name) -- re-sources the file, so `surface` is recomputed
        local spec = require("config.theme_registry").schemes[name]
        if spec and spec.reapply then
            spec.reapply()
        end
        local hls = vim.api.nvim_get_hl(0, {})
        local keys = vim.tbl_keys(hls)
        table.sort(keys)
        for _, group in ipairs(keys) do
            out[#out + 1] = ("%s\t%s\t%s\t%s"):format(
                tostring(transparent),
                name,
                group,
                vim.inspect(hls[group], { newline = "", indent = "" })
            )
        end
        out[#out + 1] = ("%s\t%s\tLUALINE\t%s"):format(
            tostring(transparent),
            name,
            vim.inspect(spec and spec.lualine, { newline = "", indent = "" })
        )
    end
end

local dest = os.getenv("DUMP")
if not dest then
    error("set DUMP=<output file>")
end
vim.fn.writefile(out, dest)
