# This loads completions for akamai cli, if installed

if hash akamai 2>/dev/null; then
    eval "$(akamai --zsh)"
fi
