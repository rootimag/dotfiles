-- 自动加载 lazy.nvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- 如果未安装则自动克隆仓库 --
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
    -- 克隆失败时显示错误信息并退出 --
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)  -- 将 lazy.nvim 加入运行时路径 --

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
    spec = {
      { import = "plugins" },     -- 会自动加载 lua/plugins/*.lua 里的所有 return { ... } --
    },

    defaults = {
        lazy = true,                -- 默认所有插件都懒加载 --
    },

    -- 其他常用设置 --
    install = { colorscheme = { "tokyonight-night" } }, -- 更新时使用主题加载 UI --
    checker = { 
        enabled = true, -- 自动检查更新 --
        notify = false, -- 不要通知 --
    },          
})
