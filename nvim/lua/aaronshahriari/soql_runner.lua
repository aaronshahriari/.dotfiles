local M = {}

-- Store buffer number for reuse
local result_bufnr = nil

function M.run_soql_query()
  local filepath = vim.fn.expand('%:p')

  -- Only run for .soql files
  if not filepath:match('%.soql$') then
    print("Not a .soql file")
    return
  end

  -- Run the SOQL query using Salesforce CLI
  local cmd = { "sf", "data", "query", "--file", filepath }

  local function create_or_replace_result_window()
    -- Reuse buffer if it exists
    if result_bufnr and vim.api.nvim_buf_is_valid(result_bufnr) then
      vim.api.nvim_buf_set_lines(result_bufnr, 0, -1, false, {})
    else
      vim.cmd("botright vsplit")
      vim.cmd("enew")
      result_bufnr = vim.api.nvim_get_current_buf()
      vim.bo[result_bufnr].buftype = 'nofile'
      vim.bo[result_bufnr].bufhidden = 'wipe'
      vim.bo[result_bufnr].swapfile = false
      vim.bo[result_bufnr].modifiable = true
      vim.api.nvim_buf_set_name(result_bufnr, "SOQL Results")
    end

    return result_bufnr
  end

  local output_lines = {}
  local function on_stdout(_, data)
    if data then
      for _, line in ipairs(data) do
        table.insert(output_lines, line)
      end
    end
  end

  local function on_exit()
    local bufnr = create_or_replace_result_window()
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output_lines)
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = on_stdout,
    on_exit = on_exit,
  })
end

return M
