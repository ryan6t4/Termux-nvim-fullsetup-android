-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("termux_" .. name, { clear = true })
end

-- Mobile/Termux specific autocmds
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("terminal_settings"),
  pattern = "terminal",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.spell = false
  end,
  desc = "Terminal-specific settings for better mobile experience",
})

-- Auto-save when focus is lost (useful for mobile multitasking)
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
  group = augroup("auto_save"),
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent update")
    end
  end,
  desc = "Auto-save files when losing focus",
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position when opening files",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 300,
    })
  end,
  desc = "Highlight yanked text",
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
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
  desc = "Close certain filetypes with <q>",
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto-create directories when saving files",
})

-- Check for external file changes more frequently (useful for mobile development)
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
  desc = "Check for external file changes when gaining focus",
})

-- Mobile-friendly line numbers for different file types
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("mobile_line_numbers"),
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.relativenumber = false -- Absolute numbers for text files
  end,
  desc = "Use absolute line numbers for text files",
})

-- Better formatting for mobile screens
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("mobile_formatting"),
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.showbreak = "↪ "
  end,
  desc = "Enable text wrapping for text files on mobile",
})

-- Termux-specific shell script settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("shell_scripts"),
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
  desc = "Shell script formatting for Termux",
})
