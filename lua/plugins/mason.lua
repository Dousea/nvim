-- Skip Ruby tooling that Mason installs through gem when Ruby isn't available
local has_gem = vim.fn.executable("gem") == 1

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if not has_gem then
        opts.ensure_installed = vim.tbl_filter(function(pkg)
          return pkg ~= "erb-formatter" and pkg ~= "erb-lint"
        end, opts.ensure_installed or {})
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not has_gem then
        for _, server in ipairs({ "ruby_lsp", "rubocop" }) do
          if type(opts.servers[server]) == "table" then
            opts.servers[server].mason = false
          end
        end
      end
    end,
  },
}
