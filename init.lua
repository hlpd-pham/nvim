require("hoa.plugins-setup")
require("hoa.core.options")
require("hoa.core.keymaps")
require("hoa.core.colorscheme")
require("hoa.plugins.comment")
require("hoa.plugins.telescope")
require("hoa.plugins.treesitter")
require("hoa.plugins.undotree")
require("hoa.plugins.fugitive")
require("hoa.plugins.lsp")
require("hoa.plugins.nvim-tree")
require("hoa.plugins.mason")
require("hoa.plugins.harpoon")

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
