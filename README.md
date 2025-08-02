# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 🎨 Termux Icon Support

This configuration includes comprehensive icon support specifically optimized for Termux on Android:

- **🔤 Nerd Font Icons**: Full icon support with automatic fallbacks
- **📱 Mobile Optimized**: Touch-friendly layouts and performance optimizations  
- **🔧 Easy Setup**: Automated font installation with `:TermuxFontInstall`
- **🎯 Comprehensive Coverage**: File types, git status, LSP symbols, and UI elements
- **⚡ Smart Fallbacks**: ASCII alternatives when Nerd Fonts aren't available

### Quick Start

1. **Install a Nerd Font** (recommended):
   ```bash
   # In Termux, install required tools
   pkg install curl unzip
   
   # Then in Neovim
   :TermuxFontInstall
   ```

2. **Check icon status**:
   ```vim
   :lua require("config.icons").diagnose()
   ```

3. **Switch icon themes**:
   ```vim
   :lua require("config.icons").set_theme("ascii")  # For ASCII fallback
   :lua require("config.icons").set_theme("nerd")   # For Nerd Font icons
   ```

For detailed documentation, see [docs/ICONS.md](docs/ICONS.md).
