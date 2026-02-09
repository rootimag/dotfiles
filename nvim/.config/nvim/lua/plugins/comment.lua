return {
    -- 快捷注释 --
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('Comment').setup({
            -- 添加注释时在注释符号后添加空格 --
            padding = true,
            -- 注释时是否保留光标位置 --
            sticky = true,
            -- 在注释/取消注释时忽略空行 --
            ignore = '^$',
  
            -- 不启用键绑定，使用 CTRL + / --
            mappings = {
                basic = false,    -- 操作模式映射 --
                extra = false,    -- 额外映射 --
            },
  
            -- 预处理钩子函数
            pre_hook = nil,
            -- 后处理钩子函数
            post_hook = nil,
        })

        local api = require('Comment.api')
        
        vim.keymap.set('n', '<C-/>', api.toggle.linewise.current, { desc = '正常模式切换注释' })
        vim.keymap.set('v', '<C-/>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", 
            { desc = '可视模式切换注释' }
        )
        vim.keymap.set('i', '<C-/>', '<ESC><cmd>lua require("Comment.api").toggle.linewise.current()<CR>i', 
            { desc = '插入模式切换注释' }
        )

    end,
}
