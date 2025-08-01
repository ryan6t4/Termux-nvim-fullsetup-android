-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- VS Code-like auto-save on focus lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and vim.bo.modifiable and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
  desc = "Auto-save on focus lost",
})

-- Automatically enter insert mode when opening terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal optimizations",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Auto-create directories on save",
})

-- Better SQL file handling
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    vim.opt_local.commentstring = "-- %s"
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "SQL file optimizations",
})

-- Termux-specific optimizations
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Adjust settings for Termux environment
    if vim.env.TERMUX_VERSION then
      vim.opt.mouse = "a" -- Enable mouse support in Termux
      vim.opt.clipboard = "unnamedplus" -- Use system clipboard
      -- Optimize for mobile screens
      vim.opt.laststatus = 2
      vim.opt.showtabline = 1
    end
  end,
  desc = "Termux-specific optimizations",
})

-- Smart line numbers
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = false -- Use absolute numbers for VS Code-like experience
    end
  end,
  desc = "Smart line numbers",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
  desc = "Smart line numbers",
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with <q>",
})
