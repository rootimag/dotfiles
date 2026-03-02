return {
    -- buffer 底栏 --
    "akinsho/bufferline.nvim",
    version = "*",  
    dependencies = {
        "nvim-tree/nvim-web-devicons", 
    },
    event = "VeryLazy",  -- 延迟加载 --
    keys = {
        { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>",   desc = "下一个 buffer" },
        { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>",   desc = "上一个 buffer" },
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "固定/取消固定 buffer" },
        { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "选择关闭 buffer" },
        { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "跳转到 buffer 1" },
        { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "跳转到 buffer 2" },
        { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "跳转到 buffer 3" },
    },
    opts = {
        options = {
            mode = "buffers",               -- 显示 buffers（默认） --
            numbers = "ordinal",            -- 显示序号（1,2,3...） --
            close_command = "bdelete! %d",  -- 关闭 buffer 时用 bdelete --
            right_mouse_command = "vert sbuffer %d",
            middle_mouse_command = nil,
            indicator = {
                icon = "▎",                   -- 活跃 buffer 左侧指示条 --
                style = "icon",               -- "icon" | "underline" | "none" --
            },
            buffer_close_icon = "✕",        -- 关闭按钮图标 --
            modified_icon = "●",            -- 修改中图标 --
            close_icon = "✕",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 18,           -- buffer 名称最大长度 --
            max_prefix_length = 15,
            truncate_names = true,          -- 太长时截断 -- 
            tab_size = 18,
            diagnostics = "nvim_lsp",       -- 显示 LSP 诊断（错误/警告图标） --
            diagnostics_update_in_insert = false,
            -- 诊断图标自定义
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
            -- 侧边栏偏移
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "文件浏览器",          -- 显示文字，或 function() return "Neo-tree" end --
                    text_align = "center",
                    separator = true,
                },
            },
            color_icons = true,
            show_buffer_icons = true,       -- 显示文件类型图标 --
            show_buffer_close_icons = true,
            show_close_icon = false,        -- 右上角总关闭按钮 --
            show_tab_indicators = true,
            persist_buffer_sort = true,     -- 记住排序 --
            separator_style = "thin",      -- 分隔符样式 --
            enforce_regular_tabs = false,
            always_show_bufferline = true,  -- 始终显示 --
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },         -- hover 时显示关闭按钮 --
            },
            sort_by = "insert_after_current",  -- 插入位置：当前 buffer 后 --
        },
    },
}
