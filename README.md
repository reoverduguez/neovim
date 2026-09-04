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
| `stylua.toml` | Formatting rules for the Lua formatter. |

## 🧩 Key Plugins Included

This setup comes pre-configured with several essential plugins to provide an IDE-like experience:

* **LSP & Autocompletion**: `nvim-lspconfig`, `mason.nvim`, `completion.lua`
* **UI & Aesthetics**: `bufferline.nvim`, `lualine` 
* **File Management**: `neo-tree.nvim`
* **Navigation & Searching**: `telescope.nvim`
* **Syntax Highlighting**: `nvim-treesitter`
* **Formatting & Linting**: `conform.nvim`
* **Git Integration**: `gitsigns.nvim`
