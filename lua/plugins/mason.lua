-- see this issue: https://github.com/LazyVim/LazyVim/issues/6039
-- the new version (2.x) of mason.nvim is not compatible with current lazyvim
return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
}
