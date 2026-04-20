vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', ':set wrap!<CR>')
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>so", vim.cmd.so)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

