# Aliases
alias reload!='exec zsh'

alias help='run-help'

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

if (( $+commands[eza] )); then
    alias ls='eza'
    alias ll='eza -la'
    alias lr='eza -lR'
    alias tree='eza -T'
    alias l='eza -1'
else
    alias ls='ls -hFG'         # Colors, size units, differentiate files/folders/symlinks
    alias ll='ls -alF'         # long list ls
    alias lr='ls -lR'          # recursive ls
    alias l='ls -1'
fi

# Shortcut for finding processes, displaying friendly output
alias p='pgrep -l'


