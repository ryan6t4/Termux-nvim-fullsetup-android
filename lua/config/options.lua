-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Termux-specific optimizations
if vim.fn.has('termux') == 1 then
  -- Battery optimization
  opt.updatetime = 1000        -- Slower updates for battery life
  opt.timeoutlen = 500         -- Faster key sequences
  opt.ttimeoutlen = 10         -- Instant escape sequences
  
  -- Memory optimization
  opt.history = 100            -- Limit history size
  opt.undolevels = 500         -- Reduce undo levels
  opt.maxmempattern = 1000     -- Limit pattern matching memory
  
  -- Performance settings
  opt.synmaxcol = 200          -- Limit syntax highlighting column
  opt.lazyredraw = true        -- Don't redraw during macros
  opt.ttyfast = true           -- Fast terminal connection
  
  -- Mobile-friendly UI
  opt.pumheight = 10           -- Popup menu height
  opt.scrolloff = 4            -- Keep cursor centered
  opt.sidescrolloff = 8        -- Horizontal scroll offset
  opt.wrap = true              -- Wrap long lines for mobile
  opt.linebreak = true         -- Break lines at word boundaries
  opt.showbreak = "↪ "         -- Show wrapped line indicator
  
  -- Touch-friendly settings
  opt.mouse = "a"              -- Enable mouse support
  opt.selection = "inclusive"  -- Include last character in selection
  opt.selectmode = "mouse,key" -- Selection mode options
  
  -- Storage optimization
  opt.backup = false           -- Don't create backup files
  opt.writebackup = false      -- Don't backup before overwriting
  opt.swapfile = false         -- Disable swap files
  opt.undofile = true          -- Enable persistent undo
  opt.undodir = vim.fn.stdpath("cache") .. "/undo"
  
  -- Visual enhancements for mobile
  opt.termguicolors = true     -- Enable 24-bit RGB colors
  opt.signcolumn = "yes:1"     -- Always show sign column
  opt.number = true            -- Show line numbers
  opt.relativenumber = false   -- Absolute numbers for mobile
  opt.cursorline = true        -- Highlight current line
  opt.colorcolumn = "80,120"   -- Show column guides
  
  -- Clipboard integration with Termux
  opt.clipboard = "unnamedplus"
  
  -- Better search experience
  opt.ignorecase = true        -- Ignore case in search
  opt.smartcase = true         -- Smart case sensitivity
  opt.hlsearch = true          -- Highlight search results
  opt.incsearch = true         -- Incremental search
  
  -- Completion settings
  opt.completeopt = "menu,menuone,noselect"
  opt.shortmess:append("c")    -- Don't show completion messages
  
  -- Split behavior
  opt.splitbelow = true        -- Horizontal splits below
  opt.splitright = true        -- Vertical splits to the right
  
  -- Indentation
  opt.expandtab = true         -- Use spaces instead of tabs
  opt.shiftwidth = 2           -- Indent size
  opt.tabstop = 2              -- Tab size
  opt.softtabstop = 2          -- Soft tab size
  opt.autoindent = true        -- Auto-indent new lines
  opt.smartindent = true       -- Smart indentation
  
  -- Folding
  opt.foldmethod = "expr"      -- Use expression for folding
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  opt.foldlevel = 99           -- Start with all folds open
  opt.foldenable = false       -- Disable folding by default
  
  -- Session management
  opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
  
  -- Global variables for Termux detection
  vim.g.termux_performance_mode = true
  vim.g.termux_touch_mode = true
  vim.g.termux_battery_optimization = true
end

-- Enhanced spell checking
opt.spelllang = "en_us"
opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Better diff mode
opt.diffopt:append("vertical,algorithm:patience")

-- Enhanced wildmenu
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- Format options
opt.formatoptions = "jcroqlnt"

-- Concealment settings for better readability
opt.conceallevel = 2
opt.concealcursor = "nc"

-- Virtual edit settings
opt.virtualedit = "block"

-- Better display for messages
opt.cmdheight = 1
opt.showmode = false

-- Status line always visible
opt.laststatus = 3

-- Better completion experience
opt.pumblend = 10
opt.winblend = 10

-- Improved grep
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Security settings
opt.modeline = false
opt.exrc = false

-- Better list characters
opt.list = true
opt.listchars = {
  tab = "→ ",
  eol = "↲",
  nbsp = "␣",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
}

-- Fill characters
opt.fillchars = {
  fold = "⸱",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
