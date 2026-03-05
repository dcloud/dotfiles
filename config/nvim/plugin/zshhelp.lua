-- :ZshHelp - Display zsh help files from $HELPDIR
-- Similar to :Man but for zsh builtin help files

vim.api.nvim_create_user_command("ZshHelp", function(opts)
  local word = opts.args ~= "" and opts.args or vim.fn.expand("<cword>")
  local helpdir = vim.env.HELPDIR
  if not helpdir or helpdir == "" then
    vim.notify("$HELPDIR is not set", vim.log.levels.ERROR)
    return
  end

  local path = helpdir .. "/" .. word
  if vim.fn.filereadable(path) == 0 then
    vim.notify("No zsh help for: " .. word, vim.log.levels.WARN)
    return
  end

  local bufnr = vim.fn.bufnr(path)
  if bufnr ~= -1 then
    local wins = vim.fn.win_findbuf(bufnr)
    if #wins > 0 then
      vim.fn.win_gotoid(wins[1])
      return
    end
    vim.cmd("split +b" .. bufnr)
  else
    vim.cmd("split " .. vim.fn.fnameescape(path))
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.modifiable = false
    vim.bo.filetype = "zshhelp"
  end
end, {
  nargs = "?",
  complete = function(arglead)
    local helpdir = vim.env.HELPDIR
    if not helpdir or helpdir == "" then return {} end
    local files = vim.fn.globpath(helpdir, arglead .. "*", false, true)
    return vim.tbl_map(function(f) return vim.fn.fnamemodify(f, ":t") end, files)
  end,
  desc = "Open zsh help file for a builtin",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zshhelp",
  callback = function(ev)
    vim.keymap.set("n", "K", function()
      local word = vim.fn.expand("<cword>")
      local helpdir = vim.env.HELPDIR or ""
      if helpdir ~= "" and vim.fn.filereadable(helpdir .. "/" .. word) == 1 then
        vim.cmd("ZshHelp " .. word)
      else
        -- Strip trailing (N) from man page refs like zshmisc(1)
        local manpage = word:match("^([%a%d_-]+)%(%d+%)$") or word
        vim.cmd("Man " .. manpage)
      end
    end, { buffer = ev.buf, desc = "ZshHelp or Man for word under cursor" })
  end,
})
