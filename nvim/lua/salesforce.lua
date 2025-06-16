local M = {}

local result_bufnr = nil

-- Creates or clears the result buffer window, returns buffer number
local function create_or_replace_result_window(name)
  if result_bufnr and vim.api.nvim_buf_is_valid(result_bufnr) then
    vim.api.nvim_buf_set_lines(result_bufnr, 0, -1, false, {})
  else
    vim.cmd("botright 25split")
    vim.cmd("enew")
    result_bufnr = vim.api.nvim_get_current_buf()
    vim.bo[result_bufnr].buftype = 'nofile'
    vim.bo[result_bufnr].bufhidden = 'wipe'
    vim.bo[result_bufnr].swapfile = false
    vim.bo[result_bufnr].modifiable = true
    vim.api.nvim_buf_set_name(result_bufnr, name or "Command Results")
  end
  return result_bufnr
end

-- Generic function to run a CLI command and display output in the buffer
function M.run_cmd(cmd_tbl, buf_name, filetype, post_process)
  local output_lines = {}

  local function on_stdout(_, data)
    if data then
      for _, line in ipairs(data) do
        table.insert(output_lines, line)
      end
    end
  end

  local function on_exit()
    local bufnr = create_or_replace_result_window(buf_name)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output_lines)
    if filetype then
      vim.api.nvim_buf_set_option(bufnr, 'filetype', filetype)
    end
    vim.api.nvim_set_current_buf(bufnr)
    if post_process then
      post_process(bufnr)
    end
  end

  vim.fn.jobstart(cmd_tbl, {
    stdout_buffered = true,
    on_stdout = on_stdout,
    on_exit = on_exit,
  })
end

function M.run_soql_query(target_org)
  local filepath = vim.fn.expand('%:p')
  if not filepath:match('%.soql$') then
    print("Not a .soql file")
    return
  end
  local cmd = { "sf", "data", "query", "--target-org", target_org, "--file", filepath, "-r", "csv" }
  M.run_cmd(cmd, "SOQL Results", "csv", function(bufnr)
    require("csvview").enable()
  end)
end

function M.run_apex_command(apex_cmd)
  if not apex_cmd or apex_cmd == "" then
    print("Please provide an Apex command")
    return
  end
  -- Example apex command: "apex run test --code-coverage"
  local cmd = vim.split(apex_cmd, " ", { plain = true })
  M.run_cmd(cmd, "Apex Results", "text")
end

return M
