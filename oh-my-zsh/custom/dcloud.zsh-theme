local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function virtualenv_name(){
  if [[ -n $VIRTUAL_ENV ]]; then
    printf "[%s] " ${${VIRTUAL_ENV}:t}
  fi
}

function machine_name(){
  local machine_name="%m";
  if hash scutil 2>/dev/null; then
    machine_name=$(scutil --get HostName);
  elif hash hostname 2>/dev/null; then
    machine_name="${$(hostname -f)/-<0->/}";
  fi
  printf "$machine_name";
}

local cached_machine_name=$(machine_name)

theme_precmd() {
    local mname="%{$fg[magenta]%}$cached_machine_name%{$reset_color%}";
    local pathname="%{$fg[green]%}%1~%{$reset_color%}";
    local git_info="$(git_prompt_info)%{$reset_color%}";
    print -rP "$mname  $pathname  $git_info";
}

PROMPT='❯ '

RPS1='%{$fg[red]%}$(virtualenv_name)%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%} ${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[yellow]%}"

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
