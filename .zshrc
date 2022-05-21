# Bare repo
alias config='git --git-dir=$HOME/macOS/ --work-tree=$HOME'

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# nodebrew
NODEBREW_HOME=$HOME/.nodebrew/current
export NODEBREW_HOME
export NODEBREW_ROOT=$HOME/.nodebrew
export PATH=$NODEBREW_HOME/bin:$PATH
export NODE_BINARY=$NODEBREW_HOME/bin/node

# rbenv
if [[ -d $HOME/.rbenv  ]]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# alias
alias ls='lsd -l'
alias cat='bat'
alias tree='lsd --tree'

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^U' backward-kill-line
