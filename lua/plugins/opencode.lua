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
            -- Your configuration, if any — see `lua/opencode/config.lua`
        }

        -- Required for `vim.g.opencode_opts.auto_reload`
        vim.opt.autoread = true

        -- Recommended/example keymaps
        vim.keymap.set("n", "<leader>oc", function() require("opencode").command() end, { desc = "Select command" })
        vim.keymap.set(
            "n",
            "<leader>on",
            function() require("opencode").command "session_new" end,
            { desc = "New session" }
        )
        vim.keymap.set(
            "n",
            "<leader>oi",
            function() require("opencode").command "session_interrupt" end,
            { desc = "Interrupt session" }
        )
        vim.keymap.set(
            "n",
            "<leader>oA",
            function() require("opencode").command "agent_cycle" end,
            { desc = "Cycle selected agent" }
        )
        vim.keymap.set(
            "n",
            "<S-C-u>",
            function() require("opencode").command "messages_half_page_up" end,
            { desc = "Messages half page up" }
        )
        vim.keymap.set(
            "n",
            "<S-C-d>",
            function() require("opencode").command "messages_half_page_down" end,
            { desc = "Messages half page down" }
        )
    end,
}
