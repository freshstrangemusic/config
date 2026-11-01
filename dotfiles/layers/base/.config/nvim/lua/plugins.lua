return {
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
