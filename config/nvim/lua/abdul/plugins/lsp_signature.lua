return {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    init = function(options, args)
        vim.api.nvim_create_autocmd("LspAttach", {
            require('lsp_signature').on_attach({
                bind = true,
                handler_opts = {
                    border = "rounded"
                }
            })
        })
    end
}
