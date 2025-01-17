return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon",
    on_colors = function(colors)
      colors.border = "#a9b1d6"
    end,
  },
}
