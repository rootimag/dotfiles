vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "sd", "<ESC>")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")

keymap.set('n', '<C-h>', '<C-w>h', { desc = "移动至左侧窗口" })
keymap.set('n', '<C-l>', '<C-w>l', { desc = "移动至右侧窗口" })
keymap.set('n', '<C-j>', '<C-w>j', { desc = "移动至下侧窗口" })
keymap.set('n', '<C-k>', '<C-w>k', { desc = "移动至上侧窗口" })

vim.keymap.set('n', '<F5>', function()
    vim.cmd('w')
    local dir = vim.fn.expand('%:p:h')
    local file_no_ext = vim.fn.expand('%:t:r')
    local cmd = string.format(
        "split | term cd %s && g++ %s.cpp -o %s && ./%s",
        dir, file_no_ext, file_no_ext, file_no_ext
    )
    vim.cmd(cmd)
end, { desc = "编译并运行 C++" })
