-- :[range]Uncurl [single|double|both]
-- Straighten "smart" (curly) quotation marks -- e.g. text pasted from rich-text
-- sources -- into straight ASCII quotes. With no range the whole buffer is
-- converted; from a Visual selection only the selected lines are touched.

local groups = {
  single = { { "‘", "'" }, { "’", "'" } },
  double = { { "“", '"' }, { "”", '"' } },
}

local function uncurl(opts)
  local kind = opts.args ~= "" and opts.args or "both"
  local subs = {}
  if kind == "single" or kind == "both" then
    vim.list_extend(subs, groups.single)
  end
  if kind == "double" or kind == "both" then
    vim.list_extend(subs, groups.double)
  end
  if #subs == 0 then
    vim.notify("Uncurl: expected 'single', 'double', or 'both'", vim.log.levels.ERROR)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local total = 0
  for i, line in ipairs(lines) do
    for _, pair in ipairs(subs) do
      local replaced, n = line:gsub(pair[1], pair[2])
      line = replaced
      total = total + n
    end
    lines[i] = line
  end

  if total > 0 then
    vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, lines)
  end
  vim.notify(("Uncurl: straightened %d quote%s"):format(total, total == 1 and "" or "s"))
end

vim.api.nvim_create_user_command("Uncurl", uncurl, {
  nargs = "?",
  range = "%",
  complete = function(arglead)
    return vim.tbl_filter(function(opt)
      return opt:sub(1, #arglead) == arglead
    end, { "single", "double", "both" })
  end,
  desc = "Straighten smart quotes into ASCII quotes",
})

local map = vim.keymap.set
map("n", "<leader>'", "<Cmd>Uncurl single<CR>", { silent = true, desc = "Straighten single quotes (buffer)" })
map("n", '<leader>"', "<Cmd>Uncurl double<CR>", { silent = true, desc = "Straighten double quotes (buffer)" })
map("n", "<leader>q", "<Cmd>Uncurl both<CR>", { silent = true, desc = "Straighten all smart quotes (buffer)" })
map("x", "<leader>'", ":Uncurl single<CR>", { silent = true, desc = "Straighten single quotes (selection)" })
map("x", '<leader>"', ":Uncurl double<CR>", { silent = true, desc = "Straighten double quotes (selection)" })
map("x", "<leader>q", ":Uncurl both<CR>", { silent = true, desc = "Straighten all smart quotes (selection)" })
