return {
  'xvzc/chezmoi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function(_, opts)
    require("chezmoi").setup(opts)

    vim.schedule(function()
      local result = vim.system({ "chezmoi", "source-path" }, { text = true }):wait()

      if result.code == 0 then
        local source_path = vim.fn.trim(result.stdout)
        source_path = vim.fn.fnamemodify(source_path, ":p"):gsub("/$", "") -- normalize and remove trailing slash

        -- Watch the buffers fulfilling the source path condition immediately
        -- to avoid watch not being set on the file that triggered loading
        -- of chezmoi because autocmds could be set up after the first buffer
        -- fulfilling the event condition is opened.
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          local buf_name = vim.api.nvim_buf_get_name(bufnr)
          if buf_name:find(source_path, 1, true) then
            require("chezmoi.commands.__edit").watch(bufnr)
          end
        end

        vim.api.nvim_create_autocmd({ "BufAdd" }, {
          pattern = { source_path .. "/**" },
          callback = function(ev)
            local bufnr = ev.buf
            vim.schedule(function()
              require("chezmoi.commands.__edit").watch(bufnr)
            end)
          end,
        })
      else
        vim.notify(
          "Failed to get chezmoi source path:\n" .. result.stderr,
          vim.log.levels.ERROR
        )
      end
    end)
end,
}
