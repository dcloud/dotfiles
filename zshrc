# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DOTFILES=$HOME/.dotfiles

# Set name of the theme to load.
ZSH_THEME="dcloud"

export EDITOR='vim'
export LOCAL_EDITOR='atom'
ATOMN="$LOCAL_EDITOR -n"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(catimg colorize django docker pip \
 python thefuck tmuxinator vagrant wd xcode)

source $ZSH/oh-my-zsh.sh

export BREW_PREFIX=$(brew --prefix)

# MANPATH

if [[ -d $BREW_PREFIX/share/man ]]; then
    MANPATH=$BREW_PREFIX/share/man:$MANPATH
fi

export MANPATH

#Java
# JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# NLTK
export NLTK_DATA=$BREW_PREFIX/share/nltk_data

# rbenv
export RBENV_ROOT=$BREW_PREFIX/opt/rbenv

# Android
export ANDROID_HOME=$BREW_PREFIX/opt/android-sdk

# Uncrustify
export UNCRUSTIFY_CONFIG="$HOME/.uncrustify/uncrustify.cfg"

#  rbenv
eval "$(rbenv init --no-rehash - zsh)"

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
