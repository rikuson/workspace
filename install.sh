#!/bin/zsh

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}
if [[ -e $HOME/workspace ]]; then
  abort '`workspace` directory already exists.'
fi
if [[ -z "$WORKSPACE_REPOSITORY_URL" ]]; then
  abort '`WORKSPACE_REPOSITORY_URL` is undefined.'
fi

# Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Install homebrew
  /bin/bash -c `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`
  if [[ -d /opt/homebrew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew update
  brew upgrade
  brew install ansible
fi

# WSL
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sudo apt-get -y update
  sudo apt-get -y upgrade
  sudo apt-get install -y git ansible python p7zip-full
fi

# Create bare repository
mkdir $HOME/workspace
git init --bare $HOME/workspace
alias config='git --git-dir=$HOME/workspace/ --work-tree=$HOME'
config config status.showUntrackedFiles no
config config pull.rebase true
config remote add origin $WORKSPACE_REPOSITORY_URL
config pull origin master
config branch --set-upstream-to=origin/master

# Install oh-my-zsh
sh -c `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh`

# Initialize
gem install bundler ansible_spec

touch $HOME/.zprofile
