-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Alt+Z to toggle word wrap (VS Code-like)
vim.keymap.set("n", "<A-z>", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.notify("Word wrap enabled", vim.log.levels.INFO)
  else
    vim.notify("Word wrap disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle word wrap (Alt+Z)" })

-- VS Code-like line manipulation
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down (Alt+J)" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up (Alt+K)" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down (Alt+J)" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up (Alt+K)" })

-- VS Code-like line duplication
vim.keymap.set("n", "<S-A-Down>", "yyp", { desc = "Duplicate line down" })
vim.keymap.set("n", "<S-A-Up>", "yyP", { desc = "Duplicate line up" })
vim.keymap.set("v", "<S-A-Down>", "y'>pgv", { desc = "Duplicate selection down" })
vim.keymap.set("v", "<S-A-Up>", "y'<Pgv", { desc = "Duplicate selection up" })

-- VS Code-like comment toggling (enhanced)
vim.keymap.set("n", "<C-/>", "gcc", { desc = "Toggle line comment", remap = true })
vim.keymap.set("v", "<C-/>", "gc", { desc = "Toggle block comment", remap = true })

-- VS Code-like formatting
vim.keymap.set("n", "<S-A-f>", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format document" })

-- VS Code-like save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file" })

-- VS Code-like undo/redo
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("n", "<C-S-z>", "<C-r>", { desc = "Redo" })

-- VS Code-like select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- VS Code-like find and replace
vim.keymap.set("n", "<C-h>", ":%s/", { desc = "Find and replace" })
vim.keymap.set("v", "<C-h>", ":s/", { desc = "Find and replace in selection" })

-- VS Code-like go to line
vim.keymap.set("n", "<C-g>", ":lua vim.ui.input({prompt='Go to line: '}, function(input) if input then vim.cmd('normal! ' .. input .. 'G') end end)<CR>", { desc = "Go to line" })

-- Better indentation in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and reselect" })

-- Better navigation
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Terminal-friendly keybindings for Termux
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal: Move to left window" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal: Move to down window" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal: Move to up window" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal: Move to right window" })

-- Quick access to common actions
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
