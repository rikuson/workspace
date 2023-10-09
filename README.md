# My workspace

## Install

Generate ssh keypair and register public key on GitHub.

```bash
ssh-keygen -t ed25519
```

Run install script.

```bash
curl -fsSL https://raw.githubusercontent.com/rikuson/workspace/HEAD/install.sh | WORKSPACE_REPOSITORY_URL=git@github.com:rikuson/workspace.git && zsh -
```

Restart terminal and run `make`.

## Terminal font setting

- Family: FiraCode Nerd Font
- Typeface: Regular
- Size: 12
- Character Spacing: 1
- Line Spacing: 0.85
- Cursor Color: Iron
