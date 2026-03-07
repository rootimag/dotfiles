return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "切换文件树" },
    },
    opts = {
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false,

        filesystem = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
            hijack_netrw_behavior = "open_default",
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },

        window = {
            position = "left",
            width = 30,
            mappings = {
                ["<space>"] = "none",
                ["l"] = "open",
                ["h"] = "close_node",
                ["P"] = { "toggle_preview", config = { use_float = true } },
            },
        },

        buffers = {
            follow_current_file = { enabled = true },
        },
    }
}
