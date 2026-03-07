local opt = vim.opt

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "1html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
    "editorconfig",
    "matchparen",
}

for _, plugin in ipairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 0
end

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.background = "dark"
