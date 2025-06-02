return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup()

    local ensure_installed = { "c", "embedded_template", "html", "javascript", "lua", "pkl", "vim", "vimdoc", "query" }
    treesitter.install(ensure_installed)
  end,
  lazy = false,
  build = ":TSUpdate",
}
