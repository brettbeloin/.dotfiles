print("lsp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp = vim.lsp
 
lsp.config.ccls = {
    cmd = { "ccls" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { ".git", "compile_commands.json", "compile_flags.txt" },
}
 
lsp.config.gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", ".git" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
 
lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                command = "clippy",
            },
        },
    },
}
 
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.lsp.start({
            name = "gopls",
            cmd = { "gopls" },
            root_dir = vim.fn.getcwd(),
	    capabilities = capabilities,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.lsp.start({
            name = "ccls",
            cmd = { "ccls" },
            root_dir = vim.fn.getcwd(),
	    capabilities = capabilities,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.lsp.start({
            name = "rust_analyzer",
            cmd = { "rust-analyzer" },
            root_dir = vim.fn.getcwd(),
	    capabilities = capabilities,
        })
    end,
})
 
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        
    end,
})

vim.api.nvim_exec_autocmds("FileType", { pattern = vim.bo.filetype })
