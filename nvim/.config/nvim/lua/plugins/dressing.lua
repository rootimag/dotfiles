return {
    "stevearc/dressing.nvim",
    event = "VeryLazy", -- 懒加载，首次触发 vim.ui.select / vim.ui.input 时才加载
    opts = {
        input = {
            -- vim.ui.input 的浮窗样式（例如重命名变量、输入文件名等场景）
            enabled = true,
            default_prompt = "Input:",
            title_pos = "left",
            relative = "cursor",
            border = "rounded",
            win_options = {
                winblend = 0,
            },
        },
        select = {
            -- vim.ui.select 的样式（例如 DAP 选择配置、LSP Code Action 等场景）
            enabled = true,
            -- 选择器的后端策略：优先使用 telescope，未安装则依次降级尝试后续后端
            backend = { "builtin", "nui" },

            -- 当回退或强制使用 builtin（内置弹窗）时的样式配置
            builtin = {
                border = "rounded",
                relative = "editor",
                win_options = {
                    winblend = 0,
                },
                mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"]  = "Confirm",
                },
            },
        },
    },
}
