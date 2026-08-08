return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>n", "<Cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
    },
    opts = {
        close_if_last_window = false,   -- 关闭仅剩的 Neo-tree 窗口时不自动退出 Neovim
        popup_border_style = "rounded", -- 浮窗边框样式
        enable_git_status = true,       -- 显示 Git 状态标记（新增、修改、未追踪等）
        enable_diagnostics = true,      -- 显示 LSP 诊断错误/警告标记
        sort_case_insensitive = false,  -- 排序时区分大小写

        filesystem = {
            follow_current_file = {
                enabled = true,                     -- 自动定位并在文件树中高亮当前正在编辑的文件
                leave_dirs_open = false,            -- 自动定位时折叠未激活的目录
            },
            hijack_netrw_behavior = "open_default", -- 接管 netrw 默认打开目录的行为
            use_libuv_file_watcher = true,          -- 使用系统事件监听文件变动，实时自动刷新
            filtered_items = {
                visible = false,                    -- 被过滤掉的项目默认不显示
                hide_dotfiles = false,              -- 不隐藏点开头的文件（如 .gitignore, .config）
                hide_gitignored = false,            -- 不隐藏 .gitignore 忽略的文件
            },
        },

        window = {
            position = "left",                                                     -- 侧边栏停靠在左侧
            width = 30,                                                            -- 默认侧边栏宽度
            mappings = {
                ["<space>"] = "none",                                              -- 取消空格键在文件树中的默认映射，避免冲突
                ["l"]       = "open",                                              -- l 键：展开文件夹或打开文件
                ["h"]       = "close_node",                                        -- h 键：折叠当前父文件夹
                ["P"]       = { "toggle_preview", config = { use_float = true } }, -- P 键：打开/关闭悬浮窗口预览
            },
        },

        buffers = {
            follow_current_file = { enabled = true }, -- Buffer 视图下也保持同步高亮当前文件
        },
    },
}
