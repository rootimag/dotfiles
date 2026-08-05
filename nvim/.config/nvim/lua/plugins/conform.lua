return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" }, -- 支持 Normal 与 Visual 模式（选中文本局部格式化）
            desc = "Format Buffer",
        },
    },
    opts = {
        -- 按文件类型指定格式化工具
        formatters_by_ft = {
            lua = { "stylua" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            python = { "isort", "black" },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- 保存时自动格式化配置
        format_on_save = {
            timeout_ms = 1000,       -- 放宽超时限制至 1000ms，避免首次调用格式化超时
            lsp_format = "fallback", -- 无匹配格式化工具时降级使用 LSP 格式化
        },
    },
}
