-- Advanced Productivity Features - Beyond VS Code
return {
  -- Code Minimap
  {
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        active_in_terminals = false,
        auto_enable = true,
        exclude_filetypes = { "help", "NvimTree", "lazy", "mason" },
        max_minimap_height = nil,
        max_lines = nil,
        minimap_width = 20,
        use_lsp = true,
        use_treesitter = true,
        use_git = true,
        width_multiplier = 4,
        z_index = 1,
        show_cursor = true,
        screen_bounds = "lines",
        window_border = "single",
      })
      codewindow.apply_default_keybinds()
    end,
    keys = {
      { "<leader>mo", "<cmd>lua require('codewindow').open_minimap()<cr>", desc = "Open minimap" },
      { "<leader>mc", "<cmd>lua require('codewindow').close_minimap()<cr>", desc = "Close minimap" },
      { "<leader>mf", "<cmd>lua require('codewindow').toggle_focus()<cr>", desc = "Focus minimap" },
      { "<leader>mm", "<cmd>lua require('codewindow').toggle_minimap()<cr>", desc = "Toggle minimap" },
    },
  },

  -- Advanced Git Visualization
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
      })
    end,
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open git diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git file history" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    },
  },

  -- Interactive Git Graph
  {
    "isakbm/gitgraph.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      symbols = {
        merge_commit = "M",
        commit = "*",
        merge_commit_end = "M",
        commit_end = "*",
        GVER = "│",
        GHOR = "─",
        GCLD = "╮",
        GCRD = "╭",
        GCLU = "╯",
        GCRU = "╰",
        GLRU = "┴",
        GLRD = "┬",
        GLUD = "┤",
        GRUD = "├",
        GFORKU = "┼",
        GFORKD = "┼",
        GRUDCD = "├",
        GRUDCU = "├",
        GLUDCD = "┤",
        GLUDCU = "┤",
        GLRDCL = "┬",
        GLRDCR = "┬",
        GLRUCL = "┴",
        GLRUCR = "┴",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          vim.notify("selected commit " .. commit.hash)
        end,
        on_select_range_commit = function(from, to)
          vim.notify("selected range " .. from.hash .. " " .. to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gl",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },

  -- Multi-terminal Manager
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      
      -- Custom terminal functions
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Lazygit integration
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })
      
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
      
      -- Node.js REPL
      local node = Terminal:new({cmd = "node", hidden = true})
      function _NODE_TOGGLE()
        node:toggle()
      end
      
      -- Python REPL
      local python = Terminal:new({cmd = "python", hidden = true})
      function _PYTHON_TOGGLE()
        python:toggle()
      end
      
      -- Top/htop
      local htop = Terminal:new({cmd = "top", hidden = true})
      function _HTOP_TOGGLE()
        htop:toggle()
      end
    end,
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit" },
      { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", desc = "Node.js REPL" },
      { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", desc = "Python REPL" },
      { "<leader>th", "<cmd>lua _HTOP_TOGGLE()<CR>", desc = "System monitor" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
      { "<leader>ts", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
    },
  },

  -- Project Management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
        datapath = vim.fn.stdpath("data"),
      })
    end,
    keys = {
      { "<leader>pp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
  },

  -- Focus Mode
  {
    "folke/zen-mode.nvim",
    dependencies = {
      {
        "folke/twilight.nvim",
        config = function()
          require("twilight").setup({
            dimming = {
              alpha = 0.25,
              color = { "Normal", "#ffffff" },
              term_bg = "#000000",
              inactive = false,
            },
            context = 10,
            treesitter = true,
            expand = {
              "function",
              "method",
              "table",
              "if_statement",
            },
            exclude = {},
          })
        end,
      },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          kitty = {
            enabled = false,
            font = "+4",
          },
        },
      })
    end,
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
      { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
  },

  -- Pomodoro Timer
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      "rcarriga/nvim-notify",
    },
    config = function()
      require("pomo").setup({
        sessions = {
          pomodoro = {
            ["work"] = 25,
            ["short_break"] = 5,
            ["long_break"] = 15,
          },
        },
        notifiers = {
          {
            name = "Default",
            opts = {
              sticky = false,
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>pw", "<cmd>TimerStart 25m Work<cr>", desc = "Start work timer" },
      { "<leader>pb", "<cmd>TimerStart 5m Break<cr>", desc = "Start break timer" },
      { "<leader>pl", "<cmd>TimerStart 15m Long Break<cr>", desc = "Start long break timer" },
      { "<leader>ps", "<cmd>TimerStop<cr>", desc = "Stop timer" },
      { "<leader>pr", "<cmd>TimerRepeat<cr>", desc = "Repeat last timer" },
    },
  },

  -- Performance Profiler
  {
    "stevearc/profile.nvim",
    config = function()
      local should_profile = os.getenv("NVIM_PROFILE")
      if should_profile then
        require("profile").instrument_autocmds()
        if should_profile:lower():match("^start") then
          require("profile").start("*")
        else
          require("profile").instrument("*")
        end
      end

      local function toggle_profile()
        local prof = require("profile")
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format("Wrote %s", filename))
            end
          end)
        else
          prof.start("*")
        end
      end
      
      vim.keymap.set("", "<f1>", toggle_profile)
    end,
    keys = {
      { "<leader>pt", "<cmd>lua require('profile').toggle()<cr>", desc = "Toggle profiler" },
    },
  },

  -- Smart Indentation Detection
  {
    "tpope/vim-sleuth",
    event = "BufReadPre",
  },

  -- Enhanced Surround Operations
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Smart Commenting
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Context-aware commenting for JSX/TSX
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },

  -- Advanced Text Objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}