# My workspace on macOS

## Prepare for provisioning

```bash
# Create bare repository
mkdir $HOME/macOS
git init --bare $HOME/macOS
ssh-keygen -t rsa
alias config='git --git-dir=$HOME/macOS/ --work-tree=$HOME'
config config status.showUntrackedFiles no
config config pull.rebase true
config remote add origin git@github.com:rikuson/macOS.git
config pull origin master
config branch --set-upstream-to=origin/master

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade

# Install ansible
brew install ansible
```
## Provisioning

Run ansible-playbook and serverspec.

```bash
provision all
```

## Terminal font setting

- Family: FiraCode Nerd Font
- Typeface: Regular
- Size: 12
- Character Spacing: 1
- Line Spacing: 0.85
