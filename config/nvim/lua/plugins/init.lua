return {
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "sheerun/vim-polyglot",
    {
        "https://github.com/apple/pkl-neovim",
        lazy = true,
        event = {
            "BufReadPre *.pkl",
            "BufReadPre *.pcf",
            "BufReadPre PklProject",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        build = ":TSInstall! pkl",
    },
    "neovim/nvim-lspconfig",
    "ray-x/go.nvim",
    "nvim-lualine/lualine.nvim",
    "dense-analysis/ale",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/vim-vsnip-integ",
    "mattn/emmet-vim",
    "tpope/vim-commentary",
    "tpope/vim-dadbod",
    "tpope/vim-surround",
    {
        "ibhagwan/fzf-lua",
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({"fzf-vim"})
        end
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "windwp/nvim-autopairs", event = "InsertEnter", opts={} },
    { 'rose-pine/neovim', name = 'rose-pine' },
}
