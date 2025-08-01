return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Python
        python = { "black", "isort" },
        -- JavaScript/TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- Web development
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        -- Lua
        lua = { "stylua" },
        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        -- Markdown and documentation
        markdown = { "prettier", "markdownlint" },
        -- YAML
        yaml = { "prettier" },
        yml = { "prettier" },
        -- XML
        xml = { "xmlformat" },
        -- Go
        go = { "gofmt", "goimports" },
        -- Rust
        rust = { "rustfmt" },
        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- Java
        java = { "google-java-format" },
        -- PHP
        php = { "php_cs_fixer" },
        -- SQL
        sql = { "sqlformat" },
        -- Dockerfile
        dockerfile = { "dockerlint" },
        -- TOML
        toml = { "taplo" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000, -- Increased timeout for better Termux compatibility
      },
      -- Add formatters configuration for better Android/Termux support
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" }, -- 2 space indentation, indent case statements
        },
        prettier = {
          prepend_args = { "--tab-width", "2", "--single-quote" },
        },
        black = {
          prepend_args = { "--line-length", "88" },
        },
        markdownlint = {
          args = { "--disable", "MD013", "--" }, -- Disable line length rule for mobile
        },
      },
    },
  },
}
