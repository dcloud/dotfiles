# This loads completions for akamai cli, if installed

if (( $+commands[akamai] )); then
    eval "$(akamai --zsh)"
fi
