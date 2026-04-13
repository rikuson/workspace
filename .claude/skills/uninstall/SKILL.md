---
name: uninstall
description: Uninstall tools, plugins, or applications by updating the Ansible playbook. Use when the user wants to remove a CLI tool, GUI app, Neovim plugin, ASDF runtime, or App Store app.
argument-hint: "[tool-or-plugin-name]"
allowed-tools: Read Edit Bash(rm *)
---

# Uninstall Tool/Plugin

Update the Ansible playbook to remove the specified tool or plugin.

## Step 1: Identify the uninstall target

Use `$ARGUMENTS` if provided. If missing or ambiguous, ask the user interactively.

### Question 1: What to remove

If `$ARGUMENTS` is not specific enough, ask the user for the exact package/plugin name.

### Question 2: Install type

Determine which type of install it is:

1. **brew** - Homebrew CLI package
2. **cask** - Homebrew Cask GUI app
3. **neovim** - Neovim plugin
4. **asdf** - ASDF runtime
5. **appstore** - Mac App Store app

If unclear, search the Ansible files to find where the target is defined. If found in multiple places, ask the user which one to remove.

## Step 2: Verify the target exists

Read the corresponding Ansible file(s) and confirm the target is present:
- brew: `roles/cui/tasks/homebrew.yml` (`Install brew packages`)
- cask (cui): `roles/cui/tasks/homebrew.yml` (`Install brew cask packages`)
- cask (gui): `roles/gui/tasks/homebrew.yml`
- asdf: `roles/cui/tasks/asdf.yml`
- neovim: files under `roles/cui/templates/.config/nvim/lua/plugins/`
- appstore: `roles/appstore/tasks/mas.yml`

If not found, inform the user and stop.

## Step 3: Remove from the Ansible files

### brew / cask / asdf / appstore
Remove the corresponding `- { name: ... }` line from the `with_items` list in the appropriate YAML file.

### neovim
- If the plugin is defined in `roles/cui/templates/.config/nvim/lua/plugins/init.lua`, remove its entry from the `return {}` table.
- If the plugin has a dedicated config file in `roles/cui/templates/.config/nvim/lua/plugins/` (e.g. `nvim-tree.lua`), delete the entire file.

## Step 4: Remove related configuration

Check for and remove any associated configuration:
- Shell aliases/exports in `roles/cui/tasks/homebrew.yml` (`blockinfile` tasks referencing the tool)
- Config file templates in `roles/cui/templates/` and their corresponding `template` tasks
- Any other tasks that reference the removed tool

Ask the user for confirmation before removing related configuration.

## Step 5: Report

Tell the user:
- What was removed and from which file(s)
- Any related configuration that was also removed
- Remind them to actually uninstall the tool from the system if needed (e.g. `brew uninstall <name>`, `mas uninstall <id>`)
