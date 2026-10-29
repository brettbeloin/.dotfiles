require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "gopls",
        "rust_analyzer",
        "jdtls",
        "html",
        "cssls",
        "ts_ls",
        "eslint",
        "emmet_language_server",
    },
    -- lsp.lua starts each server manually via vim.lsp.start on FileType,
    -- so let mason only install binaries here and leave enabling to that file.
    automatic_enable = false,
})

-- Non-LSP tools (formatters, linters, debug adapters) that mason-lspconfig
-- doesn't know about. Installed once in the background if missing.
local tools = {
    "prettierd",
    "htmlhint",
    "js-debug-adapter",
}

local registry = require("mason-registry")
registry.refresh(function()
    for _, name in ipairs(tools) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() then
            pkg:install()
        end
    end
end)
