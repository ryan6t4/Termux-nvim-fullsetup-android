return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        -- Core language servers
        "lua_ls",         -- Lua LSP
        "pyright",        -- Python LSP
        "tsserver",       -- TypeScript/JavaScript
        "jsonls",         -- JSON
        
        -- Web development
        "html",           -- HTML
        "cssls",          -- CSS
        "emmet_ls",       -- Emmet for HTML/CSS
        "tailwindcss",    -- Tailwind CSS
        
        -- Systems programming
        "clangd",         -- C/C++
        "rust_analyzer",  -- Rust
        "gopls",          -- Go
        
        -- Shell scripting (important for Termux)
        "bashls",         -- Bash
        
        -- Configuration and markup
        "yamlls",         -- YAML
        "taplo",          -- TOML
        "marksman",       -- Markdown
        
        -- Java (Android development)
        "jdtls",          -- Java
        
        -- Documentation
        "lemminx",        -- XML
        
        -- Docker (containerization)
        "dockerls",       -- Dockerfile
        
        -- Database
        "sqlls",          -- SQL
      })
    end,
  },
  
  -- Enhanced LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- LSP Server Settings
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
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
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
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
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
        emmet_ls = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascript",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "svelte",
            "pug",
            "typescriptreact",
            "vue",
          },
        },
      },
      -- Global capabilities
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
  },

  -- JSON Schema support
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
}
