-- Termux font management and Nerd Font setup utility
-- Provides automated font installation and configuration for Android Termux

local M = {}

-- Termux-specific paths and configurations
M.termux_paths = {
  font_dir = vim.env.HOME .. "/.termux",
  font_file = vim.env.HOME .. "/.termux/font.ttf",
  config_dir = vim.env.HOME .. "/.termux",
  backup_dir = vim.env.HOME .. "/.termux/backup",
}

-- Popular Nerd Fonts for Termux
M.recommended_fonts = {
  {
    name = "JetBrains Mono Nerd Font",
    url = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip",
    file = "JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf",
    description = "Excellent for coding with good readability on mobile screens",
  },
  {
    name = "Fira Code Nerd Font", 
    url = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip",
    file = "FiraCode/FiraCodeNerdFont-Regular.ttf",
    description = "Popular programming font with ligatures",
  },
  {
    name = "Source Code Pro Nerd Font",
    url = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip", 
    file = "SourceCodePro/SauceCodeProNerdFont-Regular.ttf",
    description = "Clean and readable, good for small screens",
  },
  {
    name = "Hack Nerd Font",
    url = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip",
    file = "Hack/HackNerdFont-Regular.ttf", 
    description = "Designed specifically for code, excellent mobile readability",
  },
}

-- Check if running in Termux
M.is_termux = function()
  return vim.env.PREFIX and vim.env.PREFIX:match("/data/data/com.termux") ~= nil
end

-- Check if required tools are available
M.check_tools = function()
  local tools = { "curl", "unzip" }
  local missing = {}
  
  for _, tool in ipairs(tools) do
    if vim.fn.executable(tool) == 0 then
      table.insert(missing, tool)
    end
  end
  
  return missing
end

-- Create necessary directories
M.setup_directories = function()
  local dirs = { M.termux_paths.font_dir, M.termux_paths.backup_dir }
  
  for _, dir in ipairs(dirs) do
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end
end

-- Backup current font
M.backup_current_font = function()
  if vim.fn.filereadable(M.termux_paths.font_file) == 1 then
    local backup_file = M.termux_paths.backup_dir .. "/font-" .. os.date("%Y%m%d-%H%M%S") .. ".ttf"
    vim.fn.system(string.format("cp %s %s", M.termux_paths.font_file, backup_file))
    return backup_file
  end
  return nil
end

-- Download and install font
M.install_font = function(font_info, callback)
  if not M.is_termux() then
    vim.notify("Font installation is only supported in Termux environment", vim.log.levels.WARN)
    return
  end
  
  local missing_tools = M.check_tools()
  if #missing_tools > 0 then
    vim.notify("Missing required tools: " .. table.concat(missing_tools, ", ") .. 
               "\nRun: pkg install curl unzip", vim.log.levels.ERROR)
    return
  end
  
  M.setup_directories()
  
  vim.notify("Downloading " .. font_info.name .. "...", vim.log.levels.INFO)
  
  local temp_dir = "/tmp/nerd-font-" .. os.time()
  local temp_zip = temp_dir .. ".zip"
  
  -- Create download command
  local download_cmd = string.format("curl -L -o %s %s", temp_zip, font_info.url)
  
  vim.fn.system(download_cmd)
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to download font", vim.log.levels.ERROR)
    return
  end
  
  -- Extract font
  vim.fn.mkdir(temp_dir, "p")
  vim.fn.system(string.format("cd %s && unzip -q %s", temp_dir, temp_zip))
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to extract font", vim.log.levels.ERROR)
    return
  end
  
  -- Find and copy font file
  local font_path = temp_dir .. "/" .. font_info.file
  if vim.fn.filereadable(font_path) == 0 then
    -- Try to find any .ttf file in the extraction
    local ttf_files = vim.fn.glob(temp_dir .. "/**/*.ttf", false, true)
    if #ttf_files > 0 then
      font_path = ttf_files[1]
    else
      vim.notify("Font file not found in downloaded archive", vim.log.levels.ERROR)
      return
    end
  end
  
  -- Backup current font
  local backup_file = M.backup_current_font()
  if backup_file then
    vim.notify("Current font backed up to: " .. backup_file, vim.log.levels.INFO)
  end
  
  -- Install new font
  vim.fn.system(string.format("cp %s %s", font_path, M.termux_paths.font_file))
  
  if vim.v.shell_error == 0 then
    vim.notify("Font installed successfully! Please restart Termux to apply changes.", vim.log.levels.INFO)
    
    -- Clean up
    vim.fn.system(string.format("rm -rf %s %s", temp_dir, temp_zip))
    
    if callback then
      callback(true)
    end
  else
    vim.notify("Failed to install font", vim.log.levels.ERROR)
    if callback then
      callback(false)
    end
  end
end

-- Interactive font selection
M.select_font = function()
  if not M.is_termux() then
    vim.notify("Font installation is only supported in Termux environment", vim.log.levels.WARN)
    return
  end
  
  local choices = {}
  for i, font in ipairs(M.recommended_fonts) do
    table.insert(choices, string.format("%d. %s - %s", i, font.name, font.description))
  end
  
  vim.ui.select(choices, {
    prompt = "Select a Nerd Font to install:",
    format_item = function(item) return item end,
  }, function(choice, idx)
    if idx then
      M.install_font(M.recommended_fonts[idx])
    end
  end)
end

-- Check current font status
M.font_status = function()
  local status = {
    "=== Termux Font Status ===",
    "Termux detected: " .. tostring(M.is_termux()),
    "Font file exists: " .. tostring(vim.fn.filereadable(M.termux_paths.font_file) == 1),
    "Font path: " .. M.termux_paths.font_file,
  }
  
  if vim.fn.filereadable(M.termux_paths.font_file) == 1 then
    local size = vim.fn.getfsize(M.termux_paths.font_file)
    table.insert(status, "Font size: " .. size .. " bytes")
  end
  
  table.insert(status, "")
  table.insert(status, "=== Tool Status ===")
  
  local tools = { "curl", "unzip" }
  for _, tool in ipairs(tools) do
    local available = vim.fn.executable(tool) == 1
    table.insert(status, tool .. ": " .. (available and "✓" or "✗"))
  end
  
  table.insert(status, "")
  table.insert(status, "=== Available Commands ===")
  table.insert(status, ":TermuxFontInstall - Interactive font selection")
  table.insert(status, ":TermuxFontStatus - Show this status")
  table.insert(status, ":TermuxFontBackup - Backup current font")
  
  vim.notify(table.concat(status, "\n"), vim.log.levels.INFO)
end

-- Create user commands
M.setup_commands = function()
  vim.api.nvim_create_user_command("TermuxFontInstall", function()
    M.select_font()
  end, { desc = "Install Nerd Font for Termux" })
  
  vim.api.nvim_create_user_command("TermuxFontStatus", function()
    M.font_status()
  end, { desc = "Check Termux font status" })
  
  vim.api.nvim_create_user_command("TermuxFontBackup", function()
    local backup_file = M.backup_current_font()
    if backup_file then
      vim.notify("Font backed up to: " .. backup_file, vim.log.levels.INFO)
    else
      vim.notify("No font to backup", vim.log.levels.WARN)
    end
  end, { desc = "Backup current Termux font" })
end

-- Auto-setup function
M.setup = function()
  if M.is_termux() then
    M.setup_commands()
    
    -- Check if font is missing and offer to install
    if vim.fn.filereadable(M.termux_paths.font_file) == 0 then
      vim.notify("No Nerd Font detected. Run :TermuxFontInstall to install one.", vim.log.levels.WARN)
    end
  end
end

return M