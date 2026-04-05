---@type LazySpec
return {
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
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
        "mistweaverco/kulala.nvim",
        branch = "develop",
        enabled = true,
        ft = { "http", "rest" },
        opts = {
            global_keymaps = true,
            global_keymaps_prefix = "<leader>r",
            kulala_keymaps_prefix = "",
            kulala_keymaps = {},
            contenttypes = {
                -- ["application/json"] = {
                --     ft = "json",
                --     formatter = { "jq", "." },
                --     pathresolver = require("kulala.parser.jsonpath").parse,
                -- },
                ["application/xml"] = {
                    ft = "xml",
                    formatter = { "xmllint", "--format", "-" },
                    pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
                },
                ["text/html"] = {
                    ft = "html",
                    formatter = { "xmllint", "--format", "--html", "-" },
                    pathresolver = {},
                },
            },
            ui = {
                formatter = true,
                max_response_size = 10000000,
                pickers = {
                    snacks = {
                        layout = function()
                            local has_snacks, snacks_picker = pcall(require, "snacks.picker")
                            return not has_snacks and {}
                                or vim.tbl_deep_extend("force", snacks_picker.config.layout "horizontal", {})
                        end,
                    },
                },
            },
            debug = true,
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
        keys = {
            { "<leader>M", mode = "n", ":MarkdownPreview<cr>", desc = "Markdown Preview" },
        },
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
        config = function(_, opts)
            require("flash").setup(opts)
            vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#000000", bg = "#d75f00", bold = true })
        end,
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "ywpkwon/yank-path.nvim",
        config = function()
            require("yank-path").setup {
                default_mapping = false,
                use_oil = true,
            }
        end,
    },
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        opts = {
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _) return name == "node_modules" or name == ".git" end,
            },
            keymaps = {
                ["<c-c>"] = false,
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["g."] = "actions.toggle_hidden",
                ["_g"] = function()
                    local git_path = vim.fn.finddir(".git", ".;")
                    local cd_git = vim.fn.fnamemodify(git_path, ":h")
                    vim.api.nvim_command(string.format("edit %s", cd_git))
                end,
            },
        },
    },
    {
        "mikavilpas/yazi.nvim",
        version = "*", -- use the latest stable version
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>e",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
            open = function(chosen_file, config, state) vim.cmd("edit " .. vim.fn.fnameescape(chosen_file)) end,
            floating_window_scaling_factor = 1.0,
            yazi_floating_window_border = "none",
        },
        -- 👇 if you use `open_for_directories=true`, this is recommended
        init = function()
            -- mark netrw as loaded so it's not loaded at all.
            --
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            vim.g.loaded_netrwPlugin = 1
        end,
    },
    {
        "serhez/teide.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        ---@module "fzf-lua"
        ---@type fzf-lua.Config|{}
        ---@diagnostic disable: missing-fields
        opts = {},
        ---@diagnostic enable: missing-fields
        config = function(_, opts) require("fzf-lua").setup(opts) end,
    },
}
