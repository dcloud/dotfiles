vim.api.nvim_create_user_command("LintDisable", function(args)
  if args.bang then
    -- LintDisable! will disable formatting just for this buffer
    vim.b.disable_autolint = true
  else
    vim.g.disable_autolint = true
  end
end, {
  desc = "Disable autolint",
  bang = true,
})
vim.api.nvim_create_user_command("LintEnable", function()
  vim.b.disable_autolint = false
  vim.g.disable_autolint = false
end, {
  desc = "Re-enable autolint",
})
