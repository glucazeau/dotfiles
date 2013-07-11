# https://github.com/blinks zsh theme

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}±%{%f%k%b%}"
  else
   echo '%(!.!.➜)'
  fi
}

function getUserColor {
  local user=$(whoami) 2>/dev/null
  if [ $user = 'root' ]; then
    echo 'red'
  else
    echo $1
  fi
}
function get_RAM {
  free -m | awk '{if (NR==3) print $4}' | xargs -i echo 'scale=1;{}/1000' | bc
}

function get_nr_jobs() {
  jobs | wc -l
}

function get_nr_CPUs() {
  grep -c "^processor" /proc/cpuinfo
}

function get_load() {
  uptime | awk '{print $11}' | tr ',' ' '
}

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{black}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{black}%B%F{$(getUserColor green)}%}%n%{%B%F{$(getUserColor blue)}%}@%{%B%F{$(getUserColor cyan)}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{black}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}
%{%K{black}%}$(_prompt_char)%{%K{black}%} %#%{%f%k%b%} '

RPROMPT='%{$fg_bold[green]%}%*%{$reset_color%} !%{%B%F{cyan}%}%!%{%f%k%b%}'
