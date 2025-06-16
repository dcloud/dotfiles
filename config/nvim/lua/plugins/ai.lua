local function ai_adapter()
  local valid_adapters = { "anthropic", "copilot" }
  local adapter_value = vim.env.NEOVIM_AI_ADAPTER
  if vim.tbl_contains(valid_adapters, adapter_value) then
    return adapter_value
  end
  vim.notify("Invalid AI adapter: " .. adapter_value, vim.log.levels.WARN)
  return nil
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
  local default_copilot_model = COPILOT_MODEL_CHOICES[1]
  local copilot_model_selection = vim.env.NEOVIM_COPILOT_MODEL

  if copilot_model_selection == nil or copilot_model_selection == "" then
    return default_copilot_model
  elseif vim.tbl_contains(COPILOT_MODEL_CHOICES, copilot_model_selection) then
    return copilot_model_selection
  end
  vim.notify(
    "Invalid Copilot model: " .. copilot_model_selection .. "... using " .. default_copilot_model,
    vim.log.levels.WARN
  )
  return default_copilot_model
end

local function ai_enabled()
  return ai_adapter() ~= nil
end

return {
  "olimorris/codecompanion.nvim",
  version = "17.x.x",
  cond = ai_enabled,
  opts = function()
    local adapter = ai_adapter()
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
      extensions = {
        history = {
          enabled = true,
        },
      },
    }
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "ravitemer/codecompanion-history.nvim",
  },
}
