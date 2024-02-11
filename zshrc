# zmodload zsh/zprof
#

# Brew zsh completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Load completions functions
# man zshbuiltins (for autoload); man zshcompsys (for completion system)
autoload -U compinit
autoload -U bashcompinit

# Generate a menu of matches when globbing (rather than auto-inserting all matches)
setopt GLOB_COMPLETE
setopt PROMPT_SUBST
setopt NO_NOMATCH

# Improve usefulness of run-help. See `man zshcontrib`
if hash run-help 2>/dev/null; then
    unalias run-help
fi
autoload run-help

DOTFILES=$HOME/.dotfiles

# Set name of the theme to load.
ZSH_THEME="dcloud"

export EDITOR='vim'

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
