return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    hints = {
      ["[dcyvV][ia][%(%)]"] = {
        message = function(keys)
          return "Use " .. keys:sub(1, 2) .. "b instead of " .. keys
        end,
        length = 3,
      },
      ["[dcyvV][ia][%{%}]"] = {
        message = function(keys)
          return "Use " .. keys:sub(1, 2) .. "B instead of " .. keys
        end,
        length = 3,
      },
    },
  },
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
