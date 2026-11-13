-- Follow the system theme written by hypr's `theme-switch` (~/.cache/theme-mode: "light" | "dark").
local M = {}

local mode_file = vim.fn.expand("~/.cache/theme-mode")

local function read_mode()
    local f = io.open(mode_file)
    if not f then
        return nil
    end
    local mode = vim.trim(f:read("*a") or "")
    f:close()
    return (mode == "light" or mode == "dark") and mode or nil
end

local function apply()
    local mode = read_mode()
    if mode and vim.o.background ~= mode then
        -- Changing 'background' makes nvim re-source the active colorscheme
        vim.o.background = mode
    end
end

function M.setup()
    apply()

    -- theme-switch rewrites the file in place, and some editors replace it, so re-arm after each event
    local watcher = vim.uv.new_fs_event()
    local function watch()
        watcher:stop()
        watcher:start(mode_file, {}, vim.schedule_wrap(function()
            apply()
            watch()
        end))
    end
    if vim.uv.fs_stat(mode_file) then
        watch()
    end

    -- Fallback for when the file didn't exist yet or a change was missed (e.g. after suspend)
    vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, { callback = apply })
end

return M
