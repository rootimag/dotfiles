return {
    -- 自动补全括号 --
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/nvim-cmp',
    },
    config = function()
        local autopairs = require('nvim-autopairs')
        
        autopairs.setup({
            check_ts = true, -- 启用 Treesitter 支持，让括号匹配更智能（比如判断是否在字符串内） --
            ts_config = {
                lua = { 'string' }, -- 在 Lua 的 string (字符串) 节点中不触发自动补全 --
                javascript = { 'template_string' }, -- 在 JS 的模板字符串中不触发 --
            },
            -- 在这些文件类型中禁用自动括号 --
            disable_filetype = { "TelescopePrompt", "vim" },
            -- 检查同一行是否有不匹配的括号，如果有则不自动补全 --
            enable_check_bracket_line = true,
            -- 如果下一个字符是字母、数字或点号 [%w%.]，则不进行自动补全 --
            ignored_next_char = "[%w%.]",
            
            -- 将字符自动放入括号
            fast_wrap = {
                map = '<M-e>', -- 快捷键：Alt + e
                chars = { '{', '[', '(', '"', "'" }, -- 允许包裹的符号 --
                pattern = [=[[%'%"%>%]%)%}%,]]=], -- 匹配结束标记的正则 --
                offset = 0, -- 偏移量 -- 
                end_key = '$', -- 按 $ 直接跳到行尾进行包裹 --
                keys = 'qwertyuiopzxcvbnmasdfghjkl', -- 提示字符（类似于 leap/hop 插件） --
                check_comma = true, -- 检查逗号 --
                highlight = 'PmenuSel', -- 选中目标的颜色 --
                highlight_grey = 'LineNr' -- 未选中目标的颜色 --
            },
        })
        
        -- 与 nvim-cmp 集成 --
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
}
