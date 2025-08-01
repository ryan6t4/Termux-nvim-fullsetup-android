-- Code Quality, Security, and Advanced Diagnostics
return {
  -- Comprehensive linting and formatting
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      
      null_ls.setup({
        sources = {
          -- Formatting
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars" },
          }),
          null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.golines,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.phpcsfixer,
          null_ls.builtins.formatting.rubocop,
          
          -- Linting
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.phpcs,
          null_ls.builtins.diagnostics.rubocop,
          
          -- Code actions
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.code_actions.refactoring,
          
          -- Security scanning
          null_ls.builtins.diagnostics.semgrep.with({
            args = { "--config", "auto", "--json", "$FILENAME" },
          }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  filter = function(client)
                    return client.name == "null-ls"
                  end,
                })
              end,
            })
          end
        end,
      })
    end,
  },

  -- Advanced treesitter for better syntax highlighting and analysis
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Core languages
          "lua", "vim", "vimdoc", "query",
          "python", "javascript", "typescript", "html", "css", "json", "yaml",
          
          -- Systems programming
          "c", "cpp", "rust", "go", "zig",
          
          -- Web development
          "tsx", "jsx", "vue", "svelte", "scss", "astro",
          
          -- Backend languages
          "java", "csharp", "php", "ruby", "elixir",
          
          -- Mobile development
          "dart", "kotlin", "swift", "objective-c",
          
          -- Data and config
          "sql", "r", "julia", "dockerfile", "terraform", "hcl",
          
          -- Markup and documentation
          "markdown", "markdown_inline", "latex", "rst",
          
          -- Shell and tools
          "bash", "fish", "powershell", "regex",
          
          -- Functional languages
          "haskell", "ocaml", "scheme", "clojure",
          
          -- Other useful languages
          "toml", "xml", "graphql", "prisma", "proto",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        
        indent = {
          enable = true,
          disable = { "python", "yaml" },
        },
        
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
          filetypes = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
        },
        
        endwise = {
          enable = true,
        },
        
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
      
      -- Setup treesitter context
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },

  -- Code complexity analysis
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_enabled = 1
      vim.g.ale_fix_on_save = 1
      vim.g.ale_lint_on_text_changed = "normal"
      vim.g.ale_lint_on_insert_leave = 1
      vim.g.ale_sign_error = "✗"
      vim.g.ale_sign_warning = "⚠"
      vim.g.ale_sign_info = "ℹ"
      vim.g.ale_sign_style_error = "✗"
      vim.g.ale_sign_style_warning = "⚠"
      
      -- Linters configuration
      vim.g.ale_linters = {
        python = { "flake8", "mypy", "pylint", "bandit" },
        javascript = { "eslint", "jshint" },
        typescript = { "eslint", "tslint" },
        go = { "golangci-lint", "gosec" },
        rust = { "cargo", "clippy" },
        c = { "clangtidy", "cppcheck" },
        cpp = { "clangtidy", "cppcheck" },
        lua = { "luacheck" },
        sh = { "shellcheck" },
        dockerfile = { "hadolint" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
        php = { "phpcs", "phpstan" },
        ruby = { "rubocop", "brakeman" },
      }
      
      -- Fixers configuration
      vim.g.ale_fixers = {
        ["*"] = { "remove_trailing_lines", "trim_whitespace" },
        python = { "black", "isort", "autopep8" },
        javascript = { "prettier", "eslint" },
        typescript = { "prettier", "eslint" },
        go = { "gofmt", "goimports" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        sh = { "shfmt" },
        json = { "prettier" },
        yaml = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        php = { "phpcbf" },
        ruby = { "rubocop" },
      }
    end,
    keys = {
      { "<leader>af", "<cmd>ALEFix<cr>", desc = "Fix with ALE" },
      { "<leader>al", "<cmd>ALELint<cr>", desc = "Lint with ALE" },
      { "<leader>ai", "<cmd>ALEInfo<cr>", desc = "ALE info" },
      { "<leader>ad", "<cmd>ALEDetail<cr>", desc = "ALE detail" },
      { "[e", "<cmd>ALEPrevious<cr>", desc = "Previous ALE error" },
      { "]e", "<cmd>ALENext<cr>", desc = "Next ALE error" },
    },
  },

  -- Security vulnerability scanning
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({
        debug = false,
        disable_commands = false,
        enable_import_on_completion = true,
        import_all_timeout = 5000,
        import_all_priorities = {
          same_file = 1,
          local_files = 2,
          buffer_content = 3,
          buffers = 4,
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,
        auto_inlay_hints = true,
        inlay_hints_highlight = "Comment",
        inlay_hints_priority = 200,
        inlay_hints_throttle = 150,
        inlay_hints_format = {
          Type = {},
          Parameter = {},
          Enum = {},
        },
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},
      })
    end,
  },

  -- Dependency vulnerability checking
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        src = {
          cmp = {
            enabled = true,
          },
        },
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          autofocus = true,
          hide_on_select = true,
          copy_register = '"',
          style = "minimal",
          border = "rounded",
          show_version_date = false,
          show_dependency_version = true,
          max_height = 30,
          min_width = 20,
          padding = 1,
        },
        disable_invalid_feature_diagnostic = false,
        text = {
          loading = "   Loading",
          version = "   %s",
          prerelease = "   %s",
          yanked = "   %s",
          nomatch = "   No match",
          upgrade = "   %s",
          error = "   Error fetching crate",
        },
        highlight = {
          loading = "CratesNvimLoading",
          version = "CratesNvimVersion",
          prerelease = "CratesNvimPreRelease",
          yanked = "CratesNvimYanked",
          nomatch = "CratesNvimNoMatch",
          upgrade = "CratesNvimUpgrade",
          error = "CratesNvimError",
        },
      })
    end,
    keys = {
      { "<leader>ct", "<cmd>lua require('crates').toggle()<cr>", desc = "Toggle crates" },
      { "<leader>cr", "<cmd>lua require('crates').reload()<cr>", desc = "Reload crates" },
      { "<leader>cv", "<cmd>lua require('crates').show_versions_popup()<cr>", desc = "Show versions" },
      { "<leader>cf", "<cmd>lua require('crates').show_features_popup()<cr>", desc = "Show features" },
      { "<leader>cd", "<cmd>lua require('crates').show_dependencies_popup()<cr>", desc = "Show dependencies" },
      { "<leader>cu", "<cmd>lua require('crates').update_crate()<cr>", desc = "Update crate" },
      { "<leader>ca", "<cmd>lua require('crates').update_all_crates()<cr>", desc = "Update all crates" },
      { "<leader>cU", "<cmd>lua require('crates').upgrade_crate()<cr>", desc = "Upgrade crate" },
      { "<leader>cA", "<cmd>lua require('crates').upgrade_all_crates()<cr>", desc = "Upgrade all crates" },
    },
  },

  -- Package.json dependency management
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    event = { "BufRead package.json" },
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#d19a66",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm",
      })
    end,
    keys = {
      { "<leader>ns", "<cmd>lua require('package-info').show()<cr>", desc = "Show package info" },
      { "<leader>nc", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package info" },
      { "<leader>nt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle package info" },
      { "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
      { "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
      { "<leader>np", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change package version" },
    },
  },

  -- Code metrics and complexity analysis
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre",
    config = function()
      require("symbol-usage").setup({
        kinds = { "Function", "Method", "Constructor" },
        kinds_filter = {},
        symbol_request_pos = "end",
        references = {
          enabled = true,
          include_declaration = false,
        },
        definition = {
          enabled = false,
        },
        implementation = {
          enabled = false,
        },
        disable = {
          lsp = {},
          filetypes = {},
          cond = {},
        },
        filetypes = {},
        symbol_request_timeout = 2000,
        text_format = function(symbol)
          local res = {}
          
          local round_start = { "", "SymbolUsageRounding" }
          local round_end = { "", "SymbolUsageRounding" }
          
          if symbol.references then
            local usage = symbol.references <= 1 and "usage" or "usages"
            local num = symbol.references == 0 and "no" or symbol.references
            table.insert(res, round_start)
            table.insert(res, { "󰌹 ", "SymbolUsageRef" })
            table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
            table.insert(res, round_end)
          end
          
          return res
        end,
      })
    end,
  },

  -- Memory usage and performance monitoring
  {
    "dstein64/nvim-scrollview",
    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "nerdtree", "neo-tree", "lazy", "mason" },
        current_only = true,
        winblend = 75,
        base = "buffer",
        column = 1,
        signs_on_startup = { "all" },
        diagnostics_severities = { vim.diagnostic.severity.ERROR },
      })
    end,
  },

  -- Advanced diagnostics viewer
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j"
        },
        indent_lines = true,
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        },
        use_diagnostic_signs = false
      })
    end,
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document diagnostics" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location list" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix list" },
      { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP references" },
    },
  },

  -- Git blame and history analysis
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true
        },
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1
        },
        yadm = {
          enable = false
        },
      })
    end,
    keys = {
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
      { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
      { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset buffer" },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>hb", "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", desc = "Blame line" },
      { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
      { "<leader>hd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" },
      { "<leader>hD", "<cmd>lua require'gitsigns'.diffthis('~')<cr>", desc = "Diff this ~" },
      { "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle deleted" },
      { "[c", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk" },
      { "]c", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
    },
  },
}