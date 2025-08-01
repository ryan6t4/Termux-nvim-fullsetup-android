return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus file explorer" },
      { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in explorer" },
    },
    opts = {
      -- disable netrw at the very start of your init.lua (strongly advised)
      disable_netrw = false, -- keep netrw as backup
      hijack_netrw = true,
      -- open the tree when nvim is started with a directory
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      -- auto close nvim-tree when it's the last window
      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = {
            enable = true,
          },
        },
      },
      view = {
        -- width of the window, can be either a number (columns) or a string in percentage
        width = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        -- auto resize window on certain events
        adaptive_size = false,
        -- show line numbers in tree window
        number = false,
        relativenumber = false,
      },
      renderer = {
        -- add / show file icons
        icons = {
          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        -- highlight git changes
        highlight_git = true,
        -- highlight opened files
        highlight_opened_files = "name",
        -- indent markers
        indent_markers = {
          enable = true,
        },
      },
      -- filters for hiding files
      filters = {
        dotfiles = false, -- show dotfiles
        custom = { "node_modules", "\\.cache" },
        exclude = {},
      },
      -- git integration
      git = {
        enable = true,
        ignore = false,
        timeout = 400,
      },
      -- update focused file on buffer change
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      -- system open settings
      system_open = {
        cmd = nil,
        args = {},
      },
    },
  },
}