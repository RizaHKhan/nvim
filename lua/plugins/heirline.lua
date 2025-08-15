return {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
        opts.winbar = nil
        local status = require "astroui.status"
        opts.statusline = {
            -- default highlight for the entire statusline
            hl = { fg = "fg", bg = "bg" },
            -- each element following is a component in astroui.status module

            -- add the vim mode component
            status.component.mode {
                -- enable mode text with padding as well as an icon before it
                mode_text = {
                    icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
                },
                -- surround the component with a separators
                surround = {
                    -- it's a left element, so use the left separator
                    separator = "left",
                    -- set the color of the surrounding based on the current mode using astronvim.utils.status module
                    color = function() return { main = status.hl.mode_bg(), right = "blank_bg" } end,
                },
            },
            -- we want an empty space here so we can use the component builder to make a new section with just an empty string
            status.component.builder {
                { provider = "" },
                -- define the surrounding separator and colors to be used inside of the component
                -- and the color to the right of the separated out section
                surround = {
                    separator = "left",
                    color = { main = "blank_bg", right = "file_info_bg" },
                },
            },
            {
                hl = { bg = "#212830" },
                -- add a section for the currently opened file information
                status.component.file_info {
                    -- enable the file_icon and disable the highlighting based on filetype
                    filename = { fallback = "Empty" },
                    -- disable some of the info
                    filetype = false,
                    file_read_only = false,
                    -- add padding
                    padding = { right = 2 },
                    -- define the section separator
                    surround = { separator = "left", condition = false, color = "file_info_bg" },
                },
                -- add a component for the current git branch if it exists and use no separator for the sections
                status.component.git_branch {
                    git_branch = { padding = { left = 2, right = 2 } },
                    surround = { separator = "none", color = { bg = "NONE" } },
                },
                -- add a component for the current git diff if it exists and use no separator for the sections
                status.component.git_diff {
                    padding = { left = 1 },
                    surround = { separator = "none", color = { bg = "NONE" } },
                },
                -- fill the rest of the statusline
                -- the elements after this will appear in the middle of the statusline
                -- status.component.fill(),
                -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
                status.component.lsp {
                    lsp_client_names = false,
                    surround = { separator = "none", color = "bg" },
                },
                -- fill the rest of the statusline
                -- the elements after this will appear on the right of the statusline
                status.component.fill(),
                -- add a component for the current diagnostics if it exists and use the right separator for the section
                -- status.component.diagnostics { surround = { separator = "right" } },
                -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
                status.component.lsp {
                    surround = { separator = "right", color = { bg = "NONE" } },
                    padding = { left = 1, right = 1 },
                },
            },
        }
    end,
}
