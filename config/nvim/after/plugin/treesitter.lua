--- treesitter config
require'nvim-treesitter.configs'.setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { 'lua' }
    },
    indent = {
        enable = true,
        disable = { 'lua', }
    }
})


-- treesitter folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
