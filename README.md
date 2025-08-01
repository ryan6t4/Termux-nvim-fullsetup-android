# 💤 LazyVim for Termux Android - VS Code-like Experience

A comprehensive Neovim configuration for [Termux](https://termux.com/) on Android, providing a VS Code-like development experience optimized for mobile devices. Based on [LazyVim](https://github.com/LazyVim/LazyVim) with extensive customizations for Android/Termux compatibility.

## ✨ Features

### 🎯 VS Code-like Experience
- **Alt+Z Word Wrap Toggle**: Just like VS Code, toggle word wrap with Alt+Z
- **VS Code Keybindings**: Familiar shortcuts for save (Ctrl+S), find (Ctrl+P), command palette (Ctrl+Shift+P)
- **Multi-cursor Support**: Edit multiple locations simultaneously with Ctrl+D
- **Integrated Terminal**: Toggle floating/horizontal/vertical terminals with built-in shortcuts
- **File Explorer**: Neo-tree with icons and git integration (Leader+E to toggle)

### 🗃️ Enhanced File Management
- **Fuzzy Finder**: Telescope with VS Code-like search (Ctrl+P for files, Ctrl+Shift+F for text)
- **File Icons**: Beautiful file type icons that work in Termux terminal
- **Project Management**: Automatic project detection and workspace switching
- **Buffer Management**: Enhanced buffer navigation and management

### 💾 SQL/Database Support
- **MariaDB/MySQL Autocompletion**: Full SQL LSP support with intelligent completion
- **SQL Formatting**: Automatic SQL code formatting
- **Database Syntax Highlighting**: Enhanced syntax support for SQL dialects

### 🎨 Code Development
- **Enhanced Autocompletion**: Codeium AI completion + LSP + snippets
- **Smart Code Folding**: UFO plugin for better code folding experience
- **Rainbow Brackets**: Color-coded bracket matching
- **Auto-formatting**: Format on save for multiple languages
- **Syntax Highlighting**: Tree-sitter powered highlighting for 30+ languages

### 🔧 Git Integration
- **Git Status Indicators**: File changes shown in explorer and editor
- **Git Blame**: Inline git blame information
- **Git Diff Viewer**: Visual diff viewer for changes
- **Enhanced Git Signs**: Better git gutter with staging/unstaging shortcuts

### 📱 Termux Optimizations
- **Mobile-Friendly**: Optimized for Android touch screens and keyboards
- **Performance Tuned**: Configured for mobile device performance
- **Termux-Specific Settings**: Auto-detection and optimization for Termux environment
- **Clipboard Integration**: Seamless copy/paste with Android system

## 🚀 Installation

### Prerequisites
```bash
# Update Termux packages
pkg update && pkg upgrade -y

# Install required packages
pkg install -y git neovim nodejs python rust golang

# Install optional but recommended packages
pkg install -y fd ripgrep fzf
```

### Quick Install
```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true

# Clone this configuration
git clone https://github.com/ryan6t4/Termux-nvim-fullsetup-android.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## ⌨️ Key Bindings

### VS Code-like Shortcuts
| Shortcut | Action | Mode |
|----------|--------|------|
| `Alt+Z` | Toggle word wrap | Normal |
| `Ctrl+P` | Find files | Normal |
| `Ctrl+Shift+P` | Command palette | Normal |
| `Ctrl+Shift+F` | Search in files | Normal |
| `Ctrl+S` | Save file | Normal/Insert |
| `Ctrl+D` | Multi-cursor selection | Normal/Visual |
| `Ctrl+/` | Toggle comment | Normal/Visual |
| `Alt+J/K` | Move line up/down | Normal/Visual |
| `Shift+Alt+↑/↓` | Duplicate line | Normal/Visual |
| `Ctrl+\` | Toggle terminal | Normal |

### File Management
| Shortcut | Action |
|----------|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>o` | Focus file explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fr` | Recent files |
| `<leader>fp` | Find projects |

### Git Operations
| Shortcut | Action |
|----------|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>gd` | Git diff view |
| `<leader>gh` | Git file history |
| `]c` / `[c` | Next/Previous git hunk |

### Terminal
| Shortcut | Action |
|----------|--------|
| `<leader>tt` | Toggle floating terminal |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<Esc>` | Exit terminal mode |

### Code Features
| Shortcut | Action |
|----------|--------|
| `<leader>mo` | Open minimap |
| `<leader>mt` | Toggle minimap |
| `zR` / `zM` | Open/Close all folds |
| `zr` / `zm` | Fold less/more |
| `zp` | Peek fold |
| `Shift+Alt+F` | Format document |

## 🔧 Configuration

### Customizing Settings

The configuration is modular and easy to customize:

- **Options**: Edit `lua/config/options.lua` for editor settings
- **Keymaps**: Edit `lua/config/keymaps.lua` for custom keybindings  
- **Plugins**: Add/modify plugins in `lua/plugins/` directory
- **LSP**: Configure language servers in `lua/plugins/lsp.lua`

### Adding New Language Support

1. Add LSP server to `lua/plugins/lsp.lua`:
```lua
opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
  "your_language_server",
})
```

2. Add formatter to `lua/plugins/formatter.lua`:
```lua
formatters_by_ft = {
  your_language = { "your_formatter" },
}
```

3. Add treesitter parser to `lua/plugins/vscode-like.lua`:
```lua
vim.list_extend(opts.ensure_installed, {
  "your_language",
})
```

## 🎯 Language Support

### Currently Supported
- **Lua** (lua_ls, stylua)
- **Python** (pyright, black)
- **JavaScript/TypeScript** (tsserver, prettier)
- **HTML/CSS** (html, cssls, prettier)
- **JSON** (jsonls, prettier)
- **SQL/MariaDB** (sqls, sqlfmt)
- **Bash/Shell** (bash-language-server)
- **Markdown** (marksman)

### Adding More Languages
The configuration is designed to be easily extensible. See the configuration section above for adding new language support.

## 📚 Plugin Ecosystem

### Core Plugins
- **LazyVim**: Base configuration framework
- **Lazy.nvim**: Plugin manager
- **Neo-tree**: File explorer with icons
- **Telescope**: Fuzzy finder and picker
- **LSP**: Language server protocol support
- **Treesitter**: Syntax highlighting and parsing

### VS Code-like Extensions
- **Codeium**: AI-powered code completion
- **Rainbow Delimiters**: Bracket pair colorization
- **UFO**: Advanced code folding
- **ToggleTerm**: Integrated terminal
- **GitSigns**: Git integration
- **DiffView**: Git diff viewer
- **Visual Multi**: Multi-cursor editing
- **Project.nvim**: Project management

### Mobile/Termux Optimizations
- **Performance tuning**: Optimized for mobile CPUs
- **Touch-friendly**: Better mobile interaction
- **Battery efficient**: Reduced background processing
- **Memory optimized**: Lower memory footprint

## 🛠️ Troubleshooting

### Common Issues

1. **Icons not showing**: Install a nerd font in Termux
2. **Slow performance**: Disable heavy plugins in `lazy-lock.json`
3. **LSP not working**: Run `:Mason` to install language servers
4. **Git integration issues**: Configure git user name and email

### Performance Tips
- Use `:Lazy` to manage plugin loading
- Run `:checkhealth` to diagnose issues
- Disable unused language servers
- Use `:LspInfo` to check LSP status

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test in Termux environment
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim) - Base configuration framework
- [Termux](https://termux.com/) - Terminal emulator for Android
- All the amazing plugin authors in the Neovim ecosystem

---

**Made with ❤️ for Android developers using Termux**
