# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository is an Ansible-based macOS workspace provisioning system for automating development environment setup. It uses Ansible playbooks to configure a personal macOS system with CLI tools, GUI applications, OS preferences, and App Store installations.

## Architecture

### Core Components

**Ansible Playbook Structure**
- `playbook.yml`: Main orchestrator defining four distinct provisioning layers (cui, gui, appstore, os)
- `hosts`: Ansible inventory configured for localhost-only execution
- `ansible.cfg`: Uses system Python 3 interpreter
- `Makefile`: Provides convenient entry points for running playbooks

**Role-Based Organization**
The repository uses four independent Ansible roles, each with specific responsibilities:

1. **cui** (Command Line Interface): Installs and configures terminal-based tools
   - Homebrew packages (bat, fzf, neovim, tmux, lazygit, ripgrep, etc.)
   - ASDF version manager with multiple runtimes (Node.js, Python, Ruby, Rust, Terraform, etc.)
   - Neovim configuration with Lazy.nvim plugin manager
   - Oh My Zsh and shell customizations
   - Git configuration

2. **gui**: Installs GUI applications via Homebrew cask
   - Docker, Google Chrome, Typora, Clipy, etc.

3. **os**: Configures macOS system preferences via osx_defaults
   - Trackpad settings (three-finger drag, tap-to-click)
   - Finder preferences (show dotfiles, path bar)
   - Dock preferences (auto-hide, hide recents)
   - Keyboard settings (disable autocorrect, smart quotes)

4. **appstore**: Installs Mac App Store applications using mas
   - Xcode, Logic Pro X, Microsoft Remote Desktop, Evernote, etc.

### Custom Ansible Modules

**library/asdf.py**
Custom module for idempotent ASDF plugin and runtime installation:
- Checks if plugin exists, adds if missing
- Installs latest version if no version installed
- Sets global version to latest

### Neovim Configuration

Neovim is configured using Lazy.nvim as the plugin manager with modular Lua configuration:
- Plugin manager config: `.config/nvim/lua/config/lazy.lua`
- Individual plugin configs in `.config/nvim/lua/plugins/` including:
  - LSP (nvim-lspconfig, none-ls)
  - Completion (nvim-cmp)
  - Navigation (telescope, easymotion)
  - UI (lualine, bufferline)
  - Git integration (lazygit via toggleterm)
  - Code editing (treesitter, nvim-autopairs, nvim-surround)

## Common Commands

### Running the Playbook

```bash
# Run all provisioning tasks
make

# Run specific provisioning layers
make cui        # CLI tools only
make gui        # GUI applications only
make appstore   # App Store apps only
make os         # macOS system preferences only

# Direct ansible-playbook invocation
ansible-playbook playbook.yml -i hosts
ansible-playbook playbook.yml -i hosts --tags="cui"
```

### Testing

```bash
make test       # Run serverspec tests
```

### Initial Setup

The install.sh script bootstraps a new system:
1. Installs Homebrew
2. Installs Oh My Zsh
3. Clones this repository to ~/workspace
4. Installs Ansible and Bundler

After running install.sh, restart the terminal and run `make`.

## Modifying Configurations

### Adding New Homebrew Packages

Edit the appropriate file:
- CUI tools: `roles/cui/tasks/homebrew.yml`
- GUI apps: `roles/gui/tasks/homebrew.yml`

Add to the `with_items` list following the existing pattern.

### Adding New ASDF Runtimes

Edit `roles/cui/tasks/asdf.yml` and add to the `with_items` list under the "Install runtime" task.

### Adding Neovim Plugins

Create a new Lua file in `roles/cui/templates/.config/nvim/lua/plugins/` or modify existing plugin configurations. The Lazy.nvim plugin manager will automatically load all files from the plugins directory.

### Modifying macOS Preferences

Edit `roles/os/tasks/main.yml` and add new osx_defaults tasks. Use handlers "Restart Dock" or "Restart Finder" when necessary to apply changes.

### Adding App Store Applications

Edit `roles/appstore/tasks/mas.yml` and add to the `with_items` list with the app name and App Store ID.

## Important Notes

- All roles are tagged and can be run independently
- The playbook runs locally (localhost) with connection: local
- OS preference changes may require Dock/Finder restarts (handled via Ansible handlers)
- The custom asdf module ensures idempotent runtime installations
- Neovim uses Lazy.nvim for plugin management with lock file versioning
