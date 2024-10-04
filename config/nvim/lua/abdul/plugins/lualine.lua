local colors = {
    bg       = '#20232800',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
}

local mode_color = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
    [''] = colors.blue,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
}

local conditions = {
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end
}

return {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    config = function()
        local lualine = require('lualine')
        local utils = require('abdul.core.utils')
        lualine.setup({
            options = {
                component_separators = '',
                section_separators = '',
                theme = {
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
                globalstatus = true,
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {
                    {
                        'mode',
                        color = function()
                            return { fg = colors.darkblue, bg = mode_color[vim.fn.mode()], gui = 'bold' }
                        end,
                        padding = { left = 1, right = 1 },
                        fmt = utils.string_trunc(80, 4, nil, true)
                    },
                    { 'branch', icon = '', color = { fg = colors.violet, gui = 'bold,italic' } },
                    {
                        utils.filename,
                        color = function()
                            if vim.bo.modified then
                                return { fg = colors.green }
                            end
                            return { fg = colors.magenta }
                        end,
                        fmt = utils.string_trunc(90, 30, 50)
                    },
                    {
                        'diff',
                        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
                        diff_color = {
                            added = { fg = colors.green },
                            modified = { fg = colors.orange },
                            removed = { fg = colors.red },
                        },
                        cond = conditions.hide_in_width,
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌶 ' },
                        diagnostics_color = {
                            color_error = { fg = colors.red },
                            color_warn = { fg = colors.yellow },
                            color_info = { fg = colors.cyan },
                            color_hint = { fg = colors.cyan }
                        },

                    },
                    { function() return '%=' end }
                },
                lualine_x = {
                    {
                        'o:encoding',
                        fmt = string.upper,
                        cond = conditions.hide_in_width,
                        color = { fg = colors.green, gui = 'bold' },
                    },
                    { 'filesize', cond = utils.buffer_not_empty },
                    { 'location' },
                    { 'progress', color = { fg = colors.fg, gui = 'bold' } },
                    {
                        function()
                            local space = vim.fn.search([[\s\+$]], 'nwc')
                            return space ~= 0 and "TW:" .. space or ""
                        end
                    },
                    {
                        'fileformat',
                        fmt = string.upper,
                        icons_enabled = true,
                        color = { fg = colors.green, gui = 'bold' },
                        symbols = {
                            unix = 'LF',
                            dos = 'CRLF',
                            mac = 'CR',
                        },
                    },
                    { function() return ' ' end, padding = { left = 0, right = 0 } },
                },
            },
            inactive_winbar = {
                lualine_c = {
                    -- { 'FugitiveHead', color = { fg = colors.violet, gui = 'italic' } },
                    -- {
                    --     'filename',
                    --     cond = utils.buffer_not_empty,
                    --     file_status = true,
                    --     path = 1,
                    --     shorting_target = 200,
                    --     color = { fg = colors.magenta, gui = 'italic' },
                    -- }
                }
            },
            extensions = { 'oil', 'fugitive' }
        })
    end
}
