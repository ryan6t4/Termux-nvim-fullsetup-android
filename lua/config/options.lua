-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Termux/Android specific optimizations
opt.clipboard = "unnamedplus" -- Use system clipboard (important for Termux)
opt.mouse = "a" -- Enable mouse support for touch screens
opt.mousemodel = "extend" -- Better mouse behavior for mobile

-- Performance optimizations for mobile
opt.updatetime = 250 -- Faster completion (default 4000ms)
opt.timeout = true
opt.timeoutlen = 300 -- Faster which-key (default 1000ms)

-- Better mobile display
opt.termguicolors = true -- Better colors in Termux
opt.signcolumn = "yes" -- Always show sign column to prevent layout shifts
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight current line

-- Better scrolling on mobile
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
opt.smoothscroll = true -- Smooth scrolling (if available)

-- Search improvements
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Override ignorecase if search contains capitals
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show search matches as you type

-- Indentation (important for mobile coding)
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Smart autoindenting

-- File handling
opt.swapfile = false -- Disable swap files (can cause issues on Termux)
opt.backup = false -- Disable backup files
opt.undofile = true -- Enable persistent undo
opt.writebackup = false -- Don't write backup before overwriting

-- Better completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10 -- Maximum height of popup menu

-- Fold settings
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99 -- Start with all folds open

-- Better splits
opt.splitright = true -- Vertical splits go to the right
opt.splitbelow = true -- Horizontal splits go below

-- Termux-specific shell settings
if vim.fn.executable("bash") == 1 then
  opt.shell = "bash"
elseif vim.fn.executable("sh") == 1 then
  opt.shell = "sh"
end

-- Mobile-friendly line wrapping
opt.wrap = false -- Don't wrap lines by default
opt.linebreak = true -- Wrap on word boundaries when wrap is enabled
opt.breakindent = true -- Maintain indent when wrapping

-- Better visual feedback
opt.showmode = false -- Don't show mode in command line (lualine shows it)
opt.showcmd = true -- Show incomplete commands
opt.cmdheight = 1 -- Command line height
opt.laststatus = 3 -- Global statusline

-- File encoding (important for mobile)
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Better backspace behavior
opt.backspace = "indent,eol,start"

-- Prevent issues with small screens
opt.winminwidth = 5 -- Minimum window width
opt.winminheight = 5 -- Minimum window height

-- Disable some features that might not work well in Termux
opt.titlestring = "%<%F%=%l/%L-%P"
opt.title = true
