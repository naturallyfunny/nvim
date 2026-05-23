# Catatan untuk Auditor

Dokumen ini mencatat keputusan yang sengaja dibuat dan mungkin terlihat seperti dead code atau anomali.

---

## `lua/config/autocmds.lua`

### Commented-out: tutup Snacks Explorer saat startup
```lua
-- vim.api.nvim_create_autocmd("VimEnter", { ... })
```
Sengaja dibiarkan commented. Digunakan dulu ketika session restore membuka file explorer secara otomatis. Uncomment jika masalah itu muncul lagi.

### `apply_hl_overrides` menduplikasi highlight dari `colors/mono.lua`
Beberapa grup (Snacks picker, Noice cmdline) di-set ulang di sini padahal sudah ada di `colors/mono.lua`. Ini disengaja — noice dan snacks memanggil `highlights.setup()` mereka sendiri saat event `ColorScheme`, sehingga menimpa hasil dari colorscheme file. `vim.schedule` + autocmd `ColorScheme` di sini memastikan override kita berjalan *setelah* semua plugin selesai.

---

## `lua/custom/dashboard.lua`

### Tiga entry ASCII art identik (OO parens art)
`arts[9]`, `arts[10]`, dan `arts[11]` adalah string yang sama persis. Ini disengaja untuk meningkatkan probabilitas munculnya art tersebut saat random pick. Bukan duplikat yang perlu dibersihkan.

---

## `lua/plugins/ui.lua`

### `{ "nvim-mini/mini.indentscope", enabled = false }`
Terlihat seperti tidak berguna, tapi diperlukan untuk meng-override default LazyVim yang mengaktifkan plugin ini. Tanpa baris ini, indent scope guide akan muncul.

---

## `lua/plugins/noice.lua`

### `lang = false` di semua format cmdline
Menonaktifkan syntax highlighting pada teks yang diketik di command line. Tanpa ini, kata seperti `:qa` ditampilkan dengan warna `Statement` (#505050 abu-abu) bukan putih — tidak konsisten dengan tema B&W.

---

## `lua/plugins/blink.lua`

### `preselect = false`
Sengaja tidak auto-select item pertama di completion menu. Jika di-set `true`, ghost text (inline preview) langsung hilang saat menu muncul karena item sudah terpilih.

---

## `lua/plugins/flash.lua`

### Monkey-patch `char.new`
Flash hardcodes `groups.current = groups.label` di `char.lua` internal-nya, yang membuat jump target untuk `f`/`F`/`t`/`T` tidak bisa dibedakan dari match biasa. Patch ini memaksa `FlashCurrent` selalu dipakai untuk jump target. Perlu dicek ulang jika flash.nvim diupdate besar.

---

## `lua/plugins/theme.lua`

### Loop patch `lualine_c` dan `lualine_x`
Mengiterasi komponen lualine bawaan LazyVim untuk memaksa warna B&W. Jika LazyVim mengubah struktur default sections-nya di masa depan, loop ini mungkin tidak menemukan komponen yang dicari (silent no-op, tidak crash).

---

## `colors/mono.lua`

### `c.border` (`#E0E0E0`) hanya dipakai oleh `FloatermBorder`
Terlihat seperti variabel yang bisa dihapus, tapi ini memang satu-satunya tempat warna border terang dipakai (untuk floaterm, berbeda dari border lain yang pakai `c.black`).

### Diagnostics: warna non-B&W (merah, kuning, hijau)
`DiagnosticError`, `DiagnosticWarn`, `DiagnosticHint`, dan turunannya sengaja diberi warna muted (bukan abu-abu) agar severity tetap bisa dibedakan secara semantik. Ini pengecualian resmi dari skema B&W.

### `NoiceFormatConfirmDefault` pakai bg terang
`bg = "#c4c4c4"` untuk opsi default di confirm dialog ("Yes/No"). Ini agar tombol terpilih tetap menonjol secara visual tanpa harus pakai warna.
