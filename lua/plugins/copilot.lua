return {
  "zbirenbaum/copilot.lua",
  opts = function(_, opts)
    local copilot_node_command = nil

    -- Check if mise is installed
    local mise_path = vim.fn.exepath("mise")
    if mise_path ~= "" then
      -- Get installed Node versions sorted by semver
      local handle = io.popen("mise ls node --json")
      if handle then
        local output = handle:read("*a")
        handle:close()
        local ok, nodes = pcall(vim.fn.json_decode, output)
        if ok and type(nodes) == "table" then
          -- Sort and find the latest version >= 20
          table.sort(nodes, function(a, b)
            return a.version > b.version
          end)
          for _, node in ipairs(nodes) do
            local major = tonumber(node.version:match("^(%d+)"))
            if major and major >= 20 then
              copilot_node_command = string.format("%s/bin/node", node.install_path)
              break
            end
          end
        end
      end
    end

    -- Fallback if not found or doesn't meet criteria
    if not copilot_node_command then
      vim.notify("Copilot: Suitable Node.js version (>= 20) not found in mise", vim.log.levels.WARN)
    else
      opts.copilot_node_command = copilot_node_command
    end

    return opts
  end,
}
