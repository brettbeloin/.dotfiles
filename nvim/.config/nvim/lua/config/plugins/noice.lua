local timeout = 1500 -- 1.5 seconds

require("notify").setup({
    timeout = timeout,
})

require("noice").setup({
    lsp = {
        -- override markdown rendering so that cmp and other plugins use Treesitter
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    views = {
        notify = { timeout = timeout },
        mini = { timeout = timeout },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = false,
    },
})
