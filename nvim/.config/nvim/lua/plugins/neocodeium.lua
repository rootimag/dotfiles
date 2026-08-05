return {
    "monkoose/neocodeium",
    event = "VeryLazy", -- 懒加载，在触发事件后加载以保证首屏秒开
    opts = {
        -- 可在此处配置静默、自定义提示路径等，默认配置已经足够轻量
    },
    config = function(_, opts)
        local neocodeium = require("neocodeium")
        neocodeium.setup(opts)

        -- 统一的快捷键配置选项
        local opts_map = { silent = true }

        -- 插入模式：接受当前的 AI 补全建议
        vim.keymap.set("i", "<A-n>", function()
            neocodeium.accept()
        end, vim.tbl_extend("force", opts_map, { desc = "Codeium Accept" }))

        -- 插入模式：仅接受当前建议的一个词（适合精准微调）
        vim.keymap.set("i", "<A-w>", function()
            neocodeium.accept_word()
        end, vim.tbl_extend("force", opts_map, { desc = "Codeium Accept Word" }))

        -- 插入模式：拒绝/清除当前的 AI 补全建议
        vim.keymap.set("i", "<A-c>", function()
            neocodeium.clear()
        end, vim.tbl_extend("force", opts_map, { desc = "Codeium Clear" }))

        -- 插入模式：切换到下一个可用的 AI 补全建议
        vim.keymap.set("i", "<A-[>", function()
            neocodeium.cycle_or_complete()
        end, vim.tbl_extend("force", opts_map, { desc = "Codeium Cycle Next" }))
    end,
}
