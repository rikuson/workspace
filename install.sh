#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# Install homebrew
/bin/bash -c `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`
eval `/opt/homebrew/bin/brew shellenv`
brew update
brew upgrade

# Create bare repository
if [ -e $HOME/macOS ]; then
  abort "`macOS` directory already exists."
fi
mkdir $HOME/macOS
git init --bare $HOME/macOS
alias config='git --git-dir=$HOME/macOS/ --work-tree=$HOME'
config config status.showUntrackedFiles no
config config pull.rebase true
config remote add origin git@github.com:rikuson/macOS.git
config pull origin master
config branch --set-upstream-to=origin/master

# Install ansible
brew install ansible
source $HOME/.zshrc
provision init
