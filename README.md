# Neovim Configuration

A modular Neovim configuration with Lazy.nvim, LSP, Telescope, and a Doom Emacs-style dashboard.

## Requirements

- **Neovim** 0.11+
- **Git**
- **A Nerd Font** (e.g., CaskaydiaMono, JetBrainsMono)
- **Tree-sitter CLI** - `npm install -g tree-sitter-cli`
- **ripgrep** - for Telescope live grep
- **Build tools** - gcc/clang (Linux/macOS) or MSVC/MinGW (Windows)

## Installation

### Linux / macOS
```bash
git clone https://github.com/henri23/nvim.git ~/.config/nvim
```

### Windows (PowerShell)
```powershell
git clone https://github.com/henri23/nvim.git $env:LOCALAPPDATA\nvim
```

Launch Neovim and plugins will auto-install.

## Key Bindings

| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `Space f f` | Find files |
| `Space f w` | Live grep |
| `Space f o` | Recent files |
| `Space e e` | File explorer |
| `Space c h` | Cheatsheet |
| `F5` | Run application (.envrc) |
| `F7` | Build project (.envrc) |
| `F8` | Post-build script (.envrc) |
| `F10` | Toggle terminal |

## Project Configuration (.envrc)

Create a `.envrc` file in your project root for build/run commands:

```bash
export APPLICATION=bin/my_app
export LAUNCH_DIR=bin
export BUILD_SCRIPT=build.sh    # or build.bat on Windows
export POST_BUILD_SCRIPT=deploy.sh
```

## Structure

```
nvim/
├── init.lua              # Entry point
├── lua/
│   ├── options.lua       # Vim options
│   ├── keymaps.lua       # Key bindings
│   ├── autocmds.lua      # Auto commands
│   ├── plugins/          # Plugin configs
│   └── custom/           # Custom modules
│       ├── cheatsheet.lua
│       └── envrc.lua
```
