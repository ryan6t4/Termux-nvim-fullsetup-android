-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local is_termux = vim.fn.isdirectory("/data/data/com.termux") == 1

-- Mobile-friendly keymaps for Android Termux
if is_termux then
  -- Easier window navigation with single key presses
  vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to left window" })
  vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to lower window" })
  vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to upper window" })
  vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to right window" })
  
  -- Quick buffer navigation
  vim.keymap.set("n", "<leader>,", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<leader>.", "<cmd>bnext<cr>", { desc = "Next buffer" })
  
  -- Easier scrolling for touch devices
  vim.keymap.set("n", "<leader>u", "<C-u>zz", { desc = "Scroll up half page" })
  vim.keymap.set("n", "<leader>d", "<C-d>zz", { desc = "Scroll down half page" })
  
  -- Quick file operations
  vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
  vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
  vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })
  
  -- Terminal integration for Termux
  vim.keymap.set("n", "<leader>tt", function()
    vim.cmd("terminal")
    vim.cmd("startinsert")
  end, { desc = "Open terminal" })
  
  -- Quick terminal commands for Termux
  vim.keymap.set("n", "<leader>tp", "<cmd>!pkg update && pkg upgrade<cr>", { desc = "Update Termux packages" })
  vim.keymap.set("n", "<leader>tc", "<cmd>!termux-clipboard-set<cr>", { desc = "Copy to Termux clipboard" })
end

-- Universal improvements
-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Keep cursor centered during search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Better paste behavior
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without yanking" })
