-- Icons configuration for Termux Neovim setup
-- Provides comprehensive icon support with Android/Termux compatibility

local M = {}

-- Termux Android detection
M.is_termux = function()
  return vim.env.PREFIX and vim.env.PREFIX:match("/data/data/com.termux") ~= nil
end

-- Font detection for Termux environment
M.check_nerd_font = function()
  -- Check common Nerd Font installation paths in Termux
  local termux_font_paths = {
    vim.env.HOME .. "/.termux/font.ttf",
    vim.env.PREFIX .. "/share/fonts/",
    "/system/fonts/",
  }
  
  if M.is_termux() then
    for _, path in ipairs(termux_font_paths) do
      if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
        return true
      end
    end
  end
  
  -- For non-Termux environments, assume Nerd Fonts are available
  return not M.is_termux()
end

-- Icon fallback system
M.has_nerd_font = M.check_nerd_font()
M.use_icons = M.has_nerd_font

-- File type icons with fallbacks
M.filetype_icons = {
  -- Programming languages
  lua = M.use_icons and " " or "LUA",
  python = M.use_icons and " " or "PY",
  javascript = M.use_icons and " " or "JS",
  typescript = M.use_icons and " " or "TS",
  rust = M.use_icons and " " or "RS",
  go = M.use_icons and " " or "GO",
  java = M.use_icons and " " or "JAVA",
  c = M.use_icons and " " or "C",
  cpp = M.use_icons and " " or "C++",
  html = M.use_icons and " " or "HTML",
  css = M.use_icons and " " or "CSS",
  scss = M.use_icons and " " or "SCSS",
  json = M.use_icons and " " or "JSON",
  yaml = M.use_icons and " " or "YAML",
  toml = M.use_icons and " " or "TOML",
  xml = M.use_icons and " " or "XML",
  sql = M.use_icons and " " or "SQL",
  bash = M.use_icons and " " or "SH",
  zsh = M.use_icons and " " or "ZSH",
  fish = M.use_icons and " " or "FISH",
  vim = M.use_icons and " " or "VIM",
  
  -- Config files
  [".gitignore"] = M.use_icons and " " or "GIT",
  [".gitconfig"] = M.use_icons and " " or "GIT",
  ["dockerfile"] = M.use_icons and " " or "DOCK",
  ["makefile"] = M.use_icons and " " or "MAKE",
  ["readme.md"] = M.use_icons and " " or "READ",
  
  -- Directories
  folder = M.use_icons and " " or "DIR",
  folder_open = M.use_icons and " " or "OPEN",
  folder_empty = M.use_icons and " " or "EMPTY",
}

-- Git status icons
M.git_icons = {
  added = M.use_icons and " " or "+",
  modified = M.use_icons and " " or "~",
  removed = M.use_icons and " " or "-",
  renamed = M.use_icons and " " or "R",
  untracked = M.use_icons and " " or "?",
  ignored = M.use_icons and " " or "!",
  unstaged = M.use_icons and " " or "U",
  staged = M.use_icons and " " or "S",
  conflict = M.use_icons and " " or "C",
  branch = M.use_icons and " " or "BR",
  commit = M.use_icons and " " or "CO",
  tag = M.use_icons and " " or "TAG",
}

-- Diagnostic icons
M.diagnostic_icons = {
  error = M.use_icons and " " or "E",
  warn = M.use_icons and " " or "W",
  info = M.use_icons and " " or "I",
  hint = M.use_icons and " " or "H",
  ok = M.use_icons and " " or "OK",
}

-- LSP icons
M.lsp_icons = {
  server = M.use_icons and " " or "LSP",
  connected = M.use_icons and " " or "ON",
  disconnected = M.use_icons and " " or "OFF",
  loading = M.use_icons and " " or "...",
  error = M.use_icons and " " or "ERR",
}

-- UI element icons
M.ui_icons = {
  menu = M.use_icons and " " or "≡",
  search = M.use_icons and " " or "?",
  settings = M.use_icons and " " or "⚙",
  close = M.use_icons and " " or "✕",
  save = M.use_icons and " " or "💾",
  new = M.use_icons and " " or "+",
  edit = M.use_icons and " " or "✎",
  delete = M.use_icons and " " or "🗑",
  copy = M.use_icons and " " or "📋",
  paste = M.use_icons and " " or "📄",
  terminal = M.use_icons and " " or "TERM",
  buffer = M.use_icons and " " or "BUF",
  tab = M.use_icons and " " or "TAB",
}

-- Kind icons for completion and symbols
M.kind_icons = {
  Text = M.use_icons and " " or "TXT",
  Method = M.use_icons and " " or "FN",
  Function = M.use_icons and " " or "FN",
  Constructor = M.use_icons and " " or "CTOR",
  Field = M.use_icons and " " or "FIELD",
  Variable = M.use_icons and " " or "VAR",
  Class = M.use_icons and " " or "CLASS",
  Interface = M.use_icons and " " or "IFACE",
  Module = M.use_icons and " " or "MOD",
  Property = M.use_icons and " " or "PROP",
  Unit = M.use_icons and " " or "UNIT",
  Value = M.use_icons and " " or "VAL",
  Enum = M.use_icons and " " or "ENUM",
  Keyword = M.use_icons and " " or "KEY",
  Snippet = M.use_icons and " " or "SNIP",
  Color = M.use_icons and " " or "COL",
  File = M.use_icons and " " or "FILE",
  Reference = M.use_icons and " " or "REF",
  Folder = M.use_icons and " " or "DIR",
  EnumMember = M.use_icons and " " or "ENUM",
  Constant = M.use_icons and " " or "CONST",
  Struct = M.use_icons and " " or "STRUCT",
  Event = M.use_icons and " " or "EVENT",
  Operator = M.use_icons and " " or "OP",
  TypeParameter = M.use_icons and " " or "TYPE",
}

-- Plugin status icons
M.plugin_icons = {
  lazy = M.use_icons and "💤 " or "LAZY",
  mason = M.use_icons and " " or "MASON",
  treesitter = M.use_icons and " " or "TS",
  telescope = M.use_icons and " " or "TELE",
  gitsigns = M.use_icons and " " or "GIT",
  cmp = M.use_icons and " " or "CMP",
  lsp = M.use_icons and " " or "LSP",
}

-- Mobile/touch optimized settings for Termux
M.mobile_config = {
  -- Larger touch targets
  icon_padding = M.is_termux() and "  " or " ",
  -- Simplified icons for small screens
  use_simple_icons = M.is_termux() and vim.o.columns < 80,
  -- Battery-friendly settings
  reduce_animations = M.is_termux(),
}

-- Icon theme switching
M.themes = {
  default = "default",
  minimal = "minimal", 
  nerd = "nerd",
  ascii = "ascii",
}

M.current_theme = M.use_icons and M.themes.nerd or M.themes.ascii

-- Function to switch icon themes
M.set_theme = function(theme)
  if not M.themes[theme] then
    vim.notify("Unknown icon theme: " .. theme, vim.log.levels.WARN)
    return
  end
  
  M.current_theme = theme
  M.use_icons = theme ~= M.themes.ascii
  
  -- Trigger reload of icon configurations
  vim.notify("Icon theme changed to: " .. theme, vim.log.levels.INFO)
end

-- Get icon by name and category
M.get_icon = function(category, name, fallback)
  local icons = M[category .. "_icons"]
  if not icons then
    return fallback or "?"
  end
  
  return icons[name] or fallback or "?"
end

-- Diagnostics and troubleshooting
M.diagnose = function()
  local info = {
    "=== Icon System Diagnostics ===",
    "Termux detected: " .. tostring(M.is_termux()),
    "Nerd Font available: " .. tostring(M.has_nerd_font),
    "Using icons: " .. tostring(M.use_icons),
    "Current theme: " .. M.current_theme,
    "Terminal columns: " .. vim.o.columns,
    "Environment PREFIX: " .. (vim.env.PREFIX or "none"),
    "",
    "=== Font Paths Check ===",
  }
  
  local termux_font_paths = {
    vim.env.HOME .. "/.termux/font.ttf",
    vim.env.PREFIX .. "/share/fonts/",
    "/system/fonts/",
  }
  
  for _, path in ipairs(termux_font_paths) do
    local exists = vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1
    table.insert(info, path .. ": " .. (exists and "✓" or "✗"))
  end
  
  table.insert(info, "")
  table.insert(info, "=== Sample Icons ===")
  table.insert(info, "File: " .. M.get_icon("filetype", "lua"))
  table.insert(info, "Git: " .. M.get_icon("git", "branch"))
  table.insert(info, "Diagnostic: " .. M.get_icon("diagnostic", "error"))
  
  vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
end

return M