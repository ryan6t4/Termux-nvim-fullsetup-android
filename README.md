# 💤 LazyVim - Android Termux Optimized

A high-performance Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim), specifically optimized for Android Termux environments.

## 🚀 Features

### 📱 Android Termux Optimizations
- **Performance-first approach** with mobile device optimizations
- **Battery-friendly settings** with reduced update frequencies
- **Touch-friendly interface** with mobile-optimized keymaps
- **Termux API integration** for native Android features
- **Memory management** optimized for mobile devices

### 🔧 Enhanced Configurations
- **Fixed conflicting plugins** and deprecated dependencies
- **Modern LSP servers** with latest configurations
- **AI-powered code completion** with Codeium integration
- **Advanced spell checking** with context awareness
- **Performance monitoring** and optimization tools

### 🎯 Key Improvements
- Resolved trouble.nvim conflicts
- Replaced deprecated typescript.nvim with typescript-tools.nvim
- Eliminated duplicate vim-illuminate configurations
- Added comprehensive Android Termux support
- Enhanced all plugin configurations for better UX

## 📚 Documentation

For detailed information about Android Termux optimizations and features, see [ANDROID_TERMUX.md](./ANDROID_TERMUX.md).

## 🛠️ Installation

### For Android Termux:
```bash
# Install required packages
pkg update && pkg upgrade
pkg install git nodejs python cmake ninja

# Clone the configuration
git clone https://github.com/ryan6t4/todo ~/.config/nvim
cd ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

### For other platforms:
Refer to the [LazyVim documentation](https://lazyvim.github.io/installation) for standard installation.

## 🌟 Termux-Specific Features

- **`:TermuxShare`** - Share files via Android
- **`:TermuxClipboard`** - Copy to system clipboard  
- **`:TermuxNotification`** - Send system notifications
- **`<leader>tp`** - Update Termux packages
- **`<leader>tt`** - Open integrated terminal
- **Session management** with `<leader>qs/ql/qd`

## 🎨 Mobile-Optimized UI

- Vertical telescope layout for narrow screens
- Compact file explorer with touch-friendly navigation
- Battery-conscious status line and notifications
- Optimized completion popup sizes
- Smart line number display (relative/absolute switching)

## ⚡ Performance Features

- Large file handling (auto-disable syntax for >100KB files)
- Reduced plugin overhead for mobile
- Memory management with automatic garbage collection
- Startup time monitoring and optimization
- Lazy loading optimized for mobile performance
