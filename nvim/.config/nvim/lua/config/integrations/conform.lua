require("conform").setup({
    formatters_by_ft = {
        c               = { "clang_format" },
        cpp             = { "clang_format" },
        go              = { "goimports" },
        python          = { "blue" },
        java            = { "palantir-java-format" },
        cs              = { "csharpier" },
        html            = { "prettierd", "prettier", stop_after_first = true },
        css             = { "prettierd", "prettier", stop_after_first = true },
        scss            = { "prettierd", "prettier", stop_after_first = true },
        javascript      = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript      = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        dockerfile      = { "dockerfmt" },
        sh              = { "shfmt" },
        bash            = { "shfmt" },
        zsh             = { "shfmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
