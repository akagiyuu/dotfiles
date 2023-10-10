return {
    {
        'kevinhwang91/nvim-fundo',
        lazy = false,
        dependencies = 'kevinhwang91/promise-async',
        config = true,
        build = function() require('fundo').install() end,
    },
    {
        'andrewferrier/debugprint.nvim',
        config = true,
        keys = { { 'g?', nil } },
    },
    {
        'cshuaimin/ssr.nvim',
        keys = {
            {
                '<leader>sr',
                function() require('ssr').open() end,
                { 'n', 'x' },
                desc = 'Structure search and replace',
            },
        },
        opts = {
            min_width = 50,
            min_height = 5,
            keymaps = {
                close = 'q',
                next_match = 'n',
                prev_match = 'N',
                replace_all = '<leader><cr>',
            },
        }
    },
    {
        'hrsh7th/nvim-insx',
        config = function() require('insx.preset.standard').setup() end,
        event = 'InsertEnter',
    },
    {
        {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup {
                    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                }
            end,
            keys = {
                { 'gc', mode = { 'n', 'v' } },
                { 'gb', mode = 'v' },
            }
        },
        {
            'danymat/neogen',
            cmd = 'Neogen',
            opts = {
                snippet_engine = 'luasnip',
                enabled = true,
                languages = {
                    cs = { template = { annotation_convention = 'xmldoc', } },
                }
            },
        }
    },
    require(... .. '.dial'),
    require(... .. '.motion'),
}
