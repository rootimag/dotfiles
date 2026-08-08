return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify", -- 提供平滑美观的浮动通知栏
        },
        keys = {
            -- 查看 Noice 消息历史记录
            { "<leader>N",  "<Cmd>Noice history<CR>",                    desc = "Noice Message History" },
            -- 清除当前显示的通知 / 弹窗
            { "<leader>Nd", "<Cmd>Noice dismiss<CR>",                    desc = "Dismiss All Noice Notices" },
            -- 重新显示最后一条 Noice 消息
            { "<leader>Nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
        },
        opts = {
            -- LSP 相关 UI 重写与接管
            lsp = {
                progress = { enabled = false }, -- 关闭右下角繁琐的 LSP 进度加载条（可根据喜好开启）
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- 接管补全菜单的文档悬浮窗
                },
            },
            -- 预设样式配置
            presets = {
                bottom_search = true,         -- 经典的底部栏搜索 (使用传统样式而不是浮窗搜索，更符合直觉)
                command_palette = true,       -- 开启命令面板样式 (将命令行置于屏幕中央，更像 IDE)
                long_message_to_split = true, -- 长消息自动分流到底部分割窗口，避免大片文字遮挡
                inc_rename = false,           -- 启用增量重命名弹窗 (若装了 inc-rename.nvim 可设为 true)
            },
            -- 消息过滤与路由配置 (用于屏蔽烦人的无用提示)
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written", -- 屏蔽保存文件时弹出的 "xxx written" 提示
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        find = "search hit BOTTOM", -- 屏蔽搜索触底提示
                    },
                    opts = { skip = true },
                },
            },
            -- 核心视图与弹窗尺寸定制
            views = {
                cmdline_popup = {
                    position = { row = 2, col = "50%" }, -- 命令面板居中偏上
                    size = { width = 60, height = "auto" },
                    border = { style = "rounded" },      -- 圆角边框
                },
                cmdline_popupmenu = {
                    position = { row = 5, col = "50%" },
                    size = { width = 60, height = 10 },
                    border = { style = "rounded" },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        },

    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            local notify = require("notify")

            -- 基本配置
            ---@diagnostic disable-next-line: undefined-field
            notify.setup({
                render = "compact",            -- 通知窗口风格
                stages = "slide",              -- 动画风格
                timeout = 3000,                -- 超时时间（毫秒)
                level = vim.log.levels.INFO,   -- 通知层级
                background_colour = "#000000", -- 背景颜色
                -- 最大高度（行数）
                max_height = function()
                    return math.floor(vim.o.lines * 0.5)
                end,
                -- 最大宽度（列数）
                max_width = function()
                    return math.floor(vim.o.columns * 0.5)
                end,
                -- 是否在插入模式下显示
                on_open = nil,
                on_close = nil,
            })

            vim.notify = notify
        end,
    }
}
