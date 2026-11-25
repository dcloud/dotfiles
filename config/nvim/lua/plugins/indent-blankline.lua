-- ibl - indentation guides
-- :help ibl
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local hooks = require("ibl.hooks")

      -- runs on every colorscheme change; only override colors for rose-pine
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        if not (vim.g.colors_name or ""):match("^rose%-pine") then
          return
        end
        local ok, palette = pcall(require, "rose-pine.palette")
        if not ok then
          return
        end
        vim.api.nvim_set_hl(0, "IblIndent", { fg = palette.highlight_low })
        vim.api.nvim_set_hl(0, "IblScope", { fg = palette.highlight_high })
      end)

      require("ibl").setup({})
    end,
  },
}
