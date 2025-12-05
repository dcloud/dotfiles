# zmodload zsh/zprof
#

# Brew zsh completions
typeset -U fpath
if whence brew &>/dev/null
then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

# Load completions functions
# man zshbuiltins (for autoload); man zshcompsys (for completion system)
autoload -U compinit
autoload -U bashcompinit

# Generate a menu of matches when globbing (rather than auto-inserting all matches)
setopt GLOB_COMPLETE
setopt PROMPT_SUBST
setopt NO_NOMATCH

DOTFILES=$HOME/.dotfiles

# Set name of the theme to load.
ZSH_THEME="dcloud"

EDITOR='vim'
MANPAGER='less'
if whence nvim &>/dev/null
then
    EDITOR='nvim'
    MANPAGER='nvim +Man!'
fi
export EDITOR
export MANPAGER

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
    set -o allexport; source ~/.localrc; set +o allexport
fi

autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:virtualenv color 220
prompt pure

# (re)build & initialize completions, only once every 24 hours
# Do this late since plugins, e.g. wd.zsh, may edit fpath
# man zshcompsys
() {
  setopt extendedglob local_options

  if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
    bashcompinit
  else
    compinit -C
    bashcompinit -C
  fi
}

# zprof
