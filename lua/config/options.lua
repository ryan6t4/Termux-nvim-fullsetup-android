-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- VS Code-like editor settings
vim.opt.relativenumber = false -- Use absolute line numbers like VS Code
vim.opt.wrap = false -- Disable word wrap by default (can be toggled with Alt+Z)
vim.opt.linebreak = true -- Break lines at word boundaries when wrap is enabled
vim.opt.showbreak = "↪ " -- Visual indicator for wrapped lines

-- Better scrolling
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8

-- Better search experience
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Better completion experience
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 15 -- Limit completion menu height

-- Better indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Better file handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Better visual experience
vim.opt.termguicolors = true
vim.opt.showmode = false -- Don't show mode in command line (status line shows it)
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1

-- Better split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Better timeout for which-key
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Enable mouse support
vim.opt.mouse = "a"

-- Clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Better diff options
vim.opt.diffopt:append("linematch:60")
