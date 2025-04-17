local function copilotEnabled()
    return vim.env.COPILOT_ENABLED ~= nil
end

return {
    {
        "zbirenbaum/copilot.lua",
        cond = copilotEnabled,
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "zbirenbaum/copilot.lua",
        cond = copilotEnabled,
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
        cond = copilotEnabled,
        config = true,
    },
    {
        "AndreM222/copilot-lualine",
        cond = copilotEnabled,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        cond = copilotEnabled,
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
        },
    },
}
