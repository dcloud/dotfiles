# Keybindings
# man zshzle

# vim keybindings
bindkey -v

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^b' backward-char
bindkey '^f' forward-char

bindkey '\eb' backward-word
bindkey '\ef' forward-word

bindkey '\ed' kill-word
bindkey '^k' kill-line

bindkey '^d' delete-char
bindkey '\ew' backward-kill-word
bindkey '^u' backward-kill-line

bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history
