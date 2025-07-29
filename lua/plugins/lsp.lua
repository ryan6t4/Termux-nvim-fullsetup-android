return {
  -- Enhanced Mason LSP configuration
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "lua_ls",          -- Lua LSP
        "pyright",         -- Python LSP
        "html",            -- HTML
        "cssls",           -- CSS  
        "emmet_ls",        -- Emmet
        "tsserver",        -- TypeScript/JS
        "jsonls",          -- JSON
        "bashls",          -- Bash
        "marksman",        -- Markdown
        "yamlls",          -- YAML
        "vimls",           -- Vim
      })
    end,
  },

  -- Enhanced LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Global LSP settings
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      -- Inlay hints
      inlay_hints = {
        enabled = true,
      },
      -- Capabilities
      capabilities = {},
      -- Format settings
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- Server configurations
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
              hint = {
                enable = true,
                arrayIndex = "Disable",
              },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
              },
            },
          },
        },
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {
          settings = {
            html = {
              format = {
                templating = true,
                wrapLineLength = 120,
                wrapAttributes = "auto",
              },
              hover = {
                documentation = true,
                references = true,
              },
            },
          },
        },
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        marksman = {
          settings = {
            marksman = {
              formatting = {
                enabled = true,
              },
            },
          },
        },
        bashls = {
          settings = {
            bashIde = {
              globPattern = "*@(.sh|.inc|.bash|.command)",
            },
          },
        },
      },
    },
  },

  -- Enhanced null-ls for formatting and linting
  {
    "nvimtools/none-ls.nvim",
    event = "LazyFile",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- Formatters
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettier.with({
            extra_filetypes = { "svelte" },
          }),
          nls.builtins.formatting.black.with({
            extra_args = { "--fast" },
          }),
          
          -- Linters
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.flake8.with({
            extra_args = { "--max-line-length=88", "--extend-ignore=E203" },
          }),
          
          -- Code actions
          nls.builtins.code_actions.shellcheck,
          nls.builtins.code_actions.gitsigns,
        },
      }
    end,
  },

  -- Schema store for JSON/YAML
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Enhanced Mason tool installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",
        "shfmt", 
        "prettier",
        "black",
        
        -- Linters
        "shellcheck",
        "flake8",
        "markdownlint",
        
        -- DAP
        "debugpy",
        "node-debug2-adapter",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    },
  },
}
