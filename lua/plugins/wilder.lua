local M = {
    'gelguy/wilder.nvim',
    event = 'VeryLazy',
    dependencies = {
        'romgrk/fzy-lua-native',
        build = 'make',
    },
}

function M.config()
    local wilder = require('wilder')
    wilder.setup({ modes = { ':', '/', '?' } })

    -- Disable Python remote plugin
    wilder.set_option('use_python_remote_plugin', 0)

    wilder.set_option('pipeline', {
        wilder.branch(
            wilder.cmdline_pipeline({
                fuzzy = 1,
                fuzzy_filter = wilder.lua_fzy_filter(),
            }),
            wilder.vim_search_pipeline()
        ),
    })

    local highlighters = {
        wilder.lua_fzy_highlighter(),
        wilder.basic_highlighter(),
    }

    local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = 'rounded',
        pumblend = 0,
        empty_message = wilder.popupmenu_empty_message_with_spinner(),
        highlighter = highlighters,
        highlights = {
            accent = wilder.make_hl(
                'WilderAccent',
                'Pmenu',
                { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }
            ),
        },
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
    }))

    local wildmenu_renderer = wilder.wildmenu_renderer({
        highlighter = highlighters,
    })

    wilder.set_option(
        'renderer',
        wilder.renderer_mux({
            [':'] = popupmenu_renderer,
            ['/'] = wildmenu_renderer,
        })
    )
end

return M
