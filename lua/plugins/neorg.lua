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
      },
    }
  end,
}
