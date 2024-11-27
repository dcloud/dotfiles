--- treesitter config
require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "embedded_template", "html", "javascript", "lua", "pkl", "vim", "vimdoc", "query" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "lua" },
    },
    indent = {
        enable = true,
        disable = { "lua" },
    },
})

-- treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- treesitter-embedded-template
vim.treesitter.language.register("embedded_template", "ejs")
