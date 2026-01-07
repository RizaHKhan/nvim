-- Customize Treesitter

---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "lua",
            "vim",
            -- add more arguments for adding more treesitter parsers
        },
        ignore_install = { "php", "php_only", "python" }, -- Prevent installation of parsers with broken queries
        highlight = {
            enable = true,
            disable = { "php", "python" }, -- Disable highlighting for parsers with broken queries
        },
    },
}
