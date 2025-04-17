return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "zbirenbaum/copilot.lua",
        config = function()
            local copilot = require("copilot")
            local asdf_latest = vim.system({ "asdf", "latest", "nodejs" }, { text = true }):wait()
            local version = string.gsub(asdf_latest.stdout, "[\r\n]+", "")
            local asdf_where = vim.system({ "asdf", "where", "nodejs", version }, { text = true }):wait()
            local node_bin = string.gsub(asdf_where.stdout, "[\r\n]+", "") .. "/bin/node"
            copilot.setup({ copilot_node_command = node_bin })
        end,
        keys = {
            {
                "<leader>cp",
                function()
                    require("copilot.panel").toggle()
                end,
                desc = "Toggle Copilot Panel",
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        config = true,
    },
    { "AndreM222/copilot-lualine" },
}
