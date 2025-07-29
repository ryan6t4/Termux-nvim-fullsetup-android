return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        providers = { "lsp", "treesitter", "regex" },
        -- Don't illuminate these filetypes
        filetypes_denylist = {
          "help",
          "NvimTree",
          "lazy",
          "lspinfo",
          "mason",
          "terminal",
          "Trouble",
        },
      })

      -- Add highlight configuration for diagnostics
      vim.cmd([[
        hi DiagnosticUnderlineError gui=undercurl guisp=Red
        hi DiagnosticUnderlineWarn gui=undercurl guisp=Yellow
        hi DiagnosticUnderlineInfo gui=undercurl guisp=Blue
        hi DiagnosticUnderlineHint gui=undercurl guisp=Grey
      ]])
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference" },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },
}
