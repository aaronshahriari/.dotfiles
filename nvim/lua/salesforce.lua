local M = {}

local result_bufnr = nil
local csvview = require("csvview")

local function create_or_replace_result_window(name)
  -- Reuse valid existing buffer
  if result_bufnr and vim.api.nvim_buf_is_valid(result_bufnr) then
    vim.api.nvim_buf_set_lines(result_bufnr, 0, -1, false, {})
    return result_bufnr
  end

  -- Save current window so we can restore it later
  local current_win = vim.api.nvim_get_current_win()

  -- Create a new split window and buffer
  vim.cmd("botright 20split")
  vim.wo.colorcolumn = ""
  -- local win = vim.api.nvim_get_current_win()
  vim.cmd("enew")

  result_bufnr = vim.api.nvim_get_current_buf()
  vim.bo[result_bufnr].buftype = 'nofile'
  vim.bo[result_bufnr].bufhidden = 'wipe'
  vim.bo[result_bufnr].swapfile = false
  vim.bo[result_bufnr].modifiable = true
  vim.api.nvim_buf_set_name(result_bufnr, name or "Command Results")

  -- Move cursor back to where it was
  vim.api.nvim_set_current_win(current_win)

  return result_bufnr
end

local function strip_ansi(str)
  if type(str) ~= "string" then return "" end
  return str:gsub("\27%[[0-9;]*m", "")
end

function M.run_cmd(cmd_tbl, buf_name, filetype, post_process, filter, pre_set_lines)
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

    if pre_set_lines then
      pre_set_lines(bufnr)
    end

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
  M.run_cmd(cmd, "SOQL Results", "csv", function(bufnr)
    local prev_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_set_current_buf(prev_buf)
    if csvview and csvview.enable then
      csvview.enable(bufnr)
    end
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

    if csvview and csvview.is_enabled and csvview.disable and csvview.is_enabled(bufnr) then
      csvview.disable(bufnr)
    end
  end

  M.run_cmd(cmd, "Apex Results", "txt", post_process, nil, function(bufnr)
    if csvview and csvview.is_enabled and csvview.disable and csvview.is_enabled(bufnr) then
      csvview.disable(bufnr)
    end
  end)
end

return M
