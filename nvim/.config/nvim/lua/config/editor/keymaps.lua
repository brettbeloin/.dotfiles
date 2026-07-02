-- Leader Key setup
vim.g.mapleader = ' '

-- Basic editor functions
vim.keymap.set('n', '<leader>w', ':set wrap!<CR>', { desc = "toggle wrap lines" })
vim.keymap.set('n', '<leader>sv', ':vsplit | terminal<CR>', { desc = "open virtical terminal" })
vim.keymap.set('n', '<leader>sh', ':split | terminal<CR>', { desc = "open horizantal terminal" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Exit to file tree :Ex" })
vim.keymap.set("n", "<leader>so", vim.cmd.so, { desc = "Source current file :so" })
vim.keymap.set('n', '<S-CR>', 'o<Esc>', { desc = "Insert line below" })

-- Movement Keys
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- clipboard options
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy muliple lines to system clipboard" })

-- Custom commands
vim.cmd("command! W w")
vim.cmd("command! X x")
vim.cmd("command! Q q")
vim.cmd("command! Wq wq")
