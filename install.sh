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

# Install homebrew
/bin/bash -c `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew update
brew upgrade

# Create bare repository
git clone $WORKSPACE_REPOSITORY_URL

# Install oh-my-zsh
sh -c `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh`

# Initialize
brew install ansible
gem install bundler ansible_spec

touch $HOME/.zprofile
