return {
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      require("rainbow-delimiters.setup")()
    end,
  },

  -- Git word diff

  -- Indent guides + context
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      char = "│",
      buftype_exclude = { "terminal", "help" },
    },
  },

  -- Scrollbar with marks
  {
    "petertriho/nvim-scrollbar",
    event = "BufRead",
    config = function()
      require("scrollbar").setup()
    end,
  },

  -- Enhanced search lens
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufRead",
    config = function()
      require("hlslens").setup()
      vim.cmd([[
        nnoremap <silent> n :execute('normal! ' . v:count1 . 'n')<CR>:lua require('hlslens').start()<CR>
        nnoremap <silent> N :execute('normal! ' . v:count1 . 'N')<CR>:lua require('hlslens').start()<CR>
      ]])
    end,
  },

  -- CSS colorizer
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- TODO comments with icons
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = { icon = " ", color = "error" },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning" },
          NOTE = { icon = " ", color = "hint" },
        },
      })
    end,
  },

  -- Yank highlight
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
    config = function()
      vim.g.highlightedyank_highlight_duration = 200
    end,
  },

  -- Highlight undercurl for diagnostics
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        providers = { "lsp", "treesitter", "regex" },
      })
      vim.cmd([[
        hi DiagnosticUnderlineError gui=undercurl guisp=Red
        hi DiagnosticUnderlineWarn gui=undercurl guisp=Yellow
        hi DiagnosticUnderlineInfo gui=undercurl guisp=Blue
        hi DiagnosticUnderlineHint gui=undercurl guisp=Grey
      ]])
    end,
  },
}
