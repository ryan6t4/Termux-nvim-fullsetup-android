-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Termux-specific mobile-friendly keymaps
if vim.fn.has('termux') == 1 then
  -- Touch-friendly navigation
  map("n", "<S-h>", "^", { desc = "Beginning of line" })
  map("n", "<S-l>", "$", { desc = "End of line" })
  map("v", "<S-h>", "^", { desc = "Beginning of line" })
  map("v", "<S-l>", "$", { desc = "End of line" })
  
  -- Easier window navigation for mobile
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
  
  -- Quick save and quit
  map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
  map("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file" })
  map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
  
  -- Better scrolling for touch devices
  map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
  map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
  map("n", "n", "nzzzv", { desc = "Next search result centered" })
  map("n", "N", "Nzzzv", { desc = "Previous search result centered" })
  
  -- Mobile-optimized text selection
  map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
  map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
  
  -- Clipboard operations for Termux
  map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
  map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
  map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
  map("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
  
  -- Touch-friendly undo/redo
  map("n", "U", "<C-r>", { desc = "Redo" })
  
  -- Easier command mode access
  map("n", ";", ":", { desc = "Enter command mode" })
  map("n", ":", ";", { desc = "Repeat last search" })
end

-- Enhanced AI keymaps
map("n", "<leader>ai", "<cmd>Gen<cr>", { desc = "AI Generate" })
map("v", "<leader>ai", "<cmd>Gen<cr>", { desc = "AI Generate" })
map("n", "<leader>ac", "<cmd>Gen Complete_Code<cr>", { desc = "AI Complete Code" })
map("n", "<leader>ae", "<cmd>Gen Explain_Code<cr>", { desc = "AI Explain Code" })
map("n", "<leader>ar", "<cmd>Gen Review_Code<cr>", { desc = "AI Review Code" })
map("n", "<leader>ao", "<cmd>Gen Optimize_Code<cr>", { desc = "AI Optimize Code" })
map("n", "<leader>ad", "<cmd>Gen Add_Docstring<cr>", { desc = "AI Add Documentation" })
map("n", "<leader>at", "<cmd>Gen Generate_Tests<cr>", { desc = "AI Generate Tests" })
map("n", "<leader>af", "<cmd>Gen Fix_Code<cr>", { desc = "AI Fix Code" })

-- Project management shortcuts
map("n", "<leader>pp", "<cmd>Telescope projects<cr>", { desc = "Find projects" })
map("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Find files in project" })
map("n", "<leader>pg", "<cmd>Telescope live_grep<cr>", { desc = "Grep in project" })
map("n", "<leader>pb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>pr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Enhanced LSP keymaps
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to definition" })
map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Go to references" })
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to implementation" })
map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Go to type definition" })
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code actions" })
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover documentation" })
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature help" })
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature help" })

-- Diagnostic navigation
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })
map("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show diagnostic" })
map("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Diagnostic list" })

-- Git shortcuts
map("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
map("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git pull" })
map("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git file history" })

-- Terminal shortcuts
map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("t", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal left window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal down window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal up window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal right window" })

-- Buffer management
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Force delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#<cr>", { desc = "Delete all but current" })

-- Quick editing
map("n", "<leader>ev", "<cmd>edit $MYVIMRC<cr>", { desc = "Edit init.lua" })
map("n", "<leader>sv", "<cmd>source $MYVIMRC<cr>", { desc = "Source init.lua" })

-- Search and replace
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/", { desc = "Replace word under cursor" })
map("v", "<leader>s", ":s/", { desc = "Replace in selection" })

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Quick pairs for mobile typing
map("i", "(", "()<left>", opts)
map("i", "[", "[]<left>", opts)
map("i", "{", "{}<left>", opts)
map("i", "'", "''<left>", opts)
map("i", '"', '""<left>', opts)
map("i", "`", "``<left>", opts)

-- Auto-completion shortcuts
map("i", "<C-Space>", "<cmd>lua require('cmp').complete()<cr>", { desc = "Trigger completion" })

-- Focus mode
map("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen mode" })
map("n", "<leader>Z", "<cmd>Twilight<cr>", { desc = "Toggle Twilight" })

-- File operations
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>fS", "<cmd>wa<cr>", { desc = "Save all files" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Code folding
map("n", "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", { desc = "Open all folds" })
map("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", { desc = "Close all folds" })

-- Minimap controls
map("n", "<leader>mm", "<cmd>lua require('codewindow').toggle_minimap()<cr>", { desc = "Toggle minimap" })
map("n", "<leader>mf", "<cmd>lua require('codewindow').toggle_focus()<cr>", { desc = "Focus minimap" })

-- Pomodoro timer
map("n", "<leader>pw", "<cmd>TimerStart 25m Work<cr>", { desc = "Start work timer" })
map("n", "<leader>pb", "<cmd>TimerStart 5m Break<cr>", { desc = "Start break timer" })
map("n", "<leader>ps", "<cmd>TimerStop<cr>", { desc = "Stop timer" })

-- Package management shortcuts
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy plugin manager" })
map("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason LSP manager" })

-- Quick exit
map("n", "ZZ", "<cmd>wqa<cr>", { desc = "Save all and exit" })
map("n", "ZQ", "<cmd>qa!<cr>", { desc = "Force quit all" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines in normal mode
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Custom functions for Termux optimization
local function toggle_performance_mode()
  vim.g.termux_performance_mode = not vim.g.termux_performance_mode
  if vim.g.termux_performance_mode then
    vim.opt.updatetime = 1000
    vim.opt.lazyredraw = true
    vim.notify("Performance mode: ON")
  else
    vim.opt.updatetime = 250
    vim.opt.lazyredraw = false
    vim.notify("Performance mode: OFF")
  end
end

local function toggle_battery_optimization()
  vim.g.termux_battery_optimization = not vim.g.termux_battery_optimization
  if vim.g.termux_battery_optimization then
    vim.opt.timeoutlen = 1000
    vim.opt.ttimeoutlen = 50
    vim.notify("Battery optimization: ON")
  else
    vim.opt.timeoutlen = 500
    vim.opt.ttimeoutlen = 10
    vim.notify("Battery optimization: OFF")
  end
end

-- Termux-specific toggles
if vim.fn.has('termux') == 1 then
  map("n", "<leader>tp", toggle_performance_mode, { desc = "Toggle performance mode" })
  map("n", "<leader>tb", toggle_battery_optimization, { desc = "Toggle battery optimization" })
end
