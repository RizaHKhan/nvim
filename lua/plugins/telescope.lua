---@type LazySpec
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-ui-select.nvim",
            config = function()
                require("telescope").load_extension("ui-select")
            end,
        },
    },
    opts = function()
        return {
            defaults = {
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = " ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    width = 0.87,
                    height = 0.80,
                },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                    n = {
                        ["q"] = "close",
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- Start in insert mode for immediate typing
                        initial_mode = "insert",
                        layout_config = {
                            height = 0.4,
                        },
                    },
                },
            },
        }
    end,
}
