return {
    -- 语法解析器 --
    'nvim-treesitter/nvim-treesitter',
    branch = "main", -- 使用 main 分支 --
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        { "nvim-treesitter/nvim-treesitter-context" },
        { "HiPhish/rainbow-delimiters.nvim" },
    },

    config = function() 
        -- 直接引用 nvim-treesitter 模块 --
        local ts = require('nvim-treesitter')

        -- 核心配置 --
        ts.setup({
            -- 这里的配置项目前在 main 分支中被直接支持 --
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            },
            -- 增量选择 --
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                },
            },
        })

        ts.install({
            "lua", "vim", "vimdoc", "query", "cpp", "kdl", "css", "json", "markdown", "markdown_inline"})
    end,
}
