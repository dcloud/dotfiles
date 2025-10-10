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

-- CodeCompanion
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- Conform
vim.keymap.set({ "n", "v" }, "<leader>ff", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })

-- Trouble
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
  "n",
  "<leader>xl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- which-key
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
