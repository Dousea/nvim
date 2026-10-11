-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "basedpyright"

-- adds <> to % matchpairs
vim.opt.matchpairs:append("<:>")
vim.opt.complete = ".,w,b,u,t,i"
vim.opt.nrformats = "bin,hex,alpha" -- can increment alphabetically too!

vim.o.foldenable = false
vim.o.spell = false

-- https://vi.stackexchange.com/a/5318/12823
vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

vim.o.background = "dark"

vim.opt.softtabstop = 2

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.breakat = " ^I-+;,."

-- GNOME only lets wl-clipboard reach the clipboard with focus, so yanks and pastes can
-- block until a "wl-clipboard is ready" notification is clicked. Copy through the
-- terminal (OSC 52) instead and paste the last copy from Neovim; paste text from
-- other apps with the terminal's paste.
if vim.env.WAYLAND_DISPLAY and (vim.env.XDG_CURRENT_DESKTOP or ""):find("GNOME") then
  local osc52 = require("vim.ui.clipboard.osc52")
  local last = {}
  local function copy(reg)
    local send = osc52.copy(reg)
    return function(lines, regtype)
      last[reg] = { lines, regtype }
      send(lines)
    end
  end
  local function paste(reg)
    return function()
      return last[reg] or { { "" }, "v" }
    end
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = copy("+"), ["*"] = copy("*") },
    paste = { ["+"] = paste("+"), ["*"] = paste("*") },
  }
end
