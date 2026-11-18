require("lint").linters_by_ft = {
    c = { "clangtidy" },
    cpp = { "clangtidy" },
    go = { "golangcilint" },
    rust = { "clippy" },
    python = { "pylint" },
    java = { "checkstyle" },
    -- css/scss are validated by cssls, and js/ts by the eslint LSP (only in
    -- projects with an eslint config), so only html needs a separate linter
    html = { "htmlhint" },
    dockerfile = { "hadolint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
