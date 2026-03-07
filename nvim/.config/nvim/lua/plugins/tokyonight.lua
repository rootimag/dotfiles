return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "night",

        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },

        dim_inactive = false,
        lualine_bold = true,

        performance = {
            cache = {
                enabled = true,
            },
            reset_packpath = true,
            rtp = {
                reset = true,
            },
        },
    },
    config = function(_, opts)
        local tokyonight = require("tokyonight")
        tokyonight.setup(opts)

        vim.cmd([[colorscheme tokyonight]])
    end,
}
