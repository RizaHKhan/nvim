return {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "j-hui/fidget.nvim", -- Display status
        "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
        "dyamon/codecompanion-filewise.nvim",
    },
    opts = {
        adapters = {
            acp = {
                gemini_cli = function()
                    return require("codecompanion.adapters").extend("gemini_cli", {
                        defaults = {
                            auth_method = "gemini-api-key", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
                        },
                        env = {
                            GEMINI_API_KEY = "cmd:op read op://Personal/Gemini/credential --no-newline",
                        },
                    })
                end,
            },
        },
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
