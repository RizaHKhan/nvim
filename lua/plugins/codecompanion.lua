return {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "j-hui/fidget.nvim", -- Display status
        "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
    },
    opts = {
        extensions = {
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    show_result_in_chat = true, -- Show mcp tool results in chat
                    make_vars = true, -- Convert resources to #variables
                    make_slash_commands = true, -- Add prompts as /slash commands
                },
            },
        },
        strategies = {
            chat = {
                adapter = {
                    name = "copilot",
                    model = "claude-sonnet-4.5",
                },
            },
        },
        inline = {
            adapter = "copilot",
        },
        opts = {
            log_level = "DEBUG",
        },
    },
}
