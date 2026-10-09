-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Reload files changed outside Neovim while it keeps focus, e.g. by tools
-- editing in another pane
local reload_timer = vim.uv.new_timer()
if reload_timer then
  reload_timer:start(
    1000,
    1000,
    vim.schedule_wrap(function()
      if vim.fn.mode() == "n" and vim.fn.getcmdwintype() == "" then
        vim.cmd("silent! checktime")
      end
    end)
  )
end

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("reload_notify", { clear = true }),
  callback = function(ev)
    vim.notify("Reloaded " .. vim.fn.fnamemodify(ev.file, ":~:."), vim.log.levels.INFO)
  end,
})
