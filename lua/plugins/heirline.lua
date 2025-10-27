return {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
        opts.winbar = nil
        local status = require "astroui.status"
        opts.statusline = {
            hl = { fg = "fg", bg = "bg" },
            status.component.mode {
                mode_text = {
                    icon = { kind = "VimIcon", padding = { right = 1, left = 1 } },
                },
                surround = {
                    separator = "left",
                    color = function() return { main = status.hl.mode_bg(), right = "blank_bg" } end,
                },
            },
            status.component.builder {
                { provider = "" },
                surround = {
                    separator = "left",
                    color = { main = "blank_bg", right = "file_info_bg" },
                },
            },
            {
                hl = { bg = "#2D353B" },
                status.component.file_info {
                    filename = { fallback = "Empty" },
                    filetype = false,
                    file_read_only = false,
                    padding = { right = 2 },
                    surround = { separator = "left", condition = false, color = "file_info_bg" },
                },
                status.component.git_branch {
                    git_branch = { padding = { left = 2, right = 2 } },
                    surround = { separator = "none", color = { bg = "NONE" } },
                },
                status.component.git_diff {
                    padding = { left = 1 },
                    surround = { separator = "none", color = { bg = "NONE" } },
                },
                status.component.fill(),
                status.component.lsp {
                    surround = { separator = "none", color = { bg = "NONE" } },
                    padding = { left = 1, right = 1 },
                },
                status.component.builder {
                    { provider = function() return string.format("%d:%d", vim.fn.line ".", vim.fn.col ".") end },
                    surround = { separator = "right", condition = false, color = "file_info_bg" },
                    padding = { left = 1, right = 1 },
                },
            },
        }
    end,
}
