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

Restart terminal and run `provision`.

```bash
ws provision all
```

## Command

`ws` which is shorthand of `workspace` is available for provisioning.

- ws git: Git command targetting config repository.
- ws provision: Run ansible-playbook and serverspec.

## Terminal font setting

- Family: FiraCode Nerd Font
- Typeface: Regular
- Size: 12
- Character Spacing: 1
- Line Spacing: 0.85
- Cursor Color: Iron
