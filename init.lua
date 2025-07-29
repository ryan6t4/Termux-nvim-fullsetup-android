-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Android Termux detection and optimizations
local is_termux = vim.fn.isdirectory("/data/data/com.termux") == 1

if is_termux then
  -- Termux-specific environment setup
  vim.env.TERMUX = "1"
  
  -- Set proper shell for Termux
  vim.o.shell = "/data/data/com.termux/files/usr/bin/bash"
  
  -- Optimize for mobile screens
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Hide the tabline on mobile to save space
      vim.o.showtabline = 0
      
      -- Set smaller cmdheight for mobile
      vim.o.cmdheight = 1
      
      -- Reduce laststatus to save space on mobile
      vim.o.laststatus = 2
    end,
  })
end

-- Enhanced spell checking autocmd (moved from embedded to init.lua for global scope)
vim.cmd([[
  augroup EnhancedSpellCheck
    autocmd!
    autocmd FileType markdown,text,gitcommit,rst,latex setlocal spell spelllang=en_us
    autocmd FileType markdown,text,gitcommit,rst,latex setlocal wrap linebreak
    autocmd FileType help,man,qf,lspinfo setlocal nospell
  augroup END
]])

-- Global error handling
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    -- Display startup time on mobile (useful for performance monitoring)
    if is_termux then
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      vim.notify("Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms", vim.log.levels.INFO)
    end
  end,
})

-- Memory management for mobile devices
if is_termux then
  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    callback = function()
      -- Force garbage collection on buffer delete to manage memory
      if math.random() > 0.8 then -- Only 20% of the time to avoid performance impact
        collectgarbage("collect")
      end
    end,
  })
end

-- Enhanced error handling for mobile
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Override vim.notify for better mobile experience
    local original_notify = vim.notify
    vim.notify = function(msg, level, opts)
      opts = opts or {}
      
      -- Shorter timeout for mobile notifications
      if is_termux then
        opts.timeout = opts.timeout or 2000
      end
      
      -- Filter out noisy notifications on mobile
      if is_termux and type(msg) == "string" then
        local ignore_patterns = {
          "method textDocument/",
          "workspace/diagnostic",
          "method window/",
        }
        
        for _, pattern in ipairs(ignore_patterns) do
          if msg:match(pattern) then
            return
          end
        end
      end
      
      return original_notify(msg, level, opts)
    end
  end,
})
