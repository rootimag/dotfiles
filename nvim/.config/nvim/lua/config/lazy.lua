local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- 自动导入 lua/plugins/ 目录下的所有插件配置文件
    spec = {
        { import = "plugins" },
    },
    -- 默认将所有插件设置为延迟加载，提升启动速度
    defaults = {
        lazy = true,
    },
    install = { colorscheme = { "tokyonight-night" } },
    -- 自动检查插件更新（静默方式）
    checker = {
        enabled = true,
        notify = false,
    },
    rocks = { enabled = false }, -- 禁用 luarocks 自动构建以提升启动性能
    -- 禁用 Neovim 原生不常用的内置插件以优化资源占用
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
