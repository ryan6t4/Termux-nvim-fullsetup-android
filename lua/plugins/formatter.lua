return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        sql = { "sqlfmt" },
        mysql = { "sqlfmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    },
  },
}
