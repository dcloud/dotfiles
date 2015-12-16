# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dcloud"

EDITOR='vim'
LOCAL_EDITOR='atom'
ATOMN="$LOCAL_EDITOR -n"
# Example aliases
alias zshconfig="$LOCAL_EDITOR ~/.zshrc"
alias ohmyzsh="$LOCAL_EDITOR ~/.oh-my-zsh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew brew-cask catimg colorize django docker fabric git heroku node pip pod \
 postgres pylint python sublime vagrant virtualenv wd xcode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

BREW_PREFIX=$(brew --prefix)

# Update homebrew paths
if [[ -d $BREW_PREFIX/bin ]]; then
  PATH=$BREW_PREFIX/bin:$PATH
fi
if [[ -d $BREW_PREFIX/sbin ]]; then
  PATH=$BREW_PREFIX/sbin:$PATH
fi

# Node binaries
if [[ -d $BREW_PREFIX/share/npm/bin ]]; then
  PATH=$BREW_PREFIX/share/npm/bin:$PATH
fi

# haskell
if [[ -d $HOME/.cabal/bin ]]; then
  PATH=$HOME/.cabal/bin:$PATH
fi

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
if [[ -d $BREW_PREFIX/texlive/2014basic/bin/x86_64-darwin ]]; then
  PATH=$BREW_PREFIX/texlive/2014basic/bin/x86_64-darwin:$PATH
fi

# Go
# You may wish to add the GOROOT-based install location to your PATH:
# if [[ -d $BREW_PREFIX/opt/go/libexec/bin ]]; then
#   PATH=$PATH:$BREW_PREFIX/opt/go/libexec/bin
# fi
export GOPATH=$HOME/.go
if [[ -d $GOPATH/bin ]]; then
  PATH=$GOPATH/bin:$PATH
fi

# User configuration
if [[ -d $HOME/.local/bin ]]; then
  PATH=$HOME/.local/bin:$PATH
fi

export PATH

# MANPATH

if [[ -d /Library/TeX/Distributions/.DefaultTeX/Contents/Man ]]; then
    MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH
fi

if [[ -d $BREW_PREFIX/man ]]; then
    MANPATH=$BREW_PREFIX/man:$MANPATH
fi

export MANPATH

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


# Set up PROJECT_HOME so mkproject works
export PROJECT_HOME=$HOME/code/python
# Set WORKON_HOME so virtualenvs have a home
export WORKON_HOME=$HOME/.virtualenvs

# Virtualenvwrapper, lazily
if [[ -f $BREW_PREFIX/bin/virtualenvwrapper.sh ]]; then
    export VIRTUALENVWRAPPER_SCRIPT=$BREW_PREFIX/bin/virtualenvwrapper.sh
    source $BREW_PREFIX/bin/virtualenvwrapper_lazy.sh
fi

#  rbenv
eval "$(rbenv init -)"

# Lunchy
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
    . $LUNCHY_DIR/lunchy-completion.zsh
fi

#  npm completion
if [ -f $BREW_PREFIX/etc/bash_completion.d/npm ]; then
    . $BREW_PREFIX/etc/bash_completion.d/npm
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"


# Aliases

alias mkvirtualenv3="mkvirtualenv -p $(which python3)"

alias use_xcode="sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# Make grep more user friendly by highlighting matches
# and exclude grepping through .svn folders.
alias grep='grep --color=always --exclude=\.svn'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

alias ls='ls -hFG'         # Colors, size units, differentiate files/folders/symlinks
alias ll='ls -alF'         # long list ls
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

# Suffix aliases
alias -s txt=$LOCAL_EDITOR
alias -s md=$LOCAL_EDITOR
alias -s html=$LOCAL_EDITOR
alias -s js=$LOCAL_EDITOR
alias -s jpeg='open -a Preview'
alias -s jpg=jpeg
alias -s png='open -a Preview'


# For teaching bash, don't load customizations
alias teachbash='bash --noprofile --rcfile /etc/bashrc'

# Turn this info a function
# alias unspacify='for a in ./**/*\ *(Dod); do mv $a ${a:h}/${a:t:gs/ /_}; done'

# function www() {
#   port=${1}
#   python -m http.server $port
# }

alias www='livereload'
alias httpserver=www

function httpless {
    # `httpless example.org'
    http --pretty=all "$@" | less -R;
}

function pynit {
    if [ "x$1" = "x" ]; then
        DIR="./"
    else
        DIR="$1"
    fi
    touch ${DIR}/__init__.py
}
