if (( $+commands[fzf] )); then
    export FZF_CTRL_R_OPTS='--no-sort --exact';
    export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
    if (( $+commands[fd] )); then
        export FZF_DEFAULT_COMMAND='fd --type f';
    fi
    source <(fzf --zsh);
fi
