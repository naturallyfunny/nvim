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
