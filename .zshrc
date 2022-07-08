# Bare repo
alias config='git --git-dir=$HOME/macOS/ --work-tree=$HOME'

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

# rbenv
if [[ -d $HOME/.rbenv  ]]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
fi

# alias
alias ls='lsd -l'
alias cat='bat --paging=never'
alias tree='lsd --tree'

# Better man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^U' backward-kill-line

# Zsh plugins
[ -f $(brew --prefix)/opt/antigen/share/antigen/antigen.zsh ] && source $(brew --prefix)/opt/antigen/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle fzf
antigen bundle jump
antigen bundle pass
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme af-magic
antigen apply
