local M = {}

local result_bufnr = nil

local function create_or_replace_result_window(name)
  -- If result buffer exists and is valid
  if result_bufnr and vim.api.nvim_buf_is_valid(result_bufnr) then
    -- Try to find the window showing this buffer
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == result_bufnr then
        -- Clear the buffer content
        vim.api.nvim_buf_set_lines(result_bufnr, 0, -1, false, {})
        -- Focus the window
        vim.api.nvim_set_current_win(win)
        return result_bufnr
      end
    end
  end

  -- Otherwise, create a new split + buffer
  vim.cmd("botright 20split")
  vim.cmd("enew")
  result_bufnr = vim.api.nvim_get_current_buf()
  vim.bo[result_bufnr].buftype = 'nofile'
  vim.bo[result_bufnr].bufhidden = 'wipe'
  vim.bo[result_bufnr].swapfile = false
  vim.bo[result_bufnr].modifiable = true
  vim.api.nvim_buf_set_name(result_bufnr, "")
  vim.api.nvim_buf_set_name(result_bufnr, name or "Command Results")

  return result_bufnr
end

local function strip_ansi(str)
  if type(str) ~= "string" then return "" end
  return str:gsub("\27%[[0-9;]*m", "")
end

function M.run_cmd(cmd_tbl, buf_name, filetype, post_process, filter)
  local output_lines = {}

  local function handle_output(_, data)
    if data then
      for _, line in ipairs(data) do
        if line ~= "" then
          local clean_line = (strip_ansi(line))
          if not filter or filter(clean_line) then
            table.insert(output_lines, clean_line)
          end
        end
      end
    end
  end

  local function on_exit()
    local bufnr = create_or_replace_result_window(buf_name)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output_lines)
    if filetype then
      vim.api.nvim_buf_set_option(bufnr, 'filetype', filetype)
    end
    if post_process then
      post_process(bufnr)
    end
  end

  vim.fn.jobstart(cmd_tbl, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = handle_output,
    on_stderr = handle_output,
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
  local function filter(line)
    return not (
      line:match("^%s*›%s*Warning: @salesforce/cli update available") or
      line:match("^Querying Data%.%.%. done$")
    )
  end
  M.run_cmd(cmd, "SOQL Results", "csv", function()
    require("csvview").enable()
  end, filter)
end

function M.run_apex_command(target_org)
  local filepath = vim.fn.expand('%:p')
  if not filepath:match('%.apex$') then
    print("Not a .apex file")
    return
  end
  local cmd = { "sf", "apex", "run", "--target-org", target_org, "--file", filepath }

  local function post_process(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local debug_output = {}

    for _, line in ipairs(lines) do
      local msg = line:match("|USER_DEBUG|.-|DEBUG|(.*)")
      if msg then
        table.insert(debug_output, msg)
      end
    end

    if #debug_output > 0 then
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, debug_output)
    end
    -- else: keep original buffer as-is
  end

  M.run_cmd(cmd, "Apex Results", "txt", post_process)
end

return M
