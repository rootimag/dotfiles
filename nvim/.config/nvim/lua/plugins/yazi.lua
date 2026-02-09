return {
    -- nvim yazi --
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", },
    keys = {
        {
            "<leader>e",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "在当前目录打开 Yazi",
        },
    },
}
