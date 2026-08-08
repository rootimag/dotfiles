return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim"
    },
    opts = {
        -- 直接设置语言，无需再嵌套一层 opts
        language = "Chinese",

        -- 适配器配置
        adapters = {
            deepseek = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    name = "deepseek",
                    env = {
                        api_key = os.getenv("DEEPSEEK_API_KEY"),
                        url = "https://api.deepseek.com",
                    },
                    endpoint = "https://api.deepseek.com/v1",
                    model = "deepseek-v4-flash",
                    max_tokens = 4096,
                    extra_request_body = {
                        thinking = { type = "disabled" },
                    },
                })
            end,
        },

        -- 交互配置（统一使用 interactions，不再使用 strategies）
        interactions = {
            chat = {
                adapter = "deepseek",
                opts = {
                    system_prompt = function(ctx)
                        local custom = [[
你是一位热爱技术的二次元少女，平时喜欢看番、逛漫展，也擅长写代码和折腾系统。
你的目标是成为我的编程搭档，用你特有的风格帮助我学习。

请遵循以下说话方式：
1. 语气亲切活泼：多用“呢”“哦”“呀”“啦”等助词，偶尔加个颜文字（比如 (｡•̀ᴗ-)✧ ），但别过度。
2. 二次元梗适当：可以偶尔吐槽“这代码像迷宫一样，比异世界还难闯”，或者用“魔法”“必杀技”比喻技术操作，但技术解释要清晰准确。
3. 温和纠错：当我犯错时，用轻松的方式指出，比如“这里有个小bug，就像装备插错槽位啦，咱们调整一下~”。
4. 鼓励式教学：我还在学习中，多给正面反馈，比如“这个思路不错，再优化一下就完美了！”。
5. 技术专业：虽然风格活泼，但代码、命令、原理必须说清楚，不能含糊。
6. 提供思路：对于询问的问题，给出一个解决方案，当我直接请求代码时，才给予完整代码。

请像朋友一样和我交流，让我觉得写代码就像冒险，有趣又充满成就感。
            ]]
                        return custom .. string.format([[
Additional context:
- Language: %s
- Working directory: %s
- Date: %s
- Neovim version: %s
- OS: %s
]], ctx.language, ctx.cwd, ctx.date, ctx.nvim_version, ctx.os)
                    end,
                },
                tools = {
                    opts = {
                        system_prompt = {
                            enabled = false, -- 关闭工具系统提示
                        },
                    },
                },
            },
            -- 内联交互移到顶层，与 chat 并列
            inline = {
                adapter = "deepseek",
            },
        },
        extensions = {
            history = {
                enabled = true,
                opts = {
                    keymap = "gh",           -- 在聊天缓冲区按 gh 打开历史
                    save_chat_keymap = "sc", -- 手动保存快捷键（auto_save=false时）
                    auto_save = true,        -- 自动保存所有聊天
                    expiration_days = 0,     -- 不过期
                    picker = "default",      -- 选择器，根据你安装的插件调整
                    auto_generate_title = true,
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                }
            }
        }
    },
    keys = {
        { "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "Open CodeCompanion chat" },
        { "<leader>cs", "<cmd>CodeCompanion<CR>",     desc = "Inline code transformation" },
    },
}
