return {
  "nvim-neotest/neotest",
  dependencies = {
    "olimorris/neotest-phpunit",
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-phpunit",
      },
    }
  end,
}
