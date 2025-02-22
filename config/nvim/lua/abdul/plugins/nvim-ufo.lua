local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end
-- adds code folding
return {
    "kevinhwang91/nvim-ufo",
    tag = 'v1.4.0',
    dependencies = { 'kevinhwang91/promise-async' },
    lazy = true,
    config = function()
        vim.o.foldcolumn = '0' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require('abdul.core.remap').ufo_keymaps()

        local ftMap = {
            java = { 'lsp', 'treesitter' },
            javascript = { 'lsp', 'treesitter' },
            typescript = { 'lsp', 'treesitter' },
            html = { 'lsp', 'treesitter' },
            handlebars = { 'lsp', 'treesitter' },
            solidity = { 'indent', 'treesitter' },
            vim = { 'indent' },
            json = { 'treesitter' },
            default = { 'treesitter', 'indent' }
        }
        require('ufo').setup({
            close_fold_kinds_for_ft = {
                -- default = { 'imports', 'comment' },
            },
            open_fold_hl_timeout = 150,
            enable_get_fold_virt_text = false,
            preview = {
                win_config = {
                    border = { '', '─', '', '', '', '─', '', '' },
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
                mappings = {
                    scrollU = '<C-u>',
                    scrollD = '<C-d>',
                    jumpTop = '[',
                    jumpBot = ']'
                }
            },
            provider_selector = function(_, filetype, _)
                return ftMap[filetype] or ftMap.default
            end,
            fold_virt_text_handler = handler
        })
    end
}
