require('config')

vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require('config.keymaps')
        require('utils')
    end,
})
