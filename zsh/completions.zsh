# Completions

local BREW_PREFIX=$(brew --prefix);

local zsh_completions="$(brew --prefix)/share/zsh-completions";
#  Extra zsh completions
if [ -d $zsh_completions ]; then
    fpath=($zsh_completions $fpath)
fi

# Local completions (e.g. _kagi)
local zsh_local_completions="${0:h}/completions"
if [ -d $zsh_local_completions ]; then
    fpath=($zsh_local_completions $fpath)
fi
