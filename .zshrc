# Homebrew
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# nodebrew
NODEBREW_HOME=$HOME/.nodebrew/current
export NODEBREW_HOME
export NODEBREW_ROOT=$HOME/.nodebrew
export PATH=$NODEBREW_HOME/bin:$PATH
export NODE_BINARY=$NODEBREW_HOME/bin/node

# alias
alias ls='lsd -l'
alias cat='bat --paging=never'
alias tree='lsd --tree'

# Better man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^U' backward-kill-line

# ws command
fpath=($HOME/.zsh/ws $fpath)
source $HOME/.zsh/ws/ws.plugin.zsh

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  asdf
  direnv
  fzf
  jump
  pass
  zsh-syntax-highlighting
  zsh-autosuggestions
)
ZSH_THEME="af-magic"
source $ZSH/oh-my-zsh.sh
