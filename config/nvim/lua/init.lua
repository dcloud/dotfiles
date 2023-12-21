-- Set mapleader
vim.g.mapleader = " "

-- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- dense-analysis/ale: Linter/Fixer
vim.g.ale_fixers['*'] = { 'remove_trailing_lines', 'trim_whitespace' }

-- autpairs
local npairs = require("nvim-autopairs")
npairs.setup({
    check_ts = true,
})

-- gitsigns
require('gitsigns').setup()

-- THEME customizations below
-- ibl
local highlight = {
    "RosePineHighlightLow",
}

local hooks = require "ibl.hooks"
-- import colorscheme palette
local palette = require('rose-pine.palette')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RosePineHighlightLow", { fg = palette.highlight_low })
end)

require("ibl").setup { indent = { highlight = highlight } }

-- lualine
-- disable icons as we aren't using a powerline font
local theme = require("lualine.themes.rose-pine")
theme.normal.c.bg = palette.overlay
theme.inactive.c.bg = palette.surface
require('lualine').setup({ options = { show_filename_only = false, theme = theme, icons_enabled = false }})

-- configure colorscheme
require('rose-pine').setup({
    dim_nc_background = true,
})
-- set colorscheme after options
vim.cmd('colorscheme rose-pine')
