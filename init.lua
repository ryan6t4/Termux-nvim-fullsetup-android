-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Initialize icon system and Termux-specific configurations
require("config.termux-fonts").setup()

vim.cmd([[
  augroup SpellCheck
    autocmd!
    autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en_us
  augroup END
]])

-- Termux-specific optimizations
if vim.env.PREFIX and vim.env.PREFIX:match("/data/data/com.termux") then
  -- Optimize for mobile performance
  vim.opt.lazyredraw = true
  vim.opt.ttyfast = true
  
  -- Better touch/swipe handling
  vim.opt.mouse = "a"
  vim.opt.ttimeoutlen = 50
  
  -- Mobile-friendly UI settings
  vim.opt.number = true
  vim.opt.relativenumber = false -- Disable for better performance on mobile
  vim.opt.signcolumn = "yes:1" -- Limit sign column width
  
  -- Better mobile scrolling
  vim.opt.scrolloff = 3
  vim.opt.sidescrolloff = 5
end
