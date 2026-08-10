require("lint").linters_by_ft = {
    c = { "clangtidy" },
    cpp = { "clangtidy" },
    go = { "golangcilint" },
    rust = { "clippy" },
    python = { "pylint" },
    java = { "checkstyle" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
