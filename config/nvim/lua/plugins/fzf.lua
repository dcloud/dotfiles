return {
    {
        "ibhagwan/fzf-lua",
        config = function()
            -- calling `setup` is optional for customization
            -- no_esc option for grep?
            local fzf = require("fzf-lua")
            fzf.setup({ "default" })
            fzf.setup_fzfvim_cmds()
        end,
    },
}
