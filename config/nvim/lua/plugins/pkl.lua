return {
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
}
