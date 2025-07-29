-- Android Termux specific plugins and configurations
local is_termux = vim.fn.isdirectory("/data/data/com.termux") == 1

if not is_termux then
  return {}
end

return {
  -- Termux API integration
  {
    "termux/termux-api",
    lazy = true,
    cmd = { "TermuxShare", "TermuxClipboard", "TermuxNotification" },
    config = function()
      -- Custom commands for Termux API integration
      vim.api.nvim_create_user_command("TermuxShare", function(args)
        local content = args.args ~= "" and args.args or vim.fn.expand("%:p")
        vim.fn.system("termux-share " .. vim.fn.shellescape(content))
      end, { nargs = "?", desc = "Share file via Termux" })

      vim.api.nvim_create_user_command("TermuxClipboard", function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")
        vim.fn.system("echo " .. vim.fn.shellescape(content) .. " | termux-clipboard-set")
        vim.notify("Buffer copied to clipboard", vim.log.levels.INFO)
      end, { desc = "Copy buffer to Termux clipboard" })

      vim.api.nvim_create_user_command("TermuxNotification", function(args)
        local title = args.args ~= "" and args.args or "Neovim"
        vim.fn.system("termux-notification --title " .. vim.fn.shellescape(title))
      end, { nargs = "?", desc = "Send Termux notification" })
    end,
  },

  -- Mobile-optimized file manager
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    opts = {
      view = {
        width = 25, -- Narrower for mobile screens
        side = "left",
        adaptive_size = true,
      },
      renderer = {
        icons = {
          show = {
            file = false, -- Disable file icons for better performance
            folder = true,
            folder_arrow = true,
            git = false,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$", "node_modules", ".cache" },
      },
      git = {
        enable = false, -- Disable git integration for better performance
      },
      actions = {
        open_file = {
          quit_on_open = true, -- Close tree when opening file
        },
      },
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
  },

  -- Touch-friendly which-key settings
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 1, 2, 1, 2 },
        winblend = 10,
      },
      layout = {
        height = { min = 4, max = 8 }, -- Smaller height for mobile
        width = { min = 20, max = 50 },
        spacing = 3,
      },
      triggers_blacklist = {
        -- Disable which-key for some modes to improve performance
        i = { "j", "k" },
        v = { "j", "k" },
      },
    },
  },

  -- Mobile-optimized telescope settings
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical", -- Better for narrow screens
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.9,
            preview_height = 0.6,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.cache/",
          "%.android/",
          "%.gradle/",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- Remove whitespace for mobile
        },
      },
    },
  },

  -- Battery-friendly auto-save
  {
    "Pocco81/auto-save.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return ""  -- Silent save to reduce notifications
        end,
      },
      trigger_events = { "InsertLeave", "TextChanged" },
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        
        -- Don't auto-save certain file types
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "hgcommit", "gitcommit" }) then
          return true
        end
        return false
      end,
      debounce_delay = 1000, -- Wait 1 second before saving
    },
  },

  -- Improved session management for mobile
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}