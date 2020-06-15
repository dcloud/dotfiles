# zmodload zsh/zprof

# Generate a menu of matches when globbing (rather than auto-inserting all matches)
setopt GLOB_COMPLETE

DOTFILES=$HOME/.dotfiles

# Set name of the theme to load.
ZSH_THEME="dcloud"

export EDITOR='vim'

if [[ -f /etc/paths ]]; then
    # Store default value of PATH
    DEFAULT_PATH=${"$(tr '\n' ':' < /etc/paths)":0:-1}
    if [[ $PATH != $DEFAULT_PATH ]]; then
        export PATH=$DEFAULT_PATH
    fi
fi

export BREW_PREFIX=$(brew --prefix)

if [[ -d $BREW_PREFIX/sbin && ":$PATH:" != *":$BREW_PREFIX/sbin:"* ]]; then
    PATH=$BREW_PREFIX/sbin:$PATH
    export PATH
fi

# MANPATH
if [[ -d $BREW_PREFIX/share/man ]]; then
    MANPATH=$BREW_PREFIX/share/man:$MANPATH
    export MANPATH
fi

# NLTK
export NLTK_DATA=$BREW_PREFIX/share/nltk_data

# Android
export ANDROID_HOME=$BREW_PREFIX/opt/android-sdk

# Uncrustify
export UNCRUSTIFY_CONFIG="$HOME/.uncrustify/uncrustify.cfg"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Adapted from https://github.com/holman/dotfiles/
typeset -U config_files
config_files=($DOTFILES/zsh/**/*.zsh)
# load config files
for file in ${config_files}
do
  source $file
done

# Personal environmental variables
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# Enable starship.rs prompt, if available
if hash starship 2>/dev/null; then
    eval "$(starship init zsh)"
fi

# zprof
