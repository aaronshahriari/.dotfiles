local wezterm = require('wezterm')

local M = {}

M.directories = {
    "~/Github",
    "~/",
    "~/work",
    "~/personal"
}

function M.select_and_open_directory_in_new_tab(window, pane)
    local find_command = "find " .. table.concat(M.directories, " ") .. " -mindepth 1 -maxdepth 1 -type d"
    local full_command = string.format("%s | fzf", find_command)

    window:perform_action(
        wezterm.action.SpawnCommandInNewTab {
            args = { "sh", "-c", full_command },
        },
        pane
    )
end

return M
