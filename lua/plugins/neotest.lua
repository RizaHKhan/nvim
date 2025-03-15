return {
  "nvim-neotest/neotest",
  dependencies = {
    "olimorris/neotest-phpunit",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  config = function()
    require("neotest").setup {
      adapters = {
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
