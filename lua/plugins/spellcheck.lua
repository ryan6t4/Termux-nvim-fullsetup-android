return {
  -- Enhanced spell checking with spellsitter
  {
    "lewis6991/spellsitter.nvim",
    event = "VeryLazy",
    config = function()
      require("spellsitter").setup({
        -- Enable spell checking for these languages
        enable = true,
        debug = false,
        
        -- Captures to spell check
        captures = {
          "comment",
          "string",
          "text",
        },
        
        -- Additional spell checking for specific contexts
        extra_captures = {
          markdown = { "text" },
          gitcommit = { "text" },
          rst = { "text" },
          latex = { "text" },
        },
      })
    end,
  },

  -- Additional spell checking enhancements
  {
    "f3fora/cmp-spell",
    ft = { "markdown", "text", "gitcommit" },
    config = function()
      -- Add spell source to nvim-cmp for spell checking suggestions
      local cmp = require("cmp")
      local config = cmp.get_config()
      
      table.insert(config.sources, {
        name = "spell",
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return require("cmp.config.context").in_treesitter_capture("spell")
          end,
        },
      })
      
      cmp.setup(config)
    end,
  },

  -- Spell toggle command
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require("which-key")
      wk.register({
        ["<leader>s"] = {
          name = "Spell",
          s = { "<cmd>set spell!<cr>", "Toggle Spell Check" },
          n = { "]s", "Next Misspelled Word" },
          p = { "[s", "Previous Misspelled Word" },
          a = { "zg", "Add Word to Dictionary" },
          r = { "zw", "Remove Word from Dictionary" },
          f = { "z=", "Fix Spelling" },
          c = { function()
            local word = vim.fn.expand("<cword>")
            local suggestions = vim.fn.spellsuggest(word, 5)
            if #suggestions > 0 then
              vim.fn.feedkeys("ciw" .. suggestions[1] .. "<Esc>")
            else
              vim.notify("No suggestions found for: " .. word, vim.log.levels.WARN)
            end
          end, "Quick Fix Spelling" },
        },
      }, { prefix = "<leader>" })
      return opts
    end,
  },
}
