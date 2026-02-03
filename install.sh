#!/bin/zsh

set -u

WORKSPACE_REPOSITORY_URL=${WORKSPACE_REPOSITORY_URL:-git@github.com:rikuson/workspace.git}

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

[[ -e $HOME/workspace ]] && abort '`workspace` directory already exists.'

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for this session
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /usr/local/Homebrew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew update
brew upgrade

# Clone repository
git clone $WORKSPACE_REPOSITORY_URL

# Initialize
brew install ansible
gem install bundler
