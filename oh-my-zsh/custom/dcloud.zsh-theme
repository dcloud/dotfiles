local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function virtualenv_name(){
  if [[ -n $VIRTUAL_ENV ]]; then
    printf "[%s] " ${${VIRTUAL_ENV}:t}
  fi
}

PROMPT='%{$fg[green]%}%1~ \
$(git_prompt_info)\
🐵 %{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[red]%}$(virtualenv_name)%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%} ${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"

