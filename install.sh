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
brew install ansible asdf
asdf plugin add terraform
asdf install terraform latest
asdf global terraform latest
asdf plugin add ruby
asdf install ruby latest
asdf global ruby latest
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
asdf plugin add helm
asdf install helm latest
asdf global helm latest
gem install bundler ansible_spec

touch $HOME/.zprofile
