# My workspace on macOS

## Prepare for provisioning

```bash
# Create bare repository
mkdir $HOME/macOS
git init --bare $HOME/macOS
ssh-keygen -t rsa
alias config='$@ --git-dir=$HOME/macOS/ --work-tree=$HOME'
config git config status.showUntrackedFiles no
config git config pull.rebase true
config git remote add origin git@github.com:rikuson/macOS.git
config git pull origin main
config git branch --set-upstream-to=origin/main
source $HOME/.bashrc

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/main/install)"
brew update
brew upgrade

# Install ansible
brew install ansible
```
## Provisioning

```bash
cd ~/provision
ansible-playbook playbook.yml -i hosts
rake serverspec:all
```

## Terminal font setting

- Family: FiraCode Nerd Font
- Typeface: Regular
- Size: 12
- Character Spacing: 1
- Line Spacing: 0.85
