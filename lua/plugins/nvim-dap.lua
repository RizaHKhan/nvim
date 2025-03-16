return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"

    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { os.getenv "HOME" .. ".vscode-server/extensions/xdebug.php-debug-1.35.0/out.phpDebug.js" },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Docker XDebug",
        port = "9003",
        log = true,
        pathMappings = {
          ["/app"] = "${workspaceFolder}", -- Use os.getenv to resolve the home directory
        },
      },
    }
  end,
}
