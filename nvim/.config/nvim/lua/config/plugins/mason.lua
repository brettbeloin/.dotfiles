require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "gopls",
        "rust_analyzer",
        "jdtls",
    },
    -- lsp.lua starts each server manually via vim.lsp.start on FileType,
    -- so let mason only install binaries here and leave enabling to that file.
    automatic_enable = false,
})
