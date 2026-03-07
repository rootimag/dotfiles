return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[                               __                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            [[                                                 ]],
            [[            - NEOPHYTE TERMINAL SYSTEM -         ]],
        }
        dashboard.section.header.opts.hl = "AlphaHeader"

        dashboard.section.buttons.val = {
            dashboard.button("f", "󰍉  SEARCH_FILES", ":Telescope find_files<CR>"),
            dashboard.button("e", "󱏒  FILE_EXPLORE", ":Yazi<CR>"),
            dashboard.button("n", "󰝒  NEW_BUFFER",   ":enew<CR>"),
            dashboard.button("r", "󱋡  RECENT_CACHE", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "󰒓  SYSTEM_SETUP", ":e $MYVIMRC<CR>"),
            dashboard.button("q", "󰈆  TERMINATE",    ":qa<CR>"),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
            button.opts.width = 32
        end

        dashboard.config.layout[1].val = 2

        return dashboard
    end,
    config = function(_, dashboard)
        local set_hl = vim.api.nvim_set_hl
        set_hl(0, "AlphaHeader",   { fg = "#89b4fa", bold = true })
        set_hl(0, "AlphaButtons",  { fg = "#9399b2" })
        set_hl(0, "AlphaShortcut", { fg = "#fab387", bold = true })
        set_hl(0, "AlphaFooter",   { fg = "#585b70", italic = true })

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = {
                    " ",
                    string.format("󱐌 MODULES_LOADED: %d | LATENCY: %s ms", stats.count, ms)
                }
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                vim.opt_local.cursorline = false
            end,
        })

        require("alpha").setup(dashboard.config)
    end,
}
