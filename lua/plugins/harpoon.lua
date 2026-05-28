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
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: file 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: file 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: file 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: file 4" },
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
