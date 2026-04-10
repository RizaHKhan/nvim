-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.completion.blink-cmp" },
    { import = "astrocommunity.completion.copilot-lua-cmp" },
    { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
    { import = "astrocommunity.debugging.nvim-dap-view" },
    { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
    { import = "astrocommunity.diagnostics.trouble-nvim" },
    { import = "astrocommunity.editing-support.neogen" },
    { import = "astrocommunity.editing-support.treesj" },
    { import = "astrocommunity.motion.mini-surround" },
    { import = "astrocommunity.quickfix.nvim-bqf" },
    { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
    { import = "astrocommunity.recipes.auto-session-restore" },
    { import = "astrocommunity.recipes.disable-borders" },
    { import = "astrocommunity.recipes.disable-tabline" },
    { import = "astrocommunity.recipes.neo-tree-dark" },
    { import = "astrocommunity.recipes.picker-lsp-mappings" },
    { import = "astrocommunity.search.grug-far-nvim" },
    { import = "astrocommunity.test.neotest" },
    { import = "astrocommunity.utility.lua-json5" },
    { import = "astrocommunity.utility.noice-nvim" },
}
