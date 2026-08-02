return {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        { "nvim-treesitter/nvim-treesitter-context" },
        { "HiPhish/rainbow-delimiters.nvim" },
    },
    config = function()
        local ts = require('nvim-treesitter')

        ts.setup({
            install_dir = vim.fn.stdpath('data') .. '/site'
        })

        ts.install({
            "lua", "vim", "vimdoc", "query", "cpp", "kdl", "css", "json", "java",
            "markdown", "markdown_inline", "regex", "bash", "slint"
        })

        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        vim.keymap.set('n', '<CR>', function()
            require('nvim-treesitter').select_node({ mode = 'node' })
        end)
    end,
}
