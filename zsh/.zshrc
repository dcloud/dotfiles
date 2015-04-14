# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dcloud"

# Example aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Update homebrew paths
if [[ -d /usr/local/bin ]]; then
  PATH=/usr/local/bin:$PATH
fi
if [[ -d /usr/local/sbin ]]; then
  PATH=/usr/local/sbin:$PATH
fi

# Set up PROJECT_HOME so mkproject works
export PROJECT_HOME=$HOME/code/python


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew brew-cask catimg colorize django docker fabric git heroku node npm pip pod \
 postgres pylint python rbenv sublime vagrant virtualenv virtualenvwrapper wd xcode \
 zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Node binaries
if [[ -d /usr/local/share/npm/bin ]]; then
  PATH=/usr/local/share/npm/bin:$PATH
fi

# haskell
if [[ -d $HOME/.cabal/bin ]]; then
  PATH=$HOME/.cabal/bin:$PATH
fi

# MacTex BasicTex http://www.tug.org/mactex/morepackages.html
if [[ -d /usr/local/texlive/2014basic/bin/x86_64-darwin ]]; then
  PATH=/usr/local/texlive/2014basic/bin/x86_64-darwin:$PATH
fi

# User configuration
if [[ -d $HOME/bin ]]; then
  PATH=$HOME/bin:$PATH
fi

export PATH

# MANPATH

if [[ -d /Library/TeX/Distributions/.DefaultTeX/Contents/Man ]]; then
    MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH
fi

if [[ -d /usr/local/man ]]; then
    MANPATH=/usr/local/man:$MANPATH
fi

export MANPATH

if [[ -d /usr/local/share/npm/lib/node_modules ]]; then
    NODE_PATH=/usr/local/share/npm/lib/node_modules:$NODE_PATH
fi
export NODE_PATH

if [[ -f $HOME/.sunlight.key ]]; then
  export SUNLIGHT_KEY=$(cat $HOME/.sunlight.key)
fi

#Java
JAVA_HOME=`/usr/libexec/java_home -v 1.7`

# NLTK
export NLTK_DATA=/usr/local/share/nltk_data

# rbenv
export RBENV_ROOT=/usr/local/opt/rbenv

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Homebrew
# export HOMEBREW_GITHUB_API_TOKEN=

# Uncrustify
export UNCRUSTIFY_CONFIG="$HOME/.uncrustify/uncrustify.cfg"


# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

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
alias -s txt=subl
alias -s md=subl
alias -s html=subl
alias -s js=subl
alias -s jpeg='open -a Preview'
alias -s jpg=jpeg
alias -s png='open -a Preview'


# For teaching bash, don't load customizations
alias plainbash='bash --noprofile --rcfile /etc/bashrc'

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
