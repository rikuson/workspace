# My workspace

## Install

Generate ssh keypair and register public key on GitHub.

```bash
ssh-keygen -t ed25519
```

Install Homebrew.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Oh My Zsh.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Clone this repository.

```bash
git clone git@github.com:rikuson/workspace.git ~/workspace
```

Install Ansible and run the playbook.

```bash
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
