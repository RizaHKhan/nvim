return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon",
    on_colors = function(colors) colors.border = "#4b5563" end,
  },
}
