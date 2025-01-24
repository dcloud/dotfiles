return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        -- Setup via opts didn't work
        local p = require("rose-pine.palette")
        require("rose-pine").setup({
            dim_inactive_windows = true,
            extend_background_behind_borders = true,
            groups = {
                border = p.love,
            },
            palette = {
                main = {
                    _nc = p.surface,
                },
            },
        })
        vim.cmd("colorscheme rose-pine")
    end,
}
