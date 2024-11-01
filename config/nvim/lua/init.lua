-- Set mapleader
vim.g.mapleader = " "

-- lazy.nvim config
require("config.lazy")

-- indent-blankline config
require("config.ibl")

-- set colorscheme after options
vim.cmd('colorscheme rose-pine')
