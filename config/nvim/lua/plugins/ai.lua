local function contains(list, item)
    for _, value in ipairs(list) do
        if value == item then
            return true
        end
    end
    return false
end

local function aiAdapter()
    local adapters = { "anthropic", "copilot" }
    local adapter_value = vim.env.NEOVIM_AI_ADAPTER
    if not contains(adapters, adapter_value) then
        adapter_value = nil
    end
    return adapter_value
end

local function aiEnabled()
    return aiAdapter() ~= nil
end

return {
    "olimorris/codecompanion.nvim",
    cond = aiEnabled,
    opts = function()
        local adapter = aiAdapter()
        local adapterconf = {}
        if adapter == "anthropic" then
            adapterconf = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = { api_key = "ANTHROPIC_API_KEY" },
                    })
                end,
            }
        end
        return {
            adapters = adapterconf,
            strategies = {
                chat = {
                    adapter = adapter,
                },
                inline = {
                    adapter = adapter,
                },
                cmd = {
                    adapter = adapter,
                },
            },
        }
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
    },
}
