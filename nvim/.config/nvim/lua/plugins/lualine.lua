return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local colors = require("tokyonight.colors").setup()

        local theme = {
            normal = {
                a = { bg = "none", fg = colors.blue, gui = "bold" },
                b = { bg = "none", fg = colors.fg },
                c = { bg = "none", fg = colors.fg_dark },
            },
            insert = {
                a = { bg = "none", fg = colors.green, gui = "bold" },
                b = { bg = "none", fg = colors.fg },
                c = { bg = "none", fg = colors.fg_dark },
            },
            visual = {
                a = { bg = "none", fg = colors.magenta, gui = "bold" },
                b = { bg = "none", fg = colors.fg },
                c = { bg = "none", fg = colors.fg_dark },
            },
            replace = {
                a = { bg = "none", fg = colors.red, gui = "bold" },
                b = { bg = "none", fg = colors.fg },
                c = { bg = "none", fg = colors.fg_dark },
            },
            command = {
                a = { bg = "none", fg = colors.yellow, gui = "bold" },
                b = { bg = "none", fg = colors.fg },
                c = { bg = "none", fg = colors.fg_dark },
            },
            inactive = {
                a = { bg = "none", fg = colors.fg_dark },
                b = { bg = "none", fg = colors.fg_dark },
                c = { bg = "none", fg = colors.fg_dark },
            },
        }

        -- 一个"空组件"，用来在 section 之间插入空白间隔
        local spacer = { function() return "" end, padding = 0 }

        require("lualine").setup({
            options = {
                theme = theme,
                icons_enabled = true,
                globalstatus = true,
                -- 分隔符改成细竖线
                component_separators = { left = "│", right = "│" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { statusline = { "dashboard", "alpha" } },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        icon = "",
                        padding = { left = 1, right = 1 },
                        fmt = function(str) return " " .. str end,
                    },
                },
                lualine_b = {
                    {
                        "branch",
                        icon = "",
                        padding = { left = 2, right = 1 },
                        color = { fg = colors.magenta, gui = "bold" },
                    },
                    {
                        "diff",
                        padding = { left = 1, right = 1 },
                        symbols = { added = " ", modified = " ", removed = " " },
                        diff_color = {
                            added    = { fg = colors.green },
                            modified = { fg = colors.yellow },
                            removed  = { fg = colors.red },
                        },
                    },
                    {
                        "diagnostics",
                        padding = { left = 1, right = 1 },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                        diagnostics_color = {
                            error = { fg = colors.red },
                            warn  = { fg = colors.yellow },
                            info  = { fg = colors.blue },
                            hint  = { fg = colors.cyan },
                        },
                    },
                },
                lualine_c = {
                    spacer, -- 左侧留白
                    {
                        "filename",
                        path = 1,
                        padding = { left = 2, right = 1 },
                        symbols = { modified = " ●", readonly = " " },
                        color = { fg = colors.fg, gui = "italic" },
                    },
                },
                lualine_x = {
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            local ok, noice = pcall(require, "noice")
                            if not ok then
                                return false
                            end
                            if not noice.api.status.mode.has() then
                                return false
                            end
                            local text = noice.api.status.mode.get()
                            return text and text:match("recording") ~= nil
                        end,
                        color = { fg = colors.orange, gui = "bold" },
                        padding = { left = 1, right = 1 },
                    },
                    {
                        "filetype",
                        padding = { left = 1, right = 1 },
                        colored = true,
                        icon_only = false,
                    },
                    {
                        "fileformat",
                        padding = { left = 1, right = 1 },
                        symbols = { unix = "", dos = "", mac = "" },
                    },
                    {
                        "encoding",
                        padding = { left = 1, right = 1 },
                        fmt = string.upper,
                    },
                },
                lualine_y = {
                    {
                        "progress",
                        padding = { left = 2, right = 1 },
                        color = { fg = colors.blue, gui = "bold" },
                    },
                },
                lualine_z = {
                    {
                        "location",
                        padding = { left = 1, right = 2 },
                        color = { bg = "none", fg = colors.blue, gui = "bold" },
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1, color = { fg = colors.fg_dark } } },
                lualine_x = { { "location", color = { fg = colors.fg_dark } } },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "nvim-tree", "lazy", "quickfix" },
        })
    end,
}
