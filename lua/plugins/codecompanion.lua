return {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "j-hui/fidget.nvim",
        "ravitemer/codecompanion-history.nvim",
        "dyamon/codecompanion-filewise.nvim",
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
                adapter = "copilot",
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
