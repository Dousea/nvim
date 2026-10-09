# nvim

My Neovim config, built on [LazyVim](https://www.lazyvim.org). It's installed by my
[dotfiles](https://github.com/Dousea/dotfiles) and works on its own as well.

## Requirements

- Neovim 0.12 or newer
- `git` and a C compiler for Treesitter parsers
- Node.js available globally (e.g. `mise use -g node@lts`): Mason installs most
  language servers with `npm` and runs it outside your projects
- A [Nerd Font](https://www.nerdfonts.com) in the terminal
- Optional: `lazygit`, `rg`, `fd`, and a terminal with the kitty graphics protocol
  (Ghostty, kitty, WezTerm) for images in Markdown

## Install

With the dotfiles, chezmoi clones this repo to `~/.config/nvim`. On its own:

```sh
git clone https://github.com/Dousea/nvim.git ~/.config/nvim
nvim
```

The first start installs the plugins, then Mason installs the language servers and
tools in the background (`:Mason` shows progress).

## Update

With the dotfiles, chezmoi pulls this repo when it's more than an hour old:

```sh
chezmoi update                      # or --refresh-externals to pull now
```

Then run `:Lazy restore` in Neovim to put the plugins at the versions in
`lazy-lock.json`. Pulling fails if the clone has local changes, so commit or
discard them first.

Update plugins on one machine with `:Lazy sync` and commit `lazy-lock.json`, so the
lockfile changes in one place only.

## What's in it

On top of LazyVim's defaults:

| Area | Setup |
|---|---|
| Languages | TypeScript/JavaScript (vtsls, ESLint, Prettier), Tailwind, JSON, Markdown, Docker, PHP (intelephense), Python (basedpyright, ruff), Ruby (ruby-lsp, rubocop), Rust |
| Editing | yanky, dial, inc-rename, mini-move, leap, navic |
| AI | [claudecode.nvim](https://github.com/coder/claudecode.nvim): connects to Claude Code (`/ide`) running in another pane or in a split |
| tmux | [smart-splits.nvim](https://github.com/smart-splits-nvim/smart-splits.nvim): one set of keys for Neovim splits and tmux panes |
| Review | [diffview.nvim](https://github.com/sindrets/diffview.nvim) for git, Neovim's built-in Undotree for anything else |
| chezmoi | LazyVim's chezmoi extra: edit and apply dotfiles from Neovim |
| Habits | [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim) hints at better motions |
| Tips | [neovim-tips](https://github.com/saxon1964/neovim-tips): a tip popup once a day, plus a searchable collection; your own tips live in `neovim_tips/user_tips.md` |

Also:

- Files changed outside Neovim (e.g. by a coding agent in another pane) reload within
  a second, with a notification. Reloads can be undone with `u`.
- Indent guides are off; spaces and line ends are shown as `⋅` and `↴` instead.
- Prettier only formats when the project has a Prettier config.
- Ruby tools that install through `gem` are skipped until Ruby is available.

## Keymaps

Only the ones added here; `<leader>` is Space. `<leader>sk` searches all keymaps.

| Keys | Action |
|---|---|
| `Ctrl-h/j/k/l` | Move between Neovim splits and tmux panes |
| `Ctrl-Arrows` | Resize splits |
| `<leader>ac` / `<leader>af` | Toggle / focus Claude |
| `<leader>as` | Send the selection to Claude (visual) |
| `<leader>ab` | Add the current buffer to Claude's context |
| `<leader>aa` / `<leader>ad` | Accept / deny Claude's proposed diff |
| `<leader>gv` | Diffview of uncommitted changes |
| `<leader>gV` | Diffview history of the current file |
| `<leader>uu` | Undotree |
| `<leader>ht` / `<leader>hr` | Toggle hardtime / show its report |
| `<leader>To` / `<leader>Tr` | Browse tips / show a random tip |
| `<leader>Tb` / `<leader>Ta` / `<leader>Te` | Bookmarked tips / add a tip / edit your tips |
| `n` / `N` | Next / previous match, centered |

## tmux

For `Ctrl-h/j/k/l` to also move out of non-Neovim panes, tmux needs these bindings
(the dotfiles include them):

```tmux
set -g focus-events on
bind -n C-h if -F '#{@pane-is-vim}' { send-keys C-h } { select-pane -L }
bind -n C-j if -F '#{@pane-is-vim}' { send-keys C-j } { select-pane -D }
bind -n C-k if -F '#{@pane-is-vim}' { send-keys C-k } { select-pane -U }
bind -n C-l if -F '#{@pane-is-vim}' { send-keys C-l } { select-pane -R }
```

`focus-events` also lets Neovim reload files as soon as you switch back to it.

## Per-project overrides

lazy.nvim loads a `.lazy.lua` from the project root after this config and asks
once whether to trust it. For example, to use solargraph from the project's bundle
instead of ruby-lsp:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = { enabled = false },
        rubocop = { enabled = false },
        solargraph = {
          enabled = true,
          mason = false,
          cmd = { "bundle", "exec", "solargraph", "stdio" },
        },
      },
    },
  },
}
```

To keep it out of the project's repo, add `.lazy.lua` to `.git/info/exclude`.
