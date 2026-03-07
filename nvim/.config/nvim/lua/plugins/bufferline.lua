return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
        { "<Tab>",      "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
        { "<S-Tab>",    "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
        { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Pick Close" },
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    },
    opts = {
        options = {
            mode = "buffers",
            separator_style = "thin",
            show_buffer_close_icons = false,
            show_close_icon = false,
            indicator = { style = "none" },

            numbers = "ordinal",
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or " "
                return "(" .. count .. ")"
            end,

            offsets = {
                {
                    filetype = "neo-tree",
                    text = "EXPLORER",
                    text_align = "left",
                    separator = true,
                },
            },

            persist_buffer_sort = true,
            always_show_bufferline = true,
        },
    },
}
