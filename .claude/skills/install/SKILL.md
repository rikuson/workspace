---
name: install
description: Install tools, plugins, or applications by updating the Ansible playbook. Use when the user wants to add a new CLI tool, GUI app, Neovim plugin, ASDF runtime, or App Store app.
argument-hint: "[tool-or-plugin-name]"
allowed-tools: Read Edit Write WebSearch Bash(brew info *) Bash(brew search *) Bash(mas search *)
---

# Install Tool/Plugin

Update the Ansible playbook to install the specified tool or plugin.

## Step 1: Identify the install target

Use `$ARGUMENTS` if provided. If missing or ambiguous, ask the user interactively.

### Question 1: Install type

Ask the user to choose the install type:

1. **brew** - Homebrew CLI package (e.g. ripgrep, lazygit, wget)
2. **cask** - Homebrew Cask GUI app (e.g. slack, visual-studio-code, firefox)
3. **neovim** - Neovim plugin (e.g. nvim-tree, copilot.nvim)
4. **asdf** - ASDF runtime (e.g. golang, java, elixir)
5. **appstore** - Mac App Store app (e.g. LINE, Things 3)

Skip this question if the type is obvious from `$ARGUMENTS` (e.g. "nvim-tree" → neovim).

### Question 2: Package name

If `$ARGUMENTS` does not include a package name, ask for it. Use search commands to suggest candidates:
- brew/cask: `brew search <keyword>`
- appstore: `mas search <keyword>`
- neovim: WebSearch
- asdf: `asdf plugin list all | grep <keyword>`, etc.

### Question 3: Additional configuration

Look up the tool/plugin README or documentation via WebSearch to check if additional configuration is recommended. Propose any of the following to the user and ask for confirmation:

- **Shell aliases**: shorthand commands or default options
- **Environment variables**: PATH additions or tool-specific settings
- **Config files**: tool-specific dotfiles
- **Key mappings** (Neovim): which keys to bind
- **Lazy loading** (Neovim): event, command, or filetype conditions
- **Dependencies**: other packages or plugins required

Skip this question if no additional configuration is needed.

## Step 2: Check for duplicates

Read the corresponding Ansible file and verify the target is not already present:
- brew: `roles/cui/tasks/homebrew.yml` (`Install brew packages`)
- cask (cui): `roles/cui/tasks/homebrew.yml` (`Install brew cask packages`)
- cask (gui): `roles/gui/tasks/homebrew.yml`
- asdf: `roles/cui/tasks/asdf.yml`
- appstore: `roles/appstore/tasks/mas.yml`
- neovim: files under `roles/cui/templates/.config/nvim/lua/plugins/`

If already present, inform the user and stop.

## Step 3: Update the Ansible files

Edit the appropriate file based on install type:

### brew
Add to `roles/cui/tasks/homebrew.yml` under `Install brew packages` → `with_items` in alphabetical order:
```yaml
    - { name: <package-name> }
```

### cask
For CLI-oriented casks, add to `roles/cui/tasks/homebrew.yml` under `Install brew cask packages`. For GUI apps, add to `roles/gui/tasks/homebrew.yml`. Insert in alphabetical order:
```yaml
    - { name: <cask-name> }
```

### asdf
Add to `roles/cui/tasks/asdf.yml` under `Install runtime` → `with_items` in alphabetical order:
```yaml
    - { name: <runtime-name> }
```

### appstore
Run `mas search <app-name>` to find the app ID, then add to `roles/appstore/tasks/mas.yml` → `with_items` in alphabetical order:
```yaml
    - { name: <App Name>, id: <app-id> }
```

### neovim
For simple plugins (no config or `config = true` only), add to `roles/cui/templates/.config/nvim/lua/plugins/init.lua` inside the `return {}` table in alphabetical order:
```lua
	{ "<author>/<plugin-name>" },
```

For plugins requiring configuration, create a new Lua file in `roles/cui/templates/.config/nvim/lua/plugins/` named after the plugin (e.g. `nvim-tree.lua`). Use Lazy.nvim format, referring to existing plugin files as examples.

## Step 4: Apply additional configuration

If the user agreed to additional configuration in Step 1 Question 3, apply it:
- Shell aliases/exports: add a `blockinfile` task in `roles/cui/tasks/homebrew.yml`
- Config files: add a template in `roles/cui/templates/` and a `template` task

## Step 5: Report

Tell the user:
- What was added and to which file(s)
- The command to actually install (e.g. `make cui`, `make gui`, `make appstore`)
- Any additional configuration that was applied
