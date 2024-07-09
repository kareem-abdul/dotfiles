local opt = vim.opt;

opt.nu = true;
opt.relativenumber = true;

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.swapfile = false
opt.backup = false

opt.hlsearch = true
opt.incsearch = true
opt.inccommand = 'split'

opt.termguicolors = true
opt.background = "dark"
opt.colorcolumn = "80"
opt.signcolumn = "yes"

opt.scrolloff = 8
opt.updatetime = 50
opt.timeoutlen = 300
opt.wrap = false

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.cursorline = true
opt.cursorlineopt = "line"

-- lualine has status so disable default
opt.showmode = false

-- netrw options
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3

-- function tree_sitter_options()
--     opt.foldlevel = 20
--     opt.foldmethod = "expr"
--     opt.foldexpr = require("treesitter").fold
-- end
