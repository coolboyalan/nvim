-- ~/.config/nvim/lua/plugins/themes.lua
return {
    -- Ayu (vim implementation; provides 'ayu' colorscheme)
    {
        'ayu-theme/ayu-vim',
        lazy = false,
        priority = 1300,
        config = function()
            -- choose ayu variant: "dark", "mirage", or "light"
            vim.g.ayucolor = 'dark'
            -- apply at startup if this is the chosen default (we also persist last theme separately)
            -- Do NOT force apply here if you want persistence later; I'll show you how to load persisted theme.
        end,
    },

    -- Popular themes (installed at startup so :colorscheme works)
    { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1200 },
    { 'folke/tokyonight.nvim', lazy = false, priority = 1150 },
    { 'rebelot/kanagawa.nvim', lazy = false, priority = 1150 },
    { 'sainnhe/gruvbox-material', lazy = false, priority = 1150 },

    -- optional extras you might like (installing these gives you more choices)
    { 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1100 },
    { 'shaunsingh/nord.nvim', lazy = false, priority = 1100 },
    { 'EdenEast/nightfox.nvim', lazy = false, priority = 1100 },
    { 'Mofiqul/vscode.nvim', lazy = false, priority = 1100 },
    { 'marko-cerovac/material.nvim', lazy = false, priority = 1000 },
    { 'NTBBloodbath/doom-one.nvim', lazy = false, priority = 1000 },
    { 'glepnir/zephyr-nvim', lazy = false, priority = 1000 },
}
