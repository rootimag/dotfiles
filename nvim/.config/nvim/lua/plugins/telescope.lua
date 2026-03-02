return {
    -- 文件查找 --
    'nvim-telescope/telescope.nvim',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    
    config = function()
        -- 核心配置
        require('telescope').setup {
        }

        -- 快捷键配置
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '查找文件' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '实时 grep 搜索' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '查找打开的缓冲区' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Neovim 帮助标签' })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '最近文件' })
    end,
}
