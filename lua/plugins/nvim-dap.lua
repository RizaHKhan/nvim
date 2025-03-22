return {
  { "nvim-neotest/nvim-nio" },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv "HOME" .. "/.local/share/nvim/lazy/vscode-php-debug/out/phpDebug.js" },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for xdebug (Docker)",
          port = 9003,
          log = true,
          pathMappings = {
            ["/app"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (Local)",
          port = 9003,
          log = true,
          pathMappings = {
            ["."] = "${workspaceFolder}",
          },
        },
      }

      for _, adapterType in ipairs { "node", "chrome", "msedge" } do
        local pwaType = "pwa-" .. adapterType

        dap.adapters[pwaType] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              os.getenv "HOME" .. "/.local/share/nvim/lazy/vscode-js-debug/out/src/vsDebugServer.js",
              "${port}",
            },
          },
        }

        -- this allow us to handle launch.json configurations
        -- which specify type as "node" or "chrome" or "msedge"
        dap.adapters[adapterType] = function(cb, config)
          local nativeAdapter = dap.adapters[pwaType]

          config.type = pwaType

          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local enter_launch_url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end

      for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" } do
        dap.configurations[language] = {
          {
            type = "pwa-msedge",
            request = "launch",
            name = "Launch Edge (nvim-dap)",
            url = "http://localhost:5173",
            webRoot = "${workspaceFolder}",
            runtimeExecutable = "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe",
            runtimeArgs = { "--remote-debugging-port=9222", "--user-data-dir=remote-debug-profile" },
            sourceMaps = true,
          },
        }
      end

    end,
    dependencies = {
      -- Install the vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "xdebug/vscode-php-debug",
        build = "npm install --legacy-peer-deps --no-save && npm run build",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          --@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup {
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            node_path = "node",

            -- Path to vscode-js-debug installation.
            -- debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          }
        end,
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
  },
}
