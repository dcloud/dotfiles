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

### Testing for command presence
- Use `(( $+commands[cmd] ))` to test if an external executable exists in PATH
  - `$commands` is an associative array mapping command names to their paths
  - Documented in `zshmodules(1)` under the `zsh/parameter` module
  - Fast (hash table lookup), no subprocess, no output to suppress
- Use `whence cmd &>/dev/null` when you need to detect aliases, functions, or builtins — not just PATH executables

## Testing Zsh changes
- Run `reload!` to pick up changes in the current session
- For completion changes, rebuild the cache first: `rm -f ~/.zcompdump && exec zsh`
