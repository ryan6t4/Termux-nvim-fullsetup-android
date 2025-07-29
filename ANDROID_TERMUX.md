# Neovim Android Termux Configuration

This Neovim configuration has been optimized for Android Termux with performance enhancements and mobile-friendly features.

## Issues Fixed

### 1. Conflicting trouble.nvim Configuration
- **Problem**: `lua/plugins/example.lua` had both enabled and disabled configurations for trouble.nvim
- **Solution**: Removed the conflicting `enabled = false` configuration, keeping only the enhanced configuration

### 2. Deprecated typescript.nvim Dependency
- **Problem**: Used archived `jose-elias-alvarez/typescript.nvim` package
- **Solution**: Replaced with `pmizio/typescript-tools.nvim` and updated API calls

### 3. Duplicate vim-illuminate Plugin
- **Problem**: vim-illuminate was configured in both `todo.lua` and `highlights.lua`
- **Solution**: 
  - Disabled duplicate in `highlights.lua`
  - Renamed `todo.lua` to `illuminate.lua` for better organization
  - Enhanced configuration with keymaps and filetypes exclusion

### 4. Enhanced Plugin Configurations
- **Problem**: Basic plugin configurations without optimization
- **Solution**: Enhanced all plugin configurations with better defaults and mobile optimizations

## New Features

### Android Termux Optimizations

#### Performance Settings (`lua/config/options.lua`)
- Automatic Termux detection via `/data/data/com.termux` directory
- Mobile-specific performance optimizations:
  - `lazyredraw = true` - Reduce screen redraws
  - `updatetime = 500` - Longer update time for battery life
  - `maxmempattern = 1000` - Reduced memory usage
  - `synmaxcol = 200` - Limit syntax highlighting for performance
- Mobile-friendly display settings:
  - `wrap = true` with `linebreak = true` - Better text wrapping
  - `scrolloff = 3` - Smaller scroll offset for mobile screens
  - Disabled swap files, enabled persistent undo

#### Mobile-Friendly Keymaps (`lua/config/keymaps.lua`)
- Touch-friendly navigation shortcuts
- Quick buffer and window navigation
- Terminal integration commands for Termux
- Package management shortcuts

#### Enhanced Lazy.nvim Configuration (`lua/config/lazy.lua`)
- Disabled additional unnecessary plugins for better performance
- Enhanced caching and performance settings
- Mobile-optimized plugin loading

### New Plugin Files

#### 1. Android-Specific Features (`lua/plugins/android.lua`)
- Termux API integration (share, clipboard, notifications)
- Mobile-optimized file manager (nvim-tree)
- Touch-friendly which-key settings
- Vertical telescope layout for narrow screens
- Battery-friendly auto-save functionality
- Session management optimized for mobile

#### 2. Performance Optimizations (`lua/plugins/performance.lua`)
- Impatient.nvim for faster startup
- Optimized treesitter settings with file size limits
- Reduced LSP diagnostics frequency for battery life
- Lightweight completion sources
- Optimized git signs and status line
- Disabled animations for better performance
- Simplified dashboard for faster startup

#### 3. Enhanced Illumination (`lua/plugins/illuminate.lua`)
- Better highlight configuration
- Excluded problematic file types
- Added navigation keymaps
- Enhanced diagnostic highlighting

### Enhanced Existing Plugins

#### LSP Configuration (`lua/plugins/lsp.lua`)
- Updated to latest server versions
- Enhanced server-specific settings
- Better diagnostics configuration
- Schema store integration for JSON/YAML
- Mason tool installer for automated setup

#### Spell Checking (`lua/plugins/spellcheck.lua`)
- Advanced spellsitter integration
- CMP spell completion
- Enhanced spell checking commands and keymaps
- Context-aware spell checking

#### AI Code Completion (`lua/plugins/codeium.lua`)
- Enhanced Codeium integration
- Chat functionality
- Privacy controls for sensitive files
- Better CMP integration with custom formatting
- AI-powered code actions

### Improved Autocmds (`lua/config/autocmds.lua`)
- Mobile-specific battery saving features
- Auto-save functionality for data protection
- Large file handling optimization
- Smart line numbers (relative/absolute)
- Enhanced file type handling
- Termux clipboard integration

### Enhanced Main Configuration (`init.lua`)
- Termux environment detection and setup
- Mobile-optimized startup configuration
- Enhanced error handling and notifications
- Memory management for mobile devices
- Startup performance monitoring

## Usage

### Termux-Specific Features
- **Termux API**: `:TermuxShare`, `:TermuxClipboard`, `:TermuxNotification`
- **Package Management**: `<leader>tp` to update Termux packages
- **Terminal Access**: `<leader>tt` to open terminal
- **Session Management**: `<leader>qs/ql/qd` for session handling

### Performance Features
- Large files (>100KB) automatically disable syntax highlighting
- Battery-optimized update frequencies
- Memory management with automatic garbage collection
- Reduced plugin overhead for mobile performance

### AI Features
- **Codeium Chat**: `<leader>cc` to open AI chat
- **Code Explanation**: Select code and use `<leader>ce`
- **Code Refactoring**: Select code and use `<leader>cr`
- **Documentation**: `<leader>cd` to generate docs

## File Structure
```
lua/
├── config/
│   ├── autocmds.lua     # Enhanced autocmds with mobile optimizations
│   ├── keymaps.lua      # Mobile-friendly keymaps
│   ├── lazy.lua         # Enhanced plugin manager config
│   └── options.lua      # Termux-optimized settings
└── plugins/
    ├── android.lua      # Termux-specific features
    ├── performance.lua  # Mobile performance optimizations
    ├── illuminate.lua   # Enhanced syntax highlighting
    ├── lsp.lua         # Modern LSP configurations
    ├── codeium.lua     # Enhanced AI completion
    ├── spellcheck.lua  # Advanced spell checking
    └── example.lua     # Fixed conflicts and updated deps
```

This configuration provides a complete, mobile-optimized Neovim experience specifically tailored for Android Termux environments while maintaining high performance and extensive functionality.