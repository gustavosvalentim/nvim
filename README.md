# Neovim Configuration

This repository contains my personal Neovim configuration. It's designed to be portable and easy to set up on a new machine.

## Prerequisites

Before you can use this configuration, you need to install Neovim and a few dependencies.

### Windows

It's recommended to use a package manager like [Scoop](https://scoop.sh/), [Chocolatey](https://chocolatey.org/), or [Winget](https://winget.run/) to install the dependencies.

**Using Scoop:**

```powershell
scoop install neovim git ripgrep fzf
```

**Using Winget:**

```powershell
winget install Neovim.Neovim Git.Git BurntSushi.Ripgrep.MSVC junegunn.fzf
```

**Using Chocolatey:**

```powershell
choco install neovim git ripgrep fzf
```

### Linux

Use your distribution's package manager to install the dependencies.

**For Debian/Ubuntu-based distributions:**

```bash
sudo apt-get update
sudo apt-get install neovim git ripgrep fzf
```

**For Arch-based distributions:**

```bash
sudo pacman -Syu neovim git ripgrep fzf
```

**For Fedora-based distributions:**

```bash
sudo dnf install neovim git ripgrep fzf
```

## Installation

Once the prerequisites are installed, you can clone this repository to the appropriate location for your operating system.

**For Windows (PowerShell):**

```powershell
git clone https://github.com/gustavosvalentim/nvim $env:LOCALAPPDATA\nvim
```

**For Linux/macOS:**

```bash
git clone https://github.com/gustavosvalentim/nvim ~/.config/nvim
```

The first time you launch Neovim after cloning the configuration, `lazy.nvim` will automatically bootstrap itself and install all the plugins.

## Configuration Overview

This configuration is structured to be modular and easy to maintain.

-   `init.lua`: The main entry point of the configuration.
-   `lua/gsv/`: The core of the configuration.
    -   `init.lua`: Loads the other configuration files.
    -   `editor.lua`: Contains general editor settings like line numbers, indentation, and search behavior.
    -   `plugins.lua`: Defines the list of plugins to be installed and managed by `lazy.nvim`.
-   `after/plugin/`: Contains plugin-specific configurations and keymaps.
    -   `fzf.lua`: Keybindings for `fzf`.
    -   `lsp.lua`: Configuration for the Language Server Protocol (LSP), completion, and diagnostics.
    -   `lualine.lua`: Configuration for the status line.
    -   `treesitter.lua`: Configuration for `nvim-treesitter` for syntax highlighting.

## Keybindings

### General

| Key | Description |
| --- | --- |
| `<leader>` | `Space` |

### FZF

| Key | Description |
| --- | --- |
| `<C-p>` | Search for files in the current directory. |
| `<C-f>` | Search for a string in the current directory using `ripgrep`. |

### LSP

| Key | Description |
| --- | --- |
| `<leader>gD` | Go to declaration. |
| `<leader>gd` | Go to definition. |
| `<leader>K` | Show hover information. |
| `<leader>gr` | Show references. |
| `<C-w>d` | Show diagnostics in a floating window. |
| `<leader>f` | Format the current buffer. |

### Completion (nvim-cmp)

| Key | Description |
| --- | --- |
| `<C-u>` | Scroll up in the documentation. |
| `<C-d>` | Scroll down in the documentation. |
| `<C-Space>` | Trigger completion. |
| `<CR>` | Confirm selection. |
| `<Tab>` | Select the next item in the completion menu. |
| `<S-Tab>` | Select the previous item in the completion menu. |

## Plugins

This configuration uses the following plugins:

-   **[lazy.nvim](https://github.com/folke/lazy.nvim):** A modern plugin manager for Neovim.
-   **[dracula.nvim](https://github.com/Mofiqul/dracula.nvim):** A dark theme.
-   **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):** For advanced syntax highlighting.
-   **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):** Configurations for the Neovim LSP client.
-   **[mason.nvim](https://github.com/williamboman/mason.nvim):** A package manager for LSP servers, DAP servers, linters, and formatters.
-   **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim):** Bridges `mason.nvim` with `nvim-lspconfig`.
-   **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp):** A completion engine.
-   **[cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp):** LSP source for `nvim-cmp`.
-   **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):** A status line for Neovim.
-   **[vim-fugitive](https://github.com/tpope/vim-fugitive):** A Git wrapper.
-   **[fzf](https://github.com/junegunn/fzf):** A command-line fuzzy finder.
-   **[fzf.vim](https://github.com/junegunn/fzf.vim):** Vim bindings for `fzf`.
-   **[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons):** Icons for file types.

## Editor Settings

-   **Indentation:** 4 spaces, with tabs expanded to spaces.
-   **Line Numbers:** Both absolute and relative line numbers are enabled.
-   **Search:** Incremental search is enabled, but highlighting of all matches is disabled.
-   **Folding:** Folding is enabled and based on Treesitter.
-   **Backup/Swap Files:** Disabled.
