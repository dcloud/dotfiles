return {
    {
        "nvim-lualine/lualine.nvim",
        event = "ColorScheme",
        opts = function()
            local ai = require("lualine.components.ai-lualine")
            return {
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
                    lualine_y = { ai },
                    lualine_z = { "progress", "location" },
                },
            }
        end,
    },
}
