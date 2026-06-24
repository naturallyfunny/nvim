vim.keymap.set("i", "kj", "<Esc>", { desc = "Escape" })

for _, mode in ipairs({ "i", "n", "v", "x", "s", "o", "t" }) do
  vim.keymap.set(mode, "<S-CR>", "<Esc>", { desc = "Escape" })
end
vim.keymap.set("c", "<S-CR>", "<C-c>", { desc = "Escape" })

-- Undo break points: bikin satu `u` menghapus per-kata/per-kalimat (mirip VSCode)
-- daripada menghapus seluruh sesi insert sekaligus.
for _, ch in ipairs({ ",", ".", "!", "?", ";", ":", " " }) do
  vim.keymap.set("i", ch, ch .. "<C-g>u")
end

-- Buka riwayat undo lewat Snacks picker: ketik `:Undo`
vim.api.nvim_create_user_command("Undo", function()
  Snacks.picker.undo()
end, { desc = "Undo history picker" })

-- Copy diagnostic at cursor (with file + line) to clipboard.
-- Format: "main.go:42 [ERROR] undefined: someVar"
-- Falls back to all diagnostics in buffer if cursor line has none.
local function copy_diag()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.fn.expand("%:t")
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

  local diags = vim.diagnostic.get(bufnr, { lnum = lnum })
  if #diags == 0 then
    diags = vim.diagnostic.get(bufnr)
  end
  if #diags == 0 then
    vim.notify("No diagnostics in this buffer", vim.log.levels.WARN)
    return
  end

  local sev = { [1] = "ERROR", [2] = "WARN", [3] = "INFO", [4] = "HINT" }
  local parts = {}
  for _, d in ipairs(diags) do
    table.insert(parts, string.format("%s:%d [%s] %s", file, d.lnum + 1, sev[d.severity] or "?", d.message))
  end

  local text = table.concat(parts, "\n")
  vim.fn.setreg("+", text)
  vim.notify(string.format("Copied %d diagnostic(s)", #diags))
end

vim.api.nvim_create_user_command("DiagCopy", copy_diag, { desc = "Copy diagnostics to clipboard (file:line [SEV] msg)" })
vim.keymap.set("n", "<leader>yd", copy_diag, { desc = "Yank diagnostic to clipboard" })

local function copy_diag_nav(direction)
  local d = direction == "next" and vim.diagnostic.get_next() or vim.diagnostic.get_prev()
  if not d then
    vim.notify("No " .. direction .. " diagnostic", vim.log.levels.WARN)
    return
  end
  local sev = { [1] = "ERROR", [2] = "WARN", [3] = "INFO", [4] = "HINT" }
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(d.bufnr), ":t")
  local text = string.format("%s:%d [%s] %s", file, d.lnum + 1, sev[d.severity] or "?", d.message)
  vim.fn.setreg("+", text)
  vim.notify(text)
end

vim.keymap.set("n", "<leader>y]d", function() copy_diag_nav("next") end, { desc = "Yank next diagnostic to clipboard" })
vim.keymap.set("n", "<leader>y[d", function() copy_diag_nav("prev") end, { desc = "Yank prev diagnostic to clipboard" })
