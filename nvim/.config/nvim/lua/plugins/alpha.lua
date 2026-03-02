return {
    -- nvim 欢迎界面 --
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        
        -- header 配置 --
    	dashboard.section.header = require("config.header")
        
        -- button 配置 --
        dashboard.section.buttons.val = {
            dashboard.button("f", "  查找文件", ":Telescope find_files<CR>"),
            dashboard.button("e", "  浏览文件", ":Yazi<CR>"),
            dashboard.button("n", "  新建文件", ":enew<CR>"),
            dashboard.button("r", "  最近文件", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "  设置", ":e $MYVIMRC<CR>"),
            dashboard.button("q", "  退出", ":qa<CR>"),
        }
        dashboard.section.buttons.opts.hl = "AlphaButtons"

        -- footer 配置 --
        local fortune = "α 结束乐队 Never Ends 󰝚 α"
	    dashboard.section.footer.val = fortune
        dashboard.section.footer.opts.hl = "AlphaFooter"
        
        -- layout 布局 --
        dashboard.config.layout = {
            { type = "padding", val = 1 },              
            dashboard.section.header,                   
            { type = "padding", val = 1 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        -- color 颜色 --
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                vim.api.nvim_set_hl(0, "AlphaHeader",  { fg = "#7aa2f7" })
                vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#bb9af7" })
                vim.api.nvim_set_hl(0, "AlphaFooter",  { fg = "#9ece6a" })
            end,
        })
        
        -- Lazy 启动统计，将覆盖 footer --
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "" .. stats.count .. " 个插件加载完成，耗时 " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        return dashboard
    end,
    config = function(_, dashboard)
        require("alpha").setup(dashboard.config)
    end,
}
