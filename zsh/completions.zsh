# Completions

# Lunchy
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
    . $LUNCHY_DIR/lunchy-completion.zsh
fi

#  npm completion
if [ -f $BREW_PREFIX/etc/bash_completion.d/npm ]; then
    . $BREW_PREFIX/etc/bash_completion.d/npm
fi
