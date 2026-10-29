vim.diagnostic.config({
    virtual_text = false, -- Set to false to hide inline messages
    signs = false,
    underline = { severity = { min = vim.diagnostic.severity.ERROR } }, -- only underline errors, not warnings
})
