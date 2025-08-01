return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        -- Core Languages
        "lua_ls",           -- Lua LSP
        "pyright",          -- Python LSP
        "tsserver",         -- TypeScript/JavaScript
        "html",             -- HTML
        "cssls",            -- CSS
        "jsonls",           -- JSON
        "yamlls",           -- YAML
        
        -- Systems Programming
        "clangd",           -- C/C++
        "rust_analyzer",    -- Rust
        "gopls",            -- Go
        "zls",              -- Zig
        
        -- Web Development
        "emmet_ls",         -- Emmet for HTML/CSS
        "tailwindcss",      -- Tailwind CSS
        "svelte",           -- Svelte
        "vuels",            -- Vue.js
        "angular",          -- Angular
        
        -- Backend Frameworks
        "jdtls",            -- Java
        "omnisharp",        -- C#/.NET
        "intelephense",     -- PHP
        "solargraph",       -- Ruby
        
        -- Mobile Development
        "dartls",           -- Dart/Flutter
        "kotlin_language_server", -- Kotlin
        "sourcekit",        -- Swift
        
        -- Data & Config
        "sqlls",            -- SQL
        "r_language_server", -- R
        "julials",          -- Julia
        "dockerls",         -- Docker
        "terraform_lsp",    -- Terraform
        "ansiblels",        -- Ansible
        
        -- Markup & Documentation
        "marksman",         -- Markdown
        "ltex",             -- LaTeX/Writing
        "grammarly",        -- Grammar checking
        
        -- Emerging Languages
        "hls",              -- Haskell
        "elixirls",         -- Elixir
        "rnix",             -- Nix
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
      
      -- Auto-format on save for supported languages
      autoformat = true,
      
      -- Language server specific settings
      servers = {
        -- Python enhanced settings
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
        
        -- TypeScript enhanced settings
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
        
        -- Rust enhanced settings
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  leptos_macro = {
                    "component",
                    "server",
                  },
                },
              },
            },
          },
        },
        
        -- Go enhanced settings
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            },
          },
        },
        
        -- C++ enhanced settings
        clangd = {
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
        },
        
        -- Lua enhanced settings
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              telemetry = { enable = false },
              hint = {
                enable = true,
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
    },
  },
}
