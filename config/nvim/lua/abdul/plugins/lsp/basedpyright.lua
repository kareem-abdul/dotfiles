
local lspconfig = require("lspconfig")

local M = {};

function M.setup(capabilities)
    -- lspconfig.basedpyright.setup({
    --     capabilities = capabilities,
    --     settings = {
    --         basedpyright = {
    --             analysis = {
    --                 -- ignore = { '*' } -- ruff_lsp handles all formatting and linting
    --                 autoSearchPaths = true,
    --                 diagnosticMode = "openFilesOnly",
    --                 useLibraryCodeForTypes = true,
    --                 typeCheckingMode = "strict",
    --                 diagnosticSeverityOverrides = {
    --                     reportAny = "warning",
    --                     reportUnknownMemberType = "warning",
    --                     enableExperimentalFeatures = true,
    --                     deprecateTypingAliases = true,
    --
    --                     reportMissingModuleSource = "error",
    --                     reportCallInDefaultInitializer = "error",
    --                     reportImplicitOverride = "error",
    --                     reportImplicitStringConcatenation = "error",
    --                     reportImportCycles = "error",
    --                     reportMissingSuperCall = "error",
    --                     reportPropertyTypeMismatch = "error",
    --                     reportShadowedImports = "error",
    --                     reportUninitializedInstanceVariable = "error",
    --                     reportUnnecessaryTypeIgnoreComment = "error",
    --                     reportUnusedCallResult = "error",
    --                     reportUnreachable = "error",
    --                     reportUnsafeMultipleInheritance = "error",
    --                     reportInvalidCast = "error",
    --                     reportImplicitRelativeImport = "error",
    --                     reportPrivateLocalImportUsage = "error",
    --                     reportIgnoreCommentWithoutRule = "error",
    --                 }
    --             }
    --         }
    --     }
    -- })
end

return M;

