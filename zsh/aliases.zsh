# Aliases
alias reload!='. ~/.zshrc'

alias help='run-help'

alias mkvirtualenv3="mkvirtualenv -p $(which python3)"

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
    alias tree='exa -T'
else
    alias ls='ls -hFG'         # Colors, size units, differentiate files/folders/symlinks
    alias ll='ls -alF'         # long list ls
    alias lr='ls -lR'          # recursive ls
fi

alias mux='tmuxinator'

alias pip="noglob pip"

# Shortcut for finding processes, displaying friendly output
alias p='pgrep -l'

# mdls is a macOS application for listing file metadata attributes
# mdid for easily getting bundle identifiers, useful with `open` cmd
alias mdid='mdls -name kMDItemCFBundleIdentifier'
