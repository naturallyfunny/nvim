vim.keymap.set("i", "kj", "<Esc>", { desc = "Escape" })

for _, mode in ipairs({ "i", "n", "v", "x", "s", "o", "t" }) do
  vim.keymap.set(mode, "<S-CR>", "<Esc>", { desc = "Escape" })
  vim.keymap.set(mode, "<S-Space>", "<Esc>", { desc = "Escape" })
end
vim.keymap.set("c", "<S-CR>", "<C-c>", { desc = "Escape" })
vim.keymap.set("c", "<S-Space>", "<C-c>", { desc = "Escape" })
