return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        padding = true, -- 在注释符号与代码之间自动添加空格（如 // code）
        sticky = true,  -- 切换注释后，光标保持在原位置
        ignore = "^$",  -- 忽略空行，避免对纯空行进行注释

        -- 禁用默认按键映射，统一使用自定义的快捷键
        mappings = {
            basic = false,
            extra = false,
        },

        pre_hook = nil,
        post_hook = nil,
    },
    config = function(_, opts)
        require("Comment").setup(opts)

        local api = require("Comment.api")

        -- 说明：绝大多数 Linux 终端中 Ctrl+/ 会被识别为 <C-_>，因此同时绑定以保障兼容性
        local toggle_current = api.toggle.linewise.current

        -- Normal 模式：切换当前行注释
        vim.keymap.set("n", "<C-/>", toggle_current, { desc = "Toggle Comment" })
        vim.keymap.set("n", "<C-_>", toggle_current, { desc = "Toggle Comment" })

        -- Visual 模式：切换选中区域注释
        local toggle_visual = function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            api.toggle.linewise(vim.fn.visualmode())
        end
        vim.keymap.set("v", "<C-/>", toggle_visual, { desc = "Toggle Comment for Selection" })
        vim.keymap.set("v", "<C-_>", toggle_visual, { desc = "Toggle Comment for Selection" })

        -- Insert 模式：切换当前行注释并保留在插入模式
        local toggle_insert = function()
            toggle_current()
            vim.cmd("startinsert")
        end
        vim.keymap.set("i", "<C-/>", toggle_insert, { desc = "Toggle Comment" })
        vim.keymap.set("i", "<C-_>", toggle_insert, { desc = "Toggle Comment" })
    end,
}
