return {
    -- Mason: 外部依赖管理器（LSP/DAP/Linter/Formatter） --
    {
        "mason-org/mason.nvim", 
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
        priority = 900,
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded", -- 界面使用圆角边框 --
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- Mason-Lspconfig: 桥接 Mason 和 lspconfig --
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- 确保这些服务器在启动时已安装 --
            ensure_installed = { "lua_ls" }, 
            -- 自动安装缺失的服务器 --
            automatic_installation = true, 
        },
    },

    -- Nvim-Lspconfig: LSP 核心配置 --
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp", -- 必须依赖补全插件以获取能力支持 --
        },
        config = function()
            -- 1. 自定义诊断符号 --
            local signs = {
                Error = "󰅚 ", 
                Warn = "󰀪 ",  
                Hint = "󰌶 ",  
                Info = " ",  
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- 2. 诊断显示配置 --
            vim.diagnostic.config({
                virtual_text = true, -- 开启行尾虚拟文字 --
                update_in_insert = false, -- 插入模式时不更新诊断（避免闪烁） --
                underline = true, -- 开启下划线 --
                severity_sort = true, -- 按照严重程度排序显示 --
                float = { border = "rounded" }, -- 浮窗使用圆角 --
            })

            local lspconfig = require("lspconfig")
            -- 告知服务器 Neovim 支持的补全能力 --
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 3. Lua 语言服务器专项配置 --
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            globals = { "vim" }, -- 消除 "未定义的全局变量 vim" 警告 --
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- 自动感知 Neovim 库文件 --
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = { enable = false },
                        hint = { enable = true }, -- 开启代码内联提示 --
                    },
                },
            })

            -- 4. LSP 绑定按键（仅在 LSP 附加到缓冲区时生效） --
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(ev)
                    local buf = ev.buf
                    local opts = { buffer = buf, noremap = true, silent = true }

                    -- 常用快捷键 --
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)      -- 定义 --
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)     -- 声明 --
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- 实现 --
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)      -- 引用 --
                    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)           -- 文档悬停 --
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)  -- 变量重命名 --
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- 修复建议 --

                    -- 诊断控制 --
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)    -- 上一个报错 --
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)    -- 下一个报错 --

                    -- 自动开启内联提示 (Inlay Hints) --
                    if vim.lsp.inlay_hint then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
                    end
                end,
            })
        end,
    },
}
