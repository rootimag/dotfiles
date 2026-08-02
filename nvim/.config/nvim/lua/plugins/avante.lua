return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",

        "stevearc/dressing.nvim",
        "MeanderingProgrammer/render-markdown.nvim",
        "ibhagwan/fzf-lua",
    },

    opts = {
        provider = "openrouter",
        auto_suggestions_provider = "openrouter",
        providers = {
            openrouter = {
                __inherited_from = "openai",
                endpoint = "https://openrouter.ai/api/v1",
                api_key_name = "OPENROUTER_API_KEY",
                model = "deepseek/deepseek-v3.2",
            },
        },
    }
}
