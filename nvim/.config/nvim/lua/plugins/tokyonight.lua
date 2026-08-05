return {
    "folke/tokyonight.nvim",
    lazy = false,                     -- 主题插件必须禁用懒加载，确保启动时优先加载样式
    priority = 1000,                  -- 设置最高加载优先级，防止首屏渲染时出现闪烁或色彩未加载问题
    opts = {
        style = "night",              -- 主题子风格：night (暗夜), storm (暴风雨), day (白昼), moon (月光)
        cache = true,                 -- 开启编译缓存以加速主题加载速度

        transparent = true,           -- 开启全局背景透明
        styles = {
            sidebars = "transparent", -- 侧边栏背景透明 (如 Neo-tree)
            floats = "transparent",   -- 浮窗背景透明 (如 Hover 文档、弹窗)
        },

        dim_inactive = false, -- 禁用未激活窗口变暗功能，保持全局高亮一致
        lualine_bold = true,  -- 在 lualine 状态栏中使用加粗字体
    },
    config = function(_, opts)
        local tokyonight = require("tokyonight")
        tokyonight.setup(opts)

        -- 应用 TokyoNight 主题
        vim.cmd([[colorscheme tokyonight]])
    end,
}
