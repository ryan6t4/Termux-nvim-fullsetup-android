return {
  -- Enhanced Codeium AI code completion
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    build = ":Codeium Auth",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        -- Enable/disable codeium
        enable_chat = true,
        
        -- API configuration
        api = {
          host = "server.codeium.com",
          port = "443",
        },
        
        -- Enterprise mode (set to true if using Codeium Enterprise)
        enterprise_mode = false,
        
        -- Tools configuration
        tools = {
          curl = "curl",
          gzip = "gzip",
          uname = "uname",
          uuidgen = "uuidgen",
        },
        
        -- Wrapper configuration
        wrapper = {
          path = vim.fn.stdpath("data") .. "/codeium/bin",
          api_url = "https://server.codeium.com",
        },
      })

      -- Enhanced keymaps for Codeium
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, desc = "Accept Codeium suggestion" })

      vim.keymap.set("i", "<C-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, desc = "Next Codeium suggestion" })

      vim.keymap.set("i", "<C-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, desc = "Previous Codeium suggestion" })

      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, desc = "Clear Codeium suggestion" })

      -- Command to toggle Codeium
      vim.api.nvim_create_user_command("CodeiumToggle", function()
        if vim.g.codeium_enabled == false then
          vim.g.codeium_enabled = true
          vim.notify("Codeium enabled", vim.log.levels.INFO)
        else
          vim.g.codeium_enabled = false
          vim.notify("Codeium disabled", vim.log.levels.INFO)
        end
      end, { desc = "Toggle Codeium" })

      -- Disable Codeium for certain file types (for privacy/security)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "env", "dotenv", "ssh_config", "gpg" },
        callback = function()
          vim.b.codeium_enabled = false
        end,
      })
    end,
  },

  -- Codeium chat integration
  {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    config = function()
      -- Codeium chat keymaps
      vim.keymap.set("n", "<leader>cc", ":CodeiumChat<CR>", { desc = "Open Codeium Chat" })
      vim.keymap.set("v", "<leader>ce", ":CodeiumExplain<CR>", { desc = "Explain code with Codeium" })
      vim.keymap.set("v", "<leader>cr", ":CodeiumRefactor<CR>", { desc = "Refactor code with Codeium" })
      vim.keymap.set("n", "<leader>cd", ":CodeiumDoc<CR>", { desc = "Generate documentation with Codeium" })
    end,
  },

  -- Integration with nvim-cmp for better completion experience
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      
      -- Add codeium source to completion sources
      table.insert(opts.sources, 1, {
        name = "codeium",
        priority = 1100,
        max_item_count = 3, -- Limit Codeium suggestions for mobile performance
      })

      -- Custom formatting for Codeium suggestions
      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(entry, vim_item)
        local icons = {
          codeium = "🤖",
          nvim_lsp = "🔧",
          buffer = "📝",
          path = "📁",
        }
        
        vim_item.kind = string.format("%s %s", icons[entry.source.name] or "📄", vim_item.kind)
        vim_item.menu = ({
          codeium = "[AI]",
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name] or "[?]"
        
        return vim_item
      end

      return opts
    end,
  },

  -- AI-powered code actions
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require("which-key")
      wk.register({
        ["<leader>c"] = {
          name = "Code/Codeium",
          c = { "<cmd>CodeiumChat<cr>", "Open Codeium Chat" },
          t = { "<cmd>CodeiumToggle<cr>", "Toggle Codeium" },
          d = { "<cmd>CodeiumDoc<cr>", "Generate Documentation" },
        },
      }, { prefix = "<leader>" })
      
      -- Visual mode mappings
      wk.register({
        ["<leader>c"] = {
          name = "Code/Codeium",
          e = { ":CodeiumExplain<cr>", "Explain Code" },
          r = { ":CodeiumRefactor<cr>", "Refactor Code" },
        },
      }, { mode = "v", prefix = "<leader>" })
      
      return opts
    end,
  },
}
