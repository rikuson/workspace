# Bare repo
alias config='git --git-dir=$HOME/macOS/ --work-tree=$HOME'

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# rbenv
if [[ -d $HOME/.rbenv  ]]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
