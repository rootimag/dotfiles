return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",

    keys = {
        { "<Tab>",      "<Cmd>BufferLineCycleNext<CR>",   mode = "n", desc = "Next Buffer" },
        { "<S-Tab>",    "<Cmd>BufferLineCyclePrev<CR>",   mode = "n", desc = "Previous Buffer" },
        { "<C-Left>",   "<Cmd>BufferLineMovePrev<CR>",    mode = "n", desc = "Move Buffer Left" },
        { "<C-Right>",  "<Cmd>BufferLineMoveNext<CR>",    mode = "n", desc = "Move Buffer Right" },
        { "<leader>bd", "<Cmd>bdelete!<CR>",              mode = "n", desc = "Delete Buffer" },
        { "<leader>bc", "<Cmd>BufferLinePickClose<CR>",   mode = "n", desc = "Pick Close Buffer" },
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",   mode = "n", desc = "Toggle Pin Buffer" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", mode = "n", desc = "Delete Other Buffers" },
    },

    opts = function()
        local bufferline = require("bufferline")
        return {
            -- 自定义 Pin（固定页）图标样式
            options = {
                groups = {
                    items = {
                        require("bufferline.groups").builtin.pinned:with({
                            icon = "󰐃",
                        }),
                    },
                },
                mode = "buffers",                               -- 标签栏模式：显示 buffer 列表（非 tab 选项卡）
                style_preset = bufferline.style_preset.minimal, -- 极简风格预设
                separator_style = "thin",                       -- 标签之间的分割线样式

                show_buffer_close_icons = false,                -- 隐藏单个标签右侧的关闭按钮
                show_close_icon = false,                        -- 隐藏最右侧的总关闭按钮
                indicator = {
                    style = "none",                             -- 禁用当前激活标签周围的指示线条/块
                },

                numbers = "ordinal",      -- 标签序号显示格式（1, 2, 3...）
                diagnostics = "nvim_lsp", -- 开启 LSP 诊断集成

                -- LSP 诊断图标与数量渲染逻辑
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or " "
                    return icon .. count
                end,

                -- 侧边栏/文件树显示时的顶栏偏移对齐配置
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "EXPLORER",
                        text_align = "left",
                        separator = true,
                    },
                },

                persist_buffer_sort = true,    -- 保持手动拖拽或平移后的 Buffer 排序
                always_show_bufferline = true, -- 仅有一个 Buffer 时也始终显示顶部标签栏
            }
        }
    end,
}
