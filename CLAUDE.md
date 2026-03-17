# Dotfiles

## Working approach
- Make changes **incrementally** — one function or one logical change at a time
- Discuss proposed changes and get agreement before editing files
- Small diffs are easier to review; avoid batching unrelated changes

## Git workflow
- Always use the `commit-commands:commit` skill for all git commits

## Zsh conventions
- Prefer `[[ ]]` over `[ ]` for conditionals
- Use arrays instead of strings when building commands — avoids `eval`
- Use `print` instead of `echo -e` for escape sequences
- Use `local` to scope variables inside functions

## Testing Zsh changes
- Run `reload!` to pick up changes in the current session
- For completion changes, rebuild the cache first: `rm -f ~/.zcompdump && exec zsh`
