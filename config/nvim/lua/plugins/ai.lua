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

local COPILOT_MODEL_CHOICES = {
    "gpt-4o",
    "gemini-2.0-flash--001",
    "claude-3.5-sonnet",
    "claude-3.7-sonnet",
    "claude-3.7-sonnet-thought",
    "o3-mini",
}

local function select_copilot_model()
    local copilot_model_selection = vim.env.NEOVIM_COPILOT_MODEL
    if not contains(COPILOT_MODEL_CHOICES, copilot_model_selection) then
        copilot_model_selection = "gpt-4o"
    end
    return copilot_model_selection
end

local function aiEnabled()
    return aiAdapter() ~= nil
end

return {
    "olimorris/codecompanion.nvim",
    version = "*",
    cond = aiEnabled,
    opts = function()
        local adapter = aiAdapter()
        return {
            adapters = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = { api_key = "ANTHROPIC_API_KEY" },
                    })
                end,
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = select_copilot_model(),
                            },
                        },
                    })
                end,
            },
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
