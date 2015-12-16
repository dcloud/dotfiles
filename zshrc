# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DOTFILES=$HOME/.dotfiles

# Set name of the theme to load.
ZSH_THEME="dcloud"

export EDITOR='vim'
export LOCAL_EDITOR='atom'
ATOMN="$LOCAL_EDITOR -n"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(brew brew-cask catimg colorize django docker fabric git heroku node pip pod \
 postgres pylint python sublime vagrant virtualenv wd xcode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export BREW_PREFIX=$(brew --prefix)

# MANPATH

if [[ -d /Library/TeX/Distributions/.DefaultTeX/Contents/Man ]]; then
    MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH
fi

if [[ -d $BREW_PREFIX/man ]]; then
    MANPATH=$BREW_PREFIX/man:$MANPATH
fi

export MANPATH

# Node path
if [[ -d $BREW_PREFIX/share/npm/lib/node_modules ]]; then
    NODE_PATH=$BREW_PREFIX/share/npm/lib/node_modules:$NODE_PATH
fi
export NODE_PATH


if [[ -f $HOME/.sunlight.key ]]; then
  export SUNLIGHT_KEY=$(cat $HOME/.sunlight.key)
fi

#Java
# JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# NLTK
export NLTK_DATA=$BREW_PREFIX/share/nltk_data

# rbenv
export RBENV_ROOT=$BREW_PREFIX/opt/rbenv

# Android
export ANDROID_HOME=$BREW_PREFIX/opt/android-sdk

# Homebrew
# export HOMEBREW_GITHUB_API_TOKEN=

# Uncrustify
export UNCRUSTIFY_CONFIG="$HOME/.uncrustify/uncrustify.cfg"

#  rbenv
eval "$(rbenv init -)"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Adapted from https://github.com/holman/dotfiles/
typeset -U config_files
config_files=($DOTFILES/zsh/**/*.zsh)
# load config files
for file in ${config_files:#*/path.zsh}
do
  source $file
done
