local M = {}

local utils = require("abdul.core.utils");

local function get_jdtls_config()
    return {
        Windows = "/config_win",
        Linux = "/config_linux",
        Darwin = "/config_mac"
    }
end

local function find_root(markers)
    return vim.fs.dirname(vim.fs.find(markers, { upward = true })[1])
end

local function get_bundles()
    -- /home/kareem/.local/share/nvim/mason/packages/java-test/extension/server
    local bundles = {
        vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar')
    };
    vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server/*.jar'), "\n"))
    bundles = vim.tbl_filter(function(s)
        return not vim.endswith(s, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
    end, bundles)
    return bundles;
end

local function on_attach(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto', config_overrides = {} })
    require("jdtls.dap").setup_dap_main_class_configs();
    require("abdul.core.remap").lsp_config_keymaps(client, bufnr)
    require("abdul.core.remap").jdtls_keymaps(bufnr);
    vim.lsp.codelens.refresh()
end;

function M.setup()
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
    )
    local jdtls = utils.load("jdtls")
    if not jdtls then
        error("jdtls not installed. use `:LspInstall jdtls`")
        return
    end

    -- see :h filename-modifiers
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'

    local project_markers = { 'pom.xml', 'settings.gradle', 'build.gradle', 'mvnw', 'gradlew', '.git'} -- { "gradlew", ".git", "mvnw"}
    local root_dir = find_root(project_markers);-- require('jdtls.setup').find_root(project_markers)
    jdtls.start_or_attach({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 80,
        },
        cmd = {
            'java', -- path to java 17, or java command if java is the default one configured
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-javaagent:' .. jdtls_path .. '/lombok.jar',
            '-Xmx4g', -- max heap size JVM can allocate (use Xms  to set minimun heap size)
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

            '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
            '-configuration', jdtls_path .. get_jdtls_config()[vim.uv.os_uname().sysname],
            '-data', vim.fn.stdpath('data') .. '/java/workspace-root/' .. project_name,
        },
        root_dir = root_dir,
        init_options = {
            bundles = get_bundles()
        },

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
            java = {
                configuration = {
                     updateBuildConfiguration = "interactive",
                     runtimes = {
                         {
                             name = "JavaSE-17",
                             path = "/usr/lib/jvm/java-17-openjdk-amd64"
                         },
                         {
                             name = "JavaSE-11",
                             path = '/usr/lib/jvm/java-11-openjdk-amd64',
                         },
                         {
                             name = "JavaSE-1.8",
                             path = '/usr/lib/jvm/java-1.8.0-openjdk-amd64'
                         }
                     }
                },
                eclipse = { downloadSources = true },
                maven = { downloadSources = true },
                format = {
                    enabled = true,
                    insertSpaces = true,
                    tabsize = 4,
                    settings = {
                        profile = "GoogleStyle",
                        url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
                    }
                },
                implementationsCodeLens = { enabled =  true },
                referenceCodeLens = { enabled = true },
                references = {
                    includeAccessors = true,
                    includeDecompiledSources = true,
                },
                saveAction = { organizeImports = false },
                inlayHints = { parameterNames = { enabled = true } },
                signatureHelp = { enabled = true },
                sources = {
                    organizeImports = {
                        starThreshold = 999,
                        staticStarThreshold = 999,
                    }
                },
                cleanup = {
                    actionsOnSave = { 'lambdaExpression' }
                },
                completion = {
                    importOrder = {},
                }

            }
        }
    })
end

return M;
