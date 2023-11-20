local M = {};

local function keymap(mode, lhs, rhs, desc, opts)
    if type(desc) == 'table' then
        opts = desc
    elseif desc then
        opts = opts or {}
        opts.desc = desc
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.load_global()
    vim.g.mapleader = " "
    keymap("n", "Q", "<nop>")
    keymap("n", "<leader>pv", vim.cmd.Ex, "netrw: explore files")
    keymap("n", "<leader>o", "o<ESC>", "Create a new line below current line in normal mode")
    keymap("n", "<leader>O", "O<ESC>", "Create a new line above current line in normal mode")
    keymap("n", "n", "nzzzv", "Goto next")
    keymap("n", "N", "Nzzzv", "Goto previous")
    keymap("n", "<C-d>", "<C-d>zz", "Half page down")
    keymap("n", "<C-u>", "<C-u>zz", "Half page up")
    keymap("i", "<C-c>", "<Esc>", "Exit normal mode")

    keymap("v", "J", ":m '>+1<CR>gv=gv", "Move current line down")
    keymap("v", "K", ":m '<-2<CR>gv=gv", "Move current line up")


    -- delete to null register keeping previous yank buffer
    keymap("x", "<leader>p", "\"_dP", "Paste, without replacing existing value")
    keymap("n", "<leader>d", "\"_d", "Delete, without replacing yank buffer")
    keymap("v", "<leader>d", "\"_d", "Delete selection, without replacing yank buffer")

    -- yank into system clipboard
    keymap("n", "<leader>y", "\"+y", "Copy to system clipboard")
    keymap("v", "<leader>y", "\"+y", "Copy selection to system clipboard")
    keymap("n", "<leader>Y", "\"+Y", "Copy line to system clipboard")

    -- auto close paranthesis, braces, brackets, quotes etc.
    keymap("i", '"', '""<left>');
    keymap("i", "'", "''<left>");
    keymap("i", "(", "()<left>");
    keymap("i", "[", "[]<left>");
    keymap("i", "{", "{}<left>");
    keymap("i", "{<CR>", "{<CR>}<ESC>O");

    -- resize panes
    keymap("n", "<C-w>>", ":vert res +20<CR>", "Resize current pane to right");
    keymap("n", "<C-w><", ":vert res -20<CR>", "Resize current pane to left");

    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        callback = function()
            keymap('n', '<leader>qd', require('abdul.core.utils').removeQfLine, "Remove current line from qf list")
        end
    })
end

function M.harpoon_keymaps()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    local cmd = require("harpoon.cmd-ui");
    keymap("n", "<leader>a", mark.add_file)
    keymap("n", "<C-e>", ui.toggle_quick_menu)
    keymap("n", "<leader>cm", cmd.toggle_quick_menu)
    keymap("n", "<C-n>", ui.nav_next)
    keymap("n", "<C-p>", ui.nav_prev)
    keymap("n", "<leader>1", function() ui.nav_file(1) end);
    keymap("n", "<leader>2", function() ui.nav_file(2) end);
    keymap("n", "<leader>3", function() ui.nav_file(3) end);
    keymap("n", "<leader>4", function() ui.nav_file(4) end);
    keymap("n", "<leader>5", function() ui.nav_file(5) end);
    keymap("n", "<leader>6", function() ui.nav_file(6) end);
    keymap("n", "<leader>7", function() ui.nav_file(7) end);
    keymap("n", "<leader>8", function() ui.nav_file(8) end);
    keymap("n", "<leader>9", function() ui.nav_file(9) end);
end

function M.telescope_keymaps()
    local builtin = require("telescope.builtin");
    local actions = require("telescope.actions");

    keymap('n', '<leader>gf', function()
        local _, err = pcall(builtin.git_files, { show_untracked = true, use_git_root = false })
        if err then
            builtin.find_files({ hidden = true, no_ignore = true });
        end
    end, "Find git files");
    keymap('n', '<leader>pf', function() builtin.find_files({ hidden = true, no_ignore = true }) end, "find project files");
    keymap('n', '<leader>lg', builtin.live_grep, "Live search project files")
    keymap('n', '<leader>/', function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false })) end, "Fuzzy search current buffer")
    keymap('n', '<leader>sr', builtin.resume, "Resume last search")
    return {
        i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.select_all,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-f>"] = actions.preview_scrolling_down,
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

function M.lsp_config_keymaps(client, bufnr)
    local builtin = require("telescope.builtin");
    local opts = { buffer = bufnr, noremap = true, silent = false };

    keymap("n", "<leader>gd", vim.lsp.buf.definition, opts)
    keymap("n", "<leader>gr", vim.lsp.buf.references, opts)
    keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    keymap("n", "<leader>vgd", vim.diagnostic.open_float, opts)
    keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)

    keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap("n", "[d", vim.diagnostic.goto_next, opts)
    keymap("n", "]d", vim.diagnostic.goto_prev, opts)
    keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<C-h>", function() vim.lsp.inlay_hint(bufnr, nil) end, "inlay hint", opts)

    -- vim.lsp.inlay_hint(bufnr, true);

    keymap("n", "gd", function() builtin.lsp_definitions() end, opts)
    keymap("n", "gr", function() builtin.lsp_references({ fname_width = 100 }) end, opts)
    keymap("n", "gi", function() builtin.lsp_implementations() end, opts)
    keymap("n", "gt", function() builtin.lsp_type_definitions() end, opts)
    keymap("n", "gD", function() builtin.diagnostics({ bufnr = bufnr }) end, opts)

    keymap("n", "<leader>rs", ":LspRestart<CR>", opts)

    keymap("n", "<leader>=", function() vim.lsp.buf.format({ async = true }) end, opts)

    M.dap_keymaps()
end

function M.dap_keymaps()
    -- debugger keymaps
    local dap = require("dap");
    local dap_widgets = require("dap.ui.widgets");
    keymap("n", "<leader>bb", dap.toggle_breakpoint)
    keymap("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
    vim.keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
    keymap("n", '<leader>br', dap.clear_breakpoints, "[dap] clear breakpoints")
    keymap("n", "<leader>dc", dap.continue, "[dap] continue")
    keymap("n", "<leader>dn", dap.step_over, "[dap] step over")
    keymap("n", "<leader>di", dap.step_into, "[dap] step into")
    keymap("n", "<leader>do", dap.step_out, "[dap] step out")
    keymap("n", '<leader>dd', dap.disconnect, "[dap] disconnect")
    keymap("n", '<leader>dt', dap.terminate, "[dap] terminate")
    keymap("n", "<leader>dr", dap.repl.toggle, "[dap] toggle repl")
    keymap("n", "<leader>dl", dap.run_last, "[dap] run last")
    keymap("n", '<leader>dk', dap_widgets.hover, "[dap] hover widget")
    keymap("n", '<leader>d?', function() dap_widgets.centered_float(dap_widgets.scopes) end, "[dap] centered float")
    keymap("n", '<leader>du', require("dapui").toggle, "[dap] toggle dap ui")
    -- keymap("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
    -- keymap("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
    -- keymap("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
end

function M.jdtls_keymaps(bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = false };
    local jdtls = require("jdtls");
    keymap("n", "<leader>tm", jdtls.test_nearest_method, "[jdtls] test menthod", opts)
    keymap("n", "<leader>tc", jdtls.test_class, "[jdtls] test class", opts)
end

function M.gitsigns_keymaps(bufnr)
    local gs = require("gitsigns")
    local opts = { buffer = bufnr, noremap = true, silent = true, desc = nil };

    -- Navigation
    keymap('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    keymap('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
    end, { expr = true })

    -- Actions
    keymap('n', '<leader>hs', gs.stage_hunk, "[git] stage hunk", opts)
    keymap('n', '<leader>hu', gs.undo_stage_hunk, "undo stage hunk", opts)
    keymap('n', '<leader>hr', gs.reset_hunk, "reset hunk", opts)
    keymap('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "stage visual select", opts)
    keymap('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "reset visula select", opts)
    keymap('n', '<leader>hS', gs.stage_buffer, "stage buffer", opts)
    keymap('n', '<leader>hR', gs.reset_buffer, "reset buffer", opts)
    keymap('n', '<leader>hp', gs.preview_hunk, "preview hunk", opts)
    keymap('n', '<leader>hb', function() gs.blame_line { full = true } end, "blame line", opts)
    keymap('n', '<leader>hd', gs.diffthis, "diff this", opts)
    keymap('n', '<leader>hD', function() gs.diffthis('~') end, "diff this ~", opts)
    -- keymap('n', '<leader>td', gs.toggle_deleted, opts)

    -- Text object
    keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "select hunk", opts)
end

function M.eslint_lsp_keymaps(buffnr)
    keymap("n", "<leader>=", ":EslintFixAll<CR>", { buffer = buffnr, noremap = true, silent = true })
end

M.load_global()
return M;

