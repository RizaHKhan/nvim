---@type LazySpec
return {
    "andweeb/presence.nvim",
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
    },
    -- customize dashboard options
    {
        "folke/snacks.nvim",
        opts = {
            scratch = {
                win = {
                    backdrop = true,
                    border = "none",
                },
            },
            git = {
                enabled = true,
            },
            bigfile = { enabled = true },
            explorer = { enabled = false },
            indent = { enabled = false },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = {
                transform = function(item)
                    if not item.file then return item end
                    -- Demote the "lazyvim" keymaps file:
                    if item.file:match "lazyvim/lua/config/keymaps%.lua" then
                        item.score_add = (item.score_add or 0) - 30
                    end
                    -- Boost the "neobean" keymaps file:
                    -- if item.file:match("neobean/lua/config/keymaps%.lua") then
                    --   item.score_add = (item.score_add or 0) + 100
                    -- end
                    -- Demote test files:
                    if
                        item.file:match "[_/\\]tests?[/\\]"
                        or item.file:match "[._-]test[._%-]"
                        or item.file:match "[._-]spec[._%-]"
                    then
                        item.score_add = (item.score_add or 0) - 50
                    end
                    -- Add file score if picked
                    if item.picked and item.score then item.score_add = (item.score_add or 0) + 50 end
                    return item
                end,
                -- In case you want to make sure that the score manipulation above works
                -- or if you want to check the score of each file
                debug = {
                    scores = false, -- show scores in the list
                },
                -- I like the "ivy" layout, so I set it as the default globaly, you can
                -- still override it in different keymaps
                layout = {
                    preset = "horizontal",
                    -- When reaching the bottom of the results in the picker, I don't want
                    -- it to cycle and go back to the top
                    cycle = false,
                },
                layouts = {
                    -- I wanted to modify the ivy layout height and preview pane width,
                    -- this is the only way I was able to do it
                    -- NOTE: I don't think this is the right way as I'm declaring all the
                    -- other values below, if you know a better way, let me know
                    --
                    -- Then call this layout in the keymaps above
                    -- got example from here
                    -- https://github.com/folke/snacks.nvim/discussions/468
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = true,
                            row = -1,
                            width = 0,
                            height = 0.5,
                            border = "top",
                            title = " {title} {live} {flags}",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                    -- I wanted to modify the layout width
                    --
                    vertical = {
                        layout = {
                            backdrop = true,
                            width = 0.8,
                            min_width = 80,
                            height = 0.8,
                            min_height = 30,
                            box = "vertical",
                            border = "none",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                        },
                    },
                    horizontal = {
                        layout = {
                            backdrop = true,
                            box = "horizontal",
                            width = 0.8,
                            min_width = 80,
                            height = 0.8,
                            {
                                box = "vertical",
                                border = "none",
                                title = "{title} {live} {flags}",
                                { win = "input", height = 1, border = "bottom" },
                                { win = "list", border = "none" },
                            },
                            { win = "preview", title = "{preview}", border = "none", width = 0.5 },
                        },
                    },
                    matcher = {
                        frecency = true,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<Esc>"] = { "close", mode = { "n", "i" } },
                            },
                        },
                    },
                    formatters = {
                        file = {
                            filename_first = true, -- display filename before the file path
                        },
                    },
                },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    -- wo = { wrap = true } -- Wrap notifications
                },
            },
            dashboard = {
                preset = {
                    header = table.concat({
                        " █████  ███████ ████████ ██████   ██████ ",
                        "██   ██ ██         ██    ██   ██ ██    ██",
                        "███████ ███████    ██    ██████  ██    ██",
                        "██   ██      ██    ██    ██   ██ ██    ██",
                        "██   ██ ███████    ██    ██   ██  ██████ ",
                        "",
                        "███    ██ ██    ██ ██ ███    ███",
                        "████   ██ ██    ██ ██ ████  ████",
                        "██ ██  ██ ██    ██ ██ ██ ████ ██",
                        "██  ██ ██  ██  ██  ██ ██  ██  ██",
                        "██   ████   ████   ██ ██      ██",
                    }, "\n"),
                },
            },
        },
        keys = {
            {
                "<leader><space>",
                function()
                    Snacks.picker.smart {
                        on_show = function() vim.cmd.stopinsert() end,
                        multi = { "files" },
                        format = "file", -- use `file` format for all sources
                        matcher = {
                            cwd_bonus = true, -- boost cwd matches
                            frecency = true, -- use frecency boosting
                            sort_empty = true, -- sort even when the filter is empty
                        },
                        transform = "unique_file",
                    }
                end,
                desc = "Smart Find Files",
            },
            {
                "H",
                function()
                    Snacks.picker.buffers {
                        -- I always want my buffers picker to start in normal mode
                        on_show = function() vim.cmd.stopinsert() end,
                        finder = "buffers",
                        format = "buffer",
                        hidden = false,
                        unloaded = true,
                        current = true,
                        sort_lastused = true,
                        matcher = {
                            cwd_bonus = true, -- boost cwd matches
                            frecency = true, -- use frecency boosting
                            sort_empty = true, -- sort even when the filter is empty
                        },
                        win = {
                            input = {
                                keys = {
                                    ["d"] = "bufdelete",
                                },
                            },
                            list = { keys = { ["d"] = "bufdelete" } },
                        },
                        -- In case you want to override the layout for this keymap
                        -- layout = "ivy",
                    }
                end,
                desc = "Buffers",
            },
            {
                "K",
                function()
                    Snacks.picker.git_status {
                        on_show = function() vim.cmd.stopinsert() end,
                    }
                end,
                desc = "Git Status Files",
            },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions {
                        focus = "list",
                    }
                end,
                desc = "Goto Definition",
            },
            {
                "gD",
                function()
                    Snacks.picker.lsp_declarations {
                        focus = "list",
                    }
                end,
                desc = "Goto Declaration",
            },
            {
                "gr",
                function() Snacks.picker.lsp_references() end,
                nowait = true,
                desc = "References",
            },
            { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            {
                "<leader>S",
                function() Snacks.scratch.select() end,
                desc = "Select Scratch Buffer",
            },
            { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
            {
                "B",
                function() Snacks.git.blame_line() end,
                desc = "Git Blame",
            },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
            { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
            {
                "]]",
                function() Snacks.words.jump(vim.v.count1) end,
                desc = "Next Reference",
                mode = { "n", "t" },
            },
            {
                "[[",
                function() Snacks.words.jump(-vim.v.count1) end,
                desc = "Prev Reference",
                mode = { "n", "t" },
            },
        },
    },

    -- You can disable default plugins as follows:
    { "max397574/better-escape.nvim", enabled = false },

    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            local luasnip = require "luasnip"
            luasnip.filetype_extend("javascript", { "javascriptreact" })
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom autopairs configuration such as custom rules
            local npairs = require "nvim-autopairs"
            local Rule = require "nvim-autopairs.rule"
            local cond = require "nvim-autopairs.conds"
            npairs.add_rules(
                {
                    Rule("$", "$", { "tex", "latex" })
                        -- don't add a pair if the next character is %
                        :with_pair(
                            cond.not_after_regex "%%"
                        )
                        -- don't add a pair if  the previous character is xxx
                        :with_pair(
                            cond.not_before_regex("xxx", 3)
                        )
                        -- don't move right when repeat character
                        :with_move(cond.none())
                        -- don't delete if the next character is xx
                        :with_del(
                            cond.not_after_regex "xx"
                        )
                        -- disable adding a newline when you press <cr>
                        :with_cr(cond.none()),
                },
                -- disable for .vim files, but it work for another filetypes
                Rule("a", "a", "-vim")
            )
        end,
    },
    {
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
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
            },
            opts = {
                log_level = "DEBUG",
            },
        },
    },
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup( --[[optional config]])
        end,
    },
    {
        "okuuva/auto-save.nvim",
        version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
        cmd = "ASToggle", -- optional for lazy loading on command
        event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
        opts = {
            -- your config goes here
            -- or just leave it empty :)
        },
    },
    {
        "vhyrro/luarocks.nvim",
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        config = function() require("mcphub").setup() end,
    },
    {
        "mistweaverco/kulala.nvim",
        branch = "develop",
        enabled = true,
        keys = {
            { "<leader>Rs", desc = "Send request" },
            { "<leader>Ra", desc = "Send all requests" },
            { "<leader>Rb", desc = "Open scratchpad" },
        },
        ft = { "http", "rest" },
        opts = {
            global_keymaps = true,
            global_keymaps_prefix = "<leader>R",

            ui = { formatter = true },
            debug = true,
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function() require("window-picker").setup() end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        "A7Lavinraj/fyler.nvim",
        dependencies = { "echasnovski/mini.icons" },
        branch = "stable",
        opts = {
            views = {
                explorer = {
                    confirm_simple = true,
                    win = {
                        kind_presets = {
                            split_left_most = {
                                width = "0.2rel",
                            },
                        },
                    },
                },
            },
        },
        keys = {
            { "=", "<cmd>:Fyler toggle kind=split_left_most<CR>" },
        },
    },
}
