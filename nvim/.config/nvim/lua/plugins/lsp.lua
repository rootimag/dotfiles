return {
    -- 1. mason: LSP 与外部 CLI 工具的包管理器
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
        priority = 900,
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    -- 2. mason-lspconfig: 自动确保指定的 LSP 服务已安装
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = { "lua_ls", "clangd" }, -- 启动时自动下载安装的服务列表
            automatic_installation = true,             -- 缺失时自动补全安装
        },
    },

    -- 3. mason-tool-installer: 自动安装 conform.nvim 所需的格式化与 lint 工具
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                -- 格式化工具（对应 conform.lua 中的 formatters_by_ft）
                "stylua",        -- Lua
                "clang-format",  -- C / C++
                "isort",         -- Python import 排序
                "black",         -- Python 格式化
                "prettierd",     -- Markdown / JSON / JavaScript
            },
            auto_update = false, -- 不在每次启动时自动更新，按需运行 :MasonToolsUpdate
            run_on_start = true, -- 首次启动时检查并补全安装缺失工具
        },
    },

    -- 4. nvim-lspconfig: 利用 Neovim 0.11+ 原生 API 配置与启动 LSP 服务
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- 自定义诊断侧边栏图标 (Sign Column)
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- 全局诊断显示配置
            vim.diagnostic.config({
                virtual_text = true,            -- 开启行内诊断文字提示
                update_in_insert = false,       -- 不在插入模式下实时更新诊断，避免打字干扰
                underline = true,               -- 给错误/警告代码下划线
                severity_sort = true,           -- 按照严重程度排序诊断消息
                float = { border = "rounded" }, -- 浮动诊断窗口使用圆角边框
            })

            -- 获取 nvim-cmp 注入的语言服务能力（如补全支持）
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 配置 Lua 语言服务 (lua_ls)
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" }, -- Neovim 内置 LuaJIT 环境
                        diagnostics = {
                            globals = { "vim" },          -- 识别 vim 全局变量，消除未定义提示
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true), -- 载入 Neovim 运行时类型库
                        },
                        telemetry = { enable = false },                        -- 关闭遥测收集
                        hint = { enable = true },                              -- 开启类型与参数推导提示 (Inlay Hints)
                    },
                },
            })

            -- 配置 C/C++ 语言服务 (clangd)
            vim.lsp.config("clangd", {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",      -- 后台建立索引以加速跳转
                    "--clang-tidy",            -- 开启静态代码分析
                    "-j=4",                    -- 并行编译索引线程数
                    "--header-insertion=iwyu", -- 自动补充包含头文件 (Include What You Use)
                },
            })

            -- 批量启用配置好的 LSP 服务 (Neovim 0.11+ API)
            vim.lsp.enable({ "lua_ls", "clangd" })

            -- 当 LSP 服务成功附着 (Attach) 到当前缓冲区时触发的自动命令
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(ev)
                    local buf = ev.buf
                    local opts = { buffer = buf, noremap = true, silent = true }

                    -- 快捷键绑定定义
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                        vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                        vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                        vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
                    vim.keymap.set("n", "gr", vim.lsp.buf.references,
                        vim.tbl_extend("force", opts, { desc = "Go to References" }))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover,
                        vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                        vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
                        vim.tbl_extend("force", opts, { desc = "Code Action" }))
                    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end,
                        vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
                    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,
                        vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))

                    -- 若 LSP 服务支持，自动开启内联类型提示 (Inlay Hints)
                    if vim.lsp.inlay_hint then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
                    end
                end,
            })
        end,
    },
}
