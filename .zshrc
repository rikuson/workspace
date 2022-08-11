# keybind
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^U' backward-kill-line

# oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]; then
  export ZSH="$HOME/.oh-my-zsh"
  plugins=(
    asdf
    direnv
    fzf
    jump
    pass
    zsh-syntax-highlighting
    zsh-autosuggestions
    ws
  )
  ZSH_THEME="af-magic"
  source $ZSH/oh-my-zsh.sh
fi
