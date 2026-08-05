return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- 调试 UI 界面
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            config = function()
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup()

                -- 调试开始与结束时自动打开/关闭 UI
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close()
                end
            end,
        },
        -- 在代码行尾显示变量实时值的虚拟文本
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {
                enabled = true,
                show_stop_reason = true,
            },
        },
        -- 自动管理和安装 DAP 适配器（统一使用 mason-org 仓库名）
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = { "mason-org/mason.nvim" },
            opts = {
                ensure_installed = { "codelldb" },
                automatic_installation = true,
                handlers = {},
            },
        },
    },
    keys = {
        { "<F5>",       function() require("dap").continue() end,                                             desc = "Debug: Start/Continue" },
        { "<F10>",      function() require("dap").step_over() end,                                            desc = "Debug: Step Over" },
        { "<F11>",      function() require("dap").step_into() end,                                            desc = "Debug: Step Into" },
        { "<F12>",      function() require("dap").step_out() end,                                             desc = "Debug: Step Out" },
        { "<leader>b",  function() require("dap").toggle_breakpoint() end,                                    desc = "Debug: Toggle Breakpoint" },
        { "<leader>B",  function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional Breakpoint" },
        { "<leader>dx", function() require("dap").terminate() end,                                            desc = "Debug: Terminate Session" },
        { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Debug: Toggle UI" },
    },
    config = function()
        local dap = require("dap")

        -- 断点图标与高亮定义（统一在此处维护，options.lua 中不再重复定义）
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF0055", bold = true })
        vim.api.nvim_set_hl(0, "DapBreakpointLine", { bg = "#3A1018" })
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bold = true })
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#1e3a2a" })

        vim.fn.sign_define("DapBreakpoint", {
            text = "🔴",
            texthl = "DapBreakpoint",
            linehl = "DapBreakpointLine",
            numhl = "DapBreakpoint",
        })
        vim.fn.sign_define("DapBreakpointCondition", {
            text = "🟡",
            texthl = "DapBreakpointCondition",
            linehl = "",
            numhl = "",
        })
        vim.fn.sign_define("DapLogPoint", {
            text = "🔷",
            texthl = "DapLogPoint",
            linehl = "",
            numhl = "",
        })
        vim.fn.sign_define("DapStopped", {
            text = "󰁕 ",
            texthl = "DapStopped",
            linehl = "DapStoppedLine",
            numhl = "",
        })

        -- CodeLLDB 适配器配置
        local mason_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = mason_path,
                args = { "--port", "${port}" },
            },
        }

        -- C / C++ 调试配置策略
        dap.configurations.cpp = {
            {
                name = "Launch Current File Binary (Auto Detect)",
                type = "codelldb",
                request = "launch",
                program = function()
                    -- 优先查找同目录下同名的无后缀可执行文件 (例如 main.cpp -> main)
                    local current_file_bin = vim.fn.expand("%:p:r")
                    if vim.fn.executable(current_file_bin) == 1 then
                        return current_file_bin
                    end

                    -- 次之查找 ./build/ 目录下的二进制文件
                    local build_bin = vim.fn.getcwd() .. "/build/" .. vim.fn.expand("%:t:r")
                    if vim.fn.executable(build_bin) == 1 then
                        return build_bin
                    end

                    -- 保底弹窗让用户手动选择/输入
                    return vim.fn.input("Executable path: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                runInTerminal = false,
            },
            {
                name = "Launch (Manual Select)",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Executable path: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                runInTerminal = false,
            },
        }

        -- 复用配置给 C 与 Rust 语言
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
    end,
}
