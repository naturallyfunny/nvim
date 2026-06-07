-- Override on top of the LazyVim extra `editor.harpoon2` (enabled in
-- lazyvim.json). The extra installs the plugin + sane opts (save_on_toggle,
-- menu width) and the <leader>1..9 jump keys. This file only re-applies my
-- personal extras the extra doesn't have:
--   * <leader>a  add file, WITH a notification ("added X" / "already marked")
--   * <leader>H  toggle the quick menu (overrides the extra's <leader>H = add)
--   * dd inside the menu prints which file was removed
-- and drops the extra's duplicate <leader>h menu binding.
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>a",
      function()
        local harpoon = require("harpoon")
        local list = harpoon:list()
        local before = list:length()
        list:add()
        if list:length() > before then
          vim.notify("Harpoon: added " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"), vim.log.levels.INFO)
        else
          vim.notify("Harpoon: already marked", vim.log.levels.WARN)
        end
      end,
      desc = "Harpoon: add file",
    },
    { "<leader>H", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon: menu" },
    { "<leader>h", false }, -- drop the extra's duplicate menu binding (we use <leader>H)
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      callback = function(ev)
        vim.keymap.set("n", "dd", function()
          local line = vim.api.nvim_get_current_line()
          if #line > 0 then
            vim.notify("Harpoon: removed " .. vim.fn.fnamemodify(line, ":t"), vim.log.levels.INFO)
          end
          vim.cmd("normal! dd")
        end, { buffer = ev.buf })
      end,
    })
  end,
}
