-- VS Code-like plugins for enhanced development experience in Termux
return {
  -- File explorer with icons (VS Code-like sidebar)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- File icons
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },

  -- Enhanced file icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        sql = {
          icon = "",
          color = "#dad8d8",
          cterm_color = "188",
          name = "Sql"
        },
        mysql = {
          icon = "",
          color = "#00758f",
          cterm_color = "24",
          name = "MySQL"
        },
      },
    },
  },

  -- Integrated terminal (VS Code-like terminal panel)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },
    },
  },

  -- Better code folding (VS Code-like)
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    },
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Fold more" },
      { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
  },

  -- Rainbow bracket matching (VS Code-like)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      require("rainbow-delimiters.setup").setup()
    end,
  },

  -- Multi-cursor support (VS Code-like)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
    keys = {
      { "<C-d>", mode = {"n", "x"}, desc = "Multi-cursor find next" },
      { "<C-S-d>", mode = {"n", "x"}, desc = "Multi-cursor find all" },
    },
  },

  -- Enhanced Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = "Next git hunk"})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = "Previous git hunk"})

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, {desc = "Stage hunk"})
        map('n', '<leader>hr', gs.reset_hunk, {desc = "Reset hunk"})
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "Stage hunk"})
        map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "Reset hunk"})
        map('n', '<leader>hS', gs.stage_buffer, {desc = "Stage buffer"})
        map('n', '<leader>hu', gs.undo_stage_hunk, {desc = "Undo stage hunk"})
        map('n', '<leader>hR', gs.reset_buffer, {desc = "Reset buffer"})
        map('n', '<leader>hp', gs.preview_hunk, {desc = "Preview hunk"})
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = "Blame line"})
        map('n', '<leader>tb', gs.toggle_current_line_blame, {desc = "Toggle line blame"})
        map('n', '<leader>hd', gs.diffthis, {desc = "Diff this"})
        map('n', '<leader>hD', function() gs.diffthis('~') end, {desc = "Diff this ~"})
        map('n', '<leader>td', gs.toggle_deleted, {desc = "Toggle deleted"})
      end
    },
  },

  -- Git diff viewer
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git diff view" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Git diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git file history" },
    },
    opts = {
      enhanced_diff_hl = true,
    },
  },

  -- Snippet support enhancement
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -- Enhanced treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "sql",        -- SQL syntax highlighting
        "markdown",
        "markdown_inline",
        "bash",
        "dockerfile",
        "gitignore",
        "gitcommit",
        "diff",
      })
    end,
  },

  -- Workspace management
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      ignore_lsp = {},
      exclude_dirs = {},
      show_hidden = false,
      silent_chdir = true,
      scope_chdir = 'global',
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find projects" },
    },
  },

  -- Mini map (terminal compatible)
  {
    "gorbit99/codewindow.nvim",
    event = "BufReadPost",
    opts = {
      auto_enable = false,
      minimap_width = 20,
      width_multiplier = 4,
      use_lsp = true,
      use_treesitter = true,
      use_git = true,
    },
    keys = {
      { "<leader>mo", function() require("codewindow").open_minimap() end, desc = "Open minimap" },
      { "<leader>mc", function() require("codewindow").close_minimap() end, desc = "Close minimap" },
      { "<leader>mt", function() require("codewindow").toggle_minimap() end, desc = "Toggle minimap" },
    },
  },
}