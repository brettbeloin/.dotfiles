vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.shell = "/usr/bin/bash"
vim.diagnostic.config({
    virtual_text = true, -- Set to false to hide inline messages
    signs = true,
})

vim.cmd.colorscheme("everforest")
