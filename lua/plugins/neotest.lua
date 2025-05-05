return {
  "nvim-neotest/neotest",
  dependencies = {
    "olimorris/neotest-phpunit",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  opts = {
    -- See all config options with :h neotest.Config
    discovery = {
      -- Drastically improve performance in ginormous projects by
      -- only AST-parsing the currently opened buffer.
      enabled = false,
      -- Number of workers to parse files concurrently.
      -- A value of 0 automatically assigns number based on CPU.
      -- Set to 1 if experiencing lag.
      concurrent = 1,
    },
    running = {
      -- Run tests concurrently when an adapter provides multiple commands to run.
      concurrent = true,
    },
    summary = {
      -- Enable/disable animation of icons.
      animated = false,
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python",
        require "neotest-vitest",
        require "neotest-phpunit",
        require "neotest-jest" {
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path) return vim.fn.getcwd() end,
        },
      },
    }
  end,
}
