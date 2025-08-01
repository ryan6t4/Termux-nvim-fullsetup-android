-- bootstrap lazy.nvim, LazyVim and your plugins
-- Track startup time for performance monitoring
vim.g.start_time = vim.fn.reltime()

require("config.lazy")

-- Enhanced spell checking and autocmds
vim.cmd([[
  augroup SpellCheck
    autocmd!
    autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en_us
  augroup END
]])

-- Termux-specific welcome message
if vim.fn.has('termux') == 1 then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Only show welcome on empty startup
      if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
        vim.defer_fn(function()
          vim.notify(
            "🚀 Ultimate Termux Neovim Setup Loaded!\n" ..
            "Run :TermuxHealth to check system status\n" ..
            "Use <leader>? to see keybindings",
            vim.log.levels.INFO,
            { title = "Welcome to Ultimate Neovim!" }
          )
        end, 1000)
      end
    end,
  })
end

-- Auto-save when focus is lost (mobile-friendly)
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "silent! wa",
})

-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Better formatting for mobile
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Remove trailing whitespace
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Resize splits if window size changes
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
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
})

-- Emergency exit keybinding for mobile
vim.keymap.set("n", "<leader>QQ", "<cmd>qa!<cr>", { desc = "Emergency exit (force quit all)" })

-- Quick health check keybinding
vim.keymap.set("n", "<leader>hc", "<cmd>TermuxHealth<cr>", { desc = "Run Termux health check" })
