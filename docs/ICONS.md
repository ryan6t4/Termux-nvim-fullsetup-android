# Icon Support System for Termux Neovim Setup

This document provides comprehensive information about the icon support system specifically designed for Termux on Android.

## Overview

The icon support system provides comprehensive icon coverage for file types, git status, UI elements, and LSP symbols with intelligent fallbacks for environments where Nerd Fonts are not available.

## Features

### 🎯 Core Features

- **File Type Icons**: Programming languages, configs, directories
- **Git Status Icons**: Added, modified, deleted, untracked, etc.
- **UI Element Icons**: Menus, search, settings, notifications
- **LSP Kind Icons**: Functions, classes, variables, etc.
- **Plugin Status Icons**: Mason, Treesitter, Telescope, etc.

### 📱 Android Termux Optimizations

- **Automatic Detection**: Recognizes Termux environment
- **Font Path Checking**: Validates Nerd Font installation
- **Fallback System**: ASCII alternatives when icons unavailable
- **Performance Optimizations**: Mobile-friendly settings
- **Touch-Friendly UI**: Larger targets and simplified layouts

### 🔧 Error Handling

- **Graceful Degradation**: Falls back to text when icons fail
- **Font Validation**: Checks font availability before use
- **Diagnostic Tools**: Built-in troubleshooting commands
- **Configuration Validation**: Prevents crashes from invalid settings

## Installation

The icon system is automatically loaded with the Neovim configuration. No additional setup is required for basic functionality.

### Font Installation (Recommended)

For the best experience, install a Nerd Font in Termux:

```bash
# Install required tools first
pkg install curl unzip

# Then in Neovim, run:
:TermuxFontInstall
```

## Configuration

### Icon Themes

The system supports multiple icon themes:

- `nerd`: Full Nerd Font icons (requires Nerd Font)
- `ascii`: ASCII fallback icons (works without special fonts)
- `minimal`: Simplified icon set
- `default`: Automatic selection based on font availability

Switch themes with:
```vim
:lua require("config.icons").set_theme("ascii")
```

### Customization

Icons can be customized in `lua/config/icons.lua`:

```lua
local icons = require("config.icons")

-- Custom file type icon
icons.filetype_icons.custom_ext = icons.use_icons and "🔧" or "TOOL"

-- Custom git status icon
icons.git_icons.custom_status = icons.use_icons and "" or "CUSTOM"
```

## Available Commands

### Font Management
- `:TermuxFontInstall` - Interactive font selection and installation
- `:TermuxFontStatus` - Check current font status
- `:TermuxFontBackup` - Backup current font

### Icon Management
- `<leader>uid` - Diagnose icon system
- `<leader>uit` - Change icon theme

## Supported Plugins

The icon system integrates with:

- **mini.icons**: Core icon provider
- **lualine**: Status line with icons
- **bufferline**: Buffer tabs with icons
- **telescope**: Fuzzy finder with icons
- **neo-tree**: File explorer with icons
- **oil.nvim**: Inline file editing with icons
- **gitsigns**: Git status indicators
- **nvim-cmp**: Completion with kind icons
- **which-key**: Key mappings with icons

## File Type Support

### Programming Languages
- Lua (`.lua`) - 
- Python (`.py`) - 
- JavaScript (`.js`) - 
- TypeScript (`.ts`) - 
- Rust (`.rs`) - 
- Go (`.go`) - 
- Java (`.java`) - 
- C/C++ (`.c`, `.cpp`) - 
- HTML (`.html`) - 
- CSS (`.css`) - 
- And many more...

### Configuration Files
- Git files (`.gitignore`, `.gitconfig`) - 
- Docker files (`dockerfile`) - 
- Makefiles (`makefile`) - 
- Package files (`package.json`) - 
- Config files (`.toml`, `.yaml`, `.json`) - 

### Special Files
- README files - 
- License files - 
- Documentation - 
- Images - 
- Archives - 

## Git Integration

Git status is indicated with intuitive icons:

- `` Added files
- `` Modified files
- `` Deleted files
- `` Untracked files
- `` Staged changes
- `` Merge conflicts
- `` Branch indicator

## LSP Integration

LSP symbols are represented with clear icons:

- `` Functions and methods
- `` Classes and interfaces
- `` Variables and fields
- `` Constants and enums
- `` Files and modules
- `` Snippets and keywords

## Troubleshooting

### Icons Not Showing

1. **Check font installation**:
   ```vim
   :TermuxFontStatus
   ```

2. **Diagnose icon system**:
   ```vim
   :lua require("config.icons").diagnose()
   ```

3. **Switch to ASCII theme**:
   ```vim
   :lua require("config.icons").set_theme("ascii")
   ```

### Performance Issues

1. **Disable animations** (mobile optimization):
   ```lua
   vim.opt.lazyredraw = true
   ```

2. **Reduce icon density**:
   ```lua
   local icons = require("config.icons")
   icons.mobile_config.use_simple_icons = true
   ```

### Font Installation Issues

1. **Check required tools**:
   ```bash
   pkg list-installed | grep -E "curl|unzip"
   ```

2. **Install missing tools**:
   ```bash
   pkg install curl unzip
   ```

3. **Manual font installation**:
   ```bash
   # Download any Nerd Font and copy to ~/.termux/font.ttf
   cp /path/to/nerd-font.ttf ~/.termux/font.ttf
   ```

## Mobile-Specific Features

### Touch Optimization
- Larger touch targets for mobile screens
- Simplified layouts for small displays
- Optimized scrolling and navigation

### Battery Optimization
- Reduced animations and effects
- Efficient rendering strategies
- Smart resource management

### Screen Size Adaptation
- Responsive layouts
- Density-aware icon sizing
- Orientation-friendly designs

## Advanced Configuration

### Custom Icon Sets

Create custom icon mappings:

```lua
local icons = require("config.icons")

-- Add custom file type
icons.filetype_icons.myext = icons.use_icons and "🚀" or "ROCKET"

-- Register with mini.icons
require("mini.icons").setup({
  extension = {
    myext = { glyph = icons.get_icon("filetype", "myext"), hl = "MiniIconsBlue" },
  },
})
```

### Theme Creation

Create a new icon theme:

```lua
local icons = require("config.icons")

icons.themes.my_theme = "my_theme"

-- Override icons when theme is active
local original_set_theme = icons.set_theme
icons.set_theme = function(theme)
  if theme == "my_theme" then
    -- Apply custom icons
    icons.filetype_icons.lua = "🌙"
    icons.git_icons.branch = "🌿"
  end
  original_set_theme(theme)
end
```

### Plugin Integration

Integrate with custom plugins:

```lua
local icons = require("config.icons")

-- Custom plugin configuration
require("my-plugin").setup({
  icons = {
    error = icons.get_icon("diagnostic", "error"),
    warn = icons.get_icon("diagnostic", "warn"),
    info = icons.get_icon("diagnostic", "info"),
  },
})
```

## API Reference

### Core Functions

- `require("config.icons").get_icon(category, name, fallback)` - Get icon by category and name
- `require("config.icons").set_theme(theme)` - Change icon theme
- `require("config.icons").diagnose()` - Run diagnostic check
- `require("config.icons").is_termux()` - Check if running in Termux
- `require("config.icons").check_nerd_font()` - Validate Nerd Font availability

### Icon Categories

- `filetype_icons` - File type and extension icons
- `git_icons` - Git status and version control icons
- `diagnostic_icons` - LSP diagnostic icons
- `lsp_icons` - Language server icons
- `ui_icons` - User interface element icons
- `kind_icons` - LSP completion kind icons
- `plugin_icons` - Plugin status icons

## Contributing

To add new icons or improve existing ones:

1. Edit `lua/config/icons.lua`
2. Follow the existing pattern with fallbacks
3. Test on both Nerd Font and ASCII environments
4. Update documentation as needed

## License

This icon system is part of the Termux Neovim setup and follows the same license terms.