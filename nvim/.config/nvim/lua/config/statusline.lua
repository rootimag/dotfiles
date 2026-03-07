local colors = {
    blue      = "#7aa2f7",
    green     = "#9ece6a",
    purple    = "#bb9af7",
    fg        = "#c0caf5",
    text_dark = "#1f2335",
}

local function set_hl()
    vim.api.nvim_set_hl(0, "StModeN", { fg = colors.text_dark, bg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "StModeI", { fg = colors.text_dark, bg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, "StModeV", { fg = colors.text_dark, bg = colors.purple, bold = true })

    vim.api.nvim_set_hl(0, "StSepN", { fg = colors.blue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "StSepI", { fg = colors.green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "StSepV", { fg = colors.purple, bg = "NONE" })

    vim.api.nvim_set_hl(0, "StSepRight", { fg = colors.blue, bg = "NONE" })

    vim.api.nvim_set_hl(0, "StBar", { fg = colors.fg, bg = "NONE" })
end
set_hl()

_G.get_statusline = function()
    local mode = vim.fn.mode():sub(1, 1)
    local stl = ""

    if mode == "i" then
        stl = "%#StModeI# 󰏫 INSERT %#StSepI#"
    elseif mode:match("[vV]") or mode == "\22" then
        stl = "%#StModeV# 󰈸 VISUAL %#StSepV#"
    else
        stl = "%#StModeN# 󰭩 NORMAL %#StSepN#"
    end

    stl = stl .. "%#StBar# %f %m %="

    stl = stl .. "%#StSepRight#%#StModeN#  %l:%c "

    return stl
end

vim.opt.statusline = "%!v:lua.get_statusline()"
