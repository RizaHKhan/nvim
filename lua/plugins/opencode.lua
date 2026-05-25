-- Install opencode:
--    npm i -g opencode-ai@latest
-- Run:
--    opencode auth login

return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `toggle()`.
        { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
    },
    config = function()
        vim.g.opencode_opts = {
            enabled = "tmux", -- or "tmux", or your custom provider (see below)
            ---@type opencode.provider.Snacks
            snacks = {
                -- Customize `snacks.terminal` to your liking.
            },
            tmux = {
                options = "-h", -- options to pass to `tmux split-window`
            },
            -- Your configuration, if any — see `lua/opencode/config.lua`
        }

        -- Required for `vim.g.opencode_opts.auto_reload`
        vim.opt.autoread = true

        -- Recommended/example keymaps
        vim.keymap.set(
            { "n", "x" },
            "<leader>oa",
            function() require("opencode").ask("@this: ", { submit = true }) end,
            { desc = "Ask about this" }
        )
        vim.keymap.set(
            { "v" },
            "<leader>os",
            function() require("opencode").prompt "@this: " end,
            { desc = "Ask about this" }
        )
        vim.keymap.set(
            { "n", "x" },
            "<leader>oA",
            function() require("opencode").select() end,
            { desc = "Add to Opencode" }
        )
        vim.keymap.set(
            { "n", "x" },
            "<leader>ob",
            function() require("opencode").ask("@buffer: ", { submit = true }) end,
            { desc = "Ask about this" }
        )
        vim.keymap.set(
            { "n", "x" },
            "<leader>oB",
            function() require("opencode").ask("@buffers: ", { submit = true }) end,
            { desc = "Ask about this" }
        )
    end,
}
