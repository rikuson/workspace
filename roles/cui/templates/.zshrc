# keybind
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^U' backward-kill-line

# homebrew
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
  )
  ZSH_THEME="af-magic"
  source $ZSH/oh-my-zsh.sh
fi

export PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
