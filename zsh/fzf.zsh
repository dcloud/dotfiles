if [[ -f ~/.fzf.zsh  ]]; then
    source ~/.fzf.zsh;
    alias vif='vim $(fzf)'
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f';
    fi
fi
