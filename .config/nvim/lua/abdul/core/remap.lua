local M = {};

function M.load_global()
    vim.g.mapleader = " "
    vim.keymap.set("n", "Q", "<nop>")
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    vim.keymap.set("n", "<leader>o", "o<ESC>")
    vim.keymap.set("n", "<leader>O", "O<ESC>")
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")
    vim.keymap.set("i", "<C-c>", "<Esc>")

    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- delete to null register keeping previous yank buffer
    vim.keymap.set("x", "<leader>p", "\"_dP")
    vim.keymap.set("n", "<leader>d", "\"_d")
    vim.keymap.set("v", "<leader>d", "\"_d")

    -- yank into system clipboard
    vim.keymap.set("n", "<leader>y", "\"+y")
    vim.keymap.set("v", "<leader>y", "\"+y")
    vim.keymap.set("n", "<leader>Y", "\"+Y")

    -- auto close paranthesis, braces, brackets, quotes etc.
    vim.keymap.set("i", '"', '""<left>');
    vim.keymap.set("i", "'", "''<left>");
    vim.keymap.set("i", "(", "()<left>");
    vim.keymap.set("i", "[", "[]<left>");
    vim.keymap.set("i", "{", "{}<left>");
    vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O");

    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        callback = function()
            vim.keymap.set('n', '<leader>qd', require('abdul.core.utils').removeQfLine)
        end
    })
end

function M.harpoon_keymaps()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    local cmd = require("harpoon.cmd-ui");
    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    vim.keymap.set("n", "<leader>cm", cmd.toggle_quick_menu)
    vim.keymap.set("n", "<C-n>", ui.nav_next)
    vim.keymap.set("n", "<C-p>", ui.nav_prev)
    vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end);
    vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end);
    vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end);
    vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end);
end

function M.telescope_keymaps()
    local builtin = require("telescope.builtin");
    local actions = require("telescope.actions");

    vim.keymap.set('n', '<leader>pf', builtin.find_files, {});
    vim.keymap.set('n', '<leader>ps',
        function() vim.ui.input({ prompt = "GREP >" }, function(arg) builtin.grep_string({ search = arg }) end) end)
    vim.keymap.set('n', '<leader>lg', builtin.live_grep)
    vim.keymap.set('n', '<leader>gf', function() builtin.git_files({ show_untracked = true }) end)
    vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false }))
    end)
    vim.keymap.set('n', '<leader>sr', builtin.resume)
    return {
        i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-a>"] = actions.select_all,
            ["<C-p>"] = actions.preview_scrolling_up,
            ["<C-n>"] = actions.preview_scrolling_down,
        }
    };
end

function M.nvim_cmp_completions()
    local cmp = require("cmp");
    return {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    };
end

function M.lsp_config_keymaps(bufnr)
    local builtin = require("telescope.builtin");
    local opts = { buffer = bufnr, noremap = true, silent = false };

    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vgd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "gd", function() builtin.lsp_definitions() end, opts)
    vim.keymap.set("n", "gr", function() builtin.lsp_references({ fname_width = 100 }) end, opts)
    vim.keymap.set("n", "gi", function() builtin.lsp_implementations() end, opts)
    vim.keymap.set("n", "gt", function() builtin.lsp_type_definitions() end, opts)
    vim.keymap.set("n", "gD", function() builtin.diagnostics({ bufnr = 0 }) end, opts)

    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

    vim.keymap.set("n", "<leader>=", function() vim.lsp.buf.format({ async = true }) end, opts)
end

function M.eslint_lsp_keymaps(buffnr)
    vim.keymap.set("n", "<leader>=", ":EslintFixAll<CR>", { buffer = buffnr, noremap = true, silent = true })
end

return M;
