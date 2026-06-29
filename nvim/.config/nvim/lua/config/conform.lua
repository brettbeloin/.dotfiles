require("conform").setup({
    formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "goimports" },
        python = { "blue" },
        java = { "clang_format" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
