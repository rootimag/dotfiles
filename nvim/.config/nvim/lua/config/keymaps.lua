-- 快捷键配置 --

local set = vim.keymap.set

-- 插入模式：按 jk 快速退出插入模式回到 Normal 模式
set("i", "jk", "<ESC>")

-- 视图模式：上下移动选中的代码块并自动对齐缩进
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

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

-- 黑洞寄存器删除
set("n", "x", '"_x')
set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete Without Yanking" })

-- 快速保存与退出
set("n", "<leader>w", ":w<CR>", { desc = "Save File" })
set("n", "<leader>q", ":q<CR>", { desc = "Quit File" })

-- 打开终端并水平拆分
set("n", "<leader>t", ":split | terminal<CR>", { desc = "Open terminal (horizontal split)" })

local function auto_compile()
    local current_file = vim.fn.expand("%:p")
    if current_file == '' then
        vim.notify("No file opened", vim.log.levels.WARN)
        return
    end

    local file_dir = vim.fn.fnamemodify(current_file, ":h")
    local cmake_root = vim.fn.findfile("CMakeLists.txt", file_dir .. ";" .. vim.fn.getcwd() .. "/")
    if type(cmake_root) == "table" then
        cmake_root = cmake_root[1] or ""
    end
    if cmake_root ~= '' then
        local root_dir = vim.fn.fnamemodify(cmake_root, ":h")
        local build_dir = root_dir .. "/build"
        if not vim.fn.isdirectory(build_dir) then
            vim.fn.mkdir(build_dir, "p")
        end
        local camke_cmd = string.format("cd %s && cmake -B build -S . && cmake --build build -j",
            root_dir)
        vim.cmd("terminal " .. camke_cmd)
    else
        local compiler = "clang++"
        if vim.fn.executable("clang++") == 0 then
            if vim.fn.executable("g++") == 1 then
                compiler = "g++"
            else
                vim.notify("No C++ compiler found", vim.log.levels.WARN)
                return
            end
        end
        local out_name = vim.fn.fnamemodify(current_file, ":r")
        local compile_cmd = string.format("%s -std=c++20 -Wall -Wextra -O2 '%s' -o '%s'", compiler, current_file,
            out_name)
        vim.cmd("terminal " .. compile_cmd)
    end
end

-- 自动编译 C++ 程序
set("n", "<leader>m", auto_compile, { desc = "Auto Compile" })
