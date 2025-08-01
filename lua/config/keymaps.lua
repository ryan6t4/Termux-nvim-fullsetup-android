-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- File Navigation and Management
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })
map("n", "<leader>E", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>O", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in explorer" })

-- Oil.nvim keymaps (alternative file manager)
map("n", "<leader>-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
map("n", "<leader>_", function() require("oil").open(vim.fn.getcwd()) end, { desc = "Open cwd in oil" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Quick save and quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Clear search highlighting
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Terminal integration (useful for Termux)
map("n", "<leader>tt", function()
  require("lazyvim.util").terminal(nil, { cwd = require("lazyvim.util").root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>tT", function()
  require("lazyvim.util").terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<leader>th", function()
  require("lazyvim.util").terminal(nil, { cwd = require("lazyvim.util").root(), direction = "horizontal" })
end, { desc = "Terminal (horizontal)" })
map("n", "<leader>tv", function()
  require("lazyvim.util").terminal(nil, { cwd = require("lazyvim.util").root(), direction = "vertical" })
end, { desc = "Terminal (vertical)" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- File creation shortcuts
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Quick access to frequently used files
map("n", "<leader>fc", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
