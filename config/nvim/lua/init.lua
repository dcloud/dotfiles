-- Set mapleader
vim.g.mapleader = " "

-- lazy.nvim config
require("config.lazy")

-- indent-blankline config
require("config.ibl")

-- session persistence
require("config.persistence")

-- linters to supplement lsp
require("config.lint")

-- set colorscheme after options
vim.cmd("colorscheme rose-pine")
