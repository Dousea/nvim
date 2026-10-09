return {
  "smart-splits-nvim/smart-splits.nvim",
  dependencies = {
    { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux", opts = {} },
  },
  -- Loaded at startup so tmux knows the pane runs Neovim
  lazy = false,
  opts = {
    mux = { backend = "smart-splits-backend-tmux", warn_if_unusable = false },
  },
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Go to Left Window" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Go to Lower Window" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Go to Upper Window" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Go to Right Window" },
    { "<C-Left>", function() require("smart-splits").resize_left() end, desc = "Resize Window Left" },
    { "<C-Down>", function() require("smart-splits").resize_down() end, desc = "Resize Window Down" },
    { "<C-Up>", function() require("smart-splits").resize_up() end, desc = "Resize Window Up" },
    { "<C-Right>", function() require("smart-splits").resize_right() end, desc = "Resize Window Right" },
  },
}
