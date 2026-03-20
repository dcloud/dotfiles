return {
  "olimorris/codecompanion.nvim",
  version = "19.x.x",
  opts = function()
    local adapter = "claude_code"
    return {
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://private/claude-cloudmba/credential --no-newline",
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = adapter,
        },
      },
    }
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        heading = { icons = { " ", " ", " " } },
      },
      ft = { "markdown", "codecompanion" },
    },
  },
}
