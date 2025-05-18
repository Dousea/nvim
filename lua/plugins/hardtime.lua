return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {},
  keys = {
    {
      "<leader>ht",
      "<cmd>Hardtime toggle<cr>",
      "Toggle Hardtime",
    },
    {
      "<leader>hr",
      "<cmd>Hardtime report<cr>",
      "Show Hardtime Report",
    },
  },
}
