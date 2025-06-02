-- treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- treesitter-embedded-template
vim.treesitter.language.register("embedded_template", "ejs")
