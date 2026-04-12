return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {
    { "rafamadriz/friendly-snippets" },
  },
  init = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
