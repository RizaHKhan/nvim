return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim", "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  config = function()
    -- Pick one of ...

    -- a) NO arguments at all to setup
    -- require("neorg").setup()

    -- b) at least load "core.defaults"
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.integrations.telescope"] = {
          config = {
            insert_file_link = {
              -- Whether to show the title preview in telescope. Affects performance with a large
              -- number of files.
              show_title_preview = true,
            },
          },
        },
        ["core.dirman"] = { -- Manage your workspaces
          config = {
            workspaces = {
              networking = "~/networking", -- Define the "networking" workspace
              notes = "~/notes", -- Example of another workspace
            },
            default_workspace = "networking", -- Optional: Set a default workspace
          },
        },
      },
    }
  end,
}
