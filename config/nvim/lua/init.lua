-- Set mapleader
vim.g.mapleader = " "

-- Turn on loading trusted .nvim.lua, .nvimrc, and .exrc files
vim.go.exrc = true

-- lazy.nvim config
require("config.lazy")

-- gitsigns
require("config.gitsigns")

-- indent-blankline config
require("config.ibl")

-- session persistence
require("config.persistence")

-- set colorscheme after options
vim.cmd("colorscheme rose-pine")
