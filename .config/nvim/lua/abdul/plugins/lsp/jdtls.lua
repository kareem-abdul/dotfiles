local M = {}

local utils = require("abdul.core.utils");

local function get_jdtls_config()
    return {
        Windows = "/config_win",
        Linux = "/config_linux",
        Darwin = "/config_mac"
    }
end

function M.setup()
    local on_attach = function(client, bufnr)
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        require("jdtls.dap").setup_dap_main_class_configs();
        require("abdul.core.remap").lsp_config_keymaps(bufnr)
        vim.lsp.codelens.refresh()
    end;
    local capabilities = require('cmp_nvim_lsp').default_capabilities();
    local jdtls = utils.load("jdtls")
    if not jdtls then
        error("jdtls not installed. use `:LspInstall jdtls`")
        return
    end

    local system = vim.uv.os_uname().sysname;

    local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    local jdtls_config_path = jdtls_path .. get_jdtls_config()[system]
    local jdtls_plugins_path = jdtls_path .. '/plugins'
    local project_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") -- see :h filename-modifiers
    local workspace_dir = vim.fn.stdpath('data') .. '/java/workspace-root/' .. project_name
    local jar_dir = vim.fn.glob(jdtls_plugins_path .. '/org.eclipse.equinox.launcher_*.jar')
    local dap_path = vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter'
    -- /home/kareem/.local/share/nvim/mason/packages/java-test/extension/server
    local java_test = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server/*.jar', 1);

    local bundles = {
        vim.fn.glob(dap_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)
    };
    vim.list_extend(bundles, vim.split(java_test, "\n"))


    local config = {
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
            '-Xmx1g', -- max heap size JVM can allocate (use Xms  to set minimun heap size)
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

            '-jar', jar_dir,
            '-configuration', jdtls_config_path,
            '-data', workspace_dir,
        },
        root_dir = require('jdtls.setup').find_root(project_markers),
        init_options = {
            bundles = bundles
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
                             name = "JavaSE-8",
                             path = '/usr/lib/jvm/java-8-openjdk-amd64'
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
                        profile = "Intellij",
                        url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/intellij-java-google-style.xml"
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
    };
    jdtls.start_or_attach(config)
end

return M;
