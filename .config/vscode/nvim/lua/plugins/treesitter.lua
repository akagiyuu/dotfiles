return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        opts = {
            indent = { enable = true },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        },
        config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end
    },
}
