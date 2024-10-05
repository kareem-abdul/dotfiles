return {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    init = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_signature_LSPATTACH", { clear = true }),
            callback = function()
                require('lsp_signature').on_attach({
                    bind = true,
                    handler_opts = {
                        border = "rounded"
                    }
                })
            end
        })
    end
}
