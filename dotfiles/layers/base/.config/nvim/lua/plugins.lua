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
    {
        "nvim-telescope/telescope.nvim",
        version = "v0.2.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
        },
    },
    "tpope/vim-sleuth",
}
