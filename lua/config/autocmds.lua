-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local is_termux = vim.fn.isdirectory("/data/data/com.termux") == 1

-- Mobile-optimized autocmds for Android Termux
if is_termux then
  -- Battery saving: reduce CursorHold frequency
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = augroup("mobile_battery"),
    callback = function()
      -- Reduce the frequency of CursorHold events
      vim.opt.updatetime = 1000
    end,
  })

  -- Auto-save for mobile (prevent data loss)
  vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    group = augroup("mobile_autosave"),
    callback = function()
      if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
        vim.api.nvim_command("silent! write")
      end
    end,
  })

  -- Optimize for small screens
  vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("mobile_resize"),
    callback = function()
      -- Adjust scroll offset based on window height
      local height = vim.api.nvim_win_get_height(0)
      vim.opt.scrolloff = math.min(height / 4, 8)
    end,
  })

  -- Terminal integration for Termux
  vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("termux_terminal"),
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.cmd("startinsert")
    end,
  })

  -- Clipboard integration with Termux API
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("termux_clipboard"),
    callback = function()
      if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
        -- Copy to Termux clipboard when using + register
        local text = vim.fn.getreg("+")
        vim.fn.system("echo " .. vim.fn.shellescape(text) .. " | termux-clipboard-set")
      end
    end,
  })
end

-- General performance autocmds
-- Disable syntax highlighting for large files
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  group = augroup("performance_large_files"),
  callback = function()
    local max_filesize = 100 * 1024 -- 100 KB
    local filename = vim.api.nvim_buf_get_name(0)
    local ok, stats = pcall(vim.loop.fs_stat, filename)
    
    if ok and stats and stats.size > max_filesize then
      vim.bo.syntax = "off"
      vim.bo.filetype = ""
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.notify("Large file detected, disabled syntax highlighting", vim.log.levels.WARN)
    end
  end,
})

-- Smart line numbers (relative in normal, absolute in insert)
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = augroup("smart_line_numbers"),
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = augroup("smart_line_numbers"),
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Close certain windows with 'q'
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap and spell check for certain file types
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true
  end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup("auto_cursorline"),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup("auto_cursorline"),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
