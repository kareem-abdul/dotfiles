return {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function ()
        local java_jdtls_group  = vim.api.nvim_create_augroup('jdtls java group', { clear = true })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'java',
            callback = function (ev)
               require("abdul.plugins.lsp.jdtls").setup();
            end,
            group = vim.api.nvim_create_augroup('jdtls_attach_java', { clear = true })
        })

        require("abdul.plugins.lsp.jdtls").setup();
    end
}
