return {
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "sheerun/vim-polyglot",
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
    "tpope/vim-commentary",
    "tpope/vim-dadbod",
    "tpope/vim-surround",
    "junegunn/fzf",
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    "junegunn/fzf.vim",
    { "windwp/nvim-autopairs", event = "InsertEnter", opts={} },
    { 'rose-pine/neovim', name = 'rose-pine' },
}
