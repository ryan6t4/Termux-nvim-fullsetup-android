return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "lua_ls",     -- Lua LSP
        "pyright",    -- Python LSP
        "html",       -- HTML
        "cssls",      -- CSS
        "emmet_ls",   -- Emmet
        "tsserver",   -- TypeScript/JS
        "jsonls",     -- JSON
        "sqls",       -- SQL LSP for MariaDB/MySQL
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sqls = {
          settings = {
            sqls = {
              connections = {
                {
                  driver = "mysql",
                  dataSourceName = "root:root@tcp(127.0.0.1:3306)/",
                },
              },
            },
          },
        },
      },
    },
  },
}
