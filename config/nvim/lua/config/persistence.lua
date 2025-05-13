-- load the session for the current directory
vim.keymap.set("n", "<leader>ss", function()
    require("persistence").load()
end, { desc = "Load session for the curent directory" })

-- select a session to load
vim.keymap.set("n", "<leader>sS", function()
    require("persistence").select()
end, { desc = "Select a session to load" })

-- load the last session
vim.keymap.set("n", "<leader>sl", function()
    require("persistence").load({ last = true })
end, { desc = "Load the last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>sd", function()
    require("persistence").stop()
end, { desc = "Stop persistence (session won't be saved)" })
