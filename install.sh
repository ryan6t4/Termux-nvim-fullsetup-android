#!/data/data/com.termux/files/usr/bin/bash

# Ultimate Termux Neovim Setup - Automated Installation Script
# Description: One-command installation for the complete development environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
REPO_URL="https://github.com/ryan6t4/Termux-nvim-fullsetup-android.git"

# Utility functions
print_header() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                 🚀 Ultimate Termux Neovim Setup              ║"
    echo "║                   Better Than VS Code!                      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Check if running in Termux
check_termux() {
    if [[ ! "$PREFIX" == *"com.termux"* ]]; then
        print_error "This script is designed for Termux. Please run it in Termux environment."
        exit 1
    fi
    print_success "Termux environment detected"
}

# Check available space
check_space() {
    available_space=$(df "$HOME" | awk 'NR==2 {print $4}')
    required_space=2000000  # 2GB in KB
    
    if [ "$available_space" -lt "$required_space" ]; then
        print_warning "Low disk space detected. Required: 2GB, Available: $(($available_space/1000))MB"
        echo "Continue anyway? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
    print_success "Sufficient disk space available"
}

# Update Termux packages
update_termux() {
    print_step "Updating Termux packages..."
    pkg update -y && pkg upgrade -y
    print_success "Termux packages updated"
}

# Install core dependencies
install_core_deps() {
    print_step "Installing core dependencies..."
    
    local core_packages=(
        "git"
        "neovim"
        "nodejs"
        "python"
        "python-pip"
        "curl"
        "wget"
        "unzip"
        "tree"
        "ripgrep"
        "fd"
        "fzf"
        "bat"
        "eza"
        "zoxide"
    )
    
    for package in "${core_packages[@]}"; do
        print_info "Installing $package..."
        pkg install -y "$package" || print_warning "Failed to install $package"
    done
    
    print_success "Core dependencies installed"
}

# Install language-specific tools
install_language_tools() {
    print_step "Installing language development tools..."
    
    # Programming languages
    local lang_packages=(
        "rust"
        "golang"
        "clang"
        "make"
        "cmake"
        "ninja"
        "lldb"
        "gdb"
        "openjdk-17"
        "php"
        "ruby"
        "lua54"
        "zig"
    )
    
    for package in "${lang_packages[@]}"; do
        print_info "Installing $package..."
        pkg install -y "$package" || print_warning "Failed to install $package"
    done
    
    # Python packages
    print_info "Installing Python development tools..."
    pip install --upgrade pip
    pip install pylsp black isort mypy flake8 autopep8 jupyter ipython requests django flask fastapi
    
    # Node.js packages
    print_info "Installing Node.js development tools..."
    npm install -g typescript eslint prettier @angular/cli create-react-app vue-cli svelte-cli
    
    # Rust tools
    print_info "Installing Rust development tools..."
    cargo install cargo-watch cargo-edit rust-analyzer || true
    
    # Go tools
    print_info "Installing Go development tools..."
    go install golang.org/x/tools/gopls@latest || true
    go install github.com/go-delve/delve/cmd/dlv@latest || true
    
    print_success "Language tools installed"
}

# Install Ollama for offline AI
install_ollama() {
    print_step "Setting up offline AI with Ollama..."
    
    # Install Ollama
    curl -fsSL https://ollama.ai/install.sh | sh || {
        print_warning "Failed to install Ollama. Skipping AI features."
        return
    }
    
    # Start Ollama service
    ollama serve &
    sleep 5
    
    # Pull coding models
    print_info "Downloading AI models (this may take a while)..."
    ollama pull codellama:7b || print_warning "Failed to download CodeLlama model"
    ollama pull starcoder:3b || print_warning "Failed to download StarCoder model"
    
    print_success "Ollama AI setup completed"
}

# Backup existing configuration
backup_config() {
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        print_step "Backing up existing Neovim configuration..."
        mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
        print_success "Backup created at $BACKUP_DIR"
    fi
}

# Clone and setup Neovim configuration
setup_neovim_config() {
    print_step "Setting up Neovim configuration..."
    
    # Clone the repository
    git clone "$REPO_URL" "$NVIM_CONFIG_DIR"
    
    # Set up configuration directories
    mkdir -p "$HOME/.local/share/nvim"
    mkdir -p "$HOME/.cache/nvim"
    
    print_success "Neovim configuration installed"
}

# Setup storage permissions
setup_storage() {
    print_step "Setting up storage access..."
    
    if [ ! -d "$HOME/storage" ]; then
        termux-setup-storage
        print_info "Please grant storage permission when prompted"
        sleep 3
    fi
    
    print_success "Storage access configured"
}

# Setup additional Termux features
setup_termux_features() {
    print_step "Configuring Termux features..."
    
    # Setup extra keys
    mkdir -p "$HOME/.termux"
    cat > "$HOME/.termux/termux.properties" << 'EOF'
# Enhanced keyboard with development keys
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'], \
              ['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]

# Enable true color support
terminal-color-depth = 24

# Hardware acceleration
hardware-acceleration = true
EOF
    
    # Setup shell aliases for productivity
    cat >> "$HOME/.bashrc" << 'EOF'

# Ultimate Neovim aliases
alias v='nvim'
alias vim='nvim'
alias vi='nvim'
alias code='nvim'
alias vscode='nvim'

# Enhanced ls with eza
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias tree='eza --tree --icons'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Development shortcuts
alias serve='python -m http.server 8000'
alias py='python'
alias node='node'
alias npm='npm'
alias pip='pip'

# Project management
alias projects='cd ~/projects'
alias config='cd ~/.config'

# Quick navigation with zoxide
eval "$(zoxide init bash)"
alias cd='z'
EOF
    
    print_success "Termux features configured"
}

# Setup project structure
setup_projects() {
    print_step "Setting up development workspace..."
    
    mkdir -p "$HOME/projects"
    mkdir -p "$HOME/projects/web"
    mkdir -p "$HOME/projects/mobile"
    mkdir -p "$HOME/projects/backend"
    mkdir -p "$HOME/projects/scripts"
    mkdir -p "$HOME/projects/learning"
    
    # Create a welcome project
    cat > "$HOME/projects/README.md" << 'EOF'
# 🚀 Welcome to Your Development Workspace

## Project Structure
- `web/` - Frontend projects (React, Vue, Angular)
- `mobile/` - Mobile apps (Flutter, React Native)
- `backend/` - Server-side projects (APIs, services)
- `scripts/` - Automation scripts and tools
- `learning/` - Learning projects and experiments

## Quick Commands
```bash
# Navigate to workspace
cd ~/projects

# Create new project
mkdir my-awesome-project && cd my-awesome-project

# Start coding
nvim .
```

Happy coding! 🎉
EOF
    
    print_success "Development workspace created"
}

# First-time Neovim setup
setup_neovim_first_run() {
    print_step "Performing initial Neovim setup..."
    
    # Run Neovim headlessly to install plugins
    print_info "Installing Neovim plugins (this may take a few minutes)..."
    nvim --headless -c "lua require('lazy').sync({wait = true})" -c "qa" 2>/dev/null || {
        print_warning "Plugin installation may have issues. Run :Lazy sync manually in Neovim."
    }
    
    print_success "Neovim setup completed"
}

# Performance optimizations
optimize_performance() {
    print_step "Applying performance optimizations..."
    
    # Create performance config
    cat >> "$NVIM_CONFIG_DIR/lua/config/options.lua" << 'EOF'

-- Termux-specific optimizations
if vim.fn.has('termux') == 1 then
  -- Battery optimization
  vim.opt.updatetime = 1000
  vim.opt.timeoutlen = 500
  vim.opt.ttimeoutlen = 10
  
  -- Memory optimization
  vim.opt.history = 100
  vim.opt.undolevels = 500
  vim.opt.maxmempattern = 1000
  
  -- Performance settings
  vim.opt.synmaxcol = 200
  vim.opt.lazyredraw = true
  vim.opt.ttyfast = true
  
  -- Mobile-friendly settings
  vim.g.termux_performance_mode = true
  vim.g.termux_touch_mode = true
end
EOF
    
    print_success "Performance optimizations applied"
}

# Create useful scripts
create_scripts() {
    print_step "Creating utility scripts..."
    
    mkdir -p "$HOME/.local/bin"
    
    # Update script
    cat > "$HOME/.local/bin/nvim-update" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🔄 Updating Neovim configuration..."
cd ~/.config/nvim
git pull origin main
nvim --headless -c "lua require('lazy').sync({wait = true})" -c "qa"
echo "✅ Update completed!"
EOF
    
    # Backup script
    cat > "$HOME/.local/bin/nvim-backup" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
cp -r ~/.config/nvim "$backup_dir"
echo "✅ Backup created at $backup_dir"
EOF
    
    # Health check script
    cat > "$HOME/.local/bin/nvim-health" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🔍 Running Neovim health check..."
nvim --headless -c "checkhealth" -c "qa"
EOF
    
    chmod +x "$HOME/.local/bin/"*
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
    
    print_success "Utility scripts created"
}

# Final setup and verification
final_verification() {
    print_step "Performing final verification..."
    
    # Check if Neovim starts without errors
    nvim --version >/dev/null 2>&1 || {
        print_error "Neovim installation verification failed"
        exit 1
    }
    
    # Check configuration
    if [ ! -f "$NVIM_CONFIG_DIR/init.lua" ]; then
        print_error "Neovim configuration not found"
        exit 1
    fi
    
    print_success "Installation verification completed"
}

# Print completion message
print_completion() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🎉 INSTALLATION COMPLETE! 🎉              ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║                                                              ║"
    echo "║  🚀 Your ultimate Neovim development environment is ready!   ║"
    echo "║                                                              ║"
    echo "║  Next steps:                                                 ║"
    echo "║  1. Restart Termux to apply all changes                     ║"
    echo "║  2. Run 'nvim' to start your enhanced editor                ║"
    echo "║  3. Use 'nvim .' in any project directory                   ║"
    echo "║  4. Check out ~/projects/ for your workspace                ║"
    echo "║                                                              ║"
    echo "║  Useful commands:                                            ║"
    echo "║  • nvim-update  - Update configuration                      ║"
    echo "║  • nvim-backup  - Backup configuration                      ║"
    echo "║  • nvim-health  - Check system health                       ║"
    echo "║                                                              ║"
    echo "║  🎯 Happy coding! You now have a setup better than VS Code! ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${CYAN}📖 For more information, visit:${NC}"
    echo -e "${BLUE}   https://github.com/ryan6t4/Termux-nvim-fullsetup-android${NC}"
    echo
    echo -e "${YELLOW}⭐ If this helped you, please star the repository!${NC}"
}

# Main installation function
main() {
    print_header
    
    echo "Starting Ultimate Termux Neovim Setup..."
    echo "This will install a complete development environment with 20+ language support,"
    echo "offline AI assistance, and advanced productivity features."
    echo
    echo "Continue? (Y/n)"
    read -r response
    if [[ "$response" =~ ^[Nn]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    
    # Installation steps
    check_termux
    check_space
    setup_storage
    update_termux
    install_core_deps
    install_language_tools
    install_ollama
    backup_config
    setup_neovim_config
    setup_termux_features
    setup_projects
    optimize_performance
    create_scripts
    setup_neovim_first_run
    final_verification
    print_completion
}

# Error handling
trap 'print_error "Installation failed at line $LINENO. Check the error messages above."' ERR

# Run main function
main "$@"