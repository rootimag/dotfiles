local opt = vim.opt

-- 设置 Leader 键为空格键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用原生的 Statusline
vim.opt.laststatus = 0

-- 禁用不必要的语言 Provider 以加速启动
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- 系统与编辑基础设置
opt.clipboard = "unnamedplus" -- 共享系统剪贴板
opt.mouse = "a"               -- 开启鼠标支持
opt.ignorecase = true         -- 搜索时忽略大小写
opt.smartcase = true          -- 若搜索词包含大写字母则精准匹配大小写
opt.splitright = true         -- 新垂直分屏默认在右侧打开
opt.splitbelow = true         -- 新水平分屏默认在下方打开
opt.undofile = true           -- 开启持久化撤销历史
opt.updatetime = 250          -- 响应时间（毫秒），影响磁盘写入与浮窗触发速度
opt.signcolumn = "yes"        -- 总是显示侧边标记列（避免 LSP/Git 标记出现时页面抖动）
opt.scrolloff = 8             -- 光标上下移动时保留的屏幕行数缓冲区

-- 行号与高亮
opt.number = true         -- 显示绝对行号
opt.relativenumber = true -- 显示相对行号（方便快捷键跳转）
opt.cursorline = true     -- 高亮当前光标所在行

-- 缩进与 Tab 设置
opt.tabstop = 4         -- 1 个 Tab 渲染为 4 个空格的宽度
opt.shiftwidth = 4      -- 自动缩进的空格长度为 4
opt.expandtab = true    -- 将输入 Tab 自动转换为空格
opt.autoindent = true   -- 新行自动继承上一行的缩进
opt.smartindent = true  -- 根据语法结构智能计算下一行的缩进

opt.background = "dark" -- 使用暗色背景主题
