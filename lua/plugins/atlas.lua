local function op_read(ref)
    local secret = vim.fn.system { "op", "read", ref, "--no-newline" }
    if vim.v.shell_error ~= 0 then return "" end
    return secret
end

---@type workspace string
---@type directory string
---@type BitbucketRepo[]
local function repositories(workspace, directory)
    local repos = {}
    local expanded = directory:gsub("^~", os.getenv "HOME")
    local p = io.popen("ls " .. directory)
    if p then
        for repo in p:lines() do
            table.insert(repos, { workspace = workspace, repo = repo })
        end
        p:close()
    end
    return repos
end

return {
    "emrearmagan/atlas.nvim",
    config = function()
        require("atlas").setup {
            ---@type BitbucketConfig
            bitbucket = {
                user = os.getenv "BITBUCKET_USER" or "",
                token = os.getenv "BITBUCKET_TOKEN" or "",
                cache_ttl = 300,
                repo_config = {
                    -- Maps `workspace/repo` to local paths. Used for checkout and custom actions.
                    paths = {
                        ["camcloud/*"] = "~/camcloud/repos/*",
                    },

                    settings = {
                        ["camcloud/atlas"] = {
                            readme = "README.md", -- optional, defaults to README.md
                        },
                    },
                },
                custom_actions = {}, -- See Custom Actions below.

                ---@type BitbucketViewConfig[]
                views = {
                    {
                        name = "Me",
                        key = "M",
                        layout = "compact", -- "compact" or "plain"
                        repos = repositories("camcloud", "~/camcloud/repos"),

                        ---@param pr BitbucketPR
                        ---@param ctx table
                        filter = function(pr, ctx)
                            local user = ctx.user or {}
                            return pr.author and pr.author.account_id == user.account_id
                        end,
                    },
                    {
                        name = "Others",
                        key = "O",
                        layout = "plain", -- "compact" or "plain"
                        repos = repositories("camcloud", "~/camcloud/repos"),
                    },
                },
            },
            jira = {
                base_url = os.getenv "JIRA_BASE_URL" or "",
                email = os.getenv "JIRA_EMAIL" or "",
                token = os.getenv "JIRA_TOKEN" or "",
                cache_ttl = 300,
                resolve_parent_issues = true,

                project_config = {
                    ALE = {
                        customfield_10003 = {
                            name = "Approvers",
                            format = function(value)
                                if type(value) ~= "table" or #value == 0 then
                                    return nil -- nil hides the field
                                end

                                return table.concat(value, ", ")
                            end,
                            hl_group = "AtlasChipActive",
                            display = "chip", -- "chip" (default) or "table"
                        },
                    },
                },

                ---@type JiraViewConfig[]
                views = {
                    {
                        name = "My Board",
                        key = "M",
                        jql = "project = ALE AND assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
                    },
                },
            },
        }
    end,
}
