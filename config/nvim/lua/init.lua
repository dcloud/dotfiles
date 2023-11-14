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

require("lazy").setup({
        {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
        "sheerun/vim-polyglot",
        "neovim/nvim-lspconfig",
        "ray-x/go.nvim",
        "nvim-lualine/lualine.nvim",
        {
            "romgrk/barbar.nvim",
            init = function() vim.g.barbar_auto_setup = false end,
            opts = { icons = { button = '⨯', filetype = { enabled = false}}}
        },
        "dense-analysis/ale",
        "tpope/vim-commentary",
        "tpope/vim-dadbod",
        "tpope/vim-fugitive",
        "tpope/vim-surround",
        "lewis6991/gitsigns.nvim",
        "junegunn/fzf",
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        "junegunn/fzf.vim",
        { "windwp/nvim-autopairs", event = "InsertEnter", opts={} },
        { 'rose-pine/neovim', name = 'rose-pine' },
    })

--- treesitter config
require'nvim-treesitter.configs'.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { 'lua', 'vim' }
    },
    indent = {
        enable = true,
        disable = { 'lua', }
    }
})

-- lspconfig
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}


-- dense-analysis/ale: Linter/Fixer
vim.g.ale_fixers['*'] = { 'remove_trailing_lines', 'trim_whitespace' }

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- autpairs
local npairs = require("nvim-autopairs")
npairs.setup({
    check_ts = true,
})

-- gitsigns
require('gitsigns').setup()

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
require('lualine').setup({ options = { theme = theme, icons_enabled = false }})

-- configure colorscheme
require('rose-pine').setup({
    dim_nc_background = true,
})
-- set colorscheme after options
vim.cmd('colorscheme rose-pine')
