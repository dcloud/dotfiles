return {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
        dim_inactive_windows = true,
    },
    config = function()
        vim.cmd("colorscheme rose-pine")
    end,
}
