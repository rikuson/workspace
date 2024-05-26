#!/bin/zsh

set -u

WORKSPACE_REPOSITORY_URL="${WORKSPACE_REPOSITORY_URL:git@github.com:rikuson/workspace.git}"

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}
if [[ -e $HOME/workspace ]]; then
  abort '`workspace` directory already exists.'
fi

# Install homebrew
/bin/bash -c `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
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
