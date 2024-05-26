#!/bin/zsh

set -u

WORKSPACE_REPOSITORY_URL="${WORKSPACE_REPOSITORY_URL:git@github.com:rikuson/workspace.git}"

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

[[ -e $HOME/workspace ]] && abort '`workspace` directory already exists.'

# Install homebrew
/bin/bash -c `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`
[[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade

# Clone repository
git clone $WORKSPACE_REPOSITORY_URL

# Install oh-my-zsh
sh -c `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh`

# Initialize
brew install ansible
gem install bundler ansible_spec

touch $HOME/.zprofile
