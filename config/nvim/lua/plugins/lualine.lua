return {
    {
        "nvim-lualine/lualine.nvim",
        event = "ColorScheme",
        opts = {
            options = {
                show_filename_only = false,
                theme = "rose-pine",
                icons_enabled = false,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "copilot" },
                lualine_z = { "progress", "location" },
            },
        },
    },
}
