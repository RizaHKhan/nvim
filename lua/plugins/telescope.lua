return {
  {
    "nvim-telescope/telescope.nvim",
    setup = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules" },
        },
      }
    end,
    dependencies = {
      { -- AstroCore is always loaded on startup, so making it a dependency doesn't matter
        "AstroNvim/astrocore",
        opts = {
          mappings = { -- define a mapping to load the plugin module
            n = {
              ["H"] = {
                function()
                  require("telescope.builtin").buffers {
                    sort_mru = true,
                    sort_lastused = true,
                    initial_mode = "normal",
                  }
                end,
              },
              ["K"] = {
                function()
                  local git_status_files = vim.fn.systemlist "git status --porcelain"
                  if #git_status_files > 0 then
                    require("telescope.builtin").git_status {
                      sort_mru = true,
                      sort_lastused = true,
                      initial_mode = "normal",
                    }
                  else
                    vim.notify("No changes in git status", vim.log.levels.INFO)
                  end
                end,
              },
              ["<leader>f."] = function()
                require("telescope.builtin").find_files {
                  initial_mode = "normal",
                  hidden = true,
                  follow = true,
                  no_ignore = true,
                  file_ignore_patterns = { "node_modules" },
                  find_command = { "rg", "--files", "--hidden", "--glob", ".*" },
                }
              end,
            },
          },
        },
      },
    },
    opts = {
      defaults = {
        mappings = {
          n = {
            ["d"] = require("telescope.actions").delete_buffer,
            ["q"] = require("telescope.actions").close,
          },
        },
      },
    },
  },
}
