-- Keymaps

-- set <leader>
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

-- https://github.com/mhinz/vim-galore#quickly-add-empty-lines
vim.keymap.set(
    "n",
    "[<space>",
    "<Cmd>put! =repeat(nr2char(10), v:count1)<cr>'['",
    { noremap = true, desc = "Insert spaces before the current line" }
)
vim.keymap.set(
    "n",
    "]<space>",
    "<Cmd>put =repeat(nr2char(10), v:count1)<cr>']'",
    { noremap = true, desc = "Insert spaces after the current line" }
)

-- Keymappings for :term
vim.keymap.set("t", "<C-h>", "<C-W>h")
vim.keymap.set("t", "<C-j>", "<C-W>j")
vim.keymap.set("t", "<C-k>", "<C-W>k")
vim.keymap.set("t", "<C-l>", "<C-W>l")
vim.keymap.set("t", "<leader><Esc>", "<C-w>N")

-- Mappings for increment and decrement
vim.keymap.set("n", "<leader>i", "<C-A>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>d", "<C-X>", { desc = "Decrement number" })

-- Copy file _path_
vim.keymap.set("n", "<leader>pr", '<Cmd>let @*=expand("%")<CR>', { desc = "Copy relative file path" })
vim.keymap.set("n", "<leader>pa", '<Cmd>let @*=expand("%:p")<CR>', { desc = "Copy absolute file path " })
vim.keymap.set("n", "<leader>pt", '<Cmd>let @*=expand("%:t")<CR>', { desc = "Copy file name" })
vim.keymap.set("n", "<leader>pd", '<Cmd>let @*=expand("%:p:h")<CR>', { desc = "Copy file directory path" })

-- Mapping for adding semicolon to end of line
vim.keymap.set("n", "<leader>;", "ms:norm A;<CR>`s", { desc = "Add a semicolon at the end of the line" })

-- Shortcuts for de-educating quotation marks
-- char 2018: ‘
-- char 2019: ’
-- char 201A: ‚
-- char 201B: ‛
-- char 201C: “
-- char 201D: ”
-- char 201E: „
-- char 201F: ‟
vim.keymap.set("n", "<leader>'", "<Cmd>.s/\\(\\%u2018\\|\\%u2019\\)/'/g<CR>", { desc = "De-educate quotation marks" })
vim.keymap.set("n", '<leader>"', '<Cmd>.s/\\(\\%u201C\\|\\%u201D\\)/"/g<CR>', { desc = "De-educate quotation marks" })
