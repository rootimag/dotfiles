return {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        { "nvim-treesitter/nvim-treesitter-context" },
        { "HiPhish/rainbow-delimiters.nvim" },
    },

    config = function()
        local ts = require('nvim-treesitter')

        ts.setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            },
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
            "lua", "vim", "vimdoc", "query", "cpp", "kdl", "css", "json", "markdown", "markdown_inline", "regex", "bash" })
    end,
}
