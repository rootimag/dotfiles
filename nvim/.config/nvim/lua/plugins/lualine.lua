return {
    -- nvim 底部状态栏 --
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 依赖图标插件 --
    event = "VeryLazy", 
    opts = {
        options = {
            theme = "tokyonight-night", -- 设置主题 --
            icons_enabled = true,       -- 开启图标 --
            -- 分隔符设置（Powerline 风格） --
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            -- 在这些特殊窗口中禁用状态栏 --
            disabled_filetypes = {
                statusline = { "dashboard", "alpha", "ministarter", "lazy", "neo-tree", "Trouble" },
                winbar = {},
            },
            globalstatus = true, -- 开启全局状态栏（所有窗口共用一个底栏） --
            refresh = { statusline = 150 }, -- 刷新频率（毫秒） --
        },
        sections = {
            -- A 区：模式显示 (NORMAL/INSERT/VISUAL) --
            lualine_a = {
                {
                    "mode",
                    -- 格式化：只取首字母（如 NORMAL -> N），减少空间占用 --
                    fmt = function(str) return " " .. str:sub(1,1) .. " " end,
                    separator = { left = "" }, 
                    padding = { left = 1, right = 1 },
                },
            },
            -- B 区：Git 信息 --
            lualine_b = { 
                "branch", 
                { "diff", colored = true } -- 显示 Git 增删改统计 --
            },
            -- C 区：文件名与路径 --
            lualine_c = {
                {
                    "filename",
                    file_status = true, -- 显示文件状态（只读、已修改） --
                    path = 1,           -- 0: 仅文件名, 1: 相对路径, 2: 绝对路径 --
                    shorting_target = 40, -- 路径过长时自动缩短 --
                    symbols = {
                        modified = "●",   -- 文件已修改标记 --
                        readonly = "",   -- 只读标记 --
                        unnamed = "[无名]",
                        newfile = "󰎔",    -- 新文件标记 --
                    },
                },
            },
            -- X 区：诊断与系统信息 --
            lualine_x = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" }, -- 诊断数据源 --
                    symbols = {
                        error = "󰅙 ",
                        warn = "󰀪 ",
                        info = "󰋼 ",
                        hint = "󰌵 ",
                    },
                    colored = true,
                    update_in_insert = false, -- 插入模式时不更新诊断，防止闪烁 --
                },
                "encoding", -- 文件编码 (UTF-8) --
                {
                    "fileformat",
                    -- 针对不同操作系统显示特定图标 --
                    symbols = { unix = "", dos = "", mac = "" },
                },
                {
                    "filetype",
                    icon_only = true, -- 仅显示图标，不显示文字 --
                    separator = "",
                    padding = { left = 1, right = 1 },
                },
            },
            -- Y 区：阅读进度 --
            lualine_y = { "progress" },
            -- Z 区：具体光标位置 --
            lualine_z = {
                {
                    "location",
                    separator = { right = "" },
                    padding = { left = 1, right = 1 },
                },
            },
        },
        -- 当窗口不活跃时的状态栏样式 --
        inactive_sections = {
            lualine_c = { "filename" },
            lualine_x = { "location" },
        },
    },
}
