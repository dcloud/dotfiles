# Aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias dotfiles="$EDITOR ~/.dotfiles"

alias -g ...='../..'
alias -- -='cd -'
alias 1='cd  -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias reload!='. ~/.zshrc'

alias help='run-help'

alias mkvirtualenv3="mkvirtualenv -p $(which python3)"

alias use_xcode="sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

if hash tmux 2> /dev/null; then
    alias tma='tmux attach -t'
    alias tmad='tmux attach -d -t'
    alias tms='tmux new-session -s'
    alias tml='tmux list-sessions'
    alias tmksv='tmux kill-server'
    alias tmkss='tmux kill-session -t'
fi

# Make sure we have vanilla grep
alias grep='\grep'
# grepc can be fun grep
alias grepc='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias pd='basename $(pwd)'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

if hash exa 2> /dev/null; then
    alias ls='exa'
    alias ll='exa -la'
    alias lr='exa -lR'
else
    alias ls='ls -hFG'         # Colors, size units, differentiate files/folders/symlinks
    alias ll='ls -alF'         # long list ls
    alias lr='ls -lR'          # recursive ls
fi

alias tree='tree -Csu'     # nice alternative to 'recursive ls'

# Suffix aliases
alias -s txt=$EDITOR
alias -s md=$EDITOR
alias -s html=$EDITOR
alias -s jpeg='open -a Preview'
alias -s jpg=jpeg
alias -s png='open -a Preview'

alias mux='tmuxinator'

# For teaching bash, don't load customizations
alias teachbash='bash --noprofile --rcfile /etc/bashrc'

alias pip="noglob pip"


# Shortcut for finding processes, displaying friendly output
alias p='pgrep -l'
