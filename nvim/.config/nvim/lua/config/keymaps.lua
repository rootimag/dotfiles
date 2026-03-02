-- 设置主键为 SPACE --
vim.g.mapleader = " "

local keymap = vim.keymap

-- 设置连按 S-D 打开命令模式 --
keymap.set("i", "sd", "<ESC>")

-- 视觉模式 --
-- 多行移动：使用 J, K 移动光标 --
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 命令模式 --
-- 窗口分屏 --
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 --
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口 --

-- 窗口移动：使用 CTRL + H/J/K/L 移动窗口 --
keymap.set('n', '<C-h>', '<C-w>h', { desc = "移动至左侧窗口" })
keymap.set('n', '<C-l>', '<C-w>l', { desc = "移动至右侧窗口" })
keymap.set('n', '<C-j>', '<C-w>j', { desc = "移动至下侧窗口" })
keymap.set('n', '<C-k>', '<C-w>k', { desc = "移动至上侧窗口" })
