return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        delay = function(ctx)
            return ctx.plugin and 0 or 200
        end,
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,
        -- 内置增强功能开关
        plugins = {
            marks = true,     -- 显示 marks 标记
            registers = true, -- 显示寄存器内容
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = true,    -- 提示 d, c, y 等操作符
                motions = true,      -- 提示 w, b, f 等移动按键
                text_objects = true, -- 提示 i", a( 等文本对象
                windows = true,      -- 提示 <c-w> 窗口操作
                nav = true,          -- 提示 z, g 等导航键
            },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (Which-key)",
        },
    },
}
