return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('Comment').setup({
            padding = true,
            sticky = true,
            ignore = '^$',

            mappings = {
                basic = false,
                extra = false,
            },

            pre_hook = nil,
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
