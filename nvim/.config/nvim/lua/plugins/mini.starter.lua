return {
    "echasnovski/mini.starter",
    version = false,
    event = "VimEnter",
    config = function()
        local starter = require("mini.starter")

        starter.setup({
            -- 居中对齐界面
            evaluate_single = true,

            -- 页眉
            header = [[
 █▄ █ █▀█ █ █ █ █▄▄▄█ █▀▄▀█
 █ ▀█ ██▄ ▀▄▀ █ █ █ █ █ ▀ █
            ]],

            -- 菜单选项列表
            items = {
                { shortcut = "1", name = "New Buffer",  action = "ene | startinsert",              section = "Actions" },
                { shortcut = "2", name = "Edit Config", action = "edit $MYVIMRC",                  section = "Actions" },
                { shortcut = "3", name = "Keybindings", action = "edit ~/.config/nvim/KEYMAPS.md", section = "Actions" },
                { shortcut = "4", name = "Quit Neovim", action = "qa",                             section = "Actions" },
                -- 显示最近打开的 4 个文件
                starter.sections.recent_files(4, true),
            },

            -- 禁用底部的格式化文本
            footer = "",

            -- 内容对齐格式
            content_hooks = {
                starter.gen_hook.adding_bullet("  "),          -- 选项前添加缩进
                starter.gen_hook.aligning("center", "center"), -- 上下左右居中
            },
        })
    end,
}
