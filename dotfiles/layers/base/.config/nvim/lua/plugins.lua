return {
    {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            indent = {
                animate = {
                    enabled = false,
                },
            },
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priorty = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-storm]])
        end
    },
    "tpope/vim-sleuth",
}
