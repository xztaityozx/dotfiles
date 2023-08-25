function _zinit_bat_atload() {
  export MANPAGER="sh -c 'col -xb | bat --theme TwoDark -l man -p'"
  alias cat="bat --theme TwoDark"
  unfunction $0
}

function _zinit_fzf_atload() {
  export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border --bind 'ctrl-a:toggle-all'"
  export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  unfunction $0
}

function _zinit_exa_atload() {
  alias ls="exa --git"
  alias ll="exa --time-style=long-iso -mUuhla --icons --changed --git"
  unfunction $0
}

function _zinit_pastel_atload() {
  export COLORTERM=24bit
  unfunction $0
}

function _zinit_fzf-tab_atload() {
  if [[ -n "$TMUX" ]]; then 
    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
    zstyle ':fzf-tab:*' fzf-flags "--border=none"
    zstyle ':fzf-tab:*' continuous-trigger 'tab'
    zstyle ':fzf-tab:complete:*' fzf-bindings 'ctrl-a:toggle'
  fi

  unfunction $0
}

# zsh-utils
function _zinit_zsh-history-substring-search_atload() {
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  unfunction $0
}

