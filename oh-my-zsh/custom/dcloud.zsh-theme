local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function virtualenv_name(){
  if [[ -n $VIRTUAL_ENV ]]; then
    printf "[%s] " ${${VIRTUAL_ENV}:t}
  fi
}

# Use zsh's built in vcs_info support
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
# %b = branch, %c = stagedstr, %u = unstagedstr, %a = action identifier (for actionformats)
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{blue}+'  # display this when there are staged changes
# actionformats is "used if there is a special action going on in your current repository"
zstyle ':vcs_info:*' actionformats '%F{$reset_color%}%{yellow%}%b%{$reset_color%}|%{$fg[cyan]%}%a%{$reset_color%}%c%u%{$reset_color%} '
zstyle ':vcs_info:*' formats '%{$reset_color%}%{$fg[yellow]%}%b%{$reset_color%}%c%u%{$reset_color%} '
zstyle ':vcs_info:*' enable git cvs svn

theme_precmd() {
    local mname="%{$fg[magenta]%}${SHORT_HOST:-$HOST}%{$reset_color%}";
    local pathname="%{$fg[green]%}%1~%{$reset_color%}";
    vcs_info
    print -rP "$mname  $pathname  ${vcs_info_msg_0_}";
}

PROMPT='❯ '

RPS1='%{$fg[red]%}$(virtualenv_name)%{$reset_color%}%{$fg[blue]%}%T%{$reset_color%} ${return_code}'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
