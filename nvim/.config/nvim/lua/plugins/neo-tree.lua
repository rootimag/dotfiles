return {
    -- 文件树 --
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- 使用稳定的 3.x 版本 --
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", 
    },
    cmd = "Neotree", -- 仅在执行 Neotree 命令时加载 --
    keys = {
        -- 切换文件树显示/隐藏 --
        { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "切换文件树" },
    },
    -- 注意：这里必须是 opts，不能是 opt --
    opts = {
        close_if_last_window = false, -- 如果只剩下文件树窗口，是否关闭 Vim --
        popup_border_style = "rounded", -- 浮窗使用圆角边框 --
        enable_git_status = true,      -- 显示文件的 Git 状态 --
        enable_diagnostics = true,     -- 显示文件的 LSP 诊断信息 --
        sort_case_insensitive = false, -- 排序是否对大小写不敏感 --

        filesystem = {
            -- 自动跟随当前正在编辑的文件 --
            follow_current_file = { 
                enabled = true,
                leave_dirs_open = false, -- 跟随文件时，不自动折叠其他目录 --
            },
            hijack_netrw_behavior = "open_default", -- 替代原生的 netrw 文件浏览器 --
            use_libuv_file_watcher = true,          -- 实时监控文件系统变化 --
            -- 过滤不需要显示的文件 --
            filtered_items = {
                visible = false, -- 是否显示隐藏文件 --
                hide_dotfiles = false, -- 不隐藏以点开头的文件 --
                hide_gitignored = false, -- 不隐藏被 git 忽略的文件 --
            },
        },

        window = {
            position = "left", -- 窗口位置：left, right, top, bottom, float --
            width = 30,        -- 窗口宽度 --
            mappings = {
                ["<space>"] = "none", -- 禁用空格键原有的映射，避免冲突 --
                ["l"] = "open",       -- 使用 l 打开文件 --
                ["h"] = "close_node", -- 使用 h 关闭/折叠目录 --
                ["P"] = { "toggle_preview", config = { use_float = true } }, -- 预览文件 --
            },
        },

        buffers = {
            -- 缓冲区列表模式下也自动跟随当前文件 --
            follow_current_file = { enabled = true },
        },
    }
}
