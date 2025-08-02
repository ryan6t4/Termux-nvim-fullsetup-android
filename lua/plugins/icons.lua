-- Icon support and theming for Termux Neovim setup
-- Integrates comprehensive icon system with LazyVim plugins

return {
  -- Enhanced mini.icons configuration for better Termux support
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = function()
      local icons = require("config.icons")
      
      return {
        -- File icons with Termux fallbacks
        file = {
          [".gitignore"] = { glyph = icons.get_icon("filetype", ".gitignore"), hl = "MiniIconsGrey" },
          [".gitconfig"] = { glyph = icons.get_icon("filetype", ".gitconfig"), hl = "MiniIconsRed" },
          ["dockerfile"] = { glyph = icons.get_icon("filetype", "dockerfile"), hl = "MiniIconsBlue" },
          ["makefile"] = { glyph = icons.get_icon("filetype", "makefile"), hl = "MiniIconsGrey" },
          ["readme.md"] = { glyph = icons.get_icon("filetype", "readme.md"), hl = "MiniIconsYellow" },
        },
        
        -- Extension icons
        extension = {
          lua = { glyph = icons.get_icon("filetype", "lua"), hl = "MiniIconsBlue" },
          py = { glyph = icons.get_icon("filetype", "python"), hl = "MiniIconsYellow" },
          js = { glyph = icons.get_icon("filetype", "javascript"), hl = "MiniIconsYellow" },
          ts = { glyph = icons.get_icon("filetype", "typescript"), hl = "MiniIconsBlue" },
          rs = { glyph = icons.get_icon("filetype", "rust"), hl = "MiniIconsRed" },
          go = { glyph = icons.get_icon("filetype", "go"), hl = "MiniIconsCyan" },
          java = { glyph = icons.get_icon("filetype", "java"), hl = "MiniIconsRed" },
          c = { glyph = icons.get_icon("filetype", "c"), hl = "MiniIconsBlue" },
          cpp = { glyph = icons.get_icon("filetype", "cpp"), hl = "MiniIconsBlue" },
          html = { glyph = icons.get_icon("filetype", "html"), hl = "MiniIconsRed" },
          css = { glyph = icons.get_icon("filetype", "css"), hl = "MiniIconsBlue" },
          scss = { glyph = icons.get_icon("filetype", "scss"), hl = "MiniIconsPurple" },
          json = { glyph = icons.get_icon("filetype", "json"), hl = "MiniIconsYellow" },
          yaml = { glyph = icons.get_icon("filetype", "yaml"), hl = "MiniIconsGrey" },
          yml = { glyph = icons.get_icon("filetype", "yaml"), hl = "MiniIconsGrey" },
          toml = { glyph = icons.get_icon("filetype", "toml"), hl = "MiniIconsGrey" },
          xml = { glyph = icons.get_icon("filetype", "xml"), hl = "MiniIconsGreen" },
          sql = { glyph = icons.get_icon("filetype", "sql"), hl = "MiniIconsBlue" },
          sh = { glyph = icons.get_icon("filetype", "bash"), hl = "MiniIconsGreen" },
          bash = { glyph = icons.get_icon("filetype", "bash"), hl = "MiniIconsGreen" },
          zsh = { glyph = icons.get_icon("filetype", "zsh"), hl = "MiniIconsGreen" },
          fish = { glyph = icons.get_icon("filetype", "fish"), hl = "MiniIconsGreen" },
          vim = { glyph = icons.get_icon("filetype", "vim"), hl = "MiniIconsGreen" },
        },
        
        -- Directory icons
        directory = {
          [""] = { glyph = icons.get_icon("filetype", "folder"), hl = "MiniIconsBlue" },
        },
        
        -- Filetype icons
        filetype = {
          lua = { glyph = icons.get_icon("filetype", "lua"), hl = "MiniIconsBlue" },
          python = { glyph = icons.get_icon("filetype", "python"), hl = "MiniIconsYellow" },
          javascript = { glyph = icons.get_icon("filetype", "javascript"), hl = "MiniIconsYellow" },
          typescript = { glyph = icons.get_icon("filetype", "typescript"), hl = "MiniIconsBlue" },
        },
        
        -- LSP kind icons for completion
        lsp = {
          array = { glyph = icons.get_icon("kind", "Field"), hl = "MiniIconsOrange" },
          boolean = { glyph = icons.get_icon("kind", "Value"), hl = "MiniIconsOrange" },
          class = { glyph = icons.get_icon("kind", "Class"), hl = "MiniIconsYellow" },
          color = { glyph = icons.get_icon("kind", "Color"), hl = "MiniIconsRed" },
          constant = { glyph = icons.get_icon("kind", "Constant"), hl = "MiniIconsOrange" },
          constructor = { glyph = icons.get_icon("kind", "Constructor"), hl = "MiniIconsBlue" },
          enum = { glyph = icons.get_icon("kind", "Enum"), hl = "MiniIconsYellow" },
          enummember = { glyph = icons.get_icon("kind", "EnumMember"), hl = "MiniIconsYellow" },
          event = { glyph = icons.get_icon("kind", "Event"), hl = "MiniIconsRed" },
          field = { glyph = icons.get_icon("kind", "Field"), hl = "MiniIconsRed" },
          file = { glyph = icons.get_icon("kind", "File"), hl = "MiniIconsBlue" },
          folder = { glyph = icons.get_icon("kind", "Folder"), hl = "MiniIconsBlue" },
          ["function"] = { glyph = icons.get_icon("kind", "Function"), hl = "MiniIconsPurple" },
          interface = { glyph = icons.get_icon("kind", "Interface"), hl = "MiniIconsYellow" },
          keyword = { glyph = icons.get_icon("kind", "Keyword"), hl = "MiniIconsCyan" },
          method = { glyph = icons.get_icon("kind", "Method"), hl = "MiniIconsPurple" },
          module = { glyph = icons.get_icon("kind", "Module"), hl = "MiniIconsBlue" },
          operator = { glyph = icons.get_icon("kind", "Operator"), hl = "MiniIconsCyan" },
          property = { glyph = icons.get_icon("kind", "Property"), hl = "MiniIconsRed" },
          reference = { glyph = icons.get_icon("kind", "Reference"), hl = "MiniIconsRed" },
          snippet = { glyph = icons.get_icon("kind", "Snippet"), hl = "MiniIconsGreen" },
          struct = { glyph = icons.get_icon("kind", "Struct"), hl = "MiniIconsYellow" },
          text = { glyph = icons.get_icon("kind", "Text"), hl = "MiniIconsGreen" },
          typeparameter = { glyph = icons.get_icon("kind", "TypeParameter"), hl = "MiniIconsYellow" },
          unit = { glyph = icons.get_icon("kind", "Unit"), hl = "MiniIconsOrange" },
          value = { glyph = icons.get_icon("kind", "Value"), hl = "MiniIconsOrange" },
          variable = { glyph = icons.get_icon("kind", "Variable"), hl = "MiniIconsBlue" },
        },
      }
    end,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- Enhanced Lualine with Termux-optimized icons
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      -- Termux-specific adjustments
      if icons.is_termux() then
        opts.options = opts.options or {}
        opts.options.component_separators = icons.use_icons and { left = "", right = "" } or { left = "|", right = "|" }
        opts.options.section_separators = icons.use_icons and { left = "", right = "" } or { left = "", right = "" }
      end
      
      -- Add diagnostic icons
      if opts.sections and opts.sections.lualine_c then
        table.insert(opts.sections.lualine_c, {
          "diagnostics",
          symbols = {
            error = icons.get_icon("diagnostic", "error") .. " ",
            warn = icons.get_icon("diagnostic", "warn") .. " ",
            info = icons.get_icon("diagnostic", "info") .. " ",
            hint = icons.get_icon("diagnostic", "hint") .. " ",
          },
        })
      end
      
      -- Add git branch with icon
      if opts.sections and opts.sections.lualine_b then
        table.insert(opts.sections.lualine_b, {
          "branch",
          icon = icons.get_icon("git", "branch"),
        })
      end
      
      return opts
    end,
  },

  -- Enhanced Git signs with custom icons
  {
    "lewis6991/gitsigns.nvim",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      opts.signs = {
        add = { text = icons.get_icon("git", "added") },
        change = { text = icons.get_icon("git", "modified") },
        delete = { text = icons.get_icon("git", "removed") },
        topdelete = { text = icons.get_icon("git", "removed") },
        changedelete = { text = icons.get_icon("git", "modified") },
        untracked = { text = icons.get_icon("git", "untracked") },
      }
      
      return opts
    end,
  },

  -- Enhanced Telescope with icons
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      opts.defaults = opts.defaults or {}
      opts.defaults.prompt_prefix = icons.get_icon("ui", "search") .. " "
      opts.defaults.selection_caret = icons.get_icon("ui", "menu") .. " "
      
      return opts
    end,
  },

  -- Enhanced which-key with icons
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      opts.icons = opts.icons or {}
      opts.icons.breadcrumb = icons.get_icon("ui", "menu")
      opts.icons.separator = icons.get_icon("ui", "menu")
      opts.icons.group = icons.get_icon("ui", "settings")
      
      return opts
    end,
  },

  -- Enhanced bufferline with icons
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      opts.options = opts.options or {}
      opts.options.close_icon = icons.get_icon("ui", "close")
      opts.options.buffer_close_icon = icons.get_icon("ui", "close")
      opts.options.modified_icon = icons.get_icon("git", "modified")
      opts.options.left_trunc_marker = icons.get_icon("ui", "menu")
      opts.options.right_trunc_marker = icons.get_icon("ui", "menu")
      
      return opts
    end,
  },

  -- Enhanced nvim-cmp with kind icons
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(_, vim_item)
        vim_item.kind = string.format("%s %s", icons.get_icon("kind", vim_item.kind), vim_item.kind)
        return vim_item
      end
      
      return opts
    end,
  },

  -- Icon management commands and utilities
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      local icons = require("config.icons")
      
      opts.spec = opts.spec or {}
      table.insert(opts.spec, {
        "<leader>ui", 
        group = "icons",
        icon = icons.get_icon("ui", "settings"),
        {
          "<leader>uid", 
          function() icons.diagnose() end, 
          desc = "Diagnose Icons",
          icon = icons.get_icon("diagnostic", "info"),
        },
        {
          "<leader>uit", 
          function()
            local theme = vim.fn.input("Icon theme (default/minimal/nerd/ascii): ")
            if theme ~= "" then
              icons.set_theme(theme)
            end
          end, 
          desc = "Set Icon Theme",
          icon = icons.get_icon("ui", "settings"),
        },
      })
      
      return opts
    end,
  },
}