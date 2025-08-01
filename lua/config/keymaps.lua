-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Word wrap toggle (Alt+Z) - VS Code compatibility for mobile editing
local function toggle_word_wrap()
  vim.wo.wrap = not vim.wo.wrap
  local status = vim.wo.wrap and "enabled" or "disabled"
  vim.notify("Word wrap " .. status, vim.log.levels.INFO, { title = "Editor" })
end

-- Map Alt+Z to toggle word wrap in normal and insert modes
vim.keymap.set("n", "<M-z>", toggle_word_wrap, { desc = "Toggle word wrap" })
vim.keymap.set("i", "<M-z>", toggle_word_wrap, { desc = "Toggle word wrap" })
