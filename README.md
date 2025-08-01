# 💤 LazyVim for Termux Android

A comprehensive Neovim configuration optimized for Android development in Termux.
Based on [LazyVim](https://github.com/LazyVim/LazyVim) with mobile-specific enhancements.

## 🚀 Features

### File Management
- **nvim-tree**: Full-featured file explorer with git integration
- **oil.nvim**: Alternative file manager for quick directory editing  
- **netrw**: Built-in file manager as backup
- Smart file navigation keybindings

### Enhanced Productivity
- **which-key**: Discover available keybindings and commands
- **toggleterm**: Advanced terminal integration for Termux
- **Auto-save**: Automatic file saving when switching apps
- Mobile-optimized UI and performance

### Development Tools
- **LSP Support**: 15+ language servers (Python, JS/TS, Rust, Go, Java, Bash, etc.)
- **Formatters**: 20+ formatters for various file types
- **Git Integration**: Built-in git support with visual indicators
- **Syntax Highlighting**: Advanced treesitter support

## 📱 Mobile Optimizations

- Touch-friendly interface with larger click targets
- Automatic clipboard integration with Android
- Optimized for small screens and touch input
- Battery-efficient performance settings
- Auto-save functionality for multitasking

## ⌨️ Key Bindings

### File Management
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `<leader>o` | Focus file explorer |
| `<leader>ef` | Find current file in explorer |
| `<leader>-` | Open parent directory (oil.nvim) |
| `<leader>pv` | Open netrw |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate between windows |
| `<C-arrows>` | Resize windows |
| `<S-h/l>` | Navigate between buffers |

### Terminal
| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

### Productivity
| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>h` | Clear search highlight |
| `<leader>fn` | New file |

## 🛠️ Installation

1. **Install Termux** from F-Droid or Google Play
2. **Update packages**:
   ```bash
   pkg update && pkg upgrade
   ```

3. **Install Neovim and dependencies**:
   ```bash
   pkg install neovim git nodejs python rust golang
   ```

4. **Clone this configuration**:
   ```bash
   git clone https://github.com/ryan6t4/Termux-nvim-fullsetup-android.git ~/.config/nvim
   ```

5. **Start Neovim**:
   ```bash
   nvim
   ```

The configuration will automatically install all plugins on first startup.

## 🔧 Language Support

### Pre-configured LSP Servers
- **Python**: pyright
- **JavaScript/TypeScript**: tsserver
- **Lua**: lua_ls
- **Shell**: bashls
- **Web**: html, cssls, emmet_ls, tailwindcss
- **Systems**: clangd (C/C++), rust_analyzer, gopls
- **Mobile**: jdtls (Java for Android)
- **Config**: yamlls, jsonls, taplo (TOML)
- **Docs**: marksman (Markdown), lemminx (XML)

### Supported Formatters
- **Python**: black, isort
- **JavaScript/TypeScript**: prettier
- **Shell**: shfmt
- **Lua**: stylua
- **Web**: prettier (HTML, CSS, JSON, YAML)
- **Systems**: rustfmt, gofmt, clang-format
- **And many more...

## 📂 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── options.lua      # Neovim options (mobile-optimized)
│   │   ├── keymaps.lua      # Key bindings
│   │   └── autocmds.lua     # Auto commands
│   └── plugins/
│       ├── nvim-tree.lua    # File explorer
│       ├── oil.lua          # Alternative file manager
│       ├── which-key.lua    # Key discovery
│       ├── mobile.lua       # Mobile optimizations
│       ├── formatter.lua    # Code formatting
│       ├── lsp.lua          # Language servers
│       └── ...              # Other plugins
```

## 🚨 Troubleshooting

### Common Issues
1. **Slow startup**: Run `:Lazy sync` to update plugins
2. **LSP not working**: Run `:Mason` to install language servers
3. **Clipboard issues**: Ensure `termux-api` is installed
4. **Font issues**: Install a Nerd Font in Termux

### Performance Tips
- Use `:checkhealth` to diagnose issues
- Keep Termux updated: `pkg upgrade`
- Close unused apps to free memory
- Use `:Lazy clean` to remove unused plugins

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This configuration is licensed under the same terms as LazyVim.

Refer to the [LazyVim documentation](https://lazyvim.github.io/installation) for more advanced configuration options.
