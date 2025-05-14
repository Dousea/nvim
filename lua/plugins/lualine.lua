return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    refresh = {
      statusline = 1500,
      tabline = 1500,
      winbar = 1500,
    },
    sections = {
      lualine_a = { "branch" },
      lualine_b = {},
      lualine_x = {},
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {},
    },
    extensions = {},
  },
  -- opts = function(_, opts)
  --   local sections = {}
  --
  --   for key, value in pairs(opts.sections) do
  --     sections[key] = value
  --   end
  --
  --   sections.lualine_z = opts.sections.lualine_y
  --   sections.lualine_y = opts.sections.lualine_x
  --   sections.lualine_x = nil
  --
  --   opts.sections = sections
  -- end,
}
