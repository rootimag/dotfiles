-- neovim 核心选项 --
local opt = vim.opt

-- 行号 --
opt.number = true       -- 显示绝对行号
opt.relativenumber = true  -- 显示相对行号
opt.cursorline = true

-- 缩进 --
opt.tabstop = 4         -- TAB 键显示为4个空格
opt.shiftwidth = 4      -- 自动缩进使用的空格数
opt.expandtab = true    -- 将 TAB 转换为空格
opt.autoindent = true   -- 继承上一行缩进
opt.smartindent = true  -- 基于语法结构的智能缩进

-- 颜色 --
opt.background = "dark"

-- 配置主题 tokyonight --
vim.cmd.colorscheme "tokyonight"
