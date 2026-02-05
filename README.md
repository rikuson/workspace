# My workspace

## Install

```bash
# Generate ssh keypair and register public key on GitHub
ssh-keygen -t ed25519

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone this repository
git clone git@github.com:rikuson/workspace.git ~/workspace

# Install Ansible and run the playbook
brew update && brew upgrade
brew install ansible
cd ~/workspace && make
```

## Terminal font setting

- Family: FiraCode Nerd Font
- Typeface: Regular
- Size: 12
- Character Spacing: 1
- Line Spacing: 0.85
- Cursor Color: Iron
