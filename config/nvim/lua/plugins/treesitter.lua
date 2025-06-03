return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  config = function()
    local nvim_ts = require("nvim-treesitter")
    nvim_ts.setup()

    local ensure_installed = {
      "c",
      "embedded_template",
      "gitcommit",
      "gitignore",
      "html",
      "javascript",
      "lua",
      "pkl",
      "python",
      "query",
      "sql",
      "vim",
      "vimdoc",
    }
    nvim_ts.install(ensure_installed)
    vim.treesitter.language.register("embedded_template", "ejs")

    -- Get available languages
    local available_languages = nvim_ts.get_available()

    -- Map languages to filetypes
    local all_supported_filetypes = vim
      .iter(available_languages)
      :map(function(lang)
        local filetypes = vim.treesitter.language.get_filetypes(lang)
        return filetypes
      end)
      :flatten()
      :totable()

    -- print(table.concat(all_supported_filetypes, ", "))

    vim.api.nvim_create_autocmd("FileType", {
      pattern = all_supported_filetypes,
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  lazy = false,
  build = ":TSUpdate",
}
