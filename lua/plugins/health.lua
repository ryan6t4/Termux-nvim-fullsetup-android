-- Health Check and Diagnostics System
return {
  -- Enhanced health checking
  {
    "folke/trouble.nvim",
    opts = function(_, opts)
      -- Custom health check function
      local function termux_health_check()
        local health = vim.health or require("health")
        
        health.start("Termux Neovim Ultimate Setup")
        
        -- Check Termux environment
        if vim.fn.has('termux') == 1 then
          health.ok("Running in Termux environment")
        else
          health.warn("Not running in Termux - some optimizations may not apply")
        end
        
        -- Check essential tools
        local tools = {
          { "git", "Git version control" },
          { "node", "Node.js runtime" },
          { "python", "Python interpreter" },
          { "rg", "Ripgrep for fast searching" },
          { "fd", "Fd for fast file finding" },
          { "fzf", "Fuzzy finder" },
        }
        
        for _, tool in ipairs(tools) do
          local name, desc = tool[1], tool[2]
          if vim.fn.executable(name) == 1 then
            local version = vim.fn.system(name .. " --version 2>/dev/null | head -n1"):gsub("\n", "")
            health.ok(desc .. " - " .. version)
          else
            health.error(desc .. " not found", { "Install with: pkg install " .. name })
          end
        end
        
        -- Check language servers
        local lsps = {
          { "lua-language-server", "Lua LSP" },
          { "pyright", "Python LSP" },
          { "typescript-language-server", "TypeScript/JavaScript LSP" },
          { "rust-analyzer", "Rust LSP" },
          { "gopls", "Go LSP" },
          { "clangd", "C/C++ LSP" },
        }
        
        for _, lsp in ipairs(lsps) do
          local name, desc = lsp[1], lsp[2]
          if vim.fn.executable(name) == 1 then
            health.ok(desc .. " available")
          else
            health.warn(desc .. " not found", { "Install via Mason: :Mason" })
          end
        end
        
        -- Check plugin status
        local ok, lazy = pcall(require, "lazy")
        if ok then
          local stats = lazy.stats()
          health.ok(string.format("Lazy.nvim: %d plugins loaded", stats.loaded))
          if stats.count > stats.loaded then
            health.info(string.format("%d plugins not loaded (lazy loading)", stats.count - stats.loaded))
          end
        else
          health.error("Lazy.nvim not found")
        end
        
        -- Check LSP status
        local clients = vim.lsp.get_active_clients()
        if #clients > 0 then
          health.ok(string.format("%d LSP client(s) active", #clients))
          for _, client in ipairs(clients) do
            health.info("  " .. client.name)
          end
        else
          health.warn("No LSP clients active")
        end
        
        -- Check Treesitter
        local ok_ts, ts = pcall(require, "nvim-treesitter.parsers")
        if ok_ts then
          local parsers = ts.get_parser_configs()
          local installed = 0
          for _ in pairs(parsers) do
            installed = installed + 1
          end
          health.ok(string.format("Treesitter: %d parsers available", installed))
        else
          health.warn("Treesitter not available")
        end
        
        -- Check AI features
        if vim.fn.executable("ollama") == 1 then
          health.ok("Ollama available for offline AI")
        else
          health.warn("Ollama not found", { "Install with install script or manually" })
        end
        
        -- Check Termux-specific features
        if vim.fn.has('termux') == 1 then
          local termux_tools = {
            { "termux-battery-status", "Battery status monitoring" },
            { "termux-notification", "System notifications" },
            { "termux-storage-get", "Storage access" },
          }
          
          for _, tool in ipairs(termux_tools) do
            local name, desc = tool[1], tool[2]
            if vim.fn.executable(name) == 1 then
              health.ok(desc .. " available")
            else
              health.warn(desc .. " not available", { "Install with: pkg install termux-api" })
            end
          end
        end
        
        -- Performance check
        local startup_time = vim.fn.reltime(vim.g.start_time or vim.fn.reltime())
        local startup_ms = vim.fn.reltimestr(startup_time) * 1000
        if startup_ms < 1000 then
          health.ok(string.format("Fast startup time: %.0fms", startup_ms))
        elseif startup_ms < 2000 then
          health.warn(string.format("Moderate startup time: %.0fms", startup_ms))
        else
          health.error(string.format("Slow startup time: %.0fms", startup_ms), {
            "Consider disabling some plugins or using performance mode"
          })
        end
        
        -- Memory usage
        local memory_kb = vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()):gsub("%s+", "")
        local memory_mb = tonumber(memory_kb) / 1024
        if memory_mb then
          if memory_mb < 100 then
            health.ok(string.format("Low memory usage: %.1fMB", memory_mb))
          elseif memory_mb < 200 then
            health.warn(string.format("Moderate memory usage: %.1fMB", memory_mb))
          else
            health.error(string.format("High memory usage: %.1fMB", memory_mb), {
              "Consider enabling memory optimizations"
            })
          end
        end
        
        -- Configuration validation
        local config_files = {
          { vim.fn.stdpath("config") .. "/init.lua", "Main configuration" },
          { vim.fn.stdpath("config") .. "/lua/config/options.lua", "Options configuration" },
          { vim.fn.stdpath("config") .. "/lua/config/keymaps.lua", "Keymaps configuration" },
        }
        
        for _, file in ipairs(config_files) do
          local path, desc = file[1], file[2]
          if vim.fn.filereadable(path) == 1 then
            health.ok(desc .. " found")
          else
            health.error(desc .. " missing", { "File should exist at: " .. path })
          end
        end
      end
      
      -- Register health check
      vim.api.nvim_create_user_command("TermuxHealth", function()
        termux_health_check()
      end, { desc = "Run Termux Neovim health check" })
      
      return opts
    end,
  },

  -- Startup time measurement
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Performance monitoring
  {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  },

  -- System monitoring integration
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      -- Termux-specific system monitoring
      if vim.fn.has('termux') == 1 then
        -- Battery monitoring
        local function check_battery()
          local handle = io.popen("termux-battery-status 2>/dev/null")
          if handle then
            local result = handle:read("*a")
            handle:close()
            
            if result and result ~= "" then
              local battery_data = vim.fn.json_decode(result)
              if battery_data and battery_data.percentage then
                local percentage = battery_data.percentage
                if percentage < 15 then
                  vim.notify(
                    string.format("Low battery: %d%% - Consider enabling power save mode", percentage),
                    vim.log.levels.WARN,
                    { title = "Battery Alert" }
                  )
                end
              end
            end
          end
        end
        
        -- Memory monitoring
        local function check_memory()
          local handle = io.popen("free -m | awk 'NR==2{printf \"%.1f\", $3*100/$2}'")
          if handle then
            local usage = handle:read("*n")
            handle:close()
            
            if usage and usage > 80 then
              vim.notify(
                string.format("High memory usage: %.1f%% - Consider restarting Neovim", usage),
                vim.log.levels.WARN,
                { title = "Memory Alert" }
              )
            end
          end
        end
        
        -- Periodic monitoring (every 5 minutes)
        local timer = vim.loop.new_timer()
        timer:start(300000, 300000, vim.schedule_wrap(function()
          check_battery()
          check_memory()
        end))
      end
      
      return opts
    end,
  },

  -- Error recovery system
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- Auto-recovery commands
      local function create_recovery_commands()
        vim.api.nvim_create_user_command("RecoverConfig", function()
          -- Reset to safe configuration
          vim.g.termux_performance_mode = true
          vim.opt.updatetime = 1000
          vim.opt.lazyredraw = true
          vim.notify("Switched to recovery mode", vim.log.levels.INFO)
        end, { desc = "Switch to recovery configuration" })
        
        vim.api.nvim_create_user_command("ResetPlugins", function()
          -- Reset plugin state
          vim.cmd("Lazy clear")
          vim.cmd("Lazy sync")
          vim.notify("Plugin state reset", vim.log.levels.INFO)
        end, { desc = "Reset plugin state" })
        
        vim.api.nvim_create_user_command("DiagnosticAll", function()
          -- Run comprehensive diagnostics
          vim.cmd("checkhealth")
          vim.cmd("LspInfo")
          vim.cmd("Lazy")
          vim.cmd("Mason")
        end, { desc = "Run all diagnostics" })
        
        vim.api.nvim_create_user_command("OptimizePerformance", function()
          -- Apply performance optimizations
          vim.g.termux_performance_mode = true
          vim.g.termux_battery_optimization = true
          vim.opt.updatetime = 2000
          vim.opt.timeoutlen = 1000
          vim.opt.lazyredraw = true
          vim.opt.synmaxcol = 200
          
          -- Disable heavy features
          vim.cmd("TSDisable highlight")
          vim.cmd("LspStop")
          
          vim.notify("Performance optimizations applied", vim.log.levels.INFO)
        end, { desc = "Apply aggressive performance optimizations" })
      end
      
      create_recovery_commands()
      return opts
    end,
  },
}