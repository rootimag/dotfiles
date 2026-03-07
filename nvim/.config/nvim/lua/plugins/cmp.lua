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
        vim.opt.pumblend = 10

        local kind_icons = {
            Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
            Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
            Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎟",
            Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
            File = "󰈙", Reference = "󰈚", Folder = "󰉋", EnumMember = "",
            Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
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
        for group, settings in pairs(kind_colors) do
            vim.api.nvim_set_hl(0, group, settings)
        end

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local highlights = {
            Pmenu = { bg = "NONE" },
            PmenuSel = { bg = "#3b4261", fg = "#c0caf5", bold = true },
            PmenuSbar = { bg = "NONE" },
            PmenuThumb = { bg = "#555555" },
            FloatBorder = { fg = "#444a73", bg = "NONE" },
        }
        for group, settings in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, settings)
        end

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                }),
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
                }),
            },

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = true,
                    behavior = cmp.ConfirmBehavior.Replace
                }),

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

            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 750 },
                { name = "path",     priority = 500 },
                { name = "buffer",   priority = 250, keyword_length = 3 },
            }),

            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")

                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip  = "[Snip]",
                        buffer   = "[Buf]",
                        path     = "[Path]",
                    })[entry.source.name]

                    return vim_item
                end,
            },

            performance = {
                debounce = 60,
                fetching_timeout = 200,
            }
        })
    end,
}
