# Completions

local BREW_PREFIX=$(brew --prefix);

local zsh_completions="$(brew --prefix)/share/zsh-completions";
#  Extra zsh completions
if [ -d $zsh_completions ]; then
    fpath=($zsh_completions $fpath)
fi
