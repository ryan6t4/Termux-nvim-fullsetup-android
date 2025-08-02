return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "lua_ls", -- Lua LSP
        "pyright", -- Python LSP
        "html", -- HTML
        "cssls", -- CSS
        "emmet_ls", -- Emmet
        "ts_ls", -- TypeScript/JS
        "jsonls", -- JSON
      })
    end,
  },
}
