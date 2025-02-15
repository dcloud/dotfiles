# Improve usefulness of run-help. See `man zshcontrib`
unalias run-help 2>/dev/null
autoload -Uz run-help

local version="${$(zsh --version)[(w)2]}";
HELPDIR="/usr/share/zsh/$version/help"
