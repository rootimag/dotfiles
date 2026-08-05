return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    opts = {
        check_ts = true,                                 -- 启用 Treesitter 语法树检测，避免在字符串/注释中误补全
        ts_config = {
            lua = { "string" },                          -- Lua 字符串节点内禁用自动补全
            javascript = { "template_string" },          -- JS 模板字符串节点内禁用自动补全
        },
        disable_filetype = { "TelescopePrompt", "vim" }, -- 在特定的 Buffer 类型中禁用自动括号
        enable_check_bracket_line = true,                -- 检查同一行后续是否有未闭合括号，避免重复插入闭合符号
        ignored_next_char = "[%w%.]",                    -- 当下一个字符是字母、数字或点号时不自动补全

        -- Fast Wrap 快速包裹功能配置 (<Alt-e> 触发)
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = [=[[%'%"%>%]%)%}%,]]=],
            offset = 0, -- 0 表示包裹目标光标位置，-1 表示前一个字符
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",       -- 高亮组名称，改为 Search 会比 PmenuSel 更醒目
            highlight_grey = "Comment", -- 灰色未选中提示的高亮组改为 Comment，透出更自然
        },
    },
    config = function(_, opts)
        local autopairs = require("nvim-autopairs")
        autopairs.setup(opts)

        -- 自动与 nvim-cmp 集成：补全函数或方法后自动追加括号 ()
        local cmp_status, cmp = pcall(require, "cmp")
        if cmp_status then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
