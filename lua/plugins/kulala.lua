return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  dependencies = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          keymaps = {
            {
              event = { "BufRead", "BufNewFile" },
              pattern = "*.http",
              desc = "kulala.nvim http file keymaps",
              callback = function()
                local opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", "<cmd>lua require('kulala').run()<cr>", opts)
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>i", "<cmd>lua require('kulala').inspect()<cr>", opts)
                vim.api.nvim_buf_set_keymap(0, "n", "<leader>p", "<cmd>lua require('kulala').toggle_view()<cr>", opts)
              end,
            },
          },
        },
      },
    },
  },
  opts = {
    debug = true,
  },
}
