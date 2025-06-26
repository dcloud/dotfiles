return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function(opts)
      ls = require("luasnip")
      ls.setup(opts)
      ls.filetype_extend("all", { "_" })
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
}
