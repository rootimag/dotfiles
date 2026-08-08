return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    config = function()
        local cmp_ok, cmp = pcall(require, "cmp")
        local luasnip_ok, luasnip = pcall(require, "luasnip")
        if not (cmp_ok and luasnip_ok) then
            return
        end

        -- 类型图标与高亮组定义
        local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎟",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈚",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
        }
        local kind_colors = {
            CmpItemKindField = { fg = "#e0af68" },
            CmpItemKindProperty = { fg = "#e0af68" },
            CmpItemKindEvent = { fg = "#e0af68" },
            CmpItemKindText = { fg = "#9ece6a" },
            CmpItemKindEnum = { fg = "#9ece6a" },
            CmpItemKindKeyword = { fg = "#9ece6a" },
            CmpItemKindConstant = { fg = "#ff9e64" },
            CmpItemKindConstructor = { fg = "#ff9e64" },
            CmpItemKindReference = { fg = "#ff9e64" },
            CmpItemKindFunction = { fg = "#7aa2f7" },
            CmpItemKindStruct = { fg = "#7aa2f7" },
            CmpItemKindClass = { fg = "#7aa2f7" },
            CmpItemKindModule = { fg = "#7aa2f7" },
            CmpItemKindOperator = { fg = "#7aa2f7" },
            CmpItemKindVariable = { fg = "#bb9af7" },
            CmpItemKindFile = { fg = "#bb9af7" },
            CmpItemKindInterface = { fg = "#bb9af7" },
            CmpItemKindSnippet = { fg = "#f7768e" },
        }

        -- 应用类型图标高亮设置
        for group, settings in pairs(kind_colors) do
            vim.api.nvim_set_hl(0, group, settings)
        end

        -- 定制补全浮窗背景与边框
        local window_highlights = {
            Pmenu = { bg = "NONE" },
            PmenuSel = { bg = "#3b4261", fg = "#c0caf5", bold = true },
            PmenuSbar = { bg = "NONE" },
            PmenuThumb = { bg = "#555555" },
            FloatBorder = { fg = "#444a73", bg = "NONE" },
        }

        -- 应用浮窗高亮设置
        for group, settings in pairs(window_highlights) do
            vim.api.nvim_set_hl(0, group, settings)
        end

        -- 判断光标前是否有有效字符
        local has_words_before = function()
            local line, col = (table.unpack or unpack)(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        vim.opt.pumblend = 10 -- 设置原生弹出菜单的透明度

        cmp.setup({
            -- 窗口外观设置
            window = {
                ---@diagnostic disable-next-line: undefined-field
                completion = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
                ---@diagnostic disable-next-line: undefined-field
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
                }),
            },

            -- 代码片段展开设置 (LuaSnip 引擎)
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- 按键映射 (Keymaps)
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动文档
                ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- 向下滚动文档
                ["<C-o>"] = cmp.mapping.complete(),      -- 手动触发补全菜单
                ["<C-e>"] = cmp.mapping.abort(),         -- 取消/关闭补全菜单

                -- 回车确认补全
                ["<CR>"] = cmp.mapping.confirm({
                    select = true,
                    -- Insert 模式替换不会吃掉光标后面的原有代码，避免代码损坏
                    behavior = cmp.ConfirmBehavior.Insert,
                }),

                -- Tab 逻辑：1. 补全菜单选中下一个 2. LuaSnip 占位符跳转 3. 非空字符触发补全 4. 默认 Tab 缩进
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Shift+Tab 逻辑：1. 补全菜单选中上一个 2. LuaSnip 占位符反向跳转
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

            -- 补全数据源优先级设置 (Sources & Priority)
            ---@diagnostic disable-next-line: undefined-field
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 750 },
                { name = "path",     priority = 500 },
                { name = "buffer",   priority = 250, keyword_length = 3 }, -- 缓冲区字符大于等于3才触发
            }),

            -- 补全项展示格式化 (Formatting)
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    -- 设置图标
                    vim_item.kind = string.format("%s ", kind_icons[vim_item.kind] or "")

                    -- 限制补全文本最大长度，防止界面过宽
                    local maxwidth = 30
                    if #vim_item.abbr > maxwidth then
                        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth) .. "…"
                    end

                    -- 设置来源标注名称
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip  = "[Snip]",
                        buffer   = "[Buf]",
                        path     = "[Path]",
                    })[entry.source.name]

                    return vim_item
                end,
            },

            -- 性能优化参数 (Performance Tuning)
            performance = {
                debounce = 60,          -- 节流响应延迟（毫秒）
                fetching_timeout = 200, -- 超时时间（毫秒）
                max_view_entries = 15,  -- 弹出菜单最大显示条目数，提升渲染性能
            },
        })
    end,
}
