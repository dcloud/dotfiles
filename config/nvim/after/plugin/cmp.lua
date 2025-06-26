-- Set up nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Tab completion for copilot, per zbirenbaum/copilot-cmp
local has_words_before = function()
  if vim.api.nvim_get_option_value("buftype", {}) == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

-- Tab completion for copilot, per zbirenbaum/copilot-cmp
cmp.setup({
  sources = cmp.config.sources({
    { name = "copilot", group_index = 1 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "buffer", group_index = 1 },
    { name = "luasnip" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(original)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        original()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(original)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.jump(-1)
      else
        original()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})

-- Use buffer source for `/` and `?`.
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
  }),
})

-- Set up lspconfig. See lsp.lua
