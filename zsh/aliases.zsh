# Aliases
alias zshconfig="$LOCAL_EDITOR ~/.zshrc"
alias ohmyzsh="$LOCAL_EDITOR ~/.oh-my-zsh"

alias reload!='. ~/.zshrc'

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

alias www='browser-sync start --server'
alias httpserver=www