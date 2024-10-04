-- a plugin to manage databases from nvim
return {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    dependencies = {
        { 'tpope/vim-dadbod', cmd = { 'DB' } },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end
};
