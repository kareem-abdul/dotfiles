-- a plugin to manage databases from nvim
return {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    dependencies = {
        { 'tpope/vim-dadbod', cmd = { 'DB' } }
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
};
