return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function()
        -- 注册 hook，当高亮组被设置时，定义彩虹颜色
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })

        -- 插件主配置
        require("ibl").setup({
            -- 缩进线样式
            indent = {
                char = "▏", -- 使用细竖线字符
                -- 使用彩虹高亮，循环使用这些组（可以添加更多）
                highlight = {
                    "RainbowRed",
                    "RainbowYellow",
                    "RainbowBlue",
                    "RainbowOrange",
                    "RainbowGreen",
                    "RainbowViolet",
                },
            },

            -- 作用域高亮（显示光标所在代码块范围）
            scope = {
                enabled = true, -- 启用
                char = "▎", -- 作用域缩进线字符
                show_start = false, -- 作用域开始处不显示下划线
                show_end = false, -- 作用域结束处不显示下划线
                highlight = { "RainbowBlue" }, -- 单独指定作用域颜色（可选）
            },

            -- 排除某些文件类型或缓冲区类型（避免在终端、帮助等窗口中显示）
            exclude = {
                filetypes = {
                    "help",
                    "terminal",
                    "NvimTree",
                    "TelescopePrompt",
                    "lspinfo",
                    "qf", -- quickfix 列表
                },
                buftypes = {
                    "terminal",
                    "nofile",
                    "help",
                },
            },

            -- 性能优化：限制屏幕上下扫描的行数
            viewport_buffer = {
                max = 60, -- 默认 60，对于超大文件可适当调小
                min = 10,
            },

        })
    end,
}
