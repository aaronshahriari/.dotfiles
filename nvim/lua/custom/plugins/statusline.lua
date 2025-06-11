return {
  "tjdevries/express_line.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  config = function()
    vim.opt.laststatus = 3
    local devicons = require("nvim-web-devicons")
    local builtin = require("el.builtin")
    local extensions = require("el.extensions")
    local sections = require("el.sections")
    local subscribe = require("el.subscribe")

    local function set_hl(hls, s)
      if not hls or not s then
        return s
      end
      hls = type(hls) == "string" and { hls } or hls
      for _, hl in ipairs(hls) do
        if vim.fn.hlID(hl) > 0 then
          return ("%%#%s#%s%%0*"):format(hl, s)
        end
      end
      return s
    end

    local function diagnostics(_, buffer)
      local counts = { 0, 0, 0, 0 }
      local diags = vim.diagnostic.get(buffer.bufnr)
      if diags and not vim.tbl_isempty(diags) then
        for _, d in ipairs(diags) do
          if tonumber(d.severity) then
            counts[d.severity] = counts[d.severity] + 1
          end
        end
      end
      counts = {
        errors = counts[1],
        warnings = counts[2],
        infos = counts[3],
        hints = counts[4],
      }
      local items = {}
      local icons = {
        ["errors"] = { "X", "DiagnosticError" },
        ["warnings"] = { "W", "DiagnosticWarn" },
        ["infos"] = { "I", "DiagnosticInfo" },
        ["hints"] = { "H", "DiagnosticHint" },
      }
      for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
        if counts[k] > 0 then
          table.insert(items, set_hl(icons[k][2], ("%s%s"):format(icons[k][1], counts[k])))
        end
      end
      local fmt = " %s"
      if vim.tbl_isempty(items) then
        return ""
      end
      local contents = ("%s"):format(table.concat(items, " "))
      return fmt:format(contents)
    end

    -- old
    -- local function git_branch()
    --   local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    --   if not git_root or git_root == "" then return "" end
    --
    --   local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD", git_root)[1] or ""
    --   if branch ~= "" then
    --     return set_hl("@constant", "[" .. branch .. "]")
    --   end
    --   return ""
    -- end

    local function git_branch()
      local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

      -- If not inside a Git repo
      if not git_root or git_root == "" or git_root:find("fatal") then
        return set_hl("@constant", "[]")
      end

      local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD", git_root)[1] or ""
      if branch ~= "" then
        return set_hl("@constant", "[" .. branch .. "]")
      end

      return ""
    end

    local function git_changes()
      local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      if not git_root or git_root == "" then return "" end

      local function run_git(cmd)
        return vim.fn.systemlist(cmd, git_root)[1] or ""
      end

      local diff = run_git("git diff --shortstat")
      local staged = run_git("git diff --cached --shortstat")
      local combined = (diff or "") .. "\n" .. (staged or "")

      local specs = {
        insert = { regex = "(%d+) insertion", icon = "+", hl = "diffAdded" },
        delete = { regex = "(%d+) deletion", icon = "-", hl = "diffRemoved" },
        change = { regex = "(%d+) file changed", icon = "~", hl = "diffChanged" },
      }

      local result = {}
      for _, spec in pairs(specs) do
        local count = 0
        for line in combined:gmatch("[^\n]+") do
          local n = tonumber(line:match(spec.regex)) or 0
          count = count + n
        end
        if count > 0 then
          table.insert(result, set_hl(spec.hl, ("%s%d"):format(spec.icon, count)))
        end
      end

      return "{" .. table.concat(result, " ") .. "}"
    end

    local function mode(_, _)
      local modes = {
        n = { "Normal", { "@function" } },
        niI = { "Normal", { "@function" } },
        niR = { "Normal", { "@function" } },
        niV = { "Normal", { "@functio" } },
        no = { "N·OpPd", { "@function" } },
        v = { "Visual", { "Directory" } },
        V = { "V·Line", { "Directory" } },
        ["󰬃"] = { "V·Blck", { "Directory" } },
        s = { "Select", { "Search" } },
        S = { "S·Line", { "Search" } },
        [""] = { "S·Block", { "Search" } },
        i = { "Insert", { "@constant" } },
        ic = { "ICompl" },
        R = { "Rplace", { "WarningMsg", "IncSearch" } },
        Rv = { "VRplce", { "WarningMsg", "IncSearch" } },
        c = { "Command", { "diffAdded", "DiffAdd" } },
        cv = { "Vim Ex" },
        ce = { "Ex (r)" },
        r = { "Prompt" },
        rm = { "More  " },
        ["r?"] = { "Cnfirm" },
        ["!"] = { "Shell ", { "DiffAdd", "diffAdded" } },
        nt = { "Term  ", { "Visual" } },
        t = { "Term  ", { "DiffAdd", "diffAdded" } },
      }
      local fmt = "%s "
      local m = vim.api.nvim_get_mode().mode
      local mode_data = modes and modes[m]
      local hls = mode_data and mode_data[2]
      m = mode_data and mode_data[1]:upper() or m
      m = (fmt):format(m)
      return set_hl(hls, m) or m
    end

    require("el").setup({
      generator = function(_, _)
        local items = {
          { mode, },
          { subscribe.buf_autocmd("el_git_branch_writepost", "BufWritePost", git_changes), },
          { subscribe.buf_autocmd("el_buf_diagnostic", "DiagnosticChanged", diagnostics), },
          { sections.split },
          { subscribe.buf_autocmd("el_git_branch_bufenter", "BufEnter", git_branch), },
          { " " },
          { "%f" },
          { sections.split },
          -- {
          --   sections.collapse_builtin({
          --     "[",
          --     builtin.help_list,
          --     builtin.readonly_list,
          --     "]",
          --   }),
          -- },
          {
            function()
              local ft = vim.bo.filetype
              local icon, _ = devicons.get_icon_by_filetype(ft) or ""
              return "[" .. ft .. "]"
            end,
          }
        }

        local result = {}
        for _, item in ipairs(items) do
          table.insert(result, item)
        end

        return result
      end,
    })
  end,
}
