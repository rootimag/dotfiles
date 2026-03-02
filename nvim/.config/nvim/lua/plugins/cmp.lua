return {
    -- 自动补全 --
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- 仅在进入插入模式时加载 --
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- LSP 补全源 --
        "L3MON4D3/LuaSnip",         -- 代码片段引擎 --
        "saadparwaiz1/cmp_luasnip",  -- LuaSnip 补全源 --
        "hrsh7th/cmp-buffer",       -- 缓冲区文本补全 --
        "hrsh7th/cmp-path",         -- 文件路径补全 --
    },
    config = function()
        -- 基础交互设置 --
        vim.opt.pumblend = 0 -- 关闭伪透明 --

        -- 补全菜单高亮组配置 --
        local highlights = {
            Pmenu = { bg = "NONE" }, -- 普通项：透明背景 --
            PmenuSel = { bg = "#3b4261", fg = "#c0caf5", bold = true }, -- 选中项：高亮背景 --
            PmenuSbar = { bg = "NONE" }, -- 滚动条背景 --
            PmenuThumb = { bg = "#555555" }, -- 滚动条滑块 --
            FloatBorder = { fg = "#444a73", bg = "NONE" }, -- 浮窗边框 --
        }
        for group, settings in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, settings)
        end

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            -- 窗口外观配置 --
            window = {
                completion = cmp.config.window.bordered({
                    border = "rounded", -- 圆角边框 --
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
                }),
            },

            -- 代码片段展开逻辑 --
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- 按键映射 --
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动文档 --
                ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- 向下滚动文档 --
                ["<C-Space>"] = cmp.mapping.complete(),  -- 手动触发补全 --
                ["<C-e>"] = cmp.mapping.abort(),         -- 取消补全 --
                ["<CR>"] = cmp.mapping.confirm({ 
                    select = true, 
                    behavior = cmp.ConfirmBehavior.Replace 
                }), -- 回车确认（覆盖模式） --

                -- Tab 键智能跳转 --
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- 补全数据源优先级 --
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 }, -- LSP 优先级最高 --
                { name = "luasnip",  priority = 750 },  -- 代码片段次之 --
                { name = "path",     priority = 500 },  -- 路径补全 --
                { name = "buffer",   priority = 250, keyword_length = 3 }, -- 缓冲区词汇最末 --
            }),

            -- 菜单样式定制 --
            formatting = {
                fields = { "abbr", "menu" }, -- 显示简称和来源标签 --
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip  = "[Snip]",
                        buffer   = "[Buf]",
                        path     = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
        })
    end,
}
