require("lint").linters_by_ft = {
    c = { "cpplint" },
    cpp = { "cpplint" },
    go = { "golangcilint" },
    rust = { "bacon" },
    python = { "pylint" },
    -- java = { "checkstyle" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
