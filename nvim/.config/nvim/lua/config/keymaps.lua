-- 基础快捷键与自定义映射配置
local set = vim.keymap.set

-- 插入模式：按 jk 快速退出插入模式回到 Normal 模式
set("i", "jk", "<ESC>")

-- 视图模式：上下移动选中的代码块并自动对齐缩进
set("v", "J", "<Cmd>m '>+1<CR>gv=gv")
set("v", "K", "<Cmd>m '<-2<CR>gv=gv")

-- 窗口分屏映射
set("n", "<leader>sv", "<C-w>v", { desc = "Split Window Vertically" })
set("n", "<leader>sh", "<C-w>s", { desc = "Split Window Horizontally" })

-- 统一普通模式与终端模式下的跨窗口无缝导航 (Ctrl + h/j/k/l)
set({ "n", "t" }, "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to Left Window" })
set({ "n", "t" }, "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to Lower Window" })
set({ "n", "t" }, "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to Upper Window" })
set({ "n", "t" }, "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to Right Window" })

-- 窗口尺寸调整：方向键调整
set("n", "<A-Up>", "<Cmd>resize +1<CR>", { desc = "Increase Window Height" })
set("n", "<A-Down>", "<Cmd>resize -1<CR>", { desc = "Decrease Window Height" })
set("n", "<A-Left>", "<Cmd>vertical resize -1<CR>", { desc = "Decrease Window Width" })
set("n", "<A-Right>", "<Cmd>vertical resize +1<CR>", { desc = "Increase Window Width" })

-- 窗口尺寸调整：hjkl 键调整
set("n", "<A-k>", "<Cmd>resize +1<CR>", { desc = "Increase Window Height" })
set("n", "<A-j>", "<Cmd>resize -1<CR>", { desc = "Decrease Window Height" })
set("n", "<A-h>", "<Cmd>vertical resize -1<CR>", { desc = "Decrease Window Width" })
set("n", "<A-l>", "<Cmd>vertical resize +1<CR>", { desc = "Increase Window Width" })

-- 黑洞寄存器删除：删除单字或文本时不覆盖当前剪贴板中的内容
set("n", "x", '"_x')
set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete Without Yanking" })
