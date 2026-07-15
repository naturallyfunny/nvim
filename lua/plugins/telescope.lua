return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          find_command = { "fd", "--type", "f", "--hidden", "--no-ignore" },
        },
        live_grep = {
          -- For live_grep, we can use ripgrep with similar flags
          grep_open_files = false,
          additional_args = function()
            return { "--hidden", "--no-ignore" }
          end,
        },
      },
    },
  },
}
