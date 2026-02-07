---@type LazySpec
return {
    "andweeb/presence.nvim",
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
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        config = function()
            require("mcphub").setup {
                extensions = {
                    copilotchat = {
                        enabled = true,
                        convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
                        convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
                        add_mcp_prefix = false, -- Add "mcp_" prefix to function names
                    },
                },
            }
        end,
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
            kulala_keymaps = {
                ["Show verbose"] = false,
                ["Show headers and body"] = false,
            },
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
                default_winbar_panes = { "body", "script_output", "report", "help" },
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
        config = function() require("yank-path").setup() end,
    },
    {
        "cenk1cenk2/jq.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "grapp-dev/nui-components.nvim",
        },
        opts = {
            ui = {
                border = "rounded",
                keymap = {
                    focus_left = "<C-h>",
                    focus_right = "<C-l>",
                    focus_up = "<C-k>",
                    focus_down = "<C-j>",
                },
            },
        },
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
        config = function(_, opts)
            require("fzf-lua").setup(opts)

            local function laravel_routes()
                local fzf = require "fzf-lua"
                local handle = io.popen "php artisan route:list --json 2>/dev/null"
                if not handle then
                    vim.notify("Failed to run php artisan route:list", vim.log.levels.ERROR)
                    return
                end

                local result = handle:read "*a"
                handle:close()

                if result == "" then
                    vim.notify("No routes found or not in a Laravel project", vim.log.levels.WARN)
                    return
                end

                local ok, routes = pcall(vim.json.decode, result)
                if not ok or not routes then
                    vim.notify("Failed to parse route list JSON", vim.log.levels.ERROR)
                    return
                end

                local entries = {}
                for _, route in ipairs(routes) do
                    if route.action and route.action ~= "Closure" then
                        local method = route.method or ""
                        local uri = route.uri or ""
                        local name = route.name or ""
                        local action = route.action or ""

                        local display = string.format("%-8s %-40s %-30s %s", method, uri, name, action)

                        table.insert(entries, {
                            display = display,
                            action = action,
                            method = method,
                            uri = uri,
                            name = name,
                        })
                    end
                end

                fzf.fzf_exec(function(cb)
                    for _, entry in ipairs(entries) do
                        cb(entry.display, function() return entry end)
                    end
                    cb()
                end, {
                    prompt = "Search Routes: ",
                    previewer = false,
                    actions = {
                        ["default"] = function(selected)
                            if not selected or #selected == 0 then return end

                            local entry = entries[1]
                            for _, e in ipairs(entries) do
                                if e.display == selected[1] then
                                    entry = e
                                    break
                                end
                            end

                            local action = entry.action
                            local controller, method = action:match "(.+)@(.+)"

                            if not controller or not method then
                                vim.notify("Could not parse controller@method from: " .. action, vim.log.levels.WARN)
                                return
                            end

                            local class_path = controller:gsub("\\", "/"):gsub("^App/Http/Controllers/", "")
                            local file_path = "app/Http/Controllers/" .. class_path .. ".php"

                            if vim.fn.filereadable(file_path) == 0 then
                                vim.notify("File not found: " .. file_path, vim.log.levels.ERROR)
                                return
                            end

                            vim.cmd("edit " .. file_path)

                            vim.defer_fn(function()
                                local pattern = "function\\s\\+" .. method .. "\\s*("
                                local found = vim.fn.search(pattern, "w")
                                if found == 0 then
                                    vim.notify("Method " .. method .. " not found in file", vim.log.levels.WARN)
                                end
                            end, 50)
                        end,
                    },
                })
            end

            vim.api.nvim_create_user_command("LaravelRoutes", laravel_routes, {})
        end,
    },
}
