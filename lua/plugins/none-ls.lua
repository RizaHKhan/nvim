-- Customize None-ls sources

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
        opts = opts or {}
        local null_ls = require "null-ls"

        opts.sources = opts.sources or {}

        if vim.fn.executable "prettier" == 1 then table.insert(opts.sources, null_ls.builtins.formatting.prettier) end

        if vim.fn.executable "biome" == 1 then table.insert(opts.sources, null_ls.builtins.formatting.biome) end

        return opts
    end,
}
