-- Set up nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "cmdline" },
    }),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(original)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                original()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(original)
            if cmp.visible() then
                cmp.select_previous_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.jump(-1)
            else
                original()
            end
        end, { "i", "s" }),
    }),
    snippets = {
        expand = function(args)
            luasnip.lsp_expand(args)
        end,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = "buffer" },
    }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
    }),
})

-- Set up lspconfig. See lsp.lua
