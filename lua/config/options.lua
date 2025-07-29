-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Android Termux optimizations
local is_termux = vim.fn.isdirectory("/data/data/com.termux") == 1

if is_termux then
  -- Performance optimizations for mobile
  vim.opt.lazyredraw = true
  vim.opt.ttyfast = true
  vim.opt.updatetime = 500  -- Increase update time for better battery life
  vim.opt.timeoutlen = 300  -- Faster which-key popup
  
  -- Memory optimizations
  vim.opt.maxmempattern = 1000  -- Reduce memory usage for patterns
  vim.opt.synmaxcol = 200       -- Limit syntax highlighting for long lines
  
  -- Mobile-friendly settings
  vim.opt.scrolloff = 3         -- Smaller scroll offset for mobile screens
  vim.opt.sidescrolloff = 3
  vim.opt.wrap = true           -- Enable line wrap for narrow screens
  vim.opt.linebreak = true      -- Break at word boundaries
  vim.opt.breakindent = true    -- Maintain indentation on wrapped lines
  
  -- Termux-specific settings
  vim.opt.mouse = ""            -- Disable mouse for better touch interaction
  vim.opt.clipboard = "unnamedplus"  -- Use system clipboard via Termux-API
  
  -- Disable swap files on mobile to save storage
  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.writebackup = false
  
  -- Use undofile for persistent undo instead of swap
  vim.opt.undofile = true
  vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
end

-- General optimizations
vim.opt.hidden = true           -- Allow hidden buffers
vim.opt.splitbelow = true       -- Horizontal splits go below
vim.opt.splitright = true      -- Vertical splits go right
vim.opt.termguicolors = true    -- Enable 24-bit colors
vim.opt.cursorline = true       -- Highlight current line
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Show relative line numbers
vim.opt.signcolumn = "yes"      -- Always show sign column
vim.opt.cmdheight = 1           -- Single line command area
vim.opt.pumheight = 10          -- Limit popup menu height
