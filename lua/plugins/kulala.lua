return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  dependencies = {
    { -- AstroCore is always loaded on startup, so making it a dependency doesn't matter
      "AstroNvim/astrocore",
      opts = {
        mappings = { -- define a mapping to load the plugin module
          n = {
            ["<leader>r"] = "<cmd>lua require('kulala').run()<cr>",
            ["[r"] = "<cmd>lua require('kulala').jump_prev()<cr>",
            ["]r"] = "<cmd>lua require('kulala').jump_next()<cr>",
            ["<leader>i"] = "<cmd>lua require('kulala').inspect()<cr>",
          },
        },
      },
    },
  },
  opts = {
    debug = true
  },
}
