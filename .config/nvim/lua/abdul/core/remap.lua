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

    -- resize panes
    vim.keymap.set("n", "<C-w>>", ":vert res +20<CR>");
    vim.keymap.set("n", "<C-w><", ":vert res -20<CR>");

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
    vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end);
    vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end);
    vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end);
    vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end);
    vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end);
end

function M.telescope_keymaps()
    local builtin = require("telescope.builtin");
    local actions = require("telescope.actions");

    vim.keymap.set('n', '<leader>pf', builtin.find_files, {});
    vim.keymap.set('n', '<leader>ps', function()
        vim.ui.input({ prompt = "GREP >" },
            function(arg)
                if not arg or arg == "" then
                    return
                end
                builtin.grep_string({ search = arg })
            end)
    end)
    vim.keymap.set('n', '<leader>lg', builtin.live_grep)
    vim.keymap.set('n', '<leader>gf', function() builtin.git_files({ show_untracked = true, use_git_root = false }) end)
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
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
    vim.keymap.set("n", "<C-h>", function() vim.lsp.inlay_hint(bufnr, nil) end, opts)

    vim.lsp.inlay_hint(bufnr, true);

    vim.keymap.set("n", "gd", function() builtin.lsp_definitions() end, opts)
    vim.keymap.set("n", "gr", function() builtin.lsp_references({ fname_width = 100 }) end, opts)
    vim.keymap.set("n", "gi", function() builtin.lsp_implementations() end, opts)
    vim.keymap.set("n", "gt", function() builtin.lsp_type_definitions() end, opts)
    vim.keymap.set("n", "gD", function() builtin.diagnostics({ bufnr = 0 }) end, opts)

    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

    vim.keymap.set("n", "<leader>=", function() vim.lsp.buf.format({ async = true }) end, opts)


    -- debugger keymaps
    local dap = require("dap");
    local dap_widgets = require("dap.ui.widgets");
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Set breakpoint" })
    vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "Set conditional breakpoint" })
    vim.keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = "Set log point" })
    vim.keymap.set("n", '<leader>br', dap.clear_breakpoints, { desc = "Clear breakpoints" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<leader>dj", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<leader>dk", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", '<leader>dd', dap.disconnect, { desc = "Disconnect" })
    vim.keymap.set("n", '<leader>dt', dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Open REPL" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
    vim.keymap.set("n", '<leader>di', dap_widgets.hover, { desc = "Variables" })
    vim.keymap.set("n", '<leader>d?', function() dap_widgets.centered_float(dap_widgets.scopes) end, { desc = "Scopes" })
    vim.keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "List breakpoints" })
    vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>', { desc = "List frames" })
    vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>', { desc = "List commands" })

end

function M.gitsigns_keymaps(bufnr)
    local gs = require("gitsigns")
    local opts = { buffer = bufnr, noremap = true, silent = true };

    -- Navigation
    vim.keymap.set('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    vim.keymap.set('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    -- Actions
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts)
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, opts)
    -- vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
    -- vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
    -- vim.keymap.set('n', '<leader>hS', gs.stage_buffer, opts)
    -- vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
    -- vim.keymap.set('n', '<leader>hR', gs.reset_buffer, opts)
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
    vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, opts)
    vim.keymap.set('n', '<leader>hd', gs.diffthis, opts)
    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, opts)
    -- vim.keymap.set('n', '<leader>td', gs.toggle_deleted, opts)

    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
end

function M.eslint_lsp_keymaps(buffnr)
    vim.keymap.set("n", "<leader>=", ":EslintFixAll<CR>", { buffer = buffnr, noremap = true, silent = true })
end

return M;

