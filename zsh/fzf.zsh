if [[ -f ~/.fzf.zsh  ]]; then
    export FZF_CTRL_R_OPTS="-e"
    source ~/.fzf.zsh;
    alias vif='vim +Files'
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f';
    fi
fi
