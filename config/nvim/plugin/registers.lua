-- The a-z "named" registers are filled by the user and retain values across restarts

function clearRegisters(opts)
    registers = "abcdefghijklmnopqrstuvwxyz"
    for i = 1, #registers do
        r = string.sub(registers, i, i)
        vim.fn.setreg(r, "")
    end
end
vim.api.nvim_create_user_command("ClearRegisters", clearRegisters, { nargs = 0 })
vim.keymap.set("n", "<leader>X", clearRegisters, { desc = "Clear named registers" })
