-- ~/.config/nvim/lua/config/theme-cycle.lua
-- Cycle installed themes and remember last chosen theme (persist to state file)

local M = {}

-- list of installed theme names (must match the colorscheme names provided by the plugins above)
M.themes = {
    'ayu', -- ayu-vim colorscheme name
    'catppuccin', -- catppuccin's name
    'tokyonight', -- tokyonight
    'kanagawa', -- kanagawa
    'gruvbox-material', -- gruvbox-material
    'rose-pine', -- rose-pine
    'nord', -- nord
    'nightfox', -- nightfox
    'vscode', -- vscode.nvim colorscheme name
    'material', -- material.nvim (name may be 'material' or 'material-nvim', but colorscheme is 'material')
    'doom-one', -- doom-one
    'zephyr', -- zephyr-nvim (colorscheme might be 'zephyr')
}

-- path to persist last choice
local state_file = vim.fn.stdpath('state') .. '/last_colorscheme'

local function read_last_theme()
    local f = io.open(state_file, 'r')
    if not f then
        return nil
    end
    local t = f:read('*l')
    f:close()
    return t
end

local function write_last_theme(name)
    local f = io.open(state_file, 'w')
    if not f then
        return
    end
    f:write(name)
    f:close()
end

-- apply a colorscheme safely (pcall so errors don't break startup)
function M.apply(name)
    if not name or name == '' then
        return false
    end
    local ok, _ = pcall(vim.cmd, 'colorscheme ' .. name)
    if ok then
        write_last_theme(name)
        return true
    end
    return false
end

-- cycle index (initialized from last theme if present)
local function find_index(name)
    for i, v in ipairs(M.themes) do
        if v == name then
            return i
        end
    end
    return 1
end

function M.setup(opts)
    opts = opts or {}
    -- allow overriding theme list
    if opts.themes and type(opts.themes) == 'table' then
        M.themes = opts.themes
    end

    local last = read_last_theme()
    local idx = last and find_index(last) or 1

    -- try to apply persisted theme first; fallback to first in list
    if last then
        if not M.apply(last) then
            idx = 1
            M.apply(M.themes[1])
        end
    else
        -- if nothing persisted, try first theme
        M.apply(M.themes[1])
    end

    -- set up cycle keymap
    local i = idx
    vim.keymap.set('n', '<leader>ct', function()
        i = (i % #M.themes) + 1
        local name = M.themes[i]
        if M.apply(name) then
            print('Theme → ' .. name)
        else
            print('Failed to load theme: ' .. name)
        end
    end, { desc = 'Cycle installed themes' })
end

return M
