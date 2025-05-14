-- Set mapleader
vim.g.mapleader = " "

-- Turn on loading trusted .nvim.lua, .nvimrc, and .exrc files
vim.go.exrc = true

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
    signs = true,
})

-- https://mise.jdx.dev/ide-integration.html
if vim.fn.executable("mise") == 1 then
    -- Prepend mise shims to PATH
    vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
end

-- lazy.nvim config
require("config.lazy")

-- gitsigns
require("config.gitsigns")

-- indent-blankline config
require("config.ibl")

-- session persistence
require("config.persistence")
