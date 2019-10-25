# rbenv

if hash rbenv 2>/dev/null; then
    export RBENV_ROOT=$BREW_PREFIX/opt/rbenv
    eval "$(rbenv init --no-rehash - zsh)"
fi

