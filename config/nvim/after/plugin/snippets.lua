local ls = require("luasnip")

-- VSCode-style snippets, e.g. friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

ls.filetype_extend("python", { "django" })

-- Snipmate-style snippets
require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
