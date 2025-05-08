return {
  "nvim-neorg/neorg",
  dependencies = { "luarocks.nvim" },
  config = function()
    -- Pick one of ...

    -- a) NO arguments at all to setup
    -- require("neorg").setup()

    -- b) at least load "core.defaults"
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
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
