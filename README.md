# My workspace on macOS

## Register ssh key

Paste public key on GitHub.

```bash
ssh-keygen -t rsa
```

## Install config command

```bash
curl -fsSL https://raw.githubusercontent.com/rikuson/macOS/HEAD/install.sh | zsh -
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
