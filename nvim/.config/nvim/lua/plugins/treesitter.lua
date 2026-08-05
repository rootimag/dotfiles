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
        require('nvim-treesitter').setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "query", "cpp", "kdl", "css", "json", "java",
                "markdown", "markdown_inline", "regex", "bash", "slint"
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
