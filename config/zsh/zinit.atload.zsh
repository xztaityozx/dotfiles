function __zinit_bat_atload() {
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
  export BAT_THEME=TwoDark
  alias cat="bat"
  unfunction $0
}

function __zinit_fzf_atload() {
  export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border --bind 'ctrl-a:toggle-all'"
  export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  unfunction $0
}

function __zinit_lsd_atload() {
  alias ls=lsd
  alias ll="lsd -l --date +'%F %T' --git"
  unfunction $0
}

function __zinit_pastel_atload() {
  export COLORTERM=24bit
  unfunction $0
}

function __zinit_fzf-tab_atload() {
  if [[ -n "$TMUX" ]]; then 
    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
    zstyle ':fzf-tab:*' fzf-flags "--border=none"
    zstyle ':fzf-tab:*' continuous-trigger 'tab'
    zstyle ':fzf-tab:complete:*' fzf-bindings 'ctrl-a:toggle'
  fi

  unfunction $0
}

