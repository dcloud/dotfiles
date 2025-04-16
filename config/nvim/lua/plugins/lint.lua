return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        linters_by_ft = { ruby = { "rubocop" } },
    },
    config = function()
        local lint = require("lint")
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint(nil, { ignore_errors = true })
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint(nil, { ignore_errors = true })
        end, { desc = "Trigger linting for current file" })
    end,
}
