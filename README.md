# Custom Neovim Configuration 🚀

This is a custom, highly modular Neovim setup designed specifically for **Linux systems**. It leverages **lazy.nvim** as the package manager to ensure fast startup times and easy plugin management.

## 🛠️ Prerequisites

To ensure all features—especially linters, formatters, and fuzzy finding—work correctly, you must have the following system dependencies installed on your Linux machine:

| Dependency | Purpose |
|---|---|
| **Neovim** | Core text editor (v0.9.0 or higher recommended) |
| **luacheck** | Static analyzer and linter for Lua |
| **stylua** | Opinionated Lua code formatter |
| **ripgrep** | Required for fast text searching via Telescope |
| **fd** | Required for fast file searching via Telescope |
| **Nerd Font** | Required to render icons in the UI (Neo-tree, Bufferline, etc.) |

## 📂 Repository Structure

The configuration is broken down into modular files for easy maintenance:

| Directory/File | Description |
|---|---|
| `/lua/config/` | Core Neovim configuration (`options.lua`, `keymaps.lua`, `lazy.lua`). |
| `/lua/plugins/` | Individual plugin configurations loaded by lazy.nvim. |
| `init.lua` | The entry point that bootstraps the configuration. |
| `.luacheckrc` | Configuration rules for the Lua linter. |
| `stylua.toml` | Formatting rules for the Lua formatter. Use `stylua .` |

## 🧩 Key Plugins Included

This setup comes pre-configured with several essential plugins to provide an IDE-like experience:

* **LSP & Autocompletion**: `nvim-lspconfig`, `mason`, `completion`
* **UI/UX & Aesthetics**: `bufferline`, `lualine`, `autosession`
* **File Management**: `neo-tree`
* **Navigation & Searching**: `telescope (with fzf-native and live-grep-args)`, `flash`
* **Syntax Highlighting**: `nvim-treesitter`
* **Editing Enhancements**: `tabout`, `nvim-ts-autotag`, `mini`
* **Formatting & Linting**: `conform`, `treesj`
* **Git Integration**: `gitsigns`
* **Help**: `whichkey`
