-- Performance optimizations for mobile devices and low-resource environments
return {
  -- Faster startup with impatient
  {
    "lewis6991/impatient.nvim",
    priority = 1000,
    config = function()
      require("impatient")
    end,
  },

  -- Optimize treesitter for mobile
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- Disable vim regex highlighting
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      incremental_selection = {
        enable = false, -- Disable for performance
      },
      textobjects = {
        enable = false, -- Disable for performance
      },
      playground = {
        enable = false, -- Disable playground
      },
      query_linter = {
        enable = false, -- Disable query linter
      },
    },
  },

  -- Optimize LSP for mobile performance
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Reduce LSP update time for better battery life
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          update_in_insert = false, -- Don't update diagnostics in insert mode
          severity_sort = true,
          virtual_text = {
            spacing = 2,
            prefix = "●",
          },
        }
      )

      -- Optimize hover and signature help
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 60, -- Limit width for mobile screens
        max_height = 20,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        max_width = 60,
        max_height = 10,
      })

      return opts
    end,
  },

  -- Reduce CMP sources for better performance
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      
      -- Reduce completion sources for mobile
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "buffer", priority = 500, max_item_count = 5 },
        { name = "path", priority = 300, max_item_count = 3 },
      })

      -- Optimize performance settings
      opts.performance = {
        debounce = 150, -- Increase debounce for mobile
        throttle = 60,
        fetching_timeout = 200, -- Reduce timeout
        max_view_entries = 20, -- Limit entries
      }

      -- Reduce completion menu size for mobile
      opts.window = {
        completion = cmp.config.window.bordered({
          max_height = 10,
          max_width = 50,
        }),
        documentation = cmp.config.window.bordered({
          max_height = 8,
          max_width = 40,
        }),
      }

      return opts
    end,
  },

  -- Optimize git signs for mobile
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      update_debounce = 200, -- Increase debounce
      max_file_length = 10000, -- Don't process very large files
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      current_line_blame_opts = {
        delay = 500, -- Increase delay for battery life
      },
    },
  },

  -- Optimize indent-blankline for mobile
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = false, -- Disable for performance
      show_current_context_start = false,
      max_indent_increase = 1,
      viewport_buffer = {
        min = 30,
        max = 100, -- Reduce max for mobile
      },
    },
  },

  -- Lightweight status line for mobile
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        refresh = {
          statusline = 2000, -- Refresh less frequently
          tabline = 2000,
          winbar = 2000,
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },

  -- Optimize bufferline for mobile
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        max_name_length = 20, -- Shorter names for mobile
        max_prefix_length = 10,
        tab_size = 15,
        show_buffer_icons = false, -- Disable icons for performance
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = true,
        diagnostics = false, -- Disable diagnostics in bufferline
      },
    },
  },

  -- Disable animations for better performance
  {
    "echasnovski/mini.animate",
    enabled = false,
  },

  -- Optimize file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        scan_mode = "shallow", -- Don't deep scan for performance
        use_libuv_file_watcher = false, -- Disable file watcher for battery
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          never_show = {
            ".DS_Store",
            "thumbs.db",
            "node_modules",
            ".git",
            ".cache",
          },
        },
      },
      buffers = {
        leave_dirs_open = false, -- Close dirs to save memory
      },
      git_status = {
        window = {
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },
    },
  },

  -- Optimize dashboard for faster startup
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      -- Simplify dashboard for mobile
      dashboard.section.header.val = {
        "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██║   ██║██║████╗ ████║",
        "██╔██╗ ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      }
      
      -- Reduce number of buttons for mobile
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      
      return dashboard
    end,
  },
}