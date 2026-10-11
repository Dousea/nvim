return {
  "saxon1964/neovim-tips",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  opts = {
    daily_tip = 1,
  },
  config = function(_, opts)
    -- The plugin shows its daily tip on VimEnter, where a window another plugin opens
    -- (e.g. neo-tree on `nvim <dir>`) takes focus and closes the tip. Show it once
    -- startup has settled instead.
    require("neovim_tips").setup(vim.tbl_extend("force", opts, { daily_tip = 0 }))
    require("neovim_tips.config").options.daily_tip = opts.daily_tip
    vim.defer_fn(function()
      require("neovim_tips.utils").run_async(require("neovim_tips.loader").load, function(ok)
        if ok then
          require("neovim_tips.daily_tip").check_and_show()
        end
      end)
    end, 200)
  end,
  keys = {
    { "<leader>T", "", desc = "+tips" },
    { "<leader>To", "<cmd>NeovimTips<cr>", desc = "Neovim Tips" },
    { "<leader>Tr", "<cmd>NeovimTipsRandom<cr>", desc = "Random Tip" },
    { "<leader>Tb", "<cmd>NeovimTipsBookmarks<cr>", desc = "Bookmarked Tips" },
    { "<leader>Ta", "<cmd>NeovimTipsAdd<cr>", desc = "Add Tip" },
    { "<leader>Te", "<cmd>NeovimTipsEdit<cr>", desc = "Edit Tips" },
  },
}
