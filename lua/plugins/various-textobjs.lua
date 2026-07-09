return {
  "chrisgrieser/nvim-various-textobjs",
  keys = {
    { "iv", "<cmd>lua require('various-textobjs').subword('inner')<cr>", mode = { "o", "x" }, desc = "Inner subword" },
    { "av", "<cmd>lua require('various-textobjs').subword('outer')<cr>", mode = { "o", "x" }, desc = "Outer subword" },
  },
  opts = {},
}
