return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        -- 在当前工作目录打开 Yazi
        {
            "<leader>e",
            "<cmd>Yazi<cr>",
            mode = { "n", "v" },
            desc = "Open Yazi in CWD",
        },
        -- 定位并打开当前正在编辑的文件所在的目录
        {
            "<leader>cw",
            "<cmd>Yazi cwd<cr>",
            desc = "Open Yazi in Current File Directory",
        },
    },
    opts = {
        open_for_directories = true,           -- 使用 Yazi 替代默认的 netrw 来打开目录
        floating_window_scaling_factor = 0.85, -- 浮窗在屏幕中所占的比例大小
        yazi_floating_window_winblend = 0,     -- 浮窗透明度设置
    },
}
