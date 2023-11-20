return {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function ()
        local java_jdtls_group  = vim.api.nvim_create_augroup('jdtls java group', { clear = true })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'java',
            callback = require("abdul.plugins.lsp.jdtls").setup,
            group = java_jdtls_group
        })

    end
}
