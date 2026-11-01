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
        end,
    },
    "neovim/nvim-lspconfig",
    {
        "nvim-telescope/telescope.nvim",
        version = "v0.2.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "Telescope",
        keys = {
            {
                "<Leader>ff",
                "<CMD>:Telescope find_files find_command=rg,--files,--hidden,--ignore,--iglob=!.git/<CR>",
            },
        },
    },
    {
        "simnalamburt/vim-mundo",
        cmd = "MundoToggle",
        init = function()
            -- Open mundo pane to the right.
            vim.g.mundo_right = 1
        end,
        keys = {
            { "<leader>u", "<cmd>MundoToggle<CR>" },
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
