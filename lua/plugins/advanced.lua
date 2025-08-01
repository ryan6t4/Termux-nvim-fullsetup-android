-- Project Templates and Advanced Workflow Automation
return {
  -- Project template generation
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemList" },
    config = function()
      require("template").setup({
        temp_dir = "~/.config/nvim/templates",
        author = "Termux Developer",
        email = "developer@termux.dev",
      })
    end,
  },

  -- Enhanced telescope for project management
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-dap.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git", "target", "build", "dist" },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-/>"] = actions.which_key,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          live_grep = {
            theme = "ivy",
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<A-c>"] = require("telescope._extensions.file_browser.actions").create,
                ["<S-CR>"] = require("telescope._extensions.file_browser.actions").create_from_prompt,
                ["<A-r>"] = require("telescope._extensions.file_browser.actions").rename,
                ["<A-m>"] = require("telescope._extensions.file_browser.actions").move,
                ["<A-y>"] = require("telescope._extensions.file_browser.actions").copy,
                ["<A-d>"] = require("telescope._extensions.file_browser.actions").remove,
                ["<C-o>"] = require("telescope._extensions.file_browser.actions").open,
                ["<C-g>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                ["<C-e>"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
                ["<C-w>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
                ["<C-t>"] = require("telescope._extensions.file_browser.actions").change_cwd,
                ["<C-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
                ["<C-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                ["<C-s>"] = require("telescope._extensions.file_browser.actions").toggle_all,
              },
              ["n"] = {
                ["c"] = require("telescope._extensions.file_browser.actions").create,
                ["r"] = require("telescope._extensions.file_browser.actions").rename,
                ["m"] = require("telescope._extensions.file_browser.actions").move,
                ["y"] = require("telescope._extensions.file_browser.actions").copy,
                ["d"] = require("telescope._extensions.file_browser.actions").remove,
                ["o"] = require("telescope._extensions.file_browser.actions").open,
                ["g"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                ["e"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
                ["w"] = require("telescope._extensions.file_browser.actions").goto_cwd,
                ["t"] = require("telescope._extensions.file_browser.actions").change_cwd,
                ["f"] = require("telescope._extensions.file_browser.actions").toggle_browser,
                ["h"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                ["s"] = require("telescope._extensions.file_browser.actions").toggle_all,
              },
            },
          },
        },
      })
      
      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("projects")
      telescope.load_extension("symbols")
    end,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fs", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
      { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
    },
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
        pre_save = nil,
      })
    end,
    keys = {
      { "<leader>qs", "<cmd>lua require('persistence').load()<cr>", desc = "Restore session" },
      { "<leader>ql", "<cmd>lua require('persistence').load({ last = true })<cr>", desc = "Restore last session" },
      { "<leader>qd", "<cmd>lua require('persistence').stop()<cr>", desc = "Don't save current session" },
    },
  },

  -- Voice commands placeholder (for future implementation)
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      -- Voice command setup will be implemented here
      -- This is a placeholder for voice recognition integration
      local function setup_voice_commands()
        if vim.fn.has('termux') == 1 then
          -- Future: Integrate with termux-speech-to-text
          vim.api.nvim_create_user_command("VoiceCommand", function()
            vim.notify("Voice commands coming soon! Use termux-speech-to-text API", vim.log.levels.INFO)
          end, { desc = "Activate voice commands" })
        end
      end
      
      setup_voice_commands()
      return opts
    end,
  },

  -- Enhanced debugging support
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Python debugger
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "python"
          end,
        },
      }
      
      -- Node.js debugger
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }
      dap.configurations.javascript = {
        {
          name = "Launch",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }
      dap.configurations.typescript = dap.configurations.javascript
      
      -- Go debugger
      dap.adapters.go = {
        type = "executable",
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:38697" },
      }
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
      }
      
      -- Setup UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        expand_lines = vim.fn.has("nvim-0.7"),
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
        },
      })
      
      -- Virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })
      
      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step into" },
      { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step over" },
      { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step out" },
      { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle REPL" },
      { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run last" },
      { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
      { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" },
    },
  },

  -- Test runner integration
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
          }),
          require("neotest-go"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-rust"),
        },
        discovery = {
          enabled = true,
          concurrent = 1,
        },
        diagnostic = {
          enabled = true,
          severity = 1,
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },
        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          marked = "NeotestMarked",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          select_win = "NeotestWinSelect",
          skipped = "NeotestSkipped",
          target = "NeotestTarget",
          test = "NeotestTest",
          unknown = "NeotestUnknown",
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✖",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✓",
          running = "",
          running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
          skipped = "○",
          unknown = "?",
        },
        output = {
          enabled = true,
          open_on_run = "short",
        },
        run = {
          enabled = true,
        },
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
        strategies = {
          integrated = {
            height = 40,
            width = 120,
          },
        },
        summary = {
          animated = true,
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t",
            watch = "w",
          },
        },
      })
    end,
    keys = {
      { "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run nearest test" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run current file" },
      { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle test summary" },
      { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Open test output" },
      { "<leader>tO", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle output panel" },
      { "<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop tests" },
      { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug nearest test" },
    },
  },

  -- Markdown preview for documentation
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "「${name}」"
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop markdown preview" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
    },
  },
}