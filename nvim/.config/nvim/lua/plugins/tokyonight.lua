return {
    -- 东京夜主题 --
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- 确保主题在所有其他插件之前加载 --
    opts = {
        style = "night", 
        
        -- 透明设置 --
        -- transparent = true, -- 开启主编辑区背景透明 --
        -- styles = {
        --     sidebars = "transparent", -- 侧边栏（如 Neo-tree）透明 --
        --     floats = "transparent",   -- 浮窗（如 LSP 诊断、Telescope）透明 --
        -- },

        -- 细节增强 --
        dim_inactive = false,      -- 不变暗非活动窗口 --
        lualine_bold = true,       -- 在 lualine 中使用加粗字体 --
    },
    config = function(_, opts)
        local tokyonight = require("tokyonight")
        tokyonight.setup(opts) -- 应用上面的配置 --
        
        -- 核心：将主题设为当前颜色方案 --
        vim.cmd([[colorscheme tokyonight]])
    end,
}
