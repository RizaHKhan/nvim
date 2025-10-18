---@type LazySpec
return {
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
                if item.file:match "lazyvim/lua/config/keymaps%.lua" then
                    item.score_add = (item.score_add or 0) - 30
                end
                if
                    item.file:match "[_/\\]tests?[/\\]"
                    or item.file:match "[._-]test[._%-]"
                    or item.file:match "[._-]spec[._%-]"
                then
                    item.score_add = (item.score_add or 0) - 50
                end
                if item.picked and item.score then item.score_add = (item.score_add or 0) + 50 end
                return item
            end,
            debug = {
                scores = false,
            },
            layout = {
                preset = "horizontal",
                cycle = false,
            },
            layouts = {
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
                        filename_first = true,
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
            notification = {},
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
                    "███    ██ ██    ██ ██ ███    ███",
                    "████   ██ ██    ██ ██ ████  ████",
                    "██ ██  ██ ██    ██ ██ ██ ████ ██",
                    "██  ██ ██  ██  ██  ██ ██  ██  ██",
                    "██   ████   ████   ██ ██      ██",
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
                    format = "file",
                    matcher = {
                        cwd_bonus = true,
                        frecency = true,
                        sort_empty = true,
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
                    on_show = function() vim.cmd.stopinsert() end,
                    finder = "buffers",
                    format = "buffer",
                    hidden = false,
                    unloaded = true,
                    current = true,
                    sort_lastused = true,
                    matcher = {
                        cwd_bonus = true,
                        frecency = true,
                        sort_empty = true,
                    },
                    win = {
                        input = {
                            keys = {
                                ["d"] = "bufdelete",
                            },
                        },
                        list = { keys = { ["d"] = "bufdelete" } },
                    },
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
        {
            "<leader>:",
            function()
                Snacks.picker.command_history {
                    on_show = function() vim.cmd.stopinsert() end,
                    preview = "none",
                    formatters = { text = { ft = "vim" } },
                    layout = {
                        preset = "vertical",
                    },
                }
            end,
            desc = "Command History",
        },
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
            "<leader>D",
            function()
                Snacks.picker.diagnostics_buffer {
                    on_show = function() vim.cmd.stopinsert() end,
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
}
