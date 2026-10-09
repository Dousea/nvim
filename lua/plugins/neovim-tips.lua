return {
  "saxon1964/neovim-tips",
  version = "*",
  -- Loaded at startup so the daily tip can show
  lazy = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  opts = {
    daily_tip = 1,
  },
  keys = {
    { "<leader>T", "", desc = "+tips" },
    { "<leader>To", "<cmd>NeovimTips<cr>", desc = "Neovim Tips" },
    { "<leader>Tr", "<cmd>NeovimTipsRandom<cr>", desc = "Random Tip" },
    { "<leader>Tb", "<cmd>NeovimTipsBookmarks<cr>", desc = "Bookmarked Tips" },
    { "<leader>Ta", "<cmd>NeovimTipsAdd<cr>", desc = "Add Tip" },
    { "<leader>Te", "<cmd>NeovimTipsEdit<cr>", desc = "Edit Tips" },
  },
}
