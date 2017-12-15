if [[ -f ~/.fzf.zsh  ]]; then
    source ~/.fzf.zsh;
    alias vif='vim $(fzf)'
fi
