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
    "HiPhish/rainbow-delimiters.nvim",
    "neovim/nvim-lspconfig",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            icons_enabled = true,
            sections = {
                -- Disable the branch section. I use jj so git HEAD is always detached.
                lualine_b = { "diff", "diagnostics" },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "v0.2.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = "Telescope",
        keys = {
            {
                "<Leader>ff",
                "<CMD>Telescope find_files find_command=rg,--files,--hidden,--ignore,--iglob=!.git/<CR>",
            },
            {
                "<Leader>fg",
                "<CMD>Telescope live_grep find_command=rg,--hidden,--ignore,--iglob=!.git/<CR>",
            },
            {
                "<Leader>fo",
                "<CMD>Telescope oldfiles cwd_only=v:true<CR>",
            },
            {
                "<Leader>fb",
                "<CMD>Telescope buffers<CR>",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
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
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
        },
    },
    "tpope/vim-sleuth",
}
