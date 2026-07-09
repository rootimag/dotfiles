return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup({
        })

        vim.keymap.set("i", "<A-n>", function()
            neocodeium.accept()
        end)

        vim.keymap.set("i", "<A-c>", function()
            neocodeium.clear()
        end)
    end,
}
