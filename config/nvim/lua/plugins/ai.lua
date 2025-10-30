local function ai_adapter()
  local valid_adapters = { "anthropic", "copilot" }
  local adapter_value = vim.env.NEOVIM_AI_ADAPTER
  if vim.tbl_contains(valid_adapters, adapter_value) then
    return adapter_value
  end
  adapter_notice = adapter_value or "unspecified"
  vim.notify("Invalid AI adapter: " .. adapter_notice, vim.log.levels.WARN)
  return nil
end

local function select_copilot_model()
  return vim.env.NEOVIM_COPILOT_MODEL
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
        http = {
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
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
  },
}
